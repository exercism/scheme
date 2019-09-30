(define (parse-test test)
  (let ((input (lookup 'input test)))
    `(lambda ()
       (test-success ,(lookup 'description test)
                     =
                     knapsack
                     '(,(lookup 'maximumWeight input)
                       (,@(map (lookup-partial 'weight)
                                (lookup 'items input)))
                       (,@(map (lookup-partial 'value)
                                (lookup 'items input))))
                     ,(lookup 'expected test)))))

(define (spec->tests spec)
  `(,@*test-definitions*
    (define (test . args)
      (apply
       run-test-suite
       (list ,@(map parse-test (lookup 'cases spec))
	     (lambda ()
	       (test-success "example with 30 items"
			     =
			     knapsack
			     '(100000
			       (90001 89751 10002 89501 10254 89251 10506 89001 10758 88751
				      11010 88501 11262 88251 11514 88001 11766 87751 12018 87501
				      12270 87251 12522 87001 12774 86751 13026 86501 13278 86251)
			       (90000 89750 10001 89500 10252 89250 10503 89000 10754 88750
				      11005 88500 11256 88250 11507 88000 11758 87750 12009 87500
				      12260 87250 12511 87000 12762 86750 13013 86500 13264 86250))
			     99798))
	     (lambda ()
	       (test-success "example with 50 items"
			     =
			     knapsack
			     '(341045
			       (4912 99732 56554 1818 108372 6750 1484 3072 13532 12050
				     18440 10972 1940 122094 5558 10630 2112 6942 39888 71276
				     8466 5662 231302 4690 18324 3384 7278 5566 706 10992 27552
				     7548 934 32038 1062 184848 2604 37644 1832 10306 1126 34886
				     3526 1196 1338 992 1390 56804 56804 634)
			       (1906 41516 23527 559 45136 2625 492 1086 5516 4875 7570 4436
				     620 50897 2129 4265 706 2721 16494 29688 3383 2181 96601
				     1795 7512 1242 2889 2133 103 4446 11326 3024 217 13269 281
				     77174 952 15572 566 4103 313 14393 1313 348 419 246 445
				     23552 23552 67))
			     142156)))
       args))))

(put-problem!
 'knapsack
 `((test . ,(spec->tests (get-test-specification 'knapsack)))
   (skeleton . ,"knapsack.scm")
   (solution . ,"example.scm")))

