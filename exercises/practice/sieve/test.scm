(load "test-util.ss")

(define test-cases
  `((test-success "no primes under two" equal? sieve '(1) '()) (test-success "find first prime" equal? sieve '(2) '(2))
     (test-success "find primes up to 10" equal? sieve '(10)
       '(2 3 5 7))
     (test-success "limit is prime" equal? sieve '(13)
       '(2 3 5 7 11 13))
     (test-success "find primes up to 1000" equal? sieve '(1000)
       '(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73
         79 83 89 97 101 103 107 109 113 127 131 137 139 149 151 157
         163 167 173 179 181 191 193 197 199 211 223 227 229 233 239
         241 251 257 263 269 271 277 281 283 293 307 311 313 317 331
         337 347 349 353 359 367 373 379 383 389 397 401 409 419 421
         431 433 439 443 449 457 461 463 467 479 487 491 499 503 509
         521 523 541 547 557 563 569 571 577 587 593 599 601 607 613
         617 619 631 641 643 647 653 659 661 673 677 683 691 701 709
         719 727 733 739 743 751 757 761 769 773 787 797 809 811 821
         823 827 829 839 853 857 859 863 877 881 883 887 907 911 919
         929 937 941 947 953 967 971 977 983 991 997))
     (test-success "1229 primes below 10000"
       (lambda (result n) (= n (length result))) sieve '(10000)
       1229)
     (test-success "9592 primes below 100000"
       (lambda (result n) (= n (length result))) sieve '(100000)
       9592)
     (test-success "78498 primes below 1000000"
       (lambda (result n) (= n (length result))) sieve '(1000000)
       78498)))

(run-with-cli "sieve.scm" (list test-cases))

