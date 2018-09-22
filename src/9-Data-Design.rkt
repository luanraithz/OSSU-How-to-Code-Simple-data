;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Data-Design) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; city-name

;; Atomic non-distinct

;; CityName is String
;; interp. the name of a city
(define CN1 "Boston")
(define CN2 "Vancouver")

(define (fn-for-city-name cn)
  (... cn))

;; Template rules used:
;; - atomic non-distinct: String


;; Functions:

;; CityName -> Boolean
;; produce true if the given city is the best in the world

(check-expect  (best? "Boston") false)
(check-expect  (best? "Blumenau") true)


; (define (best? cn) false);

; took template from CityName

(define (best? cn) (string=? cn "Blumenau"))



