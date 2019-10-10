(library (lint)
  (export check-config-for)
  (import (outils)
          (chezscheme))

  (define (check-config-for problem)
    (format #t "checking config for ~a~%" problem)
    (let ((exercisms (lookup 'exercises (load-config))))
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

  )
