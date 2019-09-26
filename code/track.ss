;; for turning the track-config value into a config.json file
(define (make-config)
  (let ((config.json "config.json"))
    (when (file-exists? config.json)
      (delete-file config.json))
    (with-output-to-file config.json
      (lambda ()
	(json-write (process-config))))))

(define (process-config)
  (map (lambda (x)
         (if (not (eq? (car x) 'exercises))
             x
             `(exercises . ,(remp (lambda (exercise)
                                    (memq 'wip (map car exercise)))
                                  (cdr x)))))
       track-config))

(define (configlet-uuid)
  (let ((from-to-pid (process "./bin/configlet uuid")))
    (let ((fresh-uuid (read (car from-to-pid))))
      (close-port (car from-to-pid))
      (close-port (cadr from-to-pid))
      (symbol->string fresh-uuid))))

;; assumes problem-specifications repository is cloned same direcotry
;; as this one. Makefile helps ensure this.
(define (get-problem-specification problem)
  (let* ((problem-dir (format "../problem-specifications/exercises/~a" problem))
	 (spec (directory-list problem-dir)))
    (map (lambda (file)
	   (format "~a/~a" problem-dir file))
	 spec)))

(define (write-problem-description problem)
  (let ((file (find (lambda (spec)
		      (string=? "md" (path-extension spec)))
		    (get-problem-specification problem)))
	(dir (format "code/exercises/~a" problem)))
    (unless file
      (error 'get-problem-description "couldn't find description" problem))
    (system (format "mkdir -p ~a && cp ~a ~a/README.md"
		    dir file dir))))

;; assumes only file in problem directory that is json is the test
;; case suite.
(define (get-test-specification problem)
  (let ((test-suite-file (find (lambda (spec)
				 (string=? "json" (path-extension spec)))
			       (get-problem-specification problem))))
    (unless test-suite-file
      (error 'get-test-specification "couldn't find test suite for" problem))
    (with-input-from-file test-suite-file json-read)))

(define (get-problem-list)
  (map string->symbol
       (directory-list "../problem-specifications/exercises")))

(define *test-definitions*
  (with-input-from-file "code/test.ss" read-all))

(define *problem-table*
  (make-hash-table))

(define (put-problem! problem implementation)
  (for-each (lambda (aspect)
	      (unless (assoc aspect implementation)
		(error 'put-test! "problem does not implement" problem aspect)))
	    ;; test is an sexpression. skeleton and solution are file paths
	    '(test skeleton solution))
  (hashtable-set! *problem-table* problem implementation))

(define (get-problem problem)
  (let ((implementation (hashtable-ref *problem-table* problem #f)))
    (unless implementation
      (error 'get-test "no implementation" problem))
    implementation))

(define (write-exercise problem)
  (let ((implementation (get-problem problem)))
    (let* ((dir (format "_build/exercises/~a" problem))
	   (src (format "code/exercises/~a" problem))
	   (test.scm (format "~a/test.scm" dir))
	   (skeleton.scm (format "~a/~a" src (lookup 'skeleton implementation)))
	   (solution.scm (format "~a/~a" src (lookup 'solution implementation)))
	   (README.md (format "~a/README.md" src)))
      (format #t "writing _build/~a~%" problem)
      (system
	(format "mkdir -p ~a && cp ~a ~a && cp ~a ~a && cp ~a ~a"
		dir skeleton.scm dir solution.scm dir README.md dir))
      (write-expression-to-file (lookup 'test implementation) test.scm))))

(define (setup-exercism problem)
  (format #t "setting up ~a~%" problem)
  (let* ((dir (format "code/exercises/~a" problem))
	 (implementation (format "~a/~a.ss" dir problem))
         ;; todo, add "properties" found in spec to stub skeleton and solution
	 (skeleton (format "~a/~a.scm" dir problem))
	 (solution (format "~a/example.scm" dir))
         ;; see code/exercises/anagram/anagram.ss for more information
	 (stub-implementation
	  `(,@'((define (parse-test test)
		  `(lambda ()
		     (test-success (lookup 'description test)
				   equal?
				   problem
				   (lookup 'input test)
				   (lookup 'expected test))))
		(define (spec->tests spec)
		  `(,@*test-definitions*
		    (define (test . args)
		      (apply run-test-suite
                             (list ,@(map parse-test (lookup 'cases spec)))
                             args)))))
	    (put-problem! ',problem
			  ;; fixme, quoted expression for test not working 
			  `((test . ,(spec->tests
				      (get-test-specification ',problem)))
			    (skeleton . ,,(path-last skeleton))
			    (solution . ,,(path-last solution))))))
	 (stub-solution `((define (,problem)
			    'implement-me!))))
    (when (file-exists? implementation)
      (error 'setup-exercism "implementation already exists" problem))
    (format #t "~~ getting description~%")
    (write-problem-description problem)
    (format #t "~~ writing stub implementation~%")
    (write-expression-to-file stub-implementation implementation)
    (format #t "~~ writing stub solution~%")
    (write-expression-to-file stub-solution skeleton)
    (format #t "~~ writing stub skeleton~%")
    (write-expression-to-file stub-solution solution)))

(define (check-config-for problem)
  (let ((exercisms (lookup 'exercises track-config)))
    (cond ((find (lambda (exercism)
                   (eq? problem (lookup 'slug exercism)))
                 exercisms)
           =>
           (lambda (config)
             (unless (assoc 'uuid config)
               (error 'check-config-for
                      "please set uuid"
                      problem))))
          (else (error 'check-config-for
                       "please add problem to config/config.ss"
                       problem)))))

;; http://exercism.io/api/v1/uuids
(define (verify-exercism problem)
  (let ((dir (format "_build/exercises/~a" problem))
        (implementation (get-problem problem)))
    (check-config-for problem)
    (load (format "~a/test.scm" dir))
    (with-output-to-string
      (lambda ()
        (let ((example
               (begin
                 (load (format "~a/~a" dir (lookup 'solution implementation)))
                 (test))))
          (unless (eq? 'success example)
            (error 'verify-output "bad implementation!" problem)))))
    (format #t "updating exercises/~a~%" problem)
    (system (format "rm -rf exercises/~a && cp -r ~a exercises/~a" problem dir problem))
    'done))

(define (build-implementations)
  (vector-for-each write-exercise (hashtable-keys *problem-table*)))

(define (verify-implementations)
  (for-each verify-exercism implementations))


