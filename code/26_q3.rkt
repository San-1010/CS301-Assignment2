#lang racket/base

;; Contract: inorder-acc : BTree (Listof Any) -> (Listof Any)
;; Recursive reading: Traverses right, root, then left while cons-ing onto
;; acc so the returned list is in inorder without append or reverse.
(define (inorder-acc tree acc)
  (cond
    [(null? tree) acc]
    [else
     (let ([val (car tree)]
           [left (cadr tree)]
           [right (caddr tree)])
       (inorder-acc left
                    (cons val
                          (inorder-acc right acc))))]))

;; Contract: print-inorder : BTree -> Void
;; Recursive reading: Collects the inorder elements starting from '() and
;; prints the resulting list on one line via display followed by newline.
(define (print-inorder tree)
  (display (inorder-acc tree '()))
  (newline))


;; Contract: preorder-acc : BTree (Listof Any) -> (Listof Any)
;; Recursive reading: Prepends the current node onto the preorder traversal of
;; right appended (via acc) to the preorder traversal of left, without append or reverse.
(define (preorder-acc tree acc)
  (cond
    [(null? tree) acc]
    [else
     (let ([val (car tree)]
           [left (cadr tree)]
           [right (caddr tree)])
       (cons val
             (preorder-acc left
                           (preorder-acc right acc))))]))

;; Contract: postorder-acc : BTree (Listof Any) -> (Listof Any)
;; Recursive reading: Prepends the current node onto acc, then threads that
;; accumulator through right and left so elements appear in postorder.
(define (postorder-acc tree acc)
  (cond
    [(null? tree) acc]
    [else
     (let ([val (car tree)]
           [left (cadr tree)]
           [right (caddr tree)])
       (postorder-acc left
                      (postorder-acc right
                                     (cons val acc))))]))

;; Contract: print-all-traversals : BTree -> Void
;; Recursive reading: Prints the inorder list (reusing inorder-acc), preorder
;; list, and postorder list on three separate lines using display and newline.
(define (print-all-traversals tree)
  (display (inorder-acc tree '()))
  (newline)
  (display (preorder-acc tree '()))
  (newline)
  (display (postorder-acc tree '()))
  (newline))
