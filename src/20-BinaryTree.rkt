;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 20-BinaryTree) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; bst-dd-starter.rkt

;; See the image at assets file (tree.png)

(define-struct node (key val l r))
;; BST (Binary Search Tree) is one of:
;; - false
;; - (make-node Integer String BST BST)
;; interp. false means no BSTm or empty BST
;;  key is the node key
;;  val is the node val
;;  l and r are left and right subtrees
;; Invariant: for a given node:
;; Key is > all keys in its l(eft) child
;; Key is < all keys in its r(ight) child
;; The same key never appears twice in the tree

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST27 (make-node 27 "wit" (make-node 4 "olp" false false) false))
(define BST42 (make-node 42 "ily" BST27 (make-node 50 "dug" false false)))
(define BST10 (make-node 10 "why" BST3 BST42))


(define (fn-for-bst t) 
  (cond [(false? t) (...)]
        [else (... 
          (node-key t) ; Integer 
          (node-val t) ; String
          (fn-for-bst (node-l t)) ; BST
          (fn-for-bst (node-r t)))])) ; BST
        


;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: false
;; - compound: (make-node Integer String BST BST)
;; - self reference: (node-l t) has type BST
;; - self reference: (node-r t) has type BST


; Problem


; Complete the design of the lookup-key function below. Note that because this is a search function
; it will sometimes 'fail'. this happens if it is callend with an key that doesn't exist in the BST it is provided.
; if this happens the function should produce false. The signature for such a function is written in a special way as shown below.

;; BST Natural -> String or False
;; Try to find node with given key, if found produce value; if not produce false.

(check-expect (lookup-key BST0 99) false)
(check-expect (lookup-key BST1 1) "abc")
(check-expect (lookup-key BST1 0) false)
(check-expect (lookup-key BST1 99) false)
(check-expect (lookup-key BST10 1) "abc") ;; L L
(check-expect (lookup-key BST10 4) "dcj") ;; L R
(check-expect (lookup-key BST10 27) "wit") ;; R L
(check-expect (lookup-key BST10 50) "dug") ;; R R


;; (define (lookup-key t k) "")

; <template according to BST, and additional atomic parameter k

(define (lookup-key t k)
  (cond [(false? t) false]
        [(= k (node-key t)) (node-val t)]
        [(< k (node-key t)) (lookup-key (node-l t) k)] ; go Left
        [(> k (node-key t)) (lookup-key (node-r t) k)] ; go Right
        ))
