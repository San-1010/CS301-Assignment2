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


;; Contract: tree-height : BTree -> Natural
;; Recursive reading: Returns 0 for an empty tree; otherwise adds 1 to the
;; greater of the left and right subtree heights.
(define (tree-height tree)
  (cond
    [(null? tree) 0]
    [else
     (let ([lh (tree-height (cadr tree))]
           [rh (tree-height (caddr tree))])
       (+ 1 (if (> lh rh) lh rh)))]))

;; Contract: leaf-count : BTree -> Natural
;; Recursive reading: Returns 0 for an empty tree, 1 when both left and right
;; subtrees are empty, and otherwise the sum of leaf counts in left and right.
(define (leaf-count tree)
  (cond
    [(null? tree) 0]
    [else
     (let ([left (cadr tree)]
           [right (caddr tree)])
       (if (and (null? left) (null? right))
           1
           (+ (leaf-count left) (leaf-count right))))]))

;; Contract: print-height-and-leaves : BTree -> Void
;; Recursive reading: Computes the height and leaf count of tree and prints
;; them as a two-element list on one line via display followed by newline.
(define (print-height-and-leaves tree)
  (display (list (tree-height tree) (leaf-count tree)))
  (newline))
