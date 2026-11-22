
; ============================================================
; CS F301 - Assignment 2
; S2: Conditionally Insert into a Nested List
;
; Comprehensive test suite for code/26_q4.rkt
;
; Coverage:
; 1. my-length
; 2. my-reverse
; 3. my-map
; 4. make-inserter
; 5. insert-if-short
; 6. Empty lists and boundary conditions
; 7. Numeric and symbol atoms
; 8. Original-length checking
; 9. Nesting depth of 100
; 10. Flat lists of 10,000 elements
;
; All test helpers use only permitted Scheme built-ins.
; ============================================================


; ------------------------------------------------------------
; TEST SUPPORT FUNCTIONS
; ------------------------------------------------------------

; same-result? : numeric-value numeric-value -> boolean
; Recursively compares nested lists containing numeric atoms.
; Empty lists are equal, pairs are compared element by element,
; and numeric atoms are compared using =.
(define (same-result? actual expected)
  (if (and (null? actual) (null? expected))
      #t
      (if (and (pair? actual) (pair? expected))
          (and (same-result? (car actual) (car expected))
               (same-result? (cdr actual) (cdr expected)))
          (if (or (pair? actual) (pair? expected))
              #f
              (= actual expected)))))


; same-symbol-result? : symbol-list symbol-list -> boolean
; Recursively compares nested lists containing symbol atoms.
; Uses eq? to compare symbols and preserves list structure.
(define (same-symbol-result? actual expected)
  (if (and (null? actual) (null? expected))
      #t
      (if (and (pair? actual) (pair? expected))
          (and (same-symbol-result? (car actual) (car expected))
               (same-symbol-result? (cdr actual) (cdr expected)))
          (if (or (pair? actual) (pair? expected))
              #f
              (eq? actual expected)))))


