;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 14-Struct) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Structures

; Define a structure called pos(position) that has the x and y properties

(define-struct pos (x y))

(make-pos 3 6) ; Contrusctor

(define P1 (make-pos 3 6))

(pos-y P1) ; Getter ; Outputs: 6
(pos-x P1) ; Getter ; Outputs: 3

(pos? P1) ; "Type of"