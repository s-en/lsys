(use srfi-1)
(use srfi-25)
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
          :values (map + (~ c1 'values) (~ c2 'values))))
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
(define-method * ((c1 <circular-value>) (c2 <circular-value>))
    (make <circular-value> 
          :values (map * (~ c1 'values) (~ c2 'values))))
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
(define-method rotate ((vec3 <pair>) (r <number>) (p <number>) (y <number>))
  (let1 mat (array (shape 0 4 0 4)
              (* (cos r) (cos p)) (- (* (cos r) (sin p) (sin y)) (* (sin r) (cos y))) (+ (* (cos r) (sin p) (cos y)) (* (sin r) (sin y))) 0
              (* (sin r) (cos p)) (+ (* (sin r) (sin p) (sin y)) (* (cos r) (cos y))) (- (* (sin r) (sin p) (cos y)) (* (cos r) (sin y))) 0
              (* (sin p) -1) (* (cos p) (sin y)) (* (cos p) (cos y)) 0
              0 0 0 1)
        (subseq (array-mul mat (f32array (shape 0 4 0 1) (cons vec3 '(1)))) 0 3)))

(define-method rotate ((vec3 <pair>) (angle <pair>))
  (let* ((r #?=(car vec3))
         (p #?=(cadr vec3))
         (y #?=(caddr vec3)))
  (rotate vec3 r p y)))

(define (translate ((vec3 <pair>) (vx <number>) (vy <number>) (vz <number>))
  (let1 mat (array (shape 0 4 0 4)
              1 0 0 vx
              0 1 0 vy
              0 0 1 vz
              0 0 0 1)
        (subseq (array-mul mat vec3)) 0 3))
(define-method + ((v1 <f32array>) (v2 <f32array>))
    (array-add-elements v1 v2))

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
;(define-method transfer! ((s1 <signal>) (s2 <signal>) (ratio <number>))
;  (let1 s3 (multiply! (add! (make <signal>) s2) ratio)
;        (add! s1 s3)
;        (add! s2 (multiply! s3 -1)))
;  s1)
(define-method transfer! ((v1 <circular-value>) (v2 <circular-value>) (ratio <number>))
  (let1 v3 (* (+ (make <circular-value>) v2) ratio)
        (set! (~ v1 'values) (~ (+ v1 v3) 'values))
        (set! (~ v2 'values) (~ (+ v2 (* v3 -1)) 'values)))
  v1)


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
     (angle  :init-form (f32array (shape 0 4 0 1) 0 0 0 1) :init-keyword :angle :accessor angle-of)
     (signal :init-form (make <signal>)  :init-keyword :signal :accessor signal-of)))

(define-method transfer! ((cell <cell>) (sig <signal>))
    (let* ((stock (~ cell 'stock))
           (fuel  (~ sig  'fuel))
           (auxin (~ sig  'auxin))
           (len   (~ cell 'len)))
      (when (> (average fuel) (average stock))
            (transfer! (~ cell 'stock) (~ sig 'fuel) 0.2))
      (when (> (average fuel) len)
            (set! (~ cell 'len) (+ len (* (- (average fuel) len) 0.2))))))


(define-method get-vertexes ((cell <cell>) (parent-angle <array>) (parent-pos <array>))
    (let* ((stock (~ cell 'stock))
           (angle (+ parent-angle (~ cell 'angle)))
           (vec   (array (shape 0 3 0 1)
                         (0 #f32((~ cell 'len) 0))))
           (pos   (translate parent-pos vec))
           (circle-angle 0)
           (circle-margin (/ 2pi (length stock)))
           (cicular-vertexes (map (^(x)
                                     (inc! circle-angle circle-margin)
                                     (#f32((* x (cos circle-angle)) 0 (* x (sin circle-angle)))))
                                  stock)))
      (map (^(v)
              (translate v pos))
           cicular-vertexes)))

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


(define-method transfer! ((cell <cell>) (sig <signal>))
    (let* ((stock (~ cell 'stock))
           (fuel  (~ sig  'fuel))
           (auxin (~ sig  'auxin))
           (len   (~ cell 'len)))
      (when (> (average fuel) (average stock))
            (transfer! (~ cell 'stock) (~ sig 'fuel) 0.2))
      (when (and (not (eq? (~ cell 'type) 'R)) (> (average fuel) len))
            (set! (~ cell 'len) (+ len (* (- (average fuel) len) 0.2))))))

(define (grow! tree)
  (define (propagate! cell signal)
    (transfer! cell signal)
    (normalize! signal))
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


(define-method vertexes ((cell <cell>))
  (let* ((stock (~ (~ cell 'stock) 'values))
         (len (length stock))
         (delta (/ 2pi len))
         (cnt 0))
    (map (^(v)
            (set! cnt (+ cnt 1))
            (f32array (shape 0 3 0 1)
                      (* v (cos (* cnt delta)))
                      0
                      (* v (sin (* cnt delta)))))
         stock)))
(define-method vertexes ((tree <tree>))
  (let ((v '())
        (parent '())
        (pos (f32array (shape 0 4 0 1) 0 0 0 1))
        (angle (f32array (shape 0 4 0 1) 0 0 0 1)))
    (walk ^(cell)
          (if (null? parent)
              (set! parent cell)
              (let ((mv (~ cell 'stock))
                    (pv (~ parent 'stock))
                    (vecr (rotate (f32array (shape 0 4 0 1) (~ cell 'len) 0 0 1) angle))
                    (mpos (+ pos vecr))
                    (map (^(v) ()) (vertexes cell))
                    )
                ))
        (~ tree 'data)))
    v)


(define my-rules (^(cell signal)
  (let1 cs (signal-of cell)
        (match (type-of cell)
               ['R cell]
               ['I (if (> (average (fuel-of cs)) 30)
                       (begin 
                         (add! (fuel-of cs) -30)
                         (list cell (make <cell> :type 'I)))
                       cell)]
               [_ cell]))))

(define test-tree (make <tree> 
        :data '(R I (I L) I A)
        :rsignal (make <signal> :fuel (make-circular-value 100))
        :rules my-rules))

(define test-tree (make <tree> 
        :data '(R I)
        :rsignal (make <signal> :fuel (make-circular-value 120))
        :rules my-rules))


(grow! test-tree)









