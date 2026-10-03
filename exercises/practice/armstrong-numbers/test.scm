; These tests are auto-generated with test data from: 
; https://github.com/exercism/problem-specifications/blob/main/exercises/armstrong-numbers/canonical-data.json
; File last updated on 2026-10-03T22:05:14+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. Zero is an Armstrong number" 
        equal? armstrong-number? '(0) #t)

    (test-success "2. Single-digit numbers are Armstrong numbers" 
        equal? armstrong-number? '(5) #t)

    (test-success "3. There are no two-digit Armstrong numbers" 
        equal? armstrong-number? '(10) #f)

    (test-success "4. Three-digit number that is an Armstrong number" 
        equal? armstrong-number? '(153) #t)

    (test-success "5. Three-digit number that is not an Armstrong number" 
        equal? armstrong-number? '(100) #f)

    (test-success "6. Four-digit number that is an Armstrong number" 
        equal? armstrong-number? '(9474) #t)

    (test-success "7. Four-digit number that is not an Armstrong number" 
        equal? armstrong-number? '(9475) #f)

    (test-success "8. Seven-digit number that is an Armstrong number" 
        equal? armstrong-number? '(9926315) #t)

    (test-success "9. Seven-digit number that is not an Armstrong number" 
        equal? armstrong-number? '(9926314) #f)

    (test-success "10. Armstrong number containing seven zeroes" 
        equal? armstrong-number? '(186709961001538790100634132976990) #t)

    (test-success "11. The largest and last Armstrong number" 
        equal? armstrong-number? '(115132219018763992565095597973971522401) #t)

    ))

(run-with-cli "armstrong-numbers.scm" (list test-cases))
