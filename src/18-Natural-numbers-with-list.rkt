;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 18-Natural-numbers-with-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; naturals-starter.rkt

; 
; Now that we understand how to form data definitions for abitrary-sized data we can 
; look at how to design functions that "count down" on natural numbers.  Here's the 
; key inight - ask yourself how many natural numbers are there?
; 
; A lot, many... an arbitrary number:
; 
; 0                      ;0
; (add1 0)               ;1
; (add1 (add1 0))        ;2
; (add1 (add1 (add1 0))) ;3
; 
; and so on
; 
; What that is saying is that (add1 <some natural>) produces a natural, 
; similarly (sub1 <some natural other than 0>) produces a natural.
; 
; So add1 is kind of like cons, it takes a natural and makes a bigger one 
; (cons makes a longer list). And sub1 is kind of like rest it takes a natural
; (other than 0) and gives the next smallest one (rest gives shorter list).
;                                                                       
; 
; Consider this type comment:
; 


;; Natural is one of:
;;  - 0
;;  - (add1 Natural)
;; interp. a natural number
(define N0 0)         ;0
(define N1 (add1 N0)) ;1
(define N2 (add1 N1)) ;2

(define (fn-for-natural n)
  (cond [(zero? n) (...)]
        [else
         (... ;n                           ;template rules wouldn't normally put this
          ;                            ;here, but we will see that we end up coming
          ;                            ;back to add it
          (fn-for-natural (sub1 n)))]))

;; Template rules used:
;;  - one-of: two cases
;;  - atomic distinct: 0
;;  - compound: (add1 Natural)
;;  - self-reference: (sub1 n) is Natural

; 
; PROBLEMs:
; 
; (A) Design a function that consumes Natural number n and produces the sum of all
;     the naturals in [0, n].
;     
; (B) Design a function that consumes Natural number n and produces a list of all
;     the naturals of the form (cons n (cons n-1 ... empty)) not including 0.
;     
;     
;     

; Natural -> Natural
; produce sum of Natural[0, n]

(check-expect (sum 0) 0)
(check-expect (sum 1) 1)
(check-expect (sum 3) (+ 3 2 1))
(check-expect (sum -0) 0)
(check-expect (sum -1) -1)
(check-expect (sum -3) (+ -3 -2 -1))

(define (sum n) 
  (cond [(zero? n) 0]
        [(< n 0) (+ n (sum (add1 n)))]
        [else (+ n (sum (sub1 n )))])) ;0


; Natural -> ListOfNatural
; prodce (cons n (cons n-1 ... empty)), not including 0 
(check-expect (to-list 0) empty)
(check-expect (to-list 1) (cons 1 empty))
(check-expect (to-list 2) (cons 2 (cons 1 empty)))
(check-expect (to-list 3) (cons 3 (cons 2 (cons 1 empty))))
(check-expect (to-list -1) (cons -1 empty))
(check-expect (to-list -2) (cons -2 (cons -1 empty)))
(check-expect (to-list -3) (cons -3 (cons -2 (cons -1 empty))))

(define (to-list n) 
  (cond [(zero? n) empty]
        [(< n 0) (cons n (to-list (add1 n)))]
        [else (cons n (to-list (sub1 n )))])) ;0