;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Larger) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; Image, Image -> Boolean
;; returns true if the first image is larger than the second
(define (larger-than? firstImage secondImage)
  (> (* (image-height firstImage) (image-width firstImage))
     (* (image-height secondImage) (image-width secondImage))))

;; (define (larger-than? firstImage secondImage) true) : stub;
;; (define (larger-than? firstImage secondImage) (... firstImage secondImage)) : template;

(check-expect (larger-than? (rectangle 20 40 "solid" "black") (rectangle 20 20 "solid" "black")) true)
(check-expect (larger-than? (rectangle 40 20 "solid" "black") (rectangle 30 20 "solid" "black")) true)
(check-expect (larger-than? (rectangle 20 40 "solid" "black") (rectangle 20 50 "solid" "black")) false)
(check-expect (larger-than? (rectangle 30 30 "solid" "black") (rectangle 30 30 "solid" "black")) false)
(check-expect (larger-than? (rectangle 20 40 "solid" "black") (rectangle 40 20 "solid" "black")) false)

 