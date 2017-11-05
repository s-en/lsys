(use util.match)

(define (atom? x) (and (not (pair? x)) (not (null? x))))

(define (cval val) (iota 7 val 0))

(define (cell type stock len angle)
  `(cell ,type ,stock ,len ,angle))
(define (make-cell type)
  (cell type (cval 0) 0 (cval 0)))

(define (cell? lst) (and (pair? lst) (eq? (car lst) 'cell)))
(define (type cell)  (~ cell 1))
(define (stock cell) (~ cell 2))
(define (len cell)   (~ cell 3))
(define (angle cell) (~ cell 4))
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
    (define (add x y) (map (^(a b) (+ a b)) x y))
    (signal (add (fuel s1) (fuel s1)) (add (auxin s1) (auxin s1)) (add (cyto s1) (cyto s1))))
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
               combsig))]
      [(x . y)
       (let* ((halfsig (split-signal sig))
              (head (walk x halfsig))
              (tail (walk y halfsig))
              (combsig (combine-signal (cdr head) (cdr tail))))
         (cons (cons (car head) (car tail)) combsig))]))
  (walk tree sig))

(define (uprules s)
  s)
(define (myrules c s)
  (cons c s))


(define (print-tree tree)
  (walk (^(c) (type c)) tree))

(define acell (make-cell 'A))

(define ttree `(,(make-cell 'R) ,(make-cell 'I) ,(make-cell 'A)))

(walk (^(c) (if (type-eq? c 'I) (list c c) c)) ttree)

(grow myrules ttree (signal (cval 10) (cval 0) (cval 0.5)))



















