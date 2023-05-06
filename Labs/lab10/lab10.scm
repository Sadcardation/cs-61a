(define (over-or-under num1 num2)
    (cond 
          ((< num1 num2) -1)
          ((> num1 num2) 1)
          ((= num1 num2) 0)))

(define (make-adder num)
    (define (adder x) (+ x num))
    adder)

(define (composed f g)
    (define (com-helper x) (f (g x)))
    com-helper)

(define lst (list (cons 1 nil) 2 (cons 3 (cons 4 nil)) 5))

(define (duplicate lst)
    (if (not (null? lst))
        (begin
            (define rest (cdr lst))
            (append (cons (car lst) nil) (cons (car lst) nil) (duplicate rest)
            ))
        nil))
