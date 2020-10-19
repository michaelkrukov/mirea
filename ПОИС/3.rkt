#lang racket


#|
    Написать программу, реализующую метод сортировки пузырька
|#

(define (sorted-pair a b) (if (< a b) (list a b) (list b a)))
(define (is-sorted arr) (if (< (length arr) 2) #t (if (<= (car arr) (cadr arr)) (is-sorted (cdr arr)) #f)))
(define (-bubble-sort-pass arr)
    (if (< (length arr) 2) arr (if (< (car arr) (cadr arr))
        (cons (car arr) (-bubble-sort-pass (cdr arr)))
        (cons (cadr arr) (-bubble-sort-pass (cons (car arr) (cddr arr))))
    ))
)
(define (bubble-sort arr)
    (if (is-sorted arr) arr (bubble-sort (-bubble-sort-pass arr)))
)
(define (test-bubble-sort n)
    (define array (build-list n (lambda (i) (random 100))))
    (displayln array)
    (displayln (bubble-sort array))
)

(displayln "Bubble sort:")
(test-bubble-sort 20)
(newline)


#|
    Написать программу, реализующую метод быстрой сортировки
|#

(define (quick-sort arr)
  (cond
    [(< (length arr) 2) arr]
    [else (let ([pivot (car arr)] [rest (cdr arr)])
            (append
                (quick-sort (filter (lambda (x) (< x pivot)) rest))
                (list pivot)
                (quick-sort (filter (lambda (x) (>= x pivot)) rest))
            )
        )]))

(define (test-quick-sort n)
    (define array (build-list n (lambda (i) (random 100))))
    (displayln array)
    (displayln (quick-sort array))
)

(displayln "Quick sort:")
(test-quick-sort 20)
(newline)


#|
    Написать программу-парсер строки, вводимой пользователем для
    вычис-ления математического выражения, строка может содержать
    скобки, чис-ла, знаки арифметических операций
|#

(require parser-tools/lex)
(require (prefix-in : parser-tools/lex-sre))

(define calc-lexer
  (lexer
   [(:+ (:or (char-range #\a #\z) (char-range #\A #\Z)))
    (cons `(ID ,(string->symbol lexeme))
          (calc-lexer input-port))]

   [#\(
    (cons '(LPAR)
          (calc-lexer input-port))]

   [#\)
    (cons '(RPAR)
          (calc-lexer input-port))]

   [(:: (:? #\-) (:+ (char-range #\0 #\9)))
    (cons `(INT ,(string->number lexeme))
          (calc-lexer input-port))]

   [(:or #\+ #\* #\/ #\-)
    (cons `(OP ,(string->symbol lexeme))
          (calc-lexer input-port))]

   [whitespace
    (calc-lexer input-port)]

   [(eof)
    '()]))

(define (parse-calc-expression value)
    (let ([input (open-input-string value)]) (calc-lexer input))
)

(displayln "Math expression (\"2 + (1 / 5) * 10 - 4\"):")
(parse-calc-expression "2 + (1 / 5) * 10 - 4")
