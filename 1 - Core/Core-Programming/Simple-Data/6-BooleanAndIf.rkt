;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6-BooleanAndIf) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Boolean and Conditional Operators

(define HEIGHT 100)
(define WIDTH 100)

(> WIDTH HEIGHT) ; Outputs: #false

(>= HEIGHT WIDTH) ; Outputs: #true

(= HEIGHT WIDTH) ; Outputs: #true

; String operators

;Equality
(string=? "foo" "bar") ;Outputs: #false

; If:
; (if <condition> <trueAction> <falseAction)
(if (= HEIGHT WIDTH) (+ 4 3) (- 3 1) )

; And condition:
; (and <condition> ...)

; Or condition:
; (or <condition> ...)

; Not operator:
; (not <condition>)