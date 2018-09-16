;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5-Functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; functions-definition

(above (circle 40 "solid" "red")
       (circle 40 "solid" "yellow")
       (circle 40 "solid" "green"))

; '(circle 40 "solid" ' is repeated many times 

; function definition:
; '(define (<functionName> <firstParamName>...)
;   <expression>Body of the function)
; Define function 'defaultCircle' with the first parameter as 'color' that returns a circle with 40 as radius and solid
(define (defaultCircle color)
  (circle 40 "solid" color))

(above (defaultCircle "red")
       (defaultCircle "yellow")
       (defaultCircle "green"))