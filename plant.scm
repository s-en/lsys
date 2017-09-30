(use util.match)

(define (atom? x) (not (pair? x)))

(define (walk func tree)
  (match tree
         [() '()]
         [(x . xs) `(,(walk func x) . ,(walk func xs))]
         [x (func x)] ))


(define-class <signal> ()
   ((fuel  :init-value 0 :init-keyword :fuel  :accessor fuel-of)
    (sugar :init-value 0 :init-keyword :sugar :accessor sugar-of)
    (auxin :init-value 0 :init-keyword :auxin :accessor auxin-of)
    (cyto  :init-value 0 :init-keyword :cyto  :accessor cyto-of)))

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
                  (set! (~ s1 sname) (/ (~ s1 sname) 2))
                  (set! (~ s2 sname) (~ s1 sname))))
    (list s1 s2)))



(define-class <cell> ()
    ((type   :init-value 'I :init-keyword :type   :accessor type-of)
     (stock  :init-value 0  :init-keyword :stock  :accessor stock-of)
     (signal :init-value '()  :init-keyword :signal :accessor signal-of)))
(define-method initialize ((self <cell>) initargs)
    (next-method)
    (set! (~ self 'signal) (make <signal>)))

(define-class <tree> ()
    ((data :init-value '() :init-keyword :data :accessor data-of)
     (rsignal :init-value (make <signal>) :init-keyword :rsignal :accessor rsignal-of)
     (rules :init-value '() :init-keyword :rules :accessor rules-of)
     ))

(define (make-tree tree-expr)
    (define (each1 t)
        (cond ((null? t) '())
              ((atom? t) (make <cell> :type t))
              (else (cons (each1 (car t)) (each1 (cdr t))))))
    (each1 tree-expr))

(define-method initialize ((self <tree>) initargs)
    (next-method)
    (set! (~ self 'data) (make-tree (~ self 'data))))




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
  (format port "~a"
          (~ tree 'data)))


(define (grow! tree)
  (define (each1 signal t)
    (if (null? t) '()
        (let* ((separate-signal (divide2 signal))
               (s1 (car separate-signal))
               (s2 (cadr separate-signal))
               (head-tree (if (is-a? (car t) <cell>)
                              ((~ tree 'rules) (car t) s1)
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
        (transfer! cs signal 1/7)
        (match (type-of cell)
               ['R cell]
               ['I (if (> (fuel-of cs) 5)
                       (begin 
                         (dec! (fuel-of cs) 5)
                         (list cell (make <cell> :type 'I)))
                       cell)]
               [_ cell]))))

(define test-tree (make <tree> 
        :data '(R I (I L) I A)
        :rsignal (make <signal> :fuel 100)
        :rules my-rules))

(define test-tree (make <tree> 
        :data '(I)
        :rsignal (make <signal> :fuel 100)
        :rules my-rules))


(grow! test-tree)










