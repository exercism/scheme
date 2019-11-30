(library (lint)
  (export check-config-for)
  (import (outils)
          (chezscheme))

  (define checkworthy-fields
    '(uuid
      core))

  (define (check-config field problem-config)
    (unless (assoc field problem-config)
      (format #t "~a~%~%" problem-config)
      (error 'check-for-field "please add field" field problem-config))
    'ok)

  (define (check-config-for problem)
    (format #t "checking config for ~a~%" problem)
    (let ((exercisms (lookup 'exercises (load-config))))
      (cond ((find (lambda (exercism)
                     (eq? problem (lookup 'slug exercism)))
                   exercisms)
             =>
             (lambda (config)
               (for-all (lambda (field)
                          (check-config field config))
                        checkworthy-fields)))
            (else
             (error 'check-config-for
                    "please add problem to config/config.ss"
                    problem)))))

  )
