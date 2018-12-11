;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Remainder) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (remainder 4 3) 1)
(check-expect (remainder 780 360) 60)
(check-expect (remainder 60 30) 0)
(check-expect (remainder 1 1) 0)
(check-expect (remainder 120 35) 15)
