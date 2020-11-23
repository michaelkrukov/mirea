#lang racket


#|
    Описать функцию, которая, выдавала бы атомарный элемент списка по
    заданному номеру n, считая от начала. Пример: для списка ‘((2) (3) 4 5 a
    (e r) g) и n=3 результатом будет a.
|#

(define (get-nth-atom lst n)
    (cond
        [(null? lst) null]
        [(list? (car lst)) (get-nth-atom (cdr lst) n)]
        [(= n 1) (car lst)]
        [else (get-nth-atom (cdr lst) (- n 1))]
    )
)

(displayln (get-nth-atom '((2) (3) 4 5 a (e r) g) 3)) ; -> a

#|
    Описать функцию, которая создавала бы список только из числовых
    элементов списка-аргумента. Список может содержать подсписки
    произвольной глубины.
|#

(define (select-numbers lst)
    (cond
        [(null? lst) '()]
        [(list? (car lst)) (append (select-numbers (car lst)) (select-numbers (cdr lst)))]
        [(number? (car lst)) (cons (car lst) (select-numbers (cdr lst)))]
        [else (select-numbers (cdr lst))]
    )
)

(displayln (select-numbers '((2) (((3), ((1)))) 4 5 a (e (r 5)) g))) ; -> (2 3 1 4 5 5)

#|
    Опишите функцию, которая из исходного списка формирует список,
    содержащий только символьные атомы.
|#

(define (select-chars lst)
    (cond
        [(null? lst) '()]
        [(list? (car lst)) (append (select-chars (car lst)) (select-chars (cdr lst)))]
        [(char? (car lst)) (cons (car lst) (select-chars (cdr lst)))]
        [else (select-chars (cdr lst))]
    )
)

(displayln (select-chars '((2) (((3), ((1)))) 4 5 #\a (#\e (#\r 5)) #\g))) ; -> (a e r g)
