(use util.match)

(define (atom? x) (and (not (pair? x)) (not (null? x))))

(define (cell type stock len angle)
  `(cell ,type ,stock ,len ,angle))
(define (cellzero type)
  (cell type '(0 0 0) 0 '(0 0 0)))

(define (cell? lst) (and (pair? lst) (eq? (car lst) 'cell)))

(define (type cell)  (cadr cell))
(define (stock cell) (caddr cell))
(define (len cell)   (cadddr cell))
(define (angle cell) (car (cddddr cell)))
(define (type-eq? cell ty) (eq? (type cell) ty))

(define (walk func lst)
  (match lst
         [() '()]
         [('cell type stock len angle) (func type stock len angle)]
         [(x . xs) `(,(walk func x) . ,(walk func xs))]))

(define (walk func lst)
  (cond ((null? lst) '())
        ((cell? (car lst))
          (let1 after (func (car lst))
                (if (or (cell? after) (atom? after))
                    (cons after (walk func (cdr lst)))
                    (append after (walk func (cdr lst))))))
        (else
          (cons (walk func (car lst))
                (walk func (cdr lst))))
        ))

(define (print-tree tree)
  (walk (^(c) (type c)) tree))

(define acell (cellzero 'A))

(define ttree `(,(cellzero 'X) ,(cellzero 'A) (,(cellzero 'B) ,(cellzero 'C))))

(walk (^(c) (if (type-eq? c 'A) (list c c) c)) ttree)