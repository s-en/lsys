(load "lib/match.so")

(define (atom? x) (and (not (pair? x)) (not (null? x))))

(define (cval val) (make-list 7 val))
(define (average cv) (/ (fold + 0 cv) (length cv)))

(define (cell type stock len angle)
  `(cell ,type ,stock ,len ,angle))
(define (make-cell type)
  (cell type (cval 0) 0 (cval 0)))

(define (cell? lst) (and (pair? lst) (eq? (car lst) 'cell)))
(define (type cell)  (~ cell 1))
(define (stock cell) (~ cell 2))
(define (len cell)   (~ cell 3))
(define (angle cell) (~ cell 4))
(define (roll cell)  (~ (angle cell) 1))
(define (pitch cell) (~ (angle cell) 2))
(define (yaw cell)   (~ (angle cell) 3))
(define (type-eq? cell ty) (eq? (type cell) ty))
(define (apex? lst)  (and (cell? lst) (type-eq? lst 'A)))
(define (inter? lst) (and (cell? lst) (type-eq? lst 'I)))
(define (root? lst)  (and (cell? lst) (type-eq? lst 'R)))

(define (signal fuel auxin cyto)
  `(signal ,fuel ,auxin ,cyto))
(define (signal? lst) (and (pair? lst) (eq? (car lst) 'signal)))
(define (fuel s)  (~ s 1))
(define (auxin s) (~ s 2))
(define (cyto s)  (~ s 3))

(define (grow func tree sig)
  (define (split-signal sig)
    (define (half cv) (map (^(v) (* v 0.5)) cv))
    (signal (half (fuel sig)) (half (auxin sig)) (half (cyto sig))))
  (define (combine-signal s1 s2)
    (define (add x y) (map + x y))
    (signal (add (fuel s1) (fuel s2))
            (map (^(x y) (min (+ x y) 1)) (auxin s1) (auxin s2))
            (add (cyto s1) (cyto s2))))
  (define (walk tree sig)
    (match tree
      [() (cons '() sig)]
      [((? cell? x) . y)
       (let* ((halfsig (split-signal sig))
              (tail (walk y halfsig))
              (combsig (combine-signal halfsig (cdr tail)))
              (down (func x combsig))
              (new-cell (car down))
              (new-sig  (cdr down)))
         (cons (if (or (cell? new-cell) (atom? new-cell))
                   (cons new-cell (car tail))
                   (append new-cell (car tail)))
               new-sig))]
      [(x . y)
       (let* ((halfsig (split-signal sig))
              (head (walk x halfsig))
              (tail (walk y halfsig))
              (combsig (combine-signal (cdr head) (cdr tail))))
         (cons (cons (car head) (car tail)) combsig))]))
  (walk tree sig))


(define (myrules c s)
  (let* ((s1 
           (match c
                  [(? apex? x) (signal (fuel s) (cval 1.0) (cyto s))]
                  [_ (signal (fuel s) (auxin s) (cyto s))]))
         (burn (map * (fuel s1) (auxin s1)))
         (_auxin (map * (auxin s1) (cval 0.9)))
         (_stock (map + (stock c) (map * burn (map - (cval 1) (auxin s1)))))
         (_len (+ (len c) (average (map * burn (auxin s1)))))
         (new-sig (signal (map - (fuel s1) burn) _auxin (cyto s1)))
         (new-cell (cell (type c) _stock _len (angle c))))
    (cons new-cell new-sig)))


(define (print-tree tree)
  (walk (^(c) (type c)) tree))

(define acell (make-cell 'A))

(define ttree `(,(make-cell 'R) ,(make-cell 'I) ,(make-cell 'A)))

(grow myrules ttree (signal (cval 10) (cval 0) (cval 0.5)))
















