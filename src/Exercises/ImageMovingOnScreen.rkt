;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ImageMovingOnScreen) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; cat-starter.rkt

; PROBLEM:

; Use the How to Design Worlds recipe to design an interactive
; program in which a cat starts at the left edge of the display 
; and then walks across the screen to the right. When the cat
; reaches the right edge it should just keep going right off 
; the screen.

; Once your design is complete revise it to add a new feature,
; which is that pressing the space key should cause the cat to
; go back to the left edge of the screen. When you do this, go
; all the way back to your domain analysis and incorporate the
; new feature.


(require 2htdp/image)
(require 2htdp/universe)

;; A cat that walks from left to right across the screen.

;; =================
;; Constants:

(define WIDTH 600)
(define HEIGHT 400)

(define CTR-Y (/ HEIGHT 2))

;; Background
(define MTS (empty-scene WIDTH HEIGHT))

;; I've removed the cat's image for make it readable on github
(define CAT-IMG (rectangle 10 10 "solid" "black"))

;; =================
;; Data definitions:

;; Cat is a Number
;; interp. x position of the cat in screen cordinates

(define C1 0)           ; left edge
(define C2 (/ WIDTH 2)) ; middle
(define C3 WIDTH)       ; right edge
#;
(define (fn-for-cat c)
  (... c))


;; Template rules used:
;; - Atomic non-distinct: Number

;; =================
;; Functions:

;; Cat -> Cat
;; start the world with (main 0)
;; 
(define (main c)
  (big-bang c                           ; Cat
            (on-tick   advance-cat)     ; Cat -> Cat
            (to-draw   render)))        ; Cat -> Image

;; Cat -> Cat
;; produce the next cat, by advancing it 1 pixel to right
(check-expect (advance-cat 3) 4)

(define (advance-cat c)
  (+ c 1))

;; Cat -> Image
;; render the cat image at appropriate place on MTS
(check-expect (render 4) (place-image CAT-IMG 4 CTR-Y MTS))
(define (render c)
  (place-image CAT-IMG c CTR-Y MTS))



