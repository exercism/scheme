; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/space-age/canonical-data.json
; File last updated on 2026-10-22T12:05:13+00:00

(load "test-util.ss")

(define (approx? out expected)
  (< (abs (- out expected)) 0.01))

(define test-cases
  `(
    (test-success "1. age on Earth"
        approx? age '(earth 1000000000)
        31.69)
    (test-success "2. age on Mercury"
        approx? age '(mercury 2134835688)
        280.88)
    (test-success "3. age on Venus"
        approx? age '(venus 189839836)
        9.78)
    (test-success "4. age on Mars"
        approx? age '(mars 2129871239)
        35.88)
    (test-success "5. age on Jupiter"
        approx? age '(jupiter 901876382)
        2.41)
    (test-success "6. age on Saturn"
        approx? age '(saturn 2000000000)
        2.15)
    (test-success "7. age on Uranus"
        approx? age '(uranus 1210123456)
        0.46)
    (test-success "8. age on Neptune"
        approx? age '(neptune 1821023456)
        0.35)
    (test-error "9. invalid planet causes error"
        age '(sun 680804807))
    ))

(run-with-cli "space-age.scm" (list test-cases))
