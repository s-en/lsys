(define (atom? x) (not (pair? x)))

(define (copy-instance obj)
  (rlet1 new (make (class-of obj))
    (dolist [slot (class-slots (class-of obj))]
      (set! (~ new (slot-definition-name slot))
            (~ obj (slot-definition-name slot))))))

(define-class <cell> ()
    ((type  :init-value 'I :init-keyword :type  :accessor type-of)
     (stock :init-value 0  :init-keyword :stock :accessor stock-of)
     (fuel  :init-value 0  :init-keyword :fuel  :accessor fuel-of)
     (sugar :init-value 0  :init-keyword :sugar :accessor sugar-of)
     (auxin :init-value 0  :init-keyword :auxin :accessor auxin-of)
     (cyto  :init-value 0  :init-keyword :cyto  :accessor cyto-of)))

(define-class <signal> ()
   ((fuel  :init-value 0 :init-keyword :fuel  :accessor fuel-of)
    (sugar :init-value 0 :init-keyword :sugar :accessor sugar-of)
    (auxin :init-value 0 :init-keyword :auxin :accessor auxin-of)
    (cyto  :init-value 0 :init-keyword :cyto  :accessor cyto-of)))

(define-class <replace-rule> ()
    ((target :init-value 'I :init-keyword target :accessor target-of)
     (condition :init-value (^ (#t)) :init-keyword condition :accessor condition-of)
     (after :init-value '() :init-keyword :after :accessor after-of)))

(define-class <tree> ()
    ((data :init-value '() :init-keyword :data :accessor data-of)
     (rsignal :init-value (make <signal>) :init-keyword :rsignal :accessor rsignal-of)
     (rules :init-value '() :init-keyword :rules :accessor rules-of)
     ))
(define-method initialize ((self <tree>) initargs)
    (next-method)
    (set! (~ self 'data) (make-tree (~ self data))))

(define-method write-object ((c <cell>) port)
  (format port "<~a ~a>"
          (~ c 'type)
          (~ c 'stock)))

(define-method write-object ((s <signal>) port)
  (format port "<signal ~a ~a>"
          (~ s 'fuel)
          (~ s 'sugar)))


(define (make-tree tree-expr)
    (define (each1 t)
        (cond ((null? t) '())
              ((atom? t) (make <cell> :type t))
              (else (cons (each1 (car t)) (each1 (cdr t))))))
    (each1 tree-expr))

(define-method + ((s1 <signal>) (s2 <signal>))
  (dolist [slot (class-slots <signal>)]
          (inc! (~ s1 (slot-definition-name slot))
                (~ s2 (slot-definition-name slot))))
  s1)
(define-method divide2 ((s1 <signal>))
  (let1 s2 (make <signal>)
    (dolist [slot (class-slots <signal>)]
            (let1 sname (slot-definition-name slot)
                  (set! (~ s1 sname) (/ (~ s1 sname) 2))
                  (set! (~ s2 sname) (~ s1 sname))))
    (list s1 s2)))

(define-method apply-signal! ((signal <signal>) (cell <cell>) (rules <replace-rule>))
    cell)

(define (grow tree)
  (define (each1 signal t)
    (if (null? t) '()
        (let* ((separate-signal (divide2 signal))
               (s1 (car separate-signal))
               (s2 (cadr separate-signal))
               (head-tree (if (is-a? (car t) <cell>)
                              (apply-signal! s1 (car t) (~ tree 'rules))
                              (each1 s1 (car t))))
               (tail-tree (each1 s2 (cdr t))))
          (+ s1 s2)
          (cons head-tree tail-tree))))
  (set! (~ tree 'data) (each1 (~ tree 'rsignal) (~ tree 'data))))

(define (broadcast-signal tree)
   (define (each1 t signal)
       (cond ((null? t) signal)
             ((is-a? (car t) <cell>)
                 (down-signal (each1 (cdr t) (raise-signal signal (car t))) (car t)))
             (else
                 (+ (each1 (car t) signal) (each1 (cdr t) signal)))))
   (each1 tree (make <signal> :fuel 100 :sugar 100)))


(define test-tree (make <tree> 
                        :data '(R I (I L) I A)
                        :))
(define rsig (make <signal> :fuel 100 :sugar 100))


(define new-tree (grow test-tree rsig))
()










