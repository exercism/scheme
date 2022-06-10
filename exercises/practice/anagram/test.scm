(load "test-util.ss")

(define test-cases
  `((test-success "no matches"
      (lambda (xs ys)
        (equal? (list-sort string<? xs) (list-sort string<? ys)))
      anagram '("diaper" ("hello" "world" "zombies" "pants")) '())
     (test-success "detects two anagrams"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram '("master" ("stream" "pigeon" "maters"))
       '("stream" "maters"))
     (test-success "does not detect anagram subsets"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram '("good" ("dog" "goody")) '())
     (test-success "detects anagram"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram '("listen" ("enlists" "google" "inlets" "banana"))
       '("inlets"))
     (test-success "detects three anagrams"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram
       '("allergy"
          ("gallery" "ballerina" "regally" "clergy" "largely"
            "leading"))
       '("gallery" "regally" "largely"))
     (test-success "detects multiple anagrams with different case"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram '("nose" ("Eons" "ONES")) '("Eons" "ONES"))
     (test-success "does not detect non-anagrams with identical checksum"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram '("mass" ("last")) '())
     (test-success "detects anagrams case-insensitively"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram
       '("Orchestra" ("cashregister" "Carthorse" "radishes"))
       '("Carthorse"))
     (test-success "detects anagrams using case-insensitive subject"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram
       '("Orchestra" ("cashregister" "carthorse" "radishes"))
       '("carthorse"))
     (test-success "detects anagrams using case-insensitive possible matches"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram
       '("orchestra" ("cashregister" "Carthorse" "radishes"))
       '("Carthorse"))
     (test-success
       "does not detect an anagram if the original word is repeated"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram '("go" ("go Go GO")) '())
     (test-success "anagrams must use all letters exactly once"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram '("tapper" ("patter")) '())
     (test-success "words are not anagrams of themselves (case-insensitive)"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram '("BANANA" ("BANANA" "Banana" "banana")) '())
     (test-success "words other than themselves can be anagrams"
       (lambda (xs ys)
         (equal? (list-sort string<? xs) (list-sort string<? ys)))
       anagram '("LISTEN" ("Listen" "Silent" "LISTEN"))
       '("Silent"))))

(run-with-cli "anagram.scm" (list test-cases))

