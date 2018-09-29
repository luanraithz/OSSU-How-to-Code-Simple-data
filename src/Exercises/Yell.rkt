;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Yell) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> String
; add a '!' at the end of a given string.
; Stub: (define (yell word) "")
; Template (define (yell word) (...word);

(define (yell word)
  (string-append word "!")
  )

(check-expect "hello!" (yell "hello"))

(check-expect "bye!" (yell "bye"))

(check-expect "See ya!" (yell "See ya"))