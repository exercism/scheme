; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/proverb/canonical-data.json
; File last updated on 2026-10-25T23:49:50+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. zero pieces"
        equal? recite
        '(())

        ,(string-append))

    (test-success "2. one piece"
        equal? recite
        '(("nail"))

        ,(string-append
          "And all for the want of a nail."))

    (test-success "3. two pieces"
        equal? recite
        '(("nail"
           "shoe"))

        ,(string-append
          "For want of a nail the shoe was lost.\n"
          "And all for the want of a nail."))

    (test-success "4. three pieces"
        equal? recite
        '(("nail"
           "shoe"
           "horse"))

        ,(string-append
          "For want of a nail the shoe was lost.\n"
          "For want of a shoe the horse was lost.\n"
          "And all for the want of a nail."))

    (test-success "5. full proverb"
        equal? recite
        '(("nail"
           "shoe"
           "horse"
           "rider"
           "message"
           "battle"
           "kingdom"))

        ,(string-append
          "For want of a nail the shoe was lost.\n"
          "For want of a shoe the horse was lost.\n"
          "For want of a horse the rider was lost.\n"
          "For want of a rider the message was lost.\n"
          "For want of a message the battle was lost.\n"
          "For want of a battle the kingdom was lost.\n"
          "And all for the want of a nail."))

    (test-success "6. four pieces modernized"
        equal? recite
        '(("pin"
           "gun"
           "soldier"
           "battle"))

        ,(string-append
          "For want of a pin the gun was lost.\n"
          "For want of a gun the soldier was lost.\n"
          "For want of a soldier the battle was lost.\n"
          "And all for the want of a pin."))))

(run-with-cli "proverb.scm" (list test-cases))
