; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/pythagorean-triplet/canonical-data.json
; File last updated on 2026-10-15T04:40:07+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. triplets whose sum is 12"
        equal? triplets-with-sum '(12)
        '((3 4 5)))

    (test-success "2. triplets whose sum is 108"
        equal? triplets-with-sum '(108)
        '((27 36 45)))

    (test-success "3. triplets whose sum is 1000"
        equal? triplets-with-sum '(1000)
        '((200 375 425)))

    (test-success "4. no matching triplets for 1001"
        equal? triplets-with-sum '(1001)
        '())

    (test-success "5. returns all matching triplets"
        equal? triplets-with-sum '(90)
        '((9 40 41) (15 36 39)))

    (test-success "6. several matching triplets"
        equal? triplets-with-sum '(840)
        '((40 399 401) (56 390 394) (105 360 375) (120 350 370) (140 336 364) (168 315 357) (210 280 350) (240 252 348)))

    (test-success "7. triplets for large number"
        equal? triplets-with-sum '(30000)
        '((1200 14375 14425) (1875 14000 14125) (5000 12000 13000) (6000 11250 12750) (7500 10000 12500)))
    ))

(run-with-cli "pythagorean-triplet.scm" (list test-cases))
