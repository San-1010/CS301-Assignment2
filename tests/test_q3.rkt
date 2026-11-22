#lang racket/base

;; Helper to run a traversal/metric printer on a labeled test tree.
(define (run-case label tree)
  (display '===)
  (display label)
  (display '===)
  (newline)
  (display 'print-inorder:)
  (newline)
  (print-inorder tree)
  (display 'print-all-traversals:)
  (newline)
  (print-all-traversals tree)
  (display 'print-height-and-leaves:)
  (newline)
  (print-height-and-leaves tree)
  (newline))

;; ---------------------------------------------------------------------------
;; Assignment example trees: t1, t2, t3, and '()
;; ---------------------------------------------------------------------------

;; t1:
;;        4
;;      /   \
;;     2     6
;;    / \   / \
;;   1   3 5   7
;; Expected:
;;   inorder:           (1 2 3 4 5 6 7)
;;   preorder:          (4 2 1 3 6 5 7)
;;   postorder:         (1 3 2 5 7 6 4)
;;   height-and-leaves: (3 4)
(define t1
  '(4 (2 (1 () ())
         (3 () ()))
      (6 (5 () ())
         (7 () ()))))

;; t2:
;;   1
;;    \
;;     2
;;      \
;;       3
;; Expected:
;;   inorder:           (1 2 3)
;;   preorder:          (1 2 3)
;;   postorder:         (3 2 1)
;;   height-and-leaves: (3 1)
(define t2
  '(1 ()
      (2 ()
         (3 () ()))))

;; t3:
;;     a
;;    / \
;;   b   c
;; Expected:
;;   inorder:           (b a c)
;;   preorder:          (a b c)
;;   postorder:         (b c a)
;;   height-and-leaves: (2 2)
(define t3
  '(a (b () ())
      (c () ())))

;; Empty tree: '()
(define t-empty '())

;; ---------------------------------------------------------------------------
;; Edge-case trees: single-node, left-skewed, right-skewed
;; ---------------------------------------------------------------------------

;; Single-node tree:
;;     42
(define t-single
  '(42 () ()))

;; Left-skewed tree:
;;       4
;;      /
;;     3
;;    /
;;   2
;;  /
;; 1
(define t-left-skewed
  '(4 (3 (2 (1 () ())
            ())
         ())
      ()))

;; Right-skewed tree:
;;   1
;;    \
;;     2
;;      \
;;       3
;;        \
;;         4
(define t-right-skewed
  '(1 ()
      (2 ()
         (3 ()
            (4 () ())))))

;; ---------------------------------------------------------------------------
;; Test executions and expected output
;; ---------------------------------------------------------------------------

;; Expected:
;;   inorder:           (1 2 3 4 5 6 7)
;;   preorder:          (4 2 1 3 6 5 7)
;;   postorder:         (1 3 2 5 7 6 4)
;;   height-and-leaves: (3 4)
(run-case "t1" t1)

;; Expected:
;;   inorder:           (1 2 3)
;;   preorder:          (1 2 3)
;;   postorder:         (3 2 1)
;;   height-and-leaves: (3 1)
(run-case "t2" t2)

;; Expected:
;;   inorder:           (b a c)
;;   preorder:          (a b c)
;;   postorder:         (b c a)
;;   height-and-leaves: (2 2)
(run-case "t3" t3)

;; Expected for '() (empty tree):
;; print-inorder:
;;   ()
;; print-all-traversals:
;;   ()
;;   ()
;;   ()
;; print-height-and-leaves:
;;   (0 0)
(run-case "empty ('())" t-empty)

;; Expected for single-node tree '(42 () ()):
;; print-inorder:
;;   (42)
;; print-all-traversals:
;;   (42)
;;   (42)
;;   (42)
;; print-height-and-leaves:
;;   (1 1)
(run-case "single-node '(42 () ())" t-single)

;; Expected for left-skewed tree:
;; print-inorder:
;;   (1 2 3 4)
;; print-all-traversals:
;;   (1 2 3 4)
;;   (4 3 2 1)
;;   (1 2 3 4)
;; print-height-and-leaves:
;;   (4 1)
(run-case "left-skewed" t-left-skewed)

;; Expected for right-skewed tree:
;; print-inorder:
;;   (1 2 3 4)
;; print-all-traversals:
;;   (1 2 3 4)
;;   (1 2 3 4)
;;   (4 3 2 1)
;; print-height-and-leaves:
;;   (4 1)
(run-case "right-skewed" t-right-skewed)
