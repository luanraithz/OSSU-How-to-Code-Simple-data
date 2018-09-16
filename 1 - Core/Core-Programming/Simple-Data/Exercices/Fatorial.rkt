;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Fatorial) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; create a function that returns the fatorial of a given number

; Number -> Number

(define (fatorial n) 
    (if (<= n 1) 1 (* n (fatorial (- n 1)))))

(check-expect (fatorial 0) 1)

(check-expect (fatorial 2) 2)

(check-expect (fatorial 5) 120)

(check-expect (fatorial 7) 5040)

(check-expect (fatorial 8) 40320)