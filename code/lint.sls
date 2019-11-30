(library (lint)
  (export check-config-for)
  (import (outils)
          (chezscheme))

  (define checkworthy-fields
    '(uuid
      core))

  (define (check-config field problem)
    (unless (assoc field problem)
      (error 'check-for-field "please add field" field problem))
    'ok)

  (define (check-config-for problem)
    (format #t "checking config for ~a~%" problem)
    (let ((exercisms (lookup 'exercises (load-config))))
      (cond ((find (lambda (exercism)
                     (eq? problem (lookup 'slug exercism)))
                   exercisms)
             =>
             (lambda (problem)
               (for-all (lambda (field)
                          (check-config field problem))
                        checkworthy-fields)))
            (else
             (error 'check-config-for
                    "please add problem to config/config.ss"
                    problem)))))

  )
