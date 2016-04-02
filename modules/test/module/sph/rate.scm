(define-test-module (test module sph rate)
  (import
    (sph rate))

  (define-test (path->root-and-rating-and-path& arguments)
    (path->root-and-rating-and-path& (first arguments) list))

  (test-execute-procedures-lambda
    (path->root-and-rating-and-path& "/" #f
      "/1/2/3" ("/1" 2 "3") "/1/2/3/a/b/c" ("/1/2" 3 "a/b/c") "" #f "." #f)
    (path->rating "/" #f "/1/2/3" 2 "/1/2/3/a/b/c" 3 "" #f "." #f)
    (path->rating-root "/" #f "/1/2/3" "/1" "/1/2/3/a/b/c" "/1/2" "" #f "." #f)))
