(define-module (sph rate))
(use-modules (srfi srfi-2) (sph) (sph filesystem) (sph other) (sph string))

(export rate rate-get-destination-by-current-rating
  rate-get-destination-by-cwd rate-parse-path rate-path->rating rate-path->root)

(define sph-rate-description
  "helpers for rating files under numeric directories by moving them into another numeric directory.
   examples:
   rate 2 /a/0/b/c -> /a/2/b/c
   cwd: /a/b
   rate 2 /a/b/c -> /a/b/2/c
   cwd: /
   rate 2 /a/b/c -> /2/a/b/c")

(define rate-parse-path
  (let
    (stop?
      (l (a)
        (or (string-null? a) (string-equal? "/" a) (string-equal? "." a) (string-equal? ".." a))))
    (l (a c)
      "string procedure:{integer:rating string:rating-root string:sub-path -> any} -> any
       find the first numeric upper directory. its dirname is the root, its name the rating"
      (and-let* ((root (and (not (stop? a)) (dirname a)))) "a/1/b/c -> a/1 b c"
        (let loop ((root (dirname root)) (name (basename root)) (path (basename a)))
          (let (rating (string->number name))
            (if rating (c rating root path)
              (if (stop? root) #f
                (loop (dirname root) (basename root) (string-append name "/" path))))))))))

(define (rate-path->root path) "string -> false/string"
  (rate-parse-path path (l (rating root path) root)))

(define (rate-path->rating path) "string -> false/integer"
  (rate-parse-path path (l (rating root path) rating)))

(define (rate-get-destination-by-current-rating number path)
  (rate-parse-path path
    (l (rating root path)
      (get-unique-path (string-append root "/" (number->string number) "/" path)))))

(define (rate-get-destination-by-cwd number path)
  (let (cwd (getcwd))
    (and (string-prefix? cwd path)
      (path-append cwd (number->string number) (string-drop-prefix cwd path)))))

(define (rate number path)
  (let*
    ( (path-source (realpath* path))
      (path-destination
        (or (rate-get-destination-by-current-rating number path-source)
          (rate-get-destination-by-cwd number path-source))))
    (false-if-not path-destination
      (begin (ensure-directory-structure (dirname path-destination))
        (rename-file path (get-unique-path path-destination))))))
