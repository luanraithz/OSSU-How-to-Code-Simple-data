;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 16-List) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Problem:

; Image that you are designing a program that will keep track of
;; your favorite quidditch teams.

;; Design a data definition to represent a list of Quidditch teams.

;; Information                             Data
;     UBC                                  "UBC"
;   McGill                                "McGill"
; Team Who Must Not Be Named        "Team Who Must Not Be Named"

(define team-list (cons "UBC" (cons "McGill" (cons "Team Who Must Not Be Named" empty))))

team-list


;; ListOfString is one of:
;; - Empty
;; - (cons String ListOfString)
;; interp. a list of strings

(define LOS1 empty)
(define LOS2 (cons "McGill" empty))
(define LOS3 (cons "UBC" (cons "McGill" empty)))

(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else  
          (... (first lost) ; String
               (fn-for-los (rest lost)) ; cons String ListOfString
          )
        ]
  )
)

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons "String" ListOfString)

