;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

;; Require bob impl
(add-to-load-path (dirname (current-filename)))
(use-modules (bob))

;;; Begin test suite
(test-begin "bob-test")

(test-equal "responds-to-something"
            "Whatever."
            (response-for "To-may-to, tom-aaaah-to."))

(test-equal "responds-to-shouts"
            "Whoa, chill out!"
            (response-for "WATCH OUT!"))

(test-equal "responds-to-questions"
            "Sure."
            (response-for "Does this cryogenic chamber make me look fat?"))

(test-equal "responds-to-forceful-talking"
            "Whatever."
            (response-for "Let's go make out behind the gym!"))

(test-equal "responds-to-acronyms"
            "Whatever."
            (response-for "It's OK if you don't want to go to the DMV."))

(test-equal "responds-to-forceful-questions"
            "Whoa, chill out!"
            (response-for "WHAT THE HELL WERE YOU THINKING?"))

(test-equal "responds-to-shouting-with-special-characters"
            "Whoa, chill out!"
            (response-for "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"))

(test-equal "responds to shouting numbers"
            "Whoa, chill out!"
            (response-for "1, 2 ,3, GO!"))

(test-equal "responds-to-shouting-wit-no-exclamation-mark"
            "Whoa, chill out!"
            (response-for "I HATE YOU"))

(test-equal "responds-to-statement-containing-question-mark"
            "Whatever."
            (response-for "Ending with ? means a question."))

(test-equal "responds-to-silence"
            "Fine. Be that way!"
            (response-for ""))

(test-equal "responds-to-prolonged-silence"
            "Fine. Be that way!"
            (response-for "     "))

(test-equal "responds-to-only-numbers"
            "Whatever."
            (response-for "1, 2, 3"))

(test-equal "responds-to-number-question"
            "Sure."
            (response-for "4?"))

(test-end "bob-test")
;;; End test suite
