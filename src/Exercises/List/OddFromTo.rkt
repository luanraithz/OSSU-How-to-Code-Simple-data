;; odd-from-n-starter.rkt

;  PROBLEM:
;  
;  Design a function called odd-from-n that consumes a natural number n, and produces a list of all 
;  the odd numbers from n down to 1. 
;  
;  Note that there is a primitive function, odd?, that produces true if a natural number is odd.
; 



;; Natural Natural -> ListOfNatural
;; produces a list of the negative numbers between two other numbers

(define (odd-from-n first second)
  (cond [(zero? (- first second)) empty]
        [(not (= (quotient second 2) 0) (cons second (odd-from-to (sub1 first) second)) ]
        [else (odd-from-n (odd-from-to (sub1 first) second)))]))