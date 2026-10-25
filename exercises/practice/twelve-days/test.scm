; These tests are auto-generated with test data from:
; https://github.com/exercism/problem-specifications/blob/main/exercises/twelve-days/canonical-data.json
; File last updated on 2026-10-25T06:32:21+00:00

(load "test-util.ss")

(define test-cases
  `(
    (test-success "1. first day a partridge in a pear tree"
        equal? recite '(1 1)
        "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.")

    (test-success "2. second day two turtle doves"
        equal? recite '(2 2)
        "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "3. third day three french hens"
        equal? recite '(3 3)
        "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "4. fourth day four calling birds"
        equal? recite '(4 4)
        "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "5. fifth day five gold rings"
        equal? recite '(5 5)
        "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "6. sixth day six geese-a-laying"
        equal? recite '(6 6)
        "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "7. seventh day seven swans-a-swimming"
        equal? recite '(7 7)
        "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "8. eighth day eight maids-a-milking"
        equal? recite '(8 8)
        "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "9. ninth day nine ladies dancing"
        equal? recite '(9 9)
        "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "10. tenth day ten lords-a-leaping"
        equal? recite '(10 10)
        "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "11. eleventh day eleven pipers piping"
        equal? recite '(11 11)
        "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "12. twelfth day twelve drummers drumming"
        equal? recite '(12 12)
        "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.")

    (test-success "13. recites first three verses of the song"
        equal? recite '(1 3)
        ,(string-append
          "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.\n"
          "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))

    (test-success "14. recites three verses from the middle of the song"
        equal? recite '(4 6)
        ,(string-append
          "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))

    (test-success "15. recites the whole song"
        equal? recite '(1 12)
        ,(string-append
          "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.\n"
          "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n"
          "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
    ))

(run-with-cli "twelve-days.scm" (list test-cases))
