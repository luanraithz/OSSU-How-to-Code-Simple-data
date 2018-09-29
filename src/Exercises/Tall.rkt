;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Tall) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Image -> Boolean
;; Produces true if the image is tall
;; (functions that return a Boolean are by convention written with '?' at the end of the name)
(check-expect (tall? (rectangle 2 3 "solid" "red")) true)
(check-expect (tall? (rectangle 3 2 "solid" "red")) false)
(check-expect (tall? (rectangle 2 2 "solid" "red")) false)

;;(define (tall? image) false) : Stub
;;(define (tall? image) (...image)) : template

(define (tall? image)
  (> (image-height image) (image-width image)))

  