(define (my-filter pred s)
    (cond ((null? s) nil)
          ((pred (car s)) (cons (car s) (my-filter pred (cdr s))))
          (else (my-filter pred (cdr s))))
    )

(define (interleave lst1 lst2)
    (cond ((null? lst1) lst2)
          ((null? lst2) lst1)
          (else (cons (car lst1) (interleave lst2 (cdr lst1))))
          )
    )

(define (accumulate joiner start n term)
    (cond ((= n 0) start)
          (else (joiner (term n) (accumulate joiner start (- n 1) term)))
          )
    )

(define (no-repeats lst)
    (if (null? lst) nil
        (begin (define ele (car lst))
               (define rest
                   (my-filter (lambda (x) (not (= x ele))) (cdr lst)))
               (cons ele (no-repeats rest))))
    )
