
;; tuition-graph-starter.rkt  (just the problem statements)

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

(define-struct school (name price))
;; Player is (make-school String Number)
;; interp. (make-school name price) is a school with name and price

(define S1 (make-school "LD" 19000))

(define S2 (make-school "Wid" 20000))

(define S3 (make-school "Other" 19500))

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

(define (fn-for-los los)
  (cond [Q A]
        [Q A]
        [else (... (fn-for-school (first los))
        (fn-for-lost (rest los))])))

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

