;; Load SRFI-64 lightweight testing specification
 (use-modules (srfi srfi-64))

 ;; Suppress log file output. To write logs, comment out the following line:
 (module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

 ;; Require module
 (add-to-load-path (dirname (current-filename)))
 (use-modules (phone-number))

 (test-begin "phone-number")

(test-equal "cleans number"
            "1234567890"
            (numbers "(123) 456-7890"))

(test-equal "cleans numbers with dots"
            "1234567890"
            (numbers "123.456.7890"))

(test-equal "valid when 11 digits and first is 1"
            "1234567890"
            (numbers "11234567890"))

(test-equal "invalid when 11 digits"
            "0000000000"
            (numbers "21234567890"))

(test-equal "invalid when 9 digits"
            "0000000000"
            (numbers "123456789"))

(test-equal "area code"
            "123"
            (area-code "1234567890"))

(test-equal "pprint"
            "(123) 456-7890"
            (pprint "1234567890"))

(test-equal "pprint with full us phone number"
            "(123) 456-7890"
            (pprint "11234567890"))

 ;; Tests go here

 (test-end "phone-number")
