;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname FirstClass) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Expressions

;(<primitive> <expression>...)
;Numbers(<value>) can be expressions

;Adding numbers

(+ 3 4 )
;Outputs 7

(+ 4 4 (* 4 2 (/ 8 2)))
;Outputs 40

(sqr 3)
;Outputs 9

(sqrt 81)
;Outputs 9

;Question 1
;Pythagoras, find the Hypotenuse of an right-angle triangle of values of 3 and 4.
(sqrt (+ (sqr 3) (sqr 4)))

;   When the expression returns a irrational numbers, 
; racker returns the result what an 'i' in the beggining, 
; to explecit that the value shown isn't exacly what it is.
