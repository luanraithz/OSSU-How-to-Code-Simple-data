;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Fibonacci) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (fibonacci number)
  (if (<= number 1) number (+ ( fibonacci (- number 1)) (fibonacci (- number 2)))))
(check-expect (fibonacci 1) 1)
(check-expect (fibonacci 0) 0)
(check-expect (fibonacci 2) 1)
(check-expect (fibonacci 3) 2)
(check-expect (fibonacci 9) 34)
(check-expect (fibonacci 18) 2584)