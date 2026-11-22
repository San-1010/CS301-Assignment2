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
