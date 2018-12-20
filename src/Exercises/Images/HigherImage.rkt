;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HigherImage) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; [Image, Image] -> Boolean
;; returns true if the first image is higher than the second

(require 2htdp/image)

(define (isHigherThan? firstImage secondImage)
  (> (image-height firstImage) (image-height secondImage)))

(check-expect (isHigherThan? (rectangle 2 4 "solid" "black") (rectangle 4 2 "solid" "black")) true)

(check-expect (isHigherThan? (rectangle 4 2 "solid" "black") (rectangle 2 4 "solid" "black")) false)

(check-expect (isHigherThan? (rectangle 3 3 "solid" "black") (rectangle 3 3 "solid" "black")) false)