; check : symbol value value -> void
; Compares numeric results and reports PASS or FAIL.
(define (check test-name actual expected)
  (if (same-result? actual expected)
      (begin
        (display 'PASS:)
        (display test-name)
        (newline))
      (begin
        (display 'FAIL:)
        (display test-name)
        (display ' expected:)
        (display expected)
        (display ' actual:)
        (display actual)
        (newline))))


; check-symbol : symbol value value -> void
; Compares symbol results and reports PASS or FAIL.
(define (check-symbol test-name actual expected)
  (if (same-symbol-result? actual expected)
      (begin
        (display 'PASS:)
        (display test-name)
        (newline))
      (begin
        (display 'FAIL:)
        (display test-name)
        (display ' expected:)
        (display expected)
        (display ' actual:)
        (display actual)
        (newline))))


; ------------------------------------------------------------
; TEST DATA GENERATORS
; ------------------------------------------------------------

; make-descending : exact-nonnegative-integer -> list
; Creates a list containing n, n-1, ..., 1.
; Uses tail recursion and an accumulator.
(define (make-descending n)
  (let loop ((current 1)
             (result '()))
    (if (> current n)
        result
        (loop (+ current 1)
              (cons current result)))))


; make-ascending : exact-nonnegative-integer -> list
; Creates a list containing 1, 2, ..., n.
; Uses tail recursion and an accumulator.
(define (make-ascending n)
  (let loop ((current n)
             (result '()))
    (if (< current 1)
        result
        (loop (- current 1)
              (cons current result)))))


; make-descending-from : integer integer -> list
; Creates a descending list from high down to low.
; Uses tail recursion and an accumulator.
(define (make-descending-from high low)
  (let loop ((current low)
             (result '()))
    (if (> current high)
        result
        (loop (+ current 1)
              (cons current result)))))


; make-nested : integer -> nested-list
; Creates a list nested to the specified depth.
; The innermost value is the empty list.
(define (make-nested depth)
  (if (= depth 0)
      '()
      (list (make-nested (- depth 1)))))


; make-expected-nested : integer -> nested-list
; Creates the expected result after inserting 0 into
; every list in a structure of the specified depth.
(define (make-expected-nested depth)
  (if (= depth 0)
      '(0)
      (list 0
            (make-expected-nested (- depth 1)))))


; ------------------------------------------------------------
; PART A: MY-LENGTH
; ------------------------------------------------------------

(check 'length-empty
       (my-length '())
       0)

(check 'length-single-element
       (my-length '(5))
       1)

(check 'length-flat-list
       (my-length '(1 2 3 4 5))
       5)

(check 'length-nested-list
       (my-length '(1 (2 3) (4 (5 6)) 7))
       4)

(check 'length-only-nested-lists
       (my-length '((1 2) (3 4) (5 6)))
       3)

(check 'length-empty-nested-lists
       (my-length '(() () ()))
       3)

(check 'length-symbol-list
       (my-length '(a b c d))
       4)


; ------------------------------------------------------------
; PART B: MY-REVERSE
; ------------------------------------------------------------

(check 'reverse-empty
       (my-reverse '())
       '())

(check 'reverse-single-element
       (my-reverse '(5))
       '(5))

(check 'reverse-flat-list
       (my-reverse '(1 2 3 4))
       '(4 3 2 1))

(check-symbol 'reverse-symbol-list
              (my-reverse '(a b c d))
              '(d c b a))

(check 'reverse-nested-elements
       (my-reverse '((1 2) (3 4) 5))
       '(5 (3 4) (1 2)))

(check-symbol 'reverse-preserves-nested-elements
              (my-reverse '(a (b c) d))
              '(d (b c) a))


; ------------------------------------------------------------
; PART C: MY-MAP
; ------------------------------------------------------------

(check 'map-empty
       (my-map (lambda (x) (+ x 1)) '())
       '())

(check 'map-add-one
       (my-map (lambda (x) (+ x 1)) '(1 2 3))
       '(2 3 4))

(check 'map-double
       (my-map (lambda (x) (* x 2)) '(1 2 3))
       '(2 4 6))

(check 'map-square
       (my-map (lambda (x) (* x x)) '(2 3 4))
       '(4 9 16))

(check 'map-preserves-order
       (my-map (lambda (x) x) '(1 2 3 4 5))
       '(1 2 3 4 5))

(check 'map-nested-elements
       (my-map (lambda (x) x) '((1 2) (3 4) 5))
       '((1 2) (3 4) 5))

(check-symbol 'map-symbols
              (my-map (lambda (x) x) '(a b c))
              '(a b c))


; ------------------------------------------------------------
; PART D: MAKE-INSERTER
; ------------------------------------------------------------

(check 'make-inserter-inserts
       ((make-inserter 9 (lambda (n) (< n 3))) '(1 2))
       '(9 1 2))

(check 'make-inserter-does-not-insert
       ((make-inserter 9 (lambda (n) (< n 2))) '(1 2))
       '(1 2))

(check 'make-inserter-empty-list
       ((make-inserter 9 (lambda (n) (< n 1))) '())
       '(9))

(check 'make-inserter-empty-list-rejected
       ((make-inserter 9 (lambda (n) (> n 0))) '())
       '())

(check 'make-inserter-custom-condition
       ((make-inserter 0 (lambda (n) (= n 2)))
        '((1 2) (3) (4 5)))
       '((0 1 2) (3) (0 4 5)))

(check-symbol 'make-inserter-symbol
              ((make-inserter 'x (lambda (n) (< n 3))) '(a b))
              '(x a b))


; ------------------------------------------------------------
; PART E: OFFICIAL ASSIGNMENT EXAMPLES
; ------------------------------------------------------------

; Example 1 from the assignment.
(check 'official-example-1
       (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3)
       '((42 1 2) (3 4 5) (42 6) (42)))


; Example 2 from the assignment.
(check 'official-example-2
       (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3)
       '((0 (0 1) 2) (0 3) (0 (4 5 6) (0))))


; ------------------------------------------------------------
; PART F: EMPTY LISTS AND BOUNDARY CONDITIONS
; ------------------------------------------------------------

(check 'empty-top-level-positive-n
       (insert-if-short 7 '() 3)
       '(7))

(check 'empty-top-level-zero-n
       (insert-if-short 7 '() 0)
       '())

(check 'empty-top-level-n-one
       (insert-if-short 7 '() 1)
       '(7))

(check 'nested-empty-lists
       (insert-if-short 8 '(() (())) 2)
       '((8) (8 (8))))

(check 'nested-empty-lists-zero-n
       (insert-if-short 8 '(() (())) 0)
       '(() (())))

(check 'length-less-than-n
       (insert-if-short 9 '(1 2) 3)
       '(9 1 2))

(check 'length-equals-n
       (insert-if-short 9 '(1 2 3) 3)
       '(1 2 3))

(check 'length-greater-than-n
       (insert-if-short 9 '(1 2 3 4) 3)
       '(1 2 3 4))

(check 'length-one-n-one
       (insert-if-short 9 '(1) 1)
       '(1))

(check 'length-zero-n-zero
       (insert-if-short 9 '() 0)
       '())


; ------------------------------------------------------------
; PART G: TOP-LEVEL AND NESTED LISTS
; ------------------------------------------------------------

(check 'top-level-insertion
       (insert-if-short 99 '(1 2) 3)
       '(99 1 2))

(check 'top-level-not-inserted
       (insert-if-short 99 '(1 2 3) 3)
       '(1 2 3))

(check 'mixed-atoms-and-nested-lists
       (insert-if-short 9 '(1 (2 3) 4 (5 (6))) 3)
       '(1 (9 2 3) 4 (9 5 (9 6))))

(check 'multiple-levels-of-nesting
       (insert-if-short 0 '((1 (2 (3))) ((4)) 5) 3)
       '((0 1 (0 2 (0 3))) (0 (0 4)) 5))

(check 'all-elements-are-numeric-atoms
       (insert-if-short 0 '(1 2 3) 4)
       '(0 1 2 3))

(check-symbol 'symbol-insertion
              (insert-if-short 'x '(a (b c) d) 3)
              '(a (x b c) d))

(check 'nested-lists-of-different-lengths
       (insert-if-short 0 '((1) (2 3) (4 5 6)) 3)
       '((0 1) (0 2 3) (4 5 6)))


; ------------------------------------------------------------
; PART H: ORIGINAL LENGTH BEFORE INSERTION
; ------------------------------------------------------------

(check 'original-length-before-insertion
       (insert-if-short 0 '((1)) 3)
       '(0 (0 1)))

(check 'original-length-equals-threshold
       (insert-if-short 0 '(1 2) 2)
       '(1 2))

(check 'nested-original-length
       (insert-if-short 0 '((1 2)) 3)
       '(0 (0 1 2)))


; ------------------------------------------------------------
; PART I: HIDDEN TEST - 10,000 ELEMENT FLAT LIST
; ------------------------------------------------------------

; Construct 10,000 elements.
(define large-list
  (make-descending 10000))

; Expected ascending list for reversal.
(define large-ascending
  (make-ascending 10000))

; Expected mapped list: 10001 down to 2.
(define large-mapped
  (make-descending-from 10001 2))


; my-length must count all 10,000 elements.
(check 'large-my-length-10000
       (my-length large-list)
       10000)


; my-reverse must reverse all 10,000 elements.
(check 'large-my-reverse-10000
       (my-reverse large-list)
       large-ascending)


; my-map must map all 10,000 elements and preserve order.
(check 'large-my-map-10000
       (my-map (lambda (x) (+ x 1)) large-list)
       large-mapped)


; Insert into a list of length 10,000 when n = 10,001.
(check 'large-insertion-10000
       (insert-if-short 999 large-list 10001)
       (cons 999 large-list))


; No insertion when original length equals 10,000.
(check 'large-no-insertion-at-10000
       (insert-if-short 999 large-list 10000)
       large-list)


; ------------------------------------------------------------
; PART J: HIDDEN TEST - NESTING DEPTH OF 100
; ------------------------------------------------------------

; Construct a structure with exactly 100 levels of nesting.
(define depth-100-list
  (make-nested 100))


; Expected result when every list receives an insertion.
(define depth-100-expected
  (make-expected-nested 100))


; All 100 singleton lists and the innermost empty list
; must receive an insertion when n = 2.
(check 'nesting-depth-100
       (insert-if-short 0 depth-100-list 2)
       depth-100-expected)


; With n = 0, no list at any level should receive an insertion.
(check 'nesting-depth-100-zero-threshold
       (insert-if-short 0 depth-100-list 0)
       depth-100-list)


; ------------------------------------------------------------
; END OF TEST SUITE
; ------------------------------------------------------------

(display 'ALL-TESTS-FINISHED)
(newline)
