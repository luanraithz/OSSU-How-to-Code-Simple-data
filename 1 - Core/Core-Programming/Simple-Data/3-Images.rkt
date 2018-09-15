;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 3-Images) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image) ; Importing images functions

(circle 10 "solid" "black")

(rectangle 30 60 "outline" "blue")

(text "Hi" 24 "orange") ; This is an image not a string

(above 
  (circle 10 "solid" "red")
  (circle 20 "solid" "blue")
  (circle 30 "solid" "black"))

(beside 
  (circle 10 "solid" "red")
  (circle 20 "solid" "blue")
  (circle 30 "solid" "black"))

(overlay 
  (circle 10 "solid" "red")
  (circle 20 "solid" "blue")
  (circle 30 "solid" "black"))
