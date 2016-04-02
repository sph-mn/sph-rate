(library (sph rate)
  (export
    path->rating
    path->rating-root
    path->root-and-rating-and-path&
    rate
    rate-get-destination-by-current-rating
    rate-get-destination-by-cwd)
  (import
    (rnrs base)
    (sph)
    (sph conditional)
    (sph filesystem)
    (sph string)
    (only (guile)
      string-prefix?
      getcwd
      rename-file
      dirname
      string-split
      string-join))

  (define (rate-get-destination-by-current-rating number path)
    (path->root-and-rating-and-path& path
      (l (root rating path-relative)
        (get-unique-target-path (string-append root "/" (number->string number) "/" path-relative)))))

  (define (rate-get-destination-by-cwd number path)
    (let (cwd (getcwd))
      (and (string-prefix? cwd path)
        (path-append cwd (number->string number) (string-drop-prefix cwd path)))))

  (define (rate number path)
    (let*
      ( (path-source (path->full-path path))
        (path-destination
          (or (rate-get-destination-by-current-rating number path-source)
            (rate-get-destination-by-cwd number path-source))))
      (false-if-not path-destination
        (begin (ensure-directory-structure (dirname path-destination))
          (rename-file path (get-unique-target-path path-destination))))))

  (define (path->root-and-rating-and-path& path c)
    (let loop ((prev (list)) (next (reverse (string-split path #\/))))
      (if (null? next) #f
        (let* ((a (first next)) (a-number (string->number a)))
          (if (and a-number (not (null? prev)))
            (c (string-join (reverse (tail next)) "/") a-number (string-join prev "/"))
            (loop (pair a prev) (tail next)))))))

  (define (path->rating-root path)
    (path->root-and-rating-and-path& path (l (root rating path) root)))

  (define (path->rating path) "string -> integer"
    (path->root-and-rating-and-path& path (l (root rating path) rating))))
