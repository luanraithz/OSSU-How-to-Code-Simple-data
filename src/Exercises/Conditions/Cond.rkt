;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Cond) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (greater-than value greater)
  (cond [(> value greater) (string-append (number->string value) " is greater than " (number->string greater))]
        [(< value greater) (string-append (number->string value) " isn't greater than " (number->string greater))]
        [else (string-append (number->string value) " is equals to " (number->string greater))]))


(check-expect (greater-than 10 20) "10 isn't greater than 20")
(check-expect (greater-than 20 10) "20 is greater than 10")
(check-expect (greater-than 10 10) "10 is equals to 10")
  