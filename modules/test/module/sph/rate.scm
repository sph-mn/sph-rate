(define-test-module (test module sph rate)
  (import
    (sph rate))

  (define-test (rate-parse-path arguments) (rate-parse-path (first arguments) list))

  (test-execute-procedures-lambda
    (rate-parse-path "/" #f
      "/1/2/3" (2 "/1" "3") "/1/2/3/a/b/c" (3 "/1/2" "a/b/c") "" #f "." #f "2/3/a" (3 "2" "a"))
    (rate-path->rating "/" #f "/1/2/3" 2 "/1/2/3/a/b/c" 3 "" #f "." #f)
    (rate-path->root "/" #f "/1/2/3" "/1" "/1/2/3/a/b/c" "/1/2" "" #f "." #f)))
