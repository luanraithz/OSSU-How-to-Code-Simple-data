;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 12-Itemization) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Consider designing the system for controlling a New Year's Eve Display.
;; Design a data definition to represent the current sate of the countdown,
;; which falls into one of three categories:
; - Not yet started
; - From 1 to 10 seconds before midnight
; - Complete (Happy new Year!)


;; CountDown is one of:
;; - false
;; - Natural[1,10]
;; - "complete"
;; interp.
;;  false means countdown has not yet started.
;;  Natural[1,10] means countdown is running and how many seconds left.
;;  "complete" means countdown is over.

(define CD1 false) ;; not yet started
(define CD2 10) ;; just started running
(define CD3 1) ;; almost over
(define CD4 "complete")


(define (fn-for-countdown c)
  (cond [(false? c) (...)]
       [(number? c) (... c)]
       [else (...)]
  ))


;; Template rules used:
;; - one of 3 cases
;; - Atomic distinct : false
;; - Atomic non-distinct: Natural[1,10]
;; - Atomic distinct : "complete"