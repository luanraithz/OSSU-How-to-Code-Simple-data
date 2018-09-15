;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 2-Strings) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
"my own String"

(string-append "Life" " " "is" " " "awesome")

; (string-append 1 "x") Throws an error

(string-length "GOD DAMN THAT IS GOOD") ; Outputs 21

(substring "Are you out of your mind" 4 7) ; Outputs "you"