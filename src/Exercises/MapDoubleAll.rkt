;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname MapDoubleAll) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; double-starter.rkt

;; =================
;; Data definitions:

;;Remember the data definition for a list of numbers we designed in Lecture 5f:
;; (if this data definition does not look familiar, please review the lecture)


;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)
;; interp. a list of numbers
(define LON1 empty)
(define LON2 (cons 60 (cons 42 empty)))
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Number ListOfNumber)
;;  - self-reference: (rest lon) is ListOfNumber

;; =================
;; Functions:

(define (double-all lon)
  (cond [(empty? lon) empty]
        [else
         (cons (* (first lon) 2)
              (double-all (rest lon)))]))

(define LON3 (cons 23 (cons 13 (cons 10 (cons 8 empty)))))
(define LON4 (cons 9 (cons 45 (cons 21 (cons 92 (cons 23 (cons 100 empty)))))))
(define LON5 (cons 61 empty))


(check-expect (double-all LON1) empty)

(check-expect (double-all LON2) (cons 120 (cons 84 empty)))
(check-expect (double-all LON3) (cons 46 (cons 26 (cons 20 (cons 16 empty)))))
(check-expect (double-all LON4) (cons 18 (cons 90 (cons 42 (cons 184 (cons 46 (cons 200 empty)))))))
(check-expect (double-all LON5) (cons 122 empty))

