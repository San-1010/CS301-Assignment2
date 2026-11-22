#lang racket/base

(require "../code/26_q3.rkt")

;; Helper to run a traversal/metric printer on a labeled test tree.
(define (run-case label tree)
  (display (string-append "=== " label " ===\n"))
  (display "-- print-inorder --\n")
  (print-inorder tree)
  (display "-- print-all-traversals --\n")
  (print-all-traversals tree)
  (display "-- print-height-and-leaves --\n")
  (print-height-and-leaves tree)
  (newline))

;; ---------------------------------------------------------------------------
;; Assignment example trees: t1, t2, t3, and '()
;; ---------------------------------------------------------------------------

;; t1:
;;       1
;;      / \
;;     2   3
(define t1
  '(1 (2 () ())
      (3 () ())))

;; t2:
;;       10
;;      /  \
;;     5    15
;;      \     \
;;       7     20
(define t2
  '(10 (5 ()
           (7 () ()))
       (15 ()
           (20 () ()))))

;; t3:
;;         a
;;        / \
;;       b   c
;;      /   / \
;;     d   e   f
;;          \
;;           g
(define t3
  '(a (b (d () ())
         ())
      (c (e ()
            (g () ()))
         (f () ()))))

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
;; Test executions & expected outputs
;; ---------------------------------------------------------------------------

;; Expected for t1:
;; print-inorder:
;;   (2 1 3)
;; print-all-traversals:
;;   (2 1 3)
;;   (1 2 3)
;;   (2 3 1)
;; print-height-and-leaves:
;;   (2 2)
(run-case "t1" t1)

;; Expected for t2:
;; print-inorder:
;;   (5 7 10 15 20)
;; print-all-traversals:
;;   (5 7 10 15 20)
;;   (10 5 7 15 20)
;;   (7 5 20 15 10)
;; print-height-and-leaves:
;;   (3 2)
(run-case "t2" t2)

;; Expected for t3:
;; print-inorder:
;;   (d b a e g c f)
;; print-all-traversals:
;;   (d b a e g c f)
;;   (a b d c e g f)
;;   (d b g e f c a)
;; print-height-and-leaves:
;;   (4 3)
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
