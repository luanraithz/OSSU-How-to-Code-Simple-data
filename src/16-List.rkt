;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 16-List) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Sumary

;; cons - a two argument list constructor
;; first - selectes the first element of a list
;; second - selects the elements after the first
;; empty - check if the list is empty

(define empty-list empty) ;; prints '()

;; List of 1 element
(define L1 (cons "Flames" empty)) ;; prints (cons "Flames" '())

;; List of 2 elements
(define L2 (cons "Leafts" (cons "Flames" empty))) ;; prints (cons "Leafts" (cons "Flames" '()))

(first L1) ;; prints "Flames"
(first L2) ;; prints "Leafts"

(rest L1) ;; '()
(rest L2) ;; (cons "Flames" '())

(empty? empty-list) ;; true
(empty? L1) ;; false
(empty? L2) ;; false