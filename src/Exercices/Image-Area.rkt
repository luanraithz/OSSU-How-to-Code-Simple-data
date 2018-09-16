;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Image-Area) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;DESIGN a function called image-area that consumes an image and produces the 
;area of that image. For the area it is sufficient to just multiple the image's 
;width by its height.

(require 2htdp/image)

; Image -> Natural
; return the area of a given image
; (define (image-area image) 0 ) : Stub
; (define (image-area image) (...image) ) : Template

(define (image-area image)
  (* (image-width image) (image-height image)
))


(check-expect (image-area (rectangle 40 20 "solid" "black")) (* 40 20))

(check-expect (image-area (rectangle 40 40 "solid" "black")) (* 40 40))
