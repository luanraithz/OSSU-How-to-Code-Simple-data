;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname MovieStruct) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; movie-starter.rkt

;; =================
;; Data definitions:
;; PROBLEM A:

;;  Design a data definition to represent a movie, including  
;; title, budget, and year released.

;; To help you to create some examples, find some interesting movie facts below: 
;;  "Titanic" - budget: 200000000 released: 1997
;;  "Avatar" - budget: 237000000 released: 2009
;;  "The Avengers" - budget: 220000000 released: 2012

;; However, feel free to resarch more on your own!

(define-struct movie (title budget release))
;; Movie is (make-movie String Number Number)

;; =================
;; Functions:

;; PROBLEM B:

;;  You have a list of movies you want to watch, but you like to watch your 
;; rentals in chronological order. Design a function that consumes two movies 
;; and produces the title of the most recently released movie.

;;  Note that the rule for templating a function that consumes two compound data 
;; parameters is for the template to include all the selectors for both 
;; parameters.

(define (recent mv1 mv2)
  (if (> (movie-release mv1) (movie-release mv2)) (movie-title mv1) (movie-title mv2)))


(define MV1 (make-movie "Titanic" 200000000 1997))
(define MV2 (make-movie "Avatar" 237000000 2009))
(define MV3 (make-movie "The Avengers" 220000000 2012))

(check-expect (recent MV1 MV2) (movie-title MV2))
(check-expect (recent MV1 MV3) (movie-title MV3))
(check-expect (recent MV3 MV2) (movie-title MV3))
(check-expect (recent MV3 MV1) (movie-title MV3))
(check-expect (recent MV2 MV1) (movie-title MV2))
(check-expect (recent MV2 MV3) (movie-title MV3))
