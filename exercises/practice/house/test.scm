; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/house/canonical-data.json
; File last updated on 2026-10-21T12:19:06+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. verse one - the house that jack built"
        equal? recite '(1 1)
        "This is the house that Jack built.")

    (test-success "2. verse two - the malt that lay"
        equal? recite '(2 2)
        "This is the malt that lay in the house that Jack built.")

    (test-success "3. verse three - the rat that ate"
        equal? recite '(3 3)
        "This is the rat that ate the malt that lay in the house that Jack built.")

    (test-success "4. verse four - the cat that killed"
        equal? recite '(4 4)
        "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.")

    (test-success "5. verse five - the dog that worried"
        equal? recite '(5 5)
        "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")

    (test-success "6. verse six - the cow with the crumpled horn"
        equal? recite '(6 6)
        "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")

    (test-success "7. verse seven - the maiden all forlorn"
        equal? recite '(7 7)
        "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")

    (test-success "8. verse eight - the man all tattered and torn"
        equal? recite '(8 8)
        "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")

    (test-success "9. verse nine - the priest all shaven and shorn"
        equal? recite '(9 9)
        "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")

    (test-success "10. verse 10 - the rooster that crowed in the morn"
        equal? recite '(10 10)
        "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")

    (test-success "11. verse 11 - the farmer sowing his corn"
        equal? recite '(11 11)
        "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")

    (test-success "12. verse 12 - the horse and the hound and the horn"
        equal? recite '(12 12)
        "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")

    (test-success "13. multiple verses"
        equal? recite '(4 8)
        "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")

    (test-success "14. full rhyme"
        equal? recite '(1 12)
        "This is the house that Jack built.
This is the malt that lay in the house that Jack built.
This is the rat that ate the malt that lay in the house that Jack built.
This is the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.")))

(run-with-cli "house.scm" (list test-cases))
