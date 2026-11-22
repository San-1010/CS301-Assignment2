#lang racket/base



; my-length : list -> exact-nonnegative-integer
; Counts the top-level elements of a list using tail recursion.
; The accumulator stores the number of elements visited so far.
(define (my-length lst)
  (let loop ((remaining lst)
             (count 0))
    (if (null? remaining)
        count
        (loop (cdr remaining)
              (+ count 1)))))

; my-reverse : list -> list
; Reverses a list using tail recursion and an accumulator.
; Accumulator invariant: it contains the reverse of all elements
; processed so far. When remaining is empty, the accumulator
; contains the complete reversed list.
(define (my-reverse lst)
  (let loop ((remaining lst)
             (result '()))
    (if (null? remaining)
        result
        (loop (cdr remaining)
              (cons (car remaining) result)))))

; my-map : function list -> list
; Applies f to every top-level element of lst and returns a new list
; in the original order. Uses tail recursion with an accumulator.
; Accumulator invariant: result contains the mapped values of all
; processed elements in reverse order. my-reverse restores their order
; when the remaining list becomes empty.
(define (my-map f lst)
  (let loop ((remaining lst)
             (result '()))
    (if (null? remaining)
        (my-reverse result)
        (loop (cdr remaining)
              (cons (f (car remaining)) result)))))

; make-inserter : atom function -> (list -> list)
; Returns a function that recursively processes every list at every
; nesting level. Each list's original length is checked before insertion.
; The recursive function processes nested lists using my-map, preserves
; atoms unchanged, and uses cons to insert x when len-ok? is true.
(define (make-inserter x len-ok?)
  (letrec ((walk
            (lambda (lst)
              (let ((original-length (my-length lst)))
                (let ((processed
                       (my-map
                        (lambda (element)
                          (if (or (null? element)
                                  (pair? element))
                              (walk element)
                              element))
                        lst)))
                  (if (len-ok? original-length)
                      (cons x processed)
                      processed))))))
    (lambda (lst)
      (walk lst))))

; insert-if-short : atom list exact-nonnegative-integer -> list
; Inserts x at the front of every list whose original length is
; strictly less than n, at every nesting level.
; Delegates all recursive processing and insertion to make-inserter.
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))

; print-insert-result : -> void
; Reads x, lst, and n from standard input in that order,
; applies insert-if-short, displays the resulting list,
; and terminates the output with a newline.
(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))