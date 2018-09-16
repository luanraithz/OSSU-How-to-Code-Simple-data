;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6-FunctionDesignAndTesting) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Design a function called double that consumes a number and return twice that number.
; The recipe is:
; * Signature, purpose, stub;
; * Examples (and testing with 'check-expect')
; * Inventory - template & constants
; * Cody body
; * Test and Debug

;; Signature : Number -> Number
;; Purpose 2 times the given number.

(check-expect (double 4) 8)
(check-expect (double 2) 4)
(check-expect (double 1.5) 3)

(define (double n) (* 2 n))
