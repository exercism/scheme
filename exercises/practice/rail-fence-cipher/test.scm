; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/rail-fence-cipher/canonical-data.json
; File last updated on 2026-10-18T22:14:51+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. encode with two rails"
        string=? encode '(2 "XOXOXOXOXOXOXOXOXO")
        "XXXXXXXXXOOOOOOOOO")

    (test-success "2. encode with three rails"
        string=? encode '(3 "WEAREDISCOVEREDFLEEATONCE")
        "WECRLTEERDSOEEFEAOCAIVDEN")

    (test-success "3. encode with ending in the middle"
        string=? encode '(4 "EXERCISES")
        "ESXIEECSR")

    (test-success "4. decode with three rails"
        string=? decode '(3 "TEITELHDVLSNHDTISEIIEA")
        "THEDEVILISINTHEDETAILS")

    (test-success "5. decode with five rails"
        string=? decode '(5 "EIEXMSMESAORIWSCE")
        "EXERCISMISAWESOME")

    (test-success "6. decode with six rails"
        string=? decode '(6 "133714114238148966225439541018335470986172518171757571896261")
        "112358132134558914423337761098715972584418167651094617711286")
    ))

(run-with-cli "rail-fence-cipher.scm" (list test-cases))
