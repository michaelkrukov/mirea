#lang racket


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
    ((lambda (ring hole)
        (let ([result (pi . * . ((expt radius-ring 2) . - . (expt radius-hole 2)))])
            (printf "Площадь кольца: ~a кв.см.\n" (round_prec result 5))
        )
    ) radius-ring radius-hole)
)


; 2
(read-line)
(display "Введите время (минут.секунд) -> ")
(define i2 (string-split (read-line (current-input-port)) "."))
((lambda (minutes seconds)
    (if (or (minutes . < . 0) (minutes . > . 60))
        (display "Ошибка: минут должно быть '>= 0' и '<= 60'\n")
        (if (or (seconds . < . 0) (seconds . > . 60))
            (display "Ошибка: секунд должно быть '>= 0' и '<= 60'\n")
            (printf "Секунд: ~a\n" ((minutes . * . 60) . + . seconds))
        )
    )
) (string->number (list-ref i2 0)) (string->number (list-ref i2 1)))

; 3
(display "Вычисление стоимости покупки с учетом скидки\n")
(display "Введите сумму покупки и нажмите <Enter> = ")
((lambda (cost) (if (cost . > . 1000)
    (begin
        (display "Вам предоставляется скидка 10%\n")
        (printf "Сумма покупки с учетом скидки: ~a руб.\n" (round_prec (cost . * . 0.9) 2))
    )
    (printf "Сумма покупки: ~a руб.\n" (round_prec cost 2))
)) (read (current-input-port)))
