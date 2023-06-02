(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (enumerate-helper l index)
      (cond ((null? l) nil)
            (else (append (cons (list index (car l)) nil) (enumerate-helper (cdr l) (+ index 1))))))
    
  (enumerate-helper s 0))
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to ORDERED? and return
;; the merged lists.
(define (merge ordered? list1 list2)
  ; BEGIN PROBLEM 16
  (cond ((null? list2) list1)
        ((null? list1) list2)
        (else 
              (cond ((ordered? (car list1) (car list2)) (append (list (car list1)) (merge ordered? (cdr list1) list2)))
                    (else (append (list (car list2)) (merge ordered? list1 (cdr list2)))))))
  )
  ; END PROBLEM 16

;; Optional Problem 2

;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN OPTIONAL PROBLEM 2
         expr
         ; END OPTIONAL PROBLEM 2
         )
        ((quoted? expr)
         ; BEGIN OPTIONAL PROBLEM 2
         expr
         ; END OPTIONAL PROBLEM 2
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM 2
           (cons form (cons params (may_handle_let body)))
           ; END OPTIONAL PROBLEM 2
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM 2
           ; get names by list of two-elements(values)
          (define (names list)
            (cond
              ((null? list) nil)
              (else (cons (caar list) (names (cdr list))))
            )
          )
          ; get real_values by list of two-elements(values)
          (define (real_values list)
            (cond
              ((null? list) nil)
              (else (cons (car (cdar list)) (real_values (cdr list))))
            )
          )
          ;let-to-lambda
          (cons (cons 'lambda (cons (may_handle_let (names values)) 
                              (may_handle_let body))) 
                              (may_handle_let (real_values values)))
           ; END OPTIONAL PROBLEM 2
           ))
        (else
         ; BEGIN OPTIONAL PROBLEM 2
         (may_handle_let expr)
         ; END OPTIONAL PROBLEM 2
         )))

; Some utility functions that you may find useful to implement for let-to-lambda

(define (may_handle_let expr)
    (cond
      ((null? expr) nil)
      (else (cons (let-to-lambda (car expr)) (may_handle_let (cdr expr)) ))             
    )
  )