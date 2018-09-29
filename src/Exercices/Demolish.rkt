;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Demolish) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; demolish-starter.rkt

;; =================
;; Data definitions:

;; PROBLEM A:

;;  You are assigned to develop a system that will classify 
;; buildings in downtown Vancouver based on how old they are. 
;; According to city guidelines, there are three different classification levels:
;; new, old, and heritage.

;;  Design a data definition to represent these classification levels. 
;; Call it BuildingStatus.

;; BuildStatus is one of:
;;  - "new"
;;  - "old"
;;  - "heritage"
;; interp. the classification of the age of the building;

;(define (fn-for-build-status status)
;  (cond [(string=? status "new") (...)]
;        [(string=? status "old") (...)]
;        [(string=? status "heritage") (...)]))

;; =================

;; Functions:
;; PROBLEM B:

;;  The city wants to demolish all buildings classified as "old". 
;; You are hired to design a function called demolish? 
;; that determines whether a building should be torn down or not

(check-expect (demolish? "heritage") false)
(check-expect (demolish? "old") true)
(check-expect (demolish? "new") false)

(define (demolish? status)
  (string=? status "old"))
