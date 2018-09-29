;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Rocket) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; rocket-starter.rkt

;; =================
;; Data definitions:

;; PROBLEM A:

;;  You are designing a program to track a rocket's journey as it descends 
;; 100 kilometers to Earth. You are only interested in the descent from 
;; 100 kilometers to touchdown. Once the rocket has landed it is done.

;;  Design a data definition to represent the rocket's remaining descent. 
;; Call it RocketDescent.

;; RocketDescent is Number
;; Example 100 means that the rocket is 100 kilometers distant from Earth.

(define (fn-for-rocket-descent distance) (...))

;; =================
;; Functions:

;; PROBLEM B:

;;  Design a function that will output the rocket's remaining descent distance 
;; in a short string that can be broadcast on Twitter. 
;; When the descent is over, the message should be "".
;; Call your function rocket-descent-to-msg.

(define (rocket-descent-to-msg distance)
  (cond [(> distance 100) (string-append "The rocket is still over " (number->string distance) " kilometers far from Earth")]
        [(> distance 0) (string-append "The rocket is " (number->string distance) " kilometers far from Earth")]
        [else "The rocket has landed!"]))

(check-expect (rocket-descent-to-msg 101) "The rocket is still over 101 kilometers far from Earth")
(check-expect (rocket-descent-to-msg 98) "The rocket is 98 kilometers far from Earth")
(check-expect (rocket-descent-to-msg 22) "The rocket is 22 kilometers far from Earth")
(check-expect (rocket-descent-to-msg 0) "The rocket has landed!")

