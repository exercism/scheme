;; Load SRFI-64 lightweight testing specification
(use-modules (srfi srfi-64))

;; Suppress log file output. To write logs, comment out the following line:
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)

;; Require module
(add-to-load-path (dirname (current-filename)))
(use-modules (robot))

(test-begin "robot-name")

(define *robbie* (build-robot))
(define *clutz*  (build-robot))

(test-assert "name matches expected pattern"
             (let ((name (robot-name *robbie*)))
               (and (eq? (string-length name) 5)
                    (string-every char-upper-case? (substring name 0 2))
                    (string-every char-numeric? (substring name 2 5)))))

(test-equal "name is persistent"
            (robot-name *robbie*)
            (robot-name *robbie*))

(test-assert "different robots have different names"
             (not
              (string=?
               (robot-name *robbie*)
               (robot-name *clutz*))))

(test-assert "name can be reset"
             (let* ((robot (build-robot))
                    (original-name (robot-name robot)))
               (reset-name robot)
               (not
                (string=?
                 (robot-name robot)
                 original-name))))

(test-end "robot-name")
