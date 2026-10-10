; These tests are auto-generated with test data from: 
; https://github.com/exercism/problem-specifications/blob/main/exercises/anagram/canonical-data.json
; File last updated on 2026-10-10T19:33:41+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. no matches"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("diaper" ("hello" "world" "zombies" "pants")) 
        `())
    (test-success "2. detects two anagrams"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("solemn" ("lemons" "cherry" "melons")) 
        `("lemons" "melons"))
    (test-success "3. does not detect anagram subsets"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("good" ("dog" "goody")) 
        `())
    (test-success "4. detects anagram"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("listen" ("enlists" "google" "inlets" "banana")) 
        `("inlets"))
    (test-success "5. detects three anagrams"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("allergy" ("gallery" "ballerina" "regally" "clergy" "largely" "leading")) 
        `("gallery" "regally" "largely"))
    (test-success "6. detects multiple anagrams with different case"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("nose" ("Eons" "ONES")) 
        `("Eons" "ONES"))
    (test-success "7. does not detect non-anagrams with identical checksum"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("mass" ("last")) 
        `())
    (test-success "8. detects anagrams case-insensitively"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("Orchestra" ("cashregister" "Carthorse" "radishes")) 
        `("Carthorse"))
    (test-success "9. detects anagrams using case-insensitive subject"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("Orchestra" ("cashregister" "carthorse" "radishes")) 
        `("carthorse"))
    (test-success "10. detects anagrams using case-insensitive possible matches"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("orchestra" ("cashregister" "Carthorse" "radishes")) 
        `("Carthorse"))
    (test-success "11. does not detect an anagram if the original word is repeated"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("go" ("goGoGO")) 
        `())
    (test-success "12. anagrams must use all letters exactly once"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("tapper" ("patter")) 
        `())
    (test-success "13. words are not anagrams of themselves"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("BANANA" ("BANANA")) 
        `())
    (test-success "14. words are not anagrams of themselves even if letter case is partially different"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("BANANA" ("Banana")) 
        `())
    (test-success "15. words are not anagrams of themselves even if letter case is completely different"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("BANANA" ("banana")) 
        `())
    (test-success "16. words other than themselves can be anagrams"
        (lambda (xs ys)
            (equal? (list-sort string<? xs) (list-sort string<? ys)))
        anagram '("LISTEN" ("LISTEN" "Silent")) 
        `("Silent"))
    ))

(run-with-cli "anagram.scm" (list test-cases))



