#lang racket


#|
    Написать программу вычисления площади кольца.
    Программа должна проверять правильность исходных
    данных. Ниже приведен рекомендуемый вид экрана во время
    выполнения программы.

        Вычисление площади кольца.
        Введите исходные данные:
        Радиус кольца (см) => 5
        Радиус отверстия (см) => 6
        Ошибка! Радиус отверстия не может быть больше радиуса кольца.
|#


(define (round_prec value prec)
    (let ([mult (expt 10 prec)])
        (/ (round (* value mult)) mult)
    )
)


; 1
(display "Вычисление площади кольца.\n")
(display "Введите исходные данные:\n")
(display "Радиус кольца (см) => ")
(define radius-ring (read (current-input-port)))
(display "Радиус отверстия (см) => ")
(define radius-hole (read (current-input-port)))
(if (radius-hole . >= . radius-ring)
    (display "Ошибка! Радиус отверстия не может быть больше радиуса кольца.\n")
    (let ([result (pi . * . ((expt radius-ring 2) . - . (expt radius-hole 2)))])
        (printf "Объем куба: ~a кв.см.\n" (round_prec result 5))
    )
)


; 2
(read-line)
(display "Введите время (минут.секунд) -> ")
(define i2 (string-split (read-line (current-input-port)) "."))
(define minutes (string->number	(list-ref i2 0)))
(define seconds (string->number	(list-ref i2 1)))
(if (or (minutes . < . 0) (minutes . > . 60))
    (display "Ошибка: минут должно быть '>= 0' и '<= 60'\n")
    (if (or (seconds . < . 0) (seconds . > . 60))
        (display "Ошибка: секунд должно быть '>= 0' и '<= 60'\n")
        (printf "Секунд: ~a\n" ((minutes . * . 60) . + . seconds))
    )
)

; 3
(display "Вычисление стоимости покупки с учетом скидки\n")
(display "Введите сумму покупки и нажмите <Enter> = ")
(define cost (read (current-input-port)))
(if (cost . > . 1000)
    (begin
        (display "Вам предоставляется скидка 10%\n")
        (printf "Сумма покупки с учетом скидки: ~a руб.\n" (round_prec (cost . * . 0.9) 2))
    )
    (printf "Сумма покупки: ~a руб.\n" (round_prec cost 2))
)
