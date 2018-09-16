;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Sum-Squares) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Sum of squares;
; Design a function which computes the sum of the squares of the numbers from 1 to n.
; n returns 1*1 + 2*2 + ... + n*n

(define (sum-squares square)
  (if (= square 0) 0 (+ (* square square) (sum-squares (- square 1)))))


; formula = (square + 1) (2.square + 1) /6

(define (formula square)
  (/ (* square (* (+ square 1) (+ (* 2 square) 1))) 6))

; Test with 5

(check-expect (formula 5) (sum-squares 5))

(check-expect 55 (sum-squares 5))

; Test with 4
(check-expect (formula 4) (sum-squares 4))

(check-expect 30 (sum-squares 4))

; Test with 8

(check-expect (formula 8) (sum-squares 8))

(check-expect 204 (sum-squares 8))


; Test with 10

(check-expect (formula 10) (sum-squares 10))

(check-expect 385 (sum-squares 10))


