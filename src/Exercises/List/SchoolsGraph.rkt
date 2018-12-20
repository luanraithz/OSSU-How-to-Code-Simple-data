;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname SchoolsGraph) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; tuition-graph-starter.rkt 

; 
; PROBLEM:
; 
; Eva is trying to decide where to go to university. One important factor for her is 
; tuition costs. Eva is a visual thinker, and has taken Systematic Program Design, 
; so she decides to design a program that will help her visualize the costs at 
; different schools. She decides to start simply, knowing she can revise her design
; later.
; 
; The information she has so far is the names of some schools as well as their 
; international student tuition costs. She would like to be able to represent that
; information in bar charts like this one:
; 
; 
;         *some image with graphs*
;         
; (A) Design data definitions to represent the information Eva has.
; (B) Design a function that consumes information about schools and their
;     tuition and produces a bar chart.
; (C) Design a function that consumes information about schools and produces
;     the school with the lowest international student tuition.
; 

(require 2htdp/image)

(define-struct school (name price))
;; Player is (make-school String Number)
;; interp. (make-school name price) is a school with name and price

(define S1 (make-school "LD" 19000))

(define S2 (make-school "Wid" 20000))

(define S3 (make-school "Other" 15000))

(define (fn-for-school p)
  (... (school-name p)       ;String
      (school-price p)       ;Number
  ))

;; Templates rules used:
;;  - Compound: 2 fields

;; ListOfSchool is one of:
;; - Empty
;; - (cons School ListOfSchool)
;; interp. a list of schools

(define LOS1 empty)
(define LOS2 (cons S1 (cons S3 (cons S3 empty))))

;(define (fn-for-los los)
;  (cond [Q A]
;        [Q A]
;        [else (... (fn-for-school (first los))
;        (fn-for-lost (rest los)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic dinstinct: empty
;; - compound: (cons School ListOfSchool)
         

;; Constants: 
(define TEXT-SIZE 24)
(define TEXT-COLOUR "black")

(define Y-SCALE 1/200)
(define BAR-WIDTH 30)
(define BAR-COLOUR "lightblue")

;; Functions:

;; School -> Image

(define (get-square-for-school school)
  (overlay/align "center" "bottom"
    (rotate 90 (text (school-name school) TEXT-SIZE TEXT-COLOUR))
    (rectangle BAR-WIDTH (* (school-price school) Y-SCALE) "outline" "black")
    (rectangle BAR-WIDTH (* (school-price school) Y-SCALE) "solid" BAR-COLOUR)
    ))

;; ListOfSchool -> Image
;; Produces bar chart showing names and tuitions of consumed schools


(check-expect (charts empty) (square 0 "solid" "white"))
(check-expect (charts (cons S2 empty))
           (beside (get-square-for-school S2) (square 0 "solid" "white")))

(check-expect (charts (cons S2 (cons S3 empty)))
           (beside/align "bottom" (get-square-for-school S2) (beside/align "bottom" (get-square-for-school S3) (square 0 "solid" "white"))))



(define (charts los) (if (empty? los) (square 0 "solid" "white")
                         (beside/align "bottom" (get-square-for-school (first los)) (charts (rest los)))))

(charts (cons S1 (cons S2 (cons S3 empty))))