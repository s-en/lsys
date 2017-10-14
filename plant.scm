(use srfi-1)
(use util.match)
(use math.const)

(define (atom? x) (not (pair? x)))

(define (walk func tree)
  (match tree
         [() '()]
         [(x . xs) `(,(walk func x) . ,(walk func xs))]
         [x (func x)] ))
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define-class <circular-value> ()
    ((values :init-form (iota 7 0 0) :init-keyword :values :accessor values-of)))
(define (make-circular-value val) 
  (make <circular-value> :values (iota 7 val 0)))
(define-method + ((c1 <circular-value>) (c2 <circular-value>))
    (make <circular-value> 
          :values (map + (~ c1 'values) (~ c2 values))))
(define-method + ((c1 <circular-value>) (num <number>))
    (make <circular-value> 
          :values (map + (~ c1 'values) (circular-list num))))
(define-method add! ((c1 <circular-value>) (num <number>))
    (set! (~ c1 'values) (map + (~ c1 'values) (circular-list num))))
(define-method inc! ((c1 <circular-value>) (c2 <circular-value>))
    (set! (~ c1 'values) (map + (~ c1 'values) (~ c2 'values))))
(define-method * ((c1 <circular-value>) (num <number>))
    (make <circular-value> 
          :values (map * (~ c1 'values) (circular-list num))))
(define-method average ((c1 <circular-value>))
    (/ (fold + 0 (~ c1 'values)) (length (~ c1 'values))))
(define-method normalize! ((c1 <circular-value>))
    (set! (~ c1 'values) 
          (accumulate 
            (^(a b) (if (null? b)
                        (cons (/ (+ a (car (~ c1 'values))) 2) b)
                        (cons (/ (+ a (car b)) 2) b)))
            '()
            (~ c1 'values))))

(define-class <signal> ()
   ((fuel  :init-form (make <circular-value>) :init-keyword :fuel  :accessor fuel-of)
    (sugar :init-form (make <circular-value>) :init-keyword :sugar :accessor sugar-of)
    (auxin :init-form (make <circular-value>) :init-keyword :auxin :accessor auxin-of)
    (cyto  :init-form (make <circular-value>) :init-keyword :cyto  :accessor cyto-of)))

(define-method add! ((s1 <signal>) (s2 <signal>))
  (dolist [slot (class-slots <signal>)]
          (inc! (~ s1 (slot-definition-name slot))
                (~ s2 (slot-definition-name slot))))
  s1)
(define-method add! ((s1 <signal>) (val <number>))
  (dolist [slot (class-slots <signal>)]
          (let1 sname (slot-definition-name slot)
                (set! (~ s1 sname) (+ (~ s1 sname) val))))
  s1)
(define-method multiply! ((s1 <signal>) (val <number>))
  (dolist [slot (class-slots <signal>)]
          (let1 sname (slot-definition-name slot)
                (set! (~ s1 sname) (* (~ s1 sname) val))))
  s1)
(define-method transfer! ((s1 <signal>) (s2 <signal>) (ratio <number>))
  (let1 s3 (multiply! (add! (make <signal>) s2) ratio)
        (add! s1 s3)
        (add! s2 (multiply! s3 -1)))
  s1)
(define-method divide2 ((s1 <signal>))
  (let1 s2 (make <signal>)
    (dolist [slot (class-slots <signal>)]
            (let1 sname (slot-definition-name slot)
                  (set! (~ s1 sname) (* (~ s1 sname) 1/2))
                  (set! (~ s2 sname) (~ s1 sname))))
    (list s1 s2)))
(define-method normalize! ((s1 <signal>))
  (dolist [slot (class-slots <signal>)]
          (let1 sname (slot-definition-name slot)
                (normalize! (~ s1 sname)))))



(define-class <cell> ()
    ((type   :init-value 'I :init-keyword :type   :accessor type-of)
     (stock  :init-form (make <circular-value>)  :init-keyword :stock  :accessor stock-of)
     (len    :init-value 0 :init-keyword :len :accessor len-of)
     (angle  :init-value 0 :init-keyword :angle :accessor angle-of)
     (signal :init-form (make <signal>)  :init-keyword :signal :accessor signal-of)))

(define-class <tree> ()
    ((data :init-value '() :init-keyword :data :accessor data-of)
     (rsignal :init-form (make <signal>) :init-keyword :rsignal :accessor rsignal-of)
     (rules :init-value '() :init-keyword :rules :accessor rules-of)))

(define (make-tree tree-expr)
    (define (each1 t)
        (cond ((null? t) '())
              ((atom? t) (make <cell> :type t))
              (else (cons (each1 (car t)) (each1 (cdr t))))))
    (each1 tree-expr))

(define-method initialize ((self <tree>) initargs)
    (next-method)
    (set! (~ self 'data) (make-tree (~ self 'data))))


(define-method write-object ((cv <circular-value>) port)
  (format port "~a"
          (average cv)))
(define-method write-object ((s <signal>) port)
  (format port "s:~a:~a"
          (~ s 'fuel)
          (~ s 'sugar)))
(define-method write-object ((c <cell>) port)
  (format port "<~a ~a ~a>"
          (~ c 'type)
          (~ c 'stock)
          (~ c 'signal)))
(define-method write-object ((tree <tree>) port)
  (format port "~a ~a"
          (~ tree 'rsignal)
          (~ tree 'data)))


(define (grow! tree)
  (define (propagate! cell signal)
    (transfer! (signal-of cell) signal 0.2)
    (normalize! (signal-of cell)))
  (define (each1 signal t)
    (if (null? t) '()
        (let* ((separate-signal (divide2 signal))
               (s1 (car separate-signal))
               (s2 (cadr separate-signal))
               (head-tree (if (is-a? (car t) <cell>)
                              (begin
                                (propagate! (car t) s1)
                                ((~ tree 'rules) (car t) s1))
                              (each1 s1 (car t))))
               (tail-tree (each1 s2 (cdr t))))
          (add! s1 s2)
          (if (and (pair? head-tree) (is-a? (car t) <cell>))
              (append head-tree tail-tree)
              (cons head-tree tail-tree)))))
  (set! (~ tree 'data) (each1 (~ tree 'rsignal) (~ tree 'data)))
  tree)


(define my-rules (^(cell signal)
  (let1 cs (signal-of cell)
        (match (type-of cell)
               ['R cell]
               ['I (if (> (average (fuel-of cs)) 40)
                       (begin 
                         (add! (fuel-of cs) -40)
                         (list cell (make <cell> :type 'I)))
                       cell)]
               [_ cell]))))

(define test-tree (make <tree> 
        :data '(R I (I L) I A)
        :rsignal (make <signal> :fuel (make-circular-value 100))
        :rules my-rules))

(define test-tree (make <tree> 
        :data '(I)
        :rsignal (make <signal> :fuel (make-circular-value 120))
        :rules my-rules))


(grow! test-tree)










