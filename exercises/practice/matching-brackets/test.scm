(load "test-util.ss")

(define test-cases
  `((test-success "paired square brackets" eq? balanced?
      '("[]") #t) (test-success "empty string" eq? balanced? '("") #t)
     (test-success "unpaired brackets" eq? balanced? '("[[") #f)
     (test-success "wrong ordered brackets" eq? balanced? '("}{")
       #f)
     (test-success "wrong closing bracket" eq? balanced? '("{]")
       #f)
     (test-success "paired with whitespace" eq? balanced?
       '("{ }") #t)
     (test-success "partially paired brackets" eq? balanced?
       '("{[])") #f)
     (test-success "simple nested brackets" eq? balanced?
       '("{[]}") #t)
     (test-success "several paired brackets" eq? balanced?
       '("{}[]") #t)
     (test-success "paired and nested brackets" eq? balanced?
       '("([{}({}[])])") #t)
     (test-success "unopened closing brackets" eq? balanced?
       '("{[)][]}") #f)
     (test-success "unpaired and nested brackets" eq? balanced?
       '("([{])") #f)
     (test-success "paired and wrong nested brackets" eq?
       balanced? '("[({]})") #f)
     (test-success "paired and incomplete brackets" eq? balanced?
       '("{}[") #f)
     (test-success "too many closing brackets" eq? balanced?
       '("[]]") #f)
     (test-success "math expression" eq? balanced?
       '("(((185 + 223.85) * 15) - 543)/2") #t)
     (test-success "complex latex expression" eq? balanced?
       '("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")
       #t)))

(run-with-cli "matching-brackets.scm" (list test-cases))

