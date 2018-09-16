;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Less-Than-Five) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; String -> Boolean
;; Checks if the string length is less than 5

(define (less word)
  (< (string-length word) 5)
  )

(check-expect (less "hey") true)
(check-expect (less "Hello") false)
(check-expect (less "Hey what the ...") false)