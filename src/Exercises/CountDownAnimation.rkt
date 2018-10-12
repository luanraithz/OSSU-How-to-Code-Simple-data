;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname CountDownAnimation) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; countdown-animation starter.rkt

; PROBLEM:

; Design an animation of a simple countdown. 

; Your program should display a simple countdown, that starts at ten, and
; decreases by one each clock tick until it reaches zero, and stays there.

; To make your countdown progress at a reasonable speed, you can use the 
; rate option to on-tick. If you say, for example, 
; (on-tick advance-countdown 1) then big-bang will wait 1 second between 
; calls to advance-countdown.

; Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.

; Once you are finished the simple version of the program, you can improve
; it by reseting the countdown to ten when you press the spacebar.

(require 2htdp/image)
(require 2htdp/universe)

;; Count down from 10

;; =================
;; Constants:

(define WIDTH 600)
(define HEIGHT 400)

(define CTR-Y (/ HEIGHT 2))
(define MTS (empty-scene WIDTH HEIGHT))

;; =================
;; Data definitions:

;; Countdown is Number

(define C1 0)
(define C2 5)
(define C3 10)

;; =================
;; Functions:

(define (fn-for-count-down count)
  (... count))

;; CountDown -> CountDown
;; start the world with some number

(define (main init-count)
  (big-bang init-count             ; CountDown
            (on-tick  count-down)  ; CountDown -> CountDown
            (to-draw   render)))   ; CountDown -> Image

;; CountDown -> CountDown
;; produce the next count, reducing by one the argument
(check-expect (count-down 10) 9)
(check-expect (count-down 5) 4)
(check-expect (count-down 0) 0)

(define (count-down count)
  (if (<= count 0) 0 (- count 1)))

;; CountDown -> Image
;; render ... 
(check-expect (render 4) (place-image (text (number->string 4) 50 "black") (/ WIDTH 2) CTR-Y MTS))

(define (render count)
  (place-image (text (number->string count) 50 "black") (/ WIDTH 2) CTR-Y MTS))

(main 5000)