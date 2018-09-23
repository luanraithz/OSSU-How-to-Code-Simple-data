;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 11-EnumDefinition) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; As part of designing a system to keep track of student grades,
;; you are asked to design a data definition to represent the letter
;; in a courde, which is one of the A, B or C.

;; LetterGrade is one of:
;; - "A"
;; - "B"
;; - "C"
;; inter. the latter grade in a cource.


(define (fn-for-letter-grade lg)
  (cond [(string=? lg "A") (...)]
        [(string=? lg "B") (...)]
        [(string=? lg "C") (...)]))

;; Template rules used:
;;  - one of: 3 cases
;; - atomic distinct value: "A"
;; - atomic distinct value: "B"
;; - atomic distinct value: "C"