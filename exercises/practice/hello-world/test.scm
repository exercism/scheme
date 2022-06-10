(load "test-util.ss")

(define test-cases
  `((test-success "Say Hi!" equal? hello-world '()
      "Hello, World!")))

(run-with-cli "hello-world.scm" (list test-cases))

