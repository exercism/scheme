((robot-simulator
   (exercise . "robot-simulator")
   (version . "3.2.0")
   (comments
     "Some tests have two expectations: one for the position, one for the direction"
     "Optionally, you can also test"
     " - An invalid direction throws an error"
     " - An invalid instruction throws an error"
     " - Default starting position and direction if none are provided")
   (cases
     ((description . "Create robot")
       (cases
         ((description . "at origin facing north")
           (property . "create")
           (input (position (x . 0) (y . 0)) (direction . "north"))
           (expected (position (x . 0) (y . 0)) (direction . "north")))
         ((description . "at negative position facing south")
           (property . "create")
           (input (position (x . -1) (y . -1)) (direction . "south"))
           (expected
             (position (x . -1) (y . -1))
             (direction . "south")))))
     ((description . "Rotating clockwise")
       (cases
         ((description . "changes north to east")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "north")
             (instructions . "R"))
           (expected (position (x . 0) (y . 0)) (direction . "east")))
         ((description . "changes east to south")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "east")
             (instructions . "R"))
           (expected (position (x . 0) (y . 0)) (direction . "south")))
         ((description . "changes south to west")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "south")
             (instructions . "R"))
           (expected (position (x . 0) (y . 0)) (direction . "west")))
         ((description . "changes west to north")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "west")
             (instructions . "R"))
           (expected
             (position (x . 0) (y . 0))
             (direction . "north")))))
     ((description . "Rotating counter-clockwise")
       (cases
         ((description . "changes north to west")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "north")
             (instructions . "L"))
           (expected (position (x . 0) (y . 0)) (direction . "west")))
         ((description . "changes west to south")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "west")
             (instructions . "L"))
           (expected (position (x . 0) (y . 0)) (direction . "south")))
         ((description . "changes south to east")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "south")
             (instructions . "L"))
           (expected (position (x . 0) (y . 0)) (direction . "east")))
         ((description . "changes east to north")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "east")
             (instructions . "L"))
           (expected
             (position (x . 0) (y . 0))
             (direction . "north")))))
     ((description . "Moving forward one")
       (cases
         ((description . "facing north increments Y")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "north")
             (instructions . "A"))
           (expected (position (x . 0) (y . 1)) (direction . "north")))
         ((description . "facing south decrements Y")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "south")
             (instructions . "A"))
           (expected
             (position (x . 0) (y . -1))
             (direction . "south")))
         ((description . "facing east increments X")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "east")
             (instructions . "A"))
           (expected (position (x . 1) (y . 0)) (direction . "east")))
         ((description . "facing west decrements X")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "west")
             (instructions . "A"))
           (expected
             (position (x . -1) (y . 0))
             (direction . "west")))))
     ((description . "Follow series of instructions")
       (comments
         "The robot can follow a series of instructions and end up with the correct position and direction."
         "Where R = Turn Right, L = Turn Left and A = Advance")
       (cases
         ((description . "moving east and north from README")
           (property . "move")
           (input
             (position (x . 7) (y . 3))
             (direction . "north")
             (instructions . "RAALAL"))
           (expected (position (x . 9) (y . 4)) (direction . "west")))
         ((description . "moving west and north")
           (property . "move")
           (input
             (position (x . 0) (y . 0))
             (direction . "north")
             (instructions . "LAAARALA"))
           (expected (position (x . -4) (y . 1)) (direction . "west")))
         ((description . "moving west and south")
           (property . "move")
           (input
             (position (x . 2) (y . -7))
             (direction . "east")
             (instructions . "RRAAAAALA"))
           (expected
             (position (x . -3) (y . -8))
             (direction . "south")))
         ((description . "moving east and north")
           (property . "move")
           (input
             (position (x . 8) (y . 4))
             (direction . "south")
             (instructions . "LAAARRRALLLL"))
           (expected
             (position (x . 11) (y . 5))
             (direction . "north")))))))
 (food-chain
   (exercise . "food-chain")
   (version . "2.1.0")
   (comments
     "JSON doesn't allow for multi-line strings, so all verses are presented "
     "here as arrays of strings. It's up to the test generator to join the "
     "lines together with line breaks."
     "Some languages test for the verse() method, which takes a start verse "
     "and optional end verse, but other languages have only tested for the full poem."
     "For those languages in the latter category, you may wish to only "
     "implement the full song test and leave the rest alone, ignoring the start "
     "and end verse fields.")
   (cases
     ((description
        .
        "Return specified verse or series of verses")
       (cases
         ((description . "fly")
           (property . "recite")
           (input (startVerse . 1) (endVerse . 1))
           (expected
             "I know an old lady who swallowed a fly."
             "I don't know why she swallowed the fly. Perhaps she'll die."))
         ((description . "spider")
           (property . "recite")
           (input (startVerse . 2) (endVerse . 2))
           (expected
             "I know an old lady who swallowed a spider."
             "It wriggled and jiggled and tickled inside her."
             "She swallowed the spider to catch the fly."
             "I don't know why she swallowed the fly. Perhaps she'll die."))
         ((description . "bird")
           (property . "recite")
           (input (startVerse . 3) (endVerse . 3))
           (expected "I know an old lady who swallowed a bird."
             "How absurd to swallow a bird!"
             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
             "She swallowed the spider to catch the fly."
             "I don't know why she swallowed the fly. Perhaps she'll die."))
         ((description . "cat")
           (property . "recite")
           (input (startVerse . 4) (endVerse . 4))
           (expected "I know an old lady who swallowed a cat."
             "Imagine that, to swallow a cat!"
             "She swallowed the cat to catch the bird."
             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
             "She swallowed the spider to catch the fly."
             "I don't know why she swallowed the fly. Perhaps she'll die."))
         ((description . "dog")
           (property . "recite")
           (input (startVerse . 5) (endVerse . 5))
           (expected "I know an old lady who swallowed a dog."
             "What a hog, to swallow a dog!"
             "She swallowed the dog to catch the cat."
             "She swallowed the cat to catch the bird."
             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
             "She swallowed the spider to catch the fly."
             "I don't know why she swallowed the fly. Perhaps she'll die."))
         ((description . "goat")
           (property . "recite")
           (input (startVerse . 6) (endVerse . 6))
           (expected "I know an old lady who swallowed a goat."
             "Just opened her throat and swallowed a goat!"
             "She swallowed the goat to catch the dog."
             "She swallowed the dog to catch the cat."
             "She swallowed the cat to catch the bird."
             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
             "She swallowed the spider to catch the fly."
             "I don't know why she swallowed the fly. Perhaps she'll die."))
         ((description . "cow")
           (property . "recite")
           (input (startVerse . 7) (endVerse . 7))
           (expected "I know an old lady who swallowed a cow."
             "I don't know how she swallowed a cow!"
             "She swallowed the cow to catch the goat."
             "She swallowed the goat to catch the dog."
             "She swallowed the dog to catch the cat."
             "She swallowed the cat to catch the bird."
             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
             "She swallowed the spider to catch the fly."
             "I don't know why she swallowed the fly. Perhaps she'll die."))
         ((description . "horse")
           (property . "recite")
           (input (startVerse . 8) (endVerse . 8))
           (expected
             "I know an old lady who swallowed a horse."
             "She's dead, of course!"))
         ((description . "multiple verses")
           (property . "recite")
           (input (startVerse . 1) (endVerse . 3))
           (expected "I know an old lady who swallowed a fly."
             "I don't know why she swallowed the fly. Perhaps she'll die."
             "" "I know an old lady who swallowed a spider."
             "It wriggled and jiggled and tickled inside her."
             "She swallowed the spider to catch the fly."
             "I don't know why she swallowed the fly. Perhaps she'll die."
             "" "I know an old lady who swallowed a bird."
             "How absurd to swallow a bird!"
             "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
             "She swallowed the spider to catch the fly."
             "I don't know why she swallowed the fly. Perhaps she'll die."))
         ((description . "full song")
           (property . "recite")
           (input (startVerse . 1) (endVerse . 8))
           (expected "I know an old lady who swallowed a fly."
            "I don't know why she swallowed the fly. Perhaps she'll die."
            "" "I know an old lady who swallowed a spider."
            "It wriggled and jiggled and tickled inside her."
            "She swallowed the spider to catch the fly."
            "I don't know why she swallowed the fly. Perhaps she'll die."
            "" "I know an old lady who swallowed a bird."
            "How absurd to swallow a bird!"
            "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
            "She swallowed the spider to catch the fly."
            "I don't know why she swallowed the fly. Perhaps she'll die."
            "" "I know an old lady who swallowed a cat."
            "Imagine that, to swallow a cat!"
            "She swallowed the cat to catch the bird."
            "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
            "She swallowed the spider to catch the fly."
            "I don't know why she swallowed the fly. Perhaps she'll die."
            "" "I know an old lady who swallowed a dog."
            "What a hog, to swallow a dog!"
            "She swallowed the dog to catch the cat."
            "She swallowed the cat to catch the bird."
            "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
            "She swallowed the spider to catch the fly."
            "I don't know why she swallowed the fly. Perhaps she'll die."
            "" "I know an old lady who swallowed a goat."
            "Just opened her throat and swallowed a goat!"
            "She swallowed the goat to catch the dog."
            "She swallowed the dog to catch the cat."
            "She swallowed the cat to catch the bird."
            "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
            "She swallowed the spider to catch the fly."
            "I don't know why she swallowed the fly. Perhaps she'll die."
            "" "I know an old lady who swallowed a cow."
            "I don't know how she swallowed a cow!"
            "She swallowed the cow to catch the goat."
            "She swallowed the goat to catch the dog."
            "She swallowed the dog to catch the cat."
            "She swallowed the cat to catch the bird."
            "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
            "She swallowed the spider to catch the fly."
            "I don't know why she swallowed the fly. Perhaps she'll die."
            "" "I know an old lady who swallowed a horse."
            "She's dead, of course!"))))))
 (word-search
   (exercise . "word-search")
   (version . "1.2.1")
   (comments "Grid rows and columns are 1-indexed.")
   (cases
    ((description
       .
       "Should accept an initial game grid and a target search word")
      (property . "search")
      (input (grid "jefblpepre") (wordsToSearchFor "clojure"))
      (expected (clojure)))
    ((description
       .
       "Should locate one word written left to right")
      (property . "search")
      (input (grid "clojurermt") (wordsToSearchFor "clojure"))
      (expected
        (clojure
          (start (column . 1) (row . 1))
          (end (column . 7) (row . 1)))))
    ((description
       .
       "Should locate the same word written left to right in a different position")
      (property . "search")
      (input (grid "mtclojurer") (wordsToSearchFor "clojure"))
      (expected
        (clojure
          (start (column . 3) (row . 1))
          (end (column . 9) (row . 1)))))
    ((description
       .
       "Should locate a different left to right word")
      (property . "search")
      (input (grid "coffeelplx") (wordsToSearchFor "coffee"))
      (expected
        (coffee
          (start (column . 1) (row . 1))
          (end (column . 6) (row . 1)))))
    ((description
       .
       "Should locate that different left to right word in a different position")
      (property . "search")
      (input (grid "xcoffeezlp") (wordsToSearchFor "coffee"))
      (expected
        (coffee
          (start (column . 2) (row . 1))
          (end (column . 7) (row . 1)))))
    ((description
       .
       "Should locate a left to right word in two line grid")
      (property . "search")
      (input
        (grid "jefblpepre" "tclojurerm")
        (wordsToSearchFor "clojure"))
      (expected
        (clojure
          (start (column . 2) (row . 2))
          (end (column . 8) (row . 2)))))
    ((description
       .
       "Should locate a left to right word in three line grid")
      (property . "search")
      (input
        (grid "camdcimgtc" "jefblpepre" "clojurermt")
        (wordsToSearchFor "clojure"))
      (expected
        (clojure
          (start (column . 1) (row . 3))
          (end (column . 7) (row . 3)))))
    ((description
       .
       "Should locate a left to right word in ten line grid")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "screeaumgr" "alxhpburyi"
          "jalaycalmp" "clojurermt")
        (wordsToSearchFor "clojure"))
      (expected
        (clojure
          (start (column . 1) (row . 10))
          (end (column . 7) (row . 10)))))
    ((description
       .
       "Should locate that left to right word in a different position in a ten line grid")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "screeaumgr" "alxhpburyi"
          "clojurermt" "jalaycalmp")
        (wordsToSearchFor "clojure"))
      (expected
        (clojure
          (start (column . 1) (row . 9))
          (end (column . 7) (row . 9)))))
    ((description
       .
       "Should locate a different left to right word in a ten line grid")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "fortranftw" "alxhpburyi"
          "clojurermt" "jalaycalmp")
        (wordsToSearchFor "fortran"))
      (expected
        (fortran
          (start (column . 1) (row . 7))
          (end (column . 7) (row . 7)))))
    ((description . "Should locate multiple words")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "fortranftw" "alxhpburyi"
          "jalaycalmp" "clojurermt")
        (wordsToSearchFor "fortran" "clojure"))
      (expected
        (clojure
          (start (column . 1) (row . 10))
          (end (column . 7) (row . 10)))
        (fortran
          (start (column . 1) (row . 7))
          (end (column . 7) (row . 7)))))
    ((description
       .
       "Should locate a single word written right to left")
      (property . "search")
      (input (grid "rixilelhrs") (wordsToSearchFor "elixir"))
      (expected
        (elixir
          (start (column . 6) (row . 1))
          (end (column . 1) (row . 1)))))
    ((description
       .
       "Should locate multiple words written in different horizontal directions")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "screeaumgr" "alxhpburyi"
          "jalaycalmp" "clojurermt")
        (wordsToSearchFor "elixir" "clojure"))
      (expected
        (clojure
          (start (column . 1) (row . 10))
          (end (column . 7) (row . 10)))
        (elixir
          (start (column . 6) (row . 5))
          (end (column . 1) (row . 5)))))
    ((description . "Should locate words written top to bottom")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "screeaumgr" "alxhpburyi"
          "jalaycalmp" "clojurermt")
        (wordsToSearchFor "clojure" "elixir" "ecmascript"))
      (expected
        (clojure
          (start (column . 1) (row . 10))
          (end (column . 7) (row . 10)))
        (elixir
          (start (column . 6) (row . 5))
          (end (column . 1) (row . 5)))
        (ecmascript
          (start (column . 10) (row . 1))
          (end (column . 10) (row . 10)))))
    ((description . "Should locate words written bottom to top")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "screeaumgr" "alxhpburyi"
          "jalaycalmp" "clojurermt")
        (wordsToSearchFor "clojure" "elixir" "ecmascript" "rust"))
      (expected
        (clojure
          (start (column . 1) (row . 10))
          (end (column . 7) (row . 10)))
        (elixir
          (start (column . 6) (row . 5))
          (end (column . 1) (row . 5)))
        (ecmascript
          (start (column . 10) (row . 1))
          (end (column . 10) (row . 10)))
        (rust
          (start (column . 9) (row . 5))
          (end (column . 9) (row . 2)))))
    ((description
       .
       "Should locate words written top left to bottom right")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "screeaumgr" "alxhpburyi"
          "jalaycalmp" "clojurermt")
        (wordsToSearchFor "clojure" "elixir" "ecmascript" "rust"
          "java"))
      (expected
        (clojure
          (start (column . 1) (row . 10))
          (end (column . 7) (row . 10)))
        (elixir
          (start (column . 6) (row . 5))
          (end (column . 1) (row . 5)))
        (ecmascript
          (start (column . 10) (row . 1))
          (end (column . 10) (row . 10)))
        (rust
          (start (column . 9) (row . 5))
          (end (column . 9) (row . 2)))
        (java
          (start (column . 1) (row . 1))
          (end (column . 4) (row . 4)))))
    ((description
       .
       "Should locate words written bottom right to top left")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "screeaumgr" "alxhpburyi"
          "jalaycalmp" "clojurermt")
        (wordsToSearchFor "clojure" "elixir" "ecmascript" "rust"
          "java" "lua"))
      (expected
        (clojure
          (start (column . 1) (row . 10))
          (end (column . 7) (row . 10)))
        (elixir
          (start (column . 6) (row . 5))
          (end (column . 1) (row . 5)))
        (ecmascript
          (start (column . 10) (row . 1))
          (end (column . 10) (row . 10)))
        (rust
          (start (column . 9) (row . 5))
          (end (column . 9) (row . 2)))
        (java
          (start (column . 1) (row . 1))
          (end (column . 4) (row . 4)))
        (lua (start (column . 8) (row . 9))
             (end (column . 6) (row . 7)))))
    ((description
       .
       "Should locate words written bottom left to top right")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "screeaumgr" "alxhpburyi"
          "jalaycalmp" "clojurermt")
        (wordsToSearchFor "clojure" "elixir" "ecmascript" "rust"
          "java" "lua" "lisp"))
      (expected
        (clojure
          (start (column . 1) (row . 10))
          (end (column . 7) (row . 10)))
        (elixir
          (start (column . 6) (row . 5))
          (end (column . 1) (row . 5)))
        (ecmascript
          (start (column . 10) (row . 1))
          (end (column . 10) (row . 10)))
        (rust
          (start (column . 9) (row . 5))
          (end (column . 9) (row . 2)))
        (java
          (start (column . 1) (row . 1))
          (end (column . 4) (row . 4)))
        (lua (start (column . 8) (row . 9))
             (end (column . 6) (row . 7)))
        (lisp
          (start (column . 3) (row . 6))
          (end (column . 6) (row . 3)))))
    ((description
       .
       "Should locate words written top right to bottom left")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "screeaumgr" "alxhpburyi"
          "jalaycalmp" "clojurermt")
        (wordsToSearchFor "clojure" "elixir" "ecmascript" "rust"
          "java" "lua" "lisp" "ruby"))
      (expected
        (clojure
          (start (column . 1) (row . 10))
          (end (column . 7) (row . 10)))
        (elixir
          (start (column . 6) (row . 5))
          (end (column . 1) (row . 5)))
        (ecmascript
          (start (column . 10) (row . 1))
          (end (column . 10) (row . 10)))
        (rust
          (start (column . 9) (row . 5))
          (end (column . 9) (row . 2)))
        (java
          (start (column . 1) (row . 1))
          (end (column . 4) (row . 4)))
        (lua (start (column . 8) (row . 9))
             (end (column . 6) (row . 7)))
        (lisp
          (start (column . 3) (row . 6))
          (end (column . 6) (row . 3)))
        (ruby
          (start (column . 8) (row . 6))
          (end (column . 5) (row . 9)))))
    ((description
       .
       "Should fail to locate a word that is not in the puzzle")
      (property . "search")
      (input
        (grid "jefblpepre" "camdcimgtc" "oivokprjsm" "pbwasqroua"
          "rixilelhrs" "wolcqlirpc" "screeaumgr" "alxhpburyi"
          "jalaycalmp" "clojurermt")
        (wordsToSearchFor "clojure" "elixir" "ecmascript" "rust"
          "java" "lua" "lisp" "ruby" "haskell"))
      (expected
        (clojure
          (start (column . 1) (row . 10))
          (end (column . 7) (row . 10)))
        (elixir
          (start (column . 6) (row . 5))
          (end (column . 1) (row . 5)))
        (ecmascript
          (start (column . 10) (row . 1))
          (end (column . 10) (row . 10)))
        (rust
          (start (column . 9) (row . 5))
          (end (column . 9) (row . 2)))
        (java
          (start (column . 1) (row . 1))
          (end (column . 4) (row . 4)))
        (lua (start (column . 8) (row . 9))
             (end (column . 6) (row . 7)))
        (lisp
          (start (column . 3) (row . 6))
          (end (column . 6) (row . 3)))
        (ruby
          (start (column . 8) (row . 6))
          (end (column . 5) (row . 9)))
        (haskell)))))
 (simple-cipher
   (exercise . "simple-cipher")
   (version . "2.0.0")
   (comments
     "Some of the strings used in this file are symbolic and do not represent their literal value. They are:"
     "cipher.key - Represents the Cipher key"
     "cipher.encode - Represents the output of the Cipher encode method"
     "new - Represents the Cipher initialization"
     "string.substring(start, length) - Represents a substring of 'string' that begins at index 'start' and is 'length' characters long")
   (cases
     ((description . "Random key cipher")
       (cases
         ((description . "Can encode")
           (property . "encode")
           (input (plaintext . "aaaaaaaaaa"))
           (expected . "cipher.key.substring(0, plaintext.length)"))
         ((description . "Can decode")
           (property . "decode")
           (input
             (ciphertext . "cipher.key.substring(0, expected.length)"))
           (expected . "aaaaaaaaaa"))
         ((description
            .
            "Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method")
           (property . "decode")
           (input
             (plaintext . "abcdefghij")
             (ciphertext . "cipher.encode"))
           (expected . "abcdefghij"))
         ((description . "Key is made only of lowercase letters")
           (property . "key")
           (input)
           (expected (match . "^[a-z]+$")))))
     ((description . "Substitution cipher")
       (cases
         ((description . "Can encode")
           (property . "encode")
           (input (key . "abcdefghij") (plaintext . "aaaaaaaaaa"))
           (expected . "abcdefghij"))
         ((description . "Can decode")
           (property . "decode")
           (input (key . "abcdefghij") (ciphertext . "abcdefghij"))
           (expected . "aaaaaaaaaa"))
         ((description
            .
            "Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method")
           (property . "decode")
           (input
             (key . "abcdefghij")
             (plaintext . "abcdefghij")
             (ciphertext . "cipher.encode"))
           (expected . "abcdefghij"))
         ((description . "Can double shift encode")
           (property . "encode")
           (input
             (key . "iamapandabear")
             (plaintext . "iamapandabear"))
           (expected . "qayaeaagaciai"))
         ((description . "Can wrap on encode")
           (property . "encode")
           (input (key . "abcdefghij") (plaintext . "zzzzzzzzzz"))
           (expected . "zabcdefghi"))
         ((description . "Can wrap on decode")
           (property . "decode")
           (input (key . "abcdefghij") (ciphertext . "zabcdefghi"))
           (expected . "zzzzzzzzzz"))
         ((description . "Can encode messages longer than the key")
           (property . "encode")
           (input (key . "abc") (plaintext . "iamapandabear"))
           (expected . "iboaqcnecbfcr"))
         ((description . "Can decode messages longer than the key")
           (property . "decode")
           (input (key . "abc") (ciphertext . "iboaqcnecbfcr"))
           (expected . "iamapandabear"))))))
 (nth-prime
   (exercise . "nth-prime")
   (version . "2.1.0")
   (cases
     ((description . "first prime")
       (property . "prime")
       (input (number . 1))
       (expected . 2))
     ((description . "second prime")
       (property . "prime")
       (input (number . 2))
       (expected . 3))
     ((description . "sixth prime")
       (property . "prime")
       (input (number . 6))
       (expected . 13))
     ((description . "big prime")
       (property . "prime")
       (input (number . 10001))
       (expected . 104743))
     ((description . "there is no zeroth prime")
       (property . "prime")
       (input (number . 0))
       (expected (error . "there is no zeroth prime")))))
 (ocr-numbers
   (exercise . "ocr-numbers")
   (version . "1.2.0")
   (cases
     ((description
        .
        "Converts lines of OCR Numbers to a string of integers")
       (cases
         ((description . "Recognizes 0")
           (property . "convert")
           (input (rows " _ " "| |" "|_|" "   "))
           (expected . "0"))
         ((description . "Recognizes 1")
           (property . "convert")
           (input (rows "   " "  |" "  |" "   "))
           (expected . "1"))
         ((description
            .
            "Unreadable but correctly sized inputs return ?")
           (property . "convert")
           (input (rows "   " "  _" "  |" "   "))
           (expected . "?"))
         ((description
            .
            "Input with a number of lines that is not a multiple of four raises an error")
           (property . "convert")
           (input (rows " _ " "| |" "   "))
           (expected
             (error .
               "Number of input lines is not a multiple of four")))
         ((description
            .
            "Input with a number of columns that is not a multiple of three raises an error")
           (property . "convert")
           (input (rows "    " "   |" "   |" "    "))
           (expected
             (error .
               "Number of input columns is not a multiple of three")))
         ((description . "Recognizes 110101100")
           (property . "convert")
           (input
             (rows
               "       _     _        _  _ "
               "  |  || |  || |  |  || || |"
               "  |  ||_|  ||_|  |  ||_||_|"
               "                           "))
           (expected . "110101100"))
         ((description
            .
            "Garbled numbers in a string are replaced with ?")
           (property . "convert")
           (input
             (rows
               "       _     _           _ "
               "  |  || |  || |     || || |"
               "  |  | _|  ||_|  |  ||_||_|"
               "                           "))
           (expected . "11?10?1?0"))
         ((description . "Recognizes 2")
           (property . "convert")
           (input (rows " _ " " _|" "|_ " "   "))
           (expected . "2"))
         ((description . "Recognizes 3")
           (property . "convert")
           (input (rows " _ " " _|" " _|" "   "))
           (expected . "3"))
         ((description . "Recognizes 4")
           (property . "convert")
           (input (rows "   " "|_|" "  |" "   "))
           (expected . "4"))
         ((description . "Recognizes 5")
           (property . "convert")
           (input (rows " _ " "|_ " " _|" "   "))
           (expected . "5"))
         ((description . "Recognizes 6")
           (property . "convert")
           (input (rows " _ " "|_ " "|_|" "   "))
           (expected . "6"))
         ((description . "Recognizes 7")
           (property . "convert")
           (input (rows " _ " "  |" "  |" "   "))
           (expected . "7"))
         ((description . "Recognizes 8")
           (property . "convert")
           (input (rows " _ " "|_|" "|_|" "   "))
           (expected . "8"))
         ((description . "Recognizes 9")
           (property . "convert")
           (input (rows " _ " "|_|" " _|" "   "))
           (expected . "9"))
         ((description . "Recognizes string of decimal numbers")
           (property . "convert")
           (input
             (rows
               "    _  _     _  _  _  _  _  _ "
               "  | _| _||_||_ |_   ||_||_|| |"
               "  ||_  _|  | _||_|  ||_| _||_|"
               "                              "))
           (expected . "1234567890"))
         ((description
            .
            "Numbers separated by empty lines are recognized. Lines are joined by commas.")
           (property . "convert")
           (input
             (rows "    _  _ " "  | _| _|" "  ||_  _|" "         " "    _  _ "
               "|_||_ |_ " "  | _||_|" "         " " _  _  _ " "  ||_||_|"
               "  ||_| _|" "         "))
           (expected . "123,456,789"))))))
 (zebra-puzzle
   (exercise . "zebra-puzzle")
   (version . "1.1.0")
   (cases
     ((description . "resident who drinks water")
       (property . "drinksWater")
       (input)
       (expected . "Norwegian"))
     ((description . "resident who owns zebra")
       (property . "ownsZebra")
       (input)
       (expected . "Japanese"))))
 (clock
   (exercise . "clock")
   (version . "2.4.0")
   (comments
     "Most languages require constructing a clock with initial values,"
     "adding or subtracting some number of minutes, and testing equality"
     "in some language-native way.  Negative and out of range values are"
     "generally expected to wrap around rather than represent errors.")
   (cases
     ((description . "Create a new clock with an initial time")
       (cases
        ((description . "on the hour")
          (property . "create")
          (input (hour . 8) (minute . 0))
          (expected . "08:00"))
        ((description . "past the hour")
          (property . "create")
          (input (hour . 11) (minute . 9))
          (expected . "11:09"))
        ((description . "midnight is zero hours")
          (property . "create")
          (input (hour . 24) (minute . 0))
          (expected . "00:00"))
        ((description . "hour rolls over")
          (property . "create")
          (input (hour . 25) (minute . 0))
          (expected . "01:00"))
        ((description . "hour rolls over continuously")
          (property . "create")
          (input (hour . 100) (minute . 0))
          (expected . "04:00"))
        ((description . "sixty minutes is next hour")
          (property . "create")
          (input (hour . 1) (minute . 60))
          (expected . "02:00"))
        ((description . "minutes roll over")
          (property . "create")
          (input (hour . 0) (minute . 160))
          (expected . "02:40"))
        ((description . "minutes roll over continuously")
          (property . "create")
          (input (hour . 0) (minute . 1723))
          (expected . "04:43"))
        ((description . "hour and minutes roll over")
          (property . "create")
          (input (hour . 25) (minute . 160))
          (expected . "03:40"))
        ((description . "hour and minutes roll over continuously")
          (property . "create")
          (input (hour . 201) (minute . 3001))
          (expected . "11:01"))
        ((description
           .
           "hour and minutes roll over to exactly midnight")
          (property . "create")
          (input (hour . 72) (minute . 8640))
          (expected . "00:00"))
        ((description . "negative hour")
          (property . "create")
          (input (hour . -1) (minute . 15))
          (expected . "23:15"))
        ((description . "negative hour rolls over")
          (property . "create")
          (input (hour . -25) (minute . 0))
          (expected . "23:00"))
        ((description . "negative hour rolls over continuously")
          (property . "create")
          (input (hour . -91) (minute . 0))
          (expected . "05:00"))
        ((description . "negative minutes")
          (property . "create")
          (input (hour . 1) (minute . -40))
          (expected . "00:20"))
        ((description . "negative minutes roll over")
          (property . "create")
          (input (hour . 1) (minute . -160))
          (expected . "22:20"))
        ((description . "negative minutes roll over continuously")
          (property . "create")
          (input (hour . 1) (minute . -4820))
          (expected . "16:40"))
        ((description . "negative sixty minutes is previous hour")
          (property . "create")
          (input (hour . 2) (minute . -60))
          (expected . "01:00"))
        ((description . "negative hour and minutes both roll over")
          (property . "create")
          (input (hour . -25) (minute . -160))
          (expected . "20:20"))
        ((description
           .
           "negative hour and minutes both roll over continuously")
          (property . "create")
          (input (hour . -121) (minute . -5810))
          (expected . "22:10"))))
     ((description . "Add minutes")
       (cases
         ((description . "add minutes")
           (property . "add")
           (input (hour . 10) (minute . 0) (value . 3))
           (expected . "10:03"))
         ((description . "add no minutes")
           (property . "add")
           (input (hour . 6) (minute . 41) (value . 0))
           (expected . "06:41"))
         ((description . "add to next hour")
           (property . "add")
           (input (hour . 0) (minute . 45) (value . 40))
           (expected . "01:25"))
         ((description . "add more than one hour")
           (property . "add")
           (input (hour . 10) (minute . 0) (value . 61))
           (expected . "11:01"))
         ((description . "add more than two hours with carry")
           (property . "add")
           (input (hour . 0) (minute . 45) (value . 160))
           (expected . "03:25"))
         ((description . "add across midnight")
           (property . "add")
           (input (hour . 23) (minute . 59) (value . 2))
           (expected . "00:01"))
         ((description . "add more than one day (1500 min = 25 hrs)")
           (property . "add")
           (input (hour . 5) (minute . 32) (value . 1500))
           (expected . "06:32"))
         ((description . "add more than two days")
           (property . "add")
           (input (hour . 1) (minute . 1) (value . 3500))
           (expected . "11:21"))))
     ((description . "Subtract minutes")
       (cases
         ((description . "subtract minutes")
           (property . "subtract")
           (input (hour . 10) (minute . 3) (value . 3))
           (expected . "10:00"))
         ((description . "subtract to previous hour")
           (property . "subtract")
           (input (hour . 10) (minute . 3) (value . 30))
           (expected . "09:33"))
         ((description . "subtract more than an hour")
           (property . "subtract")
           (input (hour . 10) (minute . 3) (value . 70))
           (expected . "08:53"))
         ((description . "subtract across midnight")
           (property . "subtract")
           (input (hour . 0) (minute . 3) (value . 4))
           (expected . "23:59"))
         ((description . "subtract more than two hours")
           (property . "subtract")
           (input (hour . 0) (minute . 0) (value . 160))
           (expected . "21:20"))
         ((description . "subtract more than two hours with borrow")
           (property . "subtract")
           (input (hour . 6) (minute . 15) (value . 160))
           (expected . "03:35"))
         ((description
            .
            "subtract more than one day (1500 min = 25 hrs)")
           (property . "subtract")
           (input (hour . 5) (minute . 32) (value . 1500))
           (expected . "04:32"))
         ((description . "subtract more than two days")
           (property . "subtract")
           (input (hour . 2) (minute . 20) (value . 3000))
           (expected . "00:20"))))
     ((description . "Compare two clocks for equality")
       (cases
         ((description . "clocks with same time")
           (property . "equal")
           (input
             (clock1 (hour . 15) (minute . 37))
             (clock2 (hour . 15) (minute . 37)))
           (expected . #t))
         ((description . "clocks a minute apart")
           (property . "equal")
           (input
             (clock1 (hour . 15) (minute . 36))
             (clock2 (hour . 15) (minute . 37)))
           (expected . #f))
         ((description . "clocks an hour apart")
           (property . "equal")
           (input
             (clock1 (hour . 14) (minute . 37))
             (clock2 (hour . 15) (minute . 37)))
           (expected . #f))
         ((description . "clocks with hour overflow")
           (property . "equal")
           (input
             (clock1 (hour . 10) (minute . 37))
             (clock2 (hour . 34) (minute . 37)))
           (expected . #t))
         ((description . "clocks with hour overflow by several days")
           (property . "equal")
           (input
             (clock1 (hour . 3) (minute . 11))
             (clock2 (hour . 99) (minute . 11)))
           (expected . #t))
         ((description . "clocks with negative hour")
           (property . "equal")
           (input
             (clock1 (hour . 22) (minute . 40))
             (clock2 (hour . -2) (minute . 40)))
           (expected . #t))
         ((description . "clocks with negative hour that wraps")
           (property . "equal")
           (input
             (clock1 (hour . 17) (minute . 3))
             (clock2 (hour . -31) (minute . 3)))
           (expected . #t))
         ((description
            .
            "clocks with negative hour that wraps multiple times")
           (property . "equal")
           (input
             (clock1 (hour . 13) (minute . 49))
             (clock2 (hour . -83) (minute . 49)))
           (expected . #t))
         ((description . "clocks with minute overflow")
           (property . "equal")
           (input
             (clock1 (hour . 0) (minute . 1))
             (clock2 (hour . 0) (minute . 1441)))
           (expected . #t))
         ((description
            .
            "clocks with minute overflow by several days")
           (property . "equal")
           (input
             (clock1 (hour . 2) (minute . 2))
             (clock2 (hour . 2) (minute . 4322)))
           (expected . #t))
         ((description . "clocks with negative minute")
           (property . "equal")
           (input
             (clock1 (hour . 2) (minute . 40))
             (clock2 (hour . 3) (minute . -20)))
           (expected . #t))
         ((description . "clocks with negative minute that wraps")
           (property . "equal")
           (input
             (clock1 (hour . 4) (minute . 10))
             (clock2 (hour . 5) (minute . -1490)))
           (expected . #t))
         ((description
            .
            "clocks with negative minute that wraps multiple times")
           (property . "equal")
           (input
             (clock1 (hour . 6) (minute . 15))
             (clock2 (hour . 6) (minute . -4305)))
           (expected . #t))
         ((description . "clocks with negative hours and minutes")
           (property . "equal")
           (input
             (clock1 (hour . 7) (minute . 32))
             (clock2 (hour . -12) (minute . -268)))
           (expected . #t))
         ((description
            .
            "clocks with negative hours and minutes that wrap")
           (property . "equal")
           (input
             (clock1 (hour . 18) (minute . 7))
             (clock2 (hour . -54) (minute . -11513)))
           (expected . #t))
         ((description . "full clock and zeroed clock")
           (property . "equal")
           (input
             (clock1 (hour . 24) (minute . 0))
             (clock2 (hour . 0) (minute . 0)))
           (expected . #t))))))
 (rest-api
   (exercise . "rest-api")
   (version . "1.1.1")
   (comments
     "The state of the API database before the request is represented"
     "by the input->database object. Your track may determine how this"
     "initial state is set."
     "The input->payload and expected objects should be marshalled as"
     "strings in track implementation, as parsing and validating text"
     "payloads is an integral part of implementing a REST API."
     "All arrays are ordered.")
   (cases
     ((description . "user management")
       (cases
         ((description . "no users")
           (property . "get")
           (input (database (users)) (url . "/users"))
           (expected (users)))
         ((description . "add user")
           (property . "post")
           (input
             (database (users))
             (url . "/add")
             (payload (user . "Adam")))
           (expected (name . "Adam") (owes) (owed_by) (balance . 0.0)))
         ((description . "get single user")
           (property . "get")
           (input
             (database
               (users
                 ((name . "Adam") (owes) (owed_by) (balance . 0.0))
                 ((name . "Bob") (owes) (owed_by) (balance . 0.0))))
             (url . "/users")
             (payload (users "Bob")))
           (expected
             (users
               ((name . "Bob") (owes) (owed_by) (balance . 0.0)))))))
     ((description . "iou")
       (cases
         ((description . "both users have 0 balance")
           (property . "post")
           (input
             (database
               (users
                 ((name . "Adam") (owes) (owed_by) (balance . 0.0))
                 ((name . "Bob") (owes) (owed_by) (balance . 0.0))))
             (url . "/iou")
             (payload
               (lender . "Adam")
               (borrower . "Bob")
               (amount . 3.0)))
           (expected
             (users
               ((name . "Adam")
                 (owes)
                 (owed_by (Bob . 3.0))
                 (balance . 3.0))
               ((name . "Bob")
                 (owes (Adam . 3.0))
                 (owed_by)
                 (balance . -3.0)))))
         ((description . "borrower has negative balance")
           (property . "post")
           (input
             (database
               (users
                 ((name . "Adam") (owes) (owed_by) (balance . 0.0))
                 ((name . "Bob")
                   (owes (Chuck . 3.0))
                   (owed_by)
                   (balance . -3.0))
                 ((name . "Chuck")
                   (owes)
                   (owed_by (Bob . 3.0))
                   (balance . 3.0))))
             (url . "/iou")
             (payload
               (lender . "Adam")
               (borrower . "Bob")
               (amount . 3.0)))
           (expected
             (users
               ((name . "Adam")
                 (owes)
                 (owed_by (Bob . 3.0))
                 (balance . 3.0))
               ((name . "Bob")
                 (owes (Adam . 3.0) (Chuck . 3.0))
                 (owed_by)
                 (balance . -6.0)))))
         ((description . "lender has negative balance")
           (property . "post")
           (input
             (database
               (users
                 ((name . "Adam") (owes) (owed_by) (balance . 0.0))
                 ((name . "Bob")
                   (owes (Chuck . 3.0))
                   (owed_by)
                   (balance . -3.0))
                 ((name . "Chuck")
                   (owes)
                   (owed_by (Bob . 3.0))
                   (balance . 3.0))))
             (url . "/iou")
             (payload
               (lender . "Bob")
               (borrower . "Adam")
               (amount . 3.0)))
           (expected
             (users
               ((name . "Adam")
                 (owes (Bob . 3.0))
                 (owed_by)
                 (balance . -3.0))
               ((name . "Bob")
                 (owes (Chuck . 3.0))
                 (owed_by (Adam . 3.0))
                 (balance . 0.0)))))
         ((description . "lender owes borrower")
           (property . "post")
           (input
             (database
               (users
                 ((name . "Adam")
                   (owes (Bob . 3.0))
                   (owed_by)
                   (balance . -3.0))
                 ((name . "Bob")
                   (owes)
                   (owed_by (Adam . 3.0))
                   (balance . 3.0))))
             (url . "/iou")
             (payload
               (lender . "Adam")
               (borrower . "Bob")
               (amount . 2.0)))
           (expected
             (users
               ((name . "Adam")
                 (owes (Bob . 1.0))
                 (owed_by)
                 (balance . -1.0))
               ((name . "Bob")
                 (owes)
                 (owed_by (Adam . 1.0))
                 (balance . 1.0)))))
         ((description . "lender owes borrower less than new loan")
           (property . "post")
           (input
             (database
               (users
                 ((name . "Adam")
                   (owes (Bob . 3.0))
                   (owed_by)
                   (balance . -3.0))
                 ((name . "Bob")
                   (owes)
                   (owed_by (Adam . 3.0))
                   (balance . 3.0))))
             (url . "/iou")
             (payload
               (lender . "Adam")
               (borrower . "Bob")
               (amount . 4.0)))
           (expected
             (users
               ((name . "Adam")
                 (owes)
                 (owed_by (Bob . 1.0))
                 (balance . 1.0))
               ((name . "Bob")
                 (owes (Adam . 1.0))
                 (owed_by)
                 (balance . -1.0)))))
         ((description . "lender owes borrower same as new loan")
           (property . "post")
           (input
             (database
               (users
                 ((name . "Adam")
                   (owes (Bob . 3.0))
                   (owed_by)
                   (balance . -3.0))
                 ((name . "Bob")
                   (owes)
                   (owed_by (Adam . 3.0))
                   (balance . 3.0))))
             (url . "/iou")
             (payload
               (lender . "Adam")
               (borrower . "Bob")
               (amount . 3.0)))
           (expected
             (users
               ((name . "Adam") (owes) (owed_by) (balance . 0.0))
               ((name . "Bob") (owes) (owed_by) (balance . 0.0)))))))))
 (binary-search
   (exercise . "binary-search")
   (version . "1.3.0")
   (comments
     "The error object is used to indicate that the value is not included in the array."
     "It should be replaced with the respective expression that is idiomatic"
     "for the language that implements the tests."
     "Following https://github.com/exercism/problem-specifications/issues/234 the exercise"
     "should NOT include checking whether the array is sorted as it defeats"
     "the point of the binary search."
     "The exercise should utilize an array-like (i.e. constant-time indexed)"
     "data structure and not a linked list. If something like an array is not"
     "usually used in the language the problem should not be implemented."
     "See https://github.com/exercism/problem-specifications/issues/244 for details.")
   (cases
     ((description
        .
        "finds a value in an array with one element")
       (property . "find")
       (input (array 6) (value . 6))
       (expected . 0))
     ((description . "finds a value in the middle of an array")
       (property . "find")
       (input (array 1 3 4 6 8 9 11) (value . 6))
       (expected . 3))
     ((description
        .
        "finds a value at the beginning of an array")
       (property . "find")
       (input (array 1 3 4 6 8 9 11) (value . 1))
       (expected . 0))
     ((description . "finds a value at the end of an array")
       (property . "find")
       (input (array 1 3 4 6 8 9 11) (value . 11))
       (expected . 6))
     ((description . "finds a value in an array of odd length")
       (property . "find")
       (input
         (array 1 3 5 8 13 21 34 55 89 144 233 377 634)
         (value . 144))
       (expected . 9))
     ((description . "finds a value in an array of even length")
       (property . "find")
       (input
         (array 1 3 5 8 13 21 34 55 89 144 233 377)
         (value . 21))
       (expected . 5))
     ((description
        .
        "identifies that a value is not included in the array")
       (property . "find")
       (input (array 1 3 4 6 8 9 11) (value . 7))
       (expected (error . "value not in array")))
     ((description
        .
        "a value smaller than the array's smallest value is not found")
       (property . "find")
       (input (array 1 3 4 6 8 9 11) (value . 0))
       (expected (error . "value not in array")))
     ((description
        .
        "a value larger than the array's largest value is not found")
       (property . "find")
       (input (array 1 3 4 6 8 9 11) (value . 13))
       (expected (error . "value not in array")))
     ((description . "nothing is found in an empty array")
       (property . "find")
       (input (array) (value . 1))
       (expected (error . "value not in array")))
     ((description
        .
        "nothing is found when the left and right bounds cross")
       (property . "find")
       (input (array 1 2) (value . 0))
       (expected (error . "value not in array")))))
 (collatz-conjecture
   (exercise . "collatz-conjecture")
   (version . "1.2.1")
   (cases
     ((description . "zero steps for one")
       (property . "steps")
       (input (number . 1))
       (expected . 0))
     ((description . "divide if even")
       (property . "steps")
       (input (number . 16))
       (expected . 4))
     ((description . "even and odd steps")
       (property . "steps")
       (input (number . 12))
       (expected . 9))
     ((description . "large number of even and odd steps")
       (property . "steps")
       (input (number . 1000000))
       (expected . 152))
     ((description . "zero is an error")
       (property . "steps")
       (input (number . 0))
       (expected (error . "Only positive numbers are allowed")))
     ((description . "negative value is an error")
       (property . "steps")
       (input (number . -15))
       (expected (error . "Only positive numbers are allowed")))))
 (matrix
   (exercise . "matrix")
   (version . "1.3.0")
   (cases
     ((description . "extract row from one number matrix")
       (property . "row")
       (input (string . "1") (index . 1))
       (expected 1))
     ((description . "can extract row")
       (property . "row")
       (input (string . "1 2\n3 4") (index . 2))
       (expected 3 4))
     ((description
        .
        "extract row where numbers have different widths")
       (property . "row")
       (input (string . "1 2\n10 20") (index . 2))
       (expected 10 20))
     ((description
        .
        "can extract row from non-square matrix with no corresponding column")
       (property . "row")
       (input (string . "1 2 3\n4 5 6\n7 8 9\n8 7 6") (index . 4))
       (expected 8 7 6))
     ((description . "extract column from one number matrix")
       (property . "column")
       (input (string . "1") (index . 1))
       (expected 1))
     ((description . "can extract column")
       (property . "column")
       (input (string . "1 2 3\n4 5 6\n7 8 9") (index . 3))
       (expected 3 6 9))
     ((description
        .
        "can extract column from non-square matrix with no corresponding row")
       (property . "column")
       (input (string . "1 2 3 4\n5 6 7 8\n9 8 7 6") (index . 4))
       (expected 4 8 6))
     ((description
        .
        "extract column where numbers have different widths")
       (property . "column")
       (input (string . "89 1903 3\n18 3 1\n9 4 800") (index . 2))
       (expected 1903 3 4))))
 (react
   (exercise . "react")
   (version . "2.0.0")
   (comments "Note that, due to the nature of this exercise,"
    "the tests are specified using their cells and a series of operations to perform on the cells."
    ""
    "Each object in the `cells` array has a `name` and `type` (`input` or `output`)."
    "input cells have an `initial_value`, and compute cells have `inputs` and `compute_function`"
    "" "Each object in the `operations` array has a `type`."
    "Depending on the type, it also has additional fields."
    "The possible types and semantics of their fields are as follows:"
    ""
    "* expect_cell_value (`cell`, `value`): Expect that cell `cell` has value `value`."
    "* set_value (`cell`, `value`, optionally `expect_callbacks`, `expect_callbacks_not_to_be_called`): Sets input cell `cell` to value `value`."
    "  Expect that, as a result, all callbacks in `expect_callbacks` (if present) were called exactly once with the designated value"
    "  Expect that no callbacks in `expect_callbacks_not_to_be_called` (if present) were called as a result."
    "* add_callback (`cell`, `name`): Adds a callback to cell `cell`. Store the callback ID in a variable named `name`."
    "  all callbacks are assumed to simply store the values they're called with in some array."
    "* remove_callback (`cell`, `name`): Removes the callback `name` from cell `cell`."
    "" "Additional notes:" ""
    "These tests only describe compute cells with up to two inputs."
    "Some languages may choose to have two functions: create_compute1 and create_compute2."
    "The compiler can then ensure that you never pass a two-input function to a one-input compute cell."
    "(This benefit only exists for statically typed languages)."
    "If your track does this, you should test that all combinations of"
    "(compute1, compute2) can depend on (input, compute1, compute2) are tested."
    "Other languages simply have a single create_compute function, taking a list of input cells."
    "Of the languages in this category, there are two subcategories:"
    "- In some languages, the compute function might take as many inputs as there are input cells."
    "  (it might be very difficult to write the type signature for create_compute in statically typed languages!)"
    "- In other languages, the compute function might always take a single input (the list of values)"
    "  (again this gives up the ability to check that the arities match)"
    "Both subcategories using create_compute have the benefit of more flexibility in arity,"
    "fewer repetitive tests (only need to test that compute cells can depend on compute cells and input cells),"
    "and likely less repetitive code." ""
    "Finally, note that all values are integers."
    "If your language supports generics, you may consider allowing reactors to act on other types."
    "Tests for that are not included here." "")
   (cases
     ((description . "input cells have a value")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 10)))
         (operations
           ((type . "expect_cell_value")
             (cell . "input")
             (value . 10))))
       (expected))
     ((description . "an input cell's value can be set")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 4)))
         (operations
           ((type . "set_value") (cell . "input") (value . 20))
           ((type . "expect_cell_value")
             (cell . "input")
             (value . 20))))
       (expected))
     ((description . "compute cells calculate initial value")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 1))
           ((name . "output")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] + 1")))
         (operations
           ((type . "expect_cell_value")
             (cell . "output")
             (value . 2))))
       (expected))
     ((description
        .
        "compute cells take inputs in the right order")
       (property . "react")
       (input
         (cells
           ((name . "one") (type . "input") (initial_value . 1))
           ((name . "two") (type . "input") (initial_value . 2))
           ((name . "output")
             (type . "compute")
             (inputs "one" "two")
             (compute_function . "inputs[0] + inputs[1] * 10")))
         (operations
           ((type . "expect_cell_value")
             (cell . "output")
             (value . 21))))
       (expected))
     ((description
        .
        "compute cells update value when dependencies are changed")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 1))
           ((name . "output")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] + 1")))
         (operations
           ((type . "set_value") (cell . "input") (value . 3))
           ((type . "expect_cell_value")
             (cell . "output")
             (value . 4))))
       (expected))
     ((description
        .
        "compute cells can depend on other compute cells")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 1))
           ((name . "times_two")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] * 2"))
           ((name . "times_thirty")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] * 30"))
           ((name . "output")
             (type . "compute")
             (inputs "times_two" "times_thirty")
             (compute_function . "inputs[0] + inputs[1]")))
         (operations
           ((type . "expect_cell_value")
             (cell . "output")
             (value . 32))
           ((type . "set_value") (cell . "input") (value . 3))
           ((type . "expect_cell_value")
             (cell . "output")
             (value . 96))))
       (expected))
     ((description . "compute cells fire callbacks")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 1))
           ((name . "output")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] + 1")))
         (operations
           ((type . "add_callback")
             (cell . "output")
             (name . "callback1"))
           ((type . "set_value")
             (cell . "input")
             (value . 3)
             (expect_callbacks (callback1 . 4)))))
       (expected))
     ((description . "callback cells only fire on change")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 1))
           ((name . "output")
             (type . "compute")
             (inputs "input")
             (compute_function . "if inputs[0] < 3 then 111 else 222")))
         (operations
           ((type . "add_callback")
             (cell . "output")
             (name . "callback1"))
           ((type . "set_value")
             (cell . "input")
             (value . 2)
             (expect_callbacks_not_to_be_called "callback1"))
           ((type . "set_value")
             (cell . "input")
             (value . 4)
             (expect_callbacks (callback1 . 222)))))
       (expected))
     ((description
        .
        "callbacks do not report already reported values")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 1))
           ((name . "output")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] + 1")))
         (operations
           ((type . "add_callback")
             (cell . "output")
             (name . "callback1"))
           ((type . "set_value")
             (cell . "input")
             (value . 2)
             (expect_callbacks (callback1 . 3)))
           ((type . "set_value")
             (cell . "input")
             (value . 3)
             (expect_callbacks (callback1 . 4)))))
       (expected))
     ((description . "callbacks can fire from multiple cells")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 1))
           ((name . "plus_one")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] + 1"))
           ((name . "minus_one")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] - 1")))
         (operations
           ((type . "add_callback")
             (cell . "plus_one")
             (name . "callback1"))
           ((type . "add_callback")
             (cell . "minus_one")
             (name . "callback2"))
           ((type . "set_value")
             (cell . "input")
             (value . 10)
             (expect_callbacks (callback1 . 11) (callback2 . 9)))))
       (expected))
     ((description . "callbacks can be added and removed")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 11))
           ((name . "output")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] + 1")))
         (operations
           ((type . "add_callback")
             (cell . "output")
             (name . "callback1"))
           ((type . "add_callback")
             (cell . "output")
             (name . "callback2"))
           ((type . "set_value")
             (cell . "input")
             (value . 31)
             (expect_callbacks (callback1 . 32) (callback2 . 32)))
           ((type . "remove_callback")
             (cell . "output")
             (name . "callback1"))
           ((type . "add_callback")
             (cell . "output")
             (name . "callback3"))
           ((type . "set_value")
             (cell . "input")
             (value . 41)
             (expect_callbacks (callback2 . 42) (callback3 . 42))
             (expect_callbacks_not_to_be_called "callback1"))))
       (expected))
     ((description
        .
        "removing a callback multiple times doesn't interfere with other callbacks")
       (comments
         "Some incorrect implementations store their callbacks in an array"
         "and removing a callback repeatedly either removes an unrelated callback"
         "or causes an out of bounds access.")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 1))
           ((name . "output")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] + 1")))
         (operations
           ((type . "add_callback")
             (cell . "output")
             (name . "callback1"))
           ((type . "add_callback")
             (cell . "output")
             (name . "callback2"))
           ((type . "remove_callback")
             (cell . "output")
             (name . "callback1"))
           ((type . "remove_callback")
             (cell . "output")
             (name . "callback1"))
           ((type . "remove_callback")
             (cell . "output")
             (name . "callback1"))
           ((type . "set_value")
             (cell . "input")
             (value . 2)
             (expect_callbacks (callback2 . 3))
             (expect_callbacks_not_to_be_called "callback1"))))
       (expected))
     ((description
        .
        "callbacks should only be called once even if multiple dependencies change")
       (comments
         "Some incorrect implementations call a callback function too early,"
         "when not all of the inputs of a compute cell have propagated new values.")
       (property . "react")
       (input
         (cells ((name . "input") (type . "input") (initial_value . 1))
           ((name . "plus_one")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] + 1"))
           ((name . "minus_one1")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] - 1"))
           ((name . "minus_one2")
             (type . "compute")
             (inputs "minus_one1")
             (compute_function . "inputs[0] - 1"))
           ((name . "output")
             (type . "compute")
             (inputs "plus_one" "minus_one2")
             (compute_function . "inputs[0] * inputs[1]")))
         (operations
           ((type . "add_callback")
             (cell . "output")
             (name . "callback1"))
           ((type . "set_value")
             (cell . "input")
             (value . 4)
             (expect_callbacks (callback1 . 10)))))
       (expected))
     ((description
        .
        "callbacks should not be called if dependencies change but output value doesn't change")
       (comments
         "Some incorrect implementations simply mark a compute cell as dirty when a dependency changes,"
         "then call callbacks on all dirty cells."
         "This is incorrect since the specification indicates only to call callbacks on change.")
       (property . "react")
       (input
         (cells
           ((name . "input") (type . "input") (initial_value . 1))
           ((name . "plus_one")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] + 1"))
           ((name . "minus_one")
             (type . "compute")
             (inputs "input")
             (compute_function . "inputs[0] - 1"))
           ((name . "always_two")
             (type . "compute")
             (inputs "plus_one" "minus_one")
             (compute_function . "inputs[0] - inputs[1]")))
         (operations
           ((type . "add_callback")
             (cell . "always_two")
             (name . "callback1"))
           ((type . "set_value")
             (cell . "input")
             (value . 2)
             (expect_callbacks_not_to_be_called "callback1"))
           ((type . "set_value")
             (cell . "input")
             (value . 3)
             (expect_callbacks_not_to_be_called "callback1"))
           ((type . "set_value")
             (cell . "input")
             (value . 4)
             (expect_callbacks_not_to_be_called "callback1"))
           ((type . "set_value")
             (cell . "input")
             (value . 5)
             (expect_callbacks_not_to_be_called "callback1"))))
       (expected))))
 (pangram
   (exercise . "pangram")
   (comments
     "A pangram is a sentence using every letter of the alphabet at least once."
     "Output should be a boolean denoting if the string is a pangram or not.")
   (version . "2.0.0")
   (cases
     ((description . "empty sentence")
       (property . "isPangram")
       (input (sentence . ""))
       (expected . #f))
     ((description . "perfect lower case")
       (property . "isPangram")
       (input (sentence . "abcdefghijklmnopqrstuvwxyz"))
       (expected . #t))
     ((description . "only lower case")
       (property . "isPangram")
       (input
         (sentence . "the quick brown fox jumps over the lazy dog"))
       (expected . #t))
     ((description . "missing the letter 'x'")
       (property . "isPangram")
       (input
         (sentence
           .
           "a quick movement of the enemy will jeopardize five gunboats"))
       (expected . #f))
     ((description . "missing the letter 'h'")
       (property . "isPangram")
       (input
         (sentence . "five boxing wizards jump quickly at it"))
       (expected . #f))
     ((description . "with underscores")
       (property . "isPangram")
       (input
         (sentence . "the_quick_brown_fox_jumps_over_the_lazy_dog"))
       (expected . #t))
     ((description . "with numbers")
       (property . "isPangram")
       (input
         (sentence
           .
           "the 1 quick brown fox jumps over the 2 lazy dogs"))
       (expected . #t))
     ((description . "missing letters replaced by numbers")
       (property . "isPangram")
       (input
         (sentence . "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"))
       (expected . #f))
     ((description . "mixed case and punctuation")
       (property . "isPangram")
       (input
         (sentence . "\"Five quacking Zephyrs jolt my wax bed.\""))
       (expected . #t))
     ((description . "case insensitive")
       (property . "isPangram")
       (input
         (sentence . "the quick brown fox jumps over with lazy FX"))
       (expected . #f))))
 (all-your-base
   (exercise . "all-your-base")
   (version . "2.3.0")
   (comments "This canonical data makes the following choices:"
     "1. Zero is always represented in outputs as [0] instead of []."
     "2. In no other instances are leading zeroes present in any outputs."
     "3. Leading zeroes are accepted in inputs."
     "4. An empty sequence of input digits is considered zero, rather than an error."
     ""
     "Tracks that wish to make different decisions for these choices may translate appropriately."
     "" "All your numeric-base are belong to [2..]. :)")
   (cases
    ((description . "single bit one to decimal")
      (property . "rebase")
      (input (inputBase . 2) (digits 1) (outputBase . 10))
      (expected 1))
    ((description . "binary to single decimal")
      (property . "rebase")
      (input (inputBase . 2) (digits 1 0 1) (outputBase . 10))
      (expected 5))
    ((description . "single decimal to binary")
      (property . "rebase")
      (input (inputBase . 10) (digits 5) (outputBase . 2))
      (expected 1 0 1))
    ((description . "binary to multiple decimal")
      (property . "rebase")
      (input
        (inputBase . 2)
        (digits 1 0 1 0 1 0)
        (outputBase . 10))
      (expected 4 2))
    ((description . "decimal to binary")
      (property . "rebase")
      (input (inputBase . 10) (digits 4 2) (outputBase . 2))
      (expected 1 0 1 0 1 0))
    ((description . "trinary to hexadecimal")
      (property . "rebase")
      (input (inputBase . 3) (digits 1 1 2 0) (outputBase . 16))
      (expected 2 10))
    ((description . "hexadecimal to trinary")
      (property . "rebase")
      (input (inputBase . 16) (digits 2 10) (outputBase . 3))
      (expected 1 1 2 0))
    ((description . "15-bit integer")
      (property . "rebase")
      (input (inputBase . 97) (digits 3 46 60) (outputBase . 73))
      (expected 6 10 45))
    ((description . "empty list")
      (property . "rebase")
      (input (inputBase . 2) (digits) (outputBase . 10))
      (expected 0))
    ((description . "single zero")
      (property . "rebase")
      (input (inputBase . 10) (digits 0) (outputBase . 2))
      (expected 0))
    ((description . "multiple zeros")
      (property . "rebase")
      (input (inputBase . 10) (digits 0 0 0) (outputBase . 2))
      (expected 0))
    ((description . "leading zeros")
      (property . "rebase")
      (input (inputBase . 7) (digits 0 6 0) (outputBase . 10))
      (expected 4 2))
    ((description . "input base is one")
      (property . "rebase")
      (input (inputBase . 1) (digits 0) (outputBase . 10))
      (expected (error . "input base must be >= 2")))
    ((description . "input base is zero")
      (property . "rebase")
      (input (inputBase . 0) (digits) (outputBase . 10))
      (expected (error . "input base must be >= 2")))
    ((description . "input base is negative")
      (property . "rebase")
      (input (inputBase . -2) (digits 1) (outputBase . 10))
      (expected (error . "input base must be >= 2")))
    ((description . "negative digit")
      (property . "rebase")
      (input
        (inputBase . 2)
        (digits 1 -1 1 0 1 0)
        (outputBase . 10))
      (expected
        (error . "all digits must satisfy 0 <= d < input base")))
    ((description . "invalid positive digit")
      (property . "rebase")
      (input
        (inputBase . 2)
        (digits 1 2 1 0 1 0)
        (outputBase . 10))
      (expected
        (error . "all digits must satisfy 0 <= d < input base")))
    ((description . "output base is one")
      (property . "rebase")
      (input
        (inputBase . 2)
        (digits 1 0 1 0 1 0)
        (outputBase . 1))
      (expected (error . "output base must be >= 2")))
    ((description . "output base is zero")
      (property . "rebase")
      (input (inputBase . 10) (digits 7) (outputBase . 0))
      (expected (error . "output base must be >= 2")))
    ((description . "output base is negative")
      (property . "rebase")
      (input (inputBase . 2) (digits 1) (outputBase . -7))
      (expected (error . "output base must be >= 2")))
    ((description . "both bases are negative")
      (property . "rebase")
      (input (inputBase . -2) (digits 1) (outputBase . -7))
      (expected (error . "input base must be >= 2")))))
 (allergies
   (exercise . "allergies")
   (version . "2.0.0")
   (comments
     "Given a number and a substance, indicate whether Tom is allergic "
     "to that substance.")
   (cases
     ((description . "testing for eggs allergy")
       (cases
         ((description . "not allergic to anything")
           (property . "allergicTo")
           (input (item . "eggs") (score . 0))
           (expected . #f))
         ((description . "allergic only to eggs")
           (property . "allergicTo")
           (input (item . "eggs") (score . 1))
           (expected . #t))
         ((description . "allergic to eggs and something else")
           (property . "allergicTo")
           (input (item . "eggs") (score . 3))
           (expected . #t))
         ((description . "allergic to something, but not eggs")
           (property . "allergicTo")
           (input (item . "eggs") (score . 2))
           (expected . #f))
         ((description . "allergic to everything")
           (property . "allergicTo")
           (input (item . "eggs") (score . 255))
           (expected . #t))))
     ((description . "testing for peanuts allergy")
       (cases
         ((description . "not allergic to anything")
           (property . "allergicTo")
           (input (item . "peanuts") (score . 0))
           (expected . #f))
         ((description . "allergic only to peanuts")
           (property . "allergicTo")
           (input (item . "peanuts") (score . 2))
           (expected . #t))
         ((description . "allergic to peanuts and something else")
           (property . "allergicTo")
           (input (item . "peanuts") (score . 7))
           (expected . #t))
         ((description . "allergic to something, but not peanuts")
           (property . "allergicTo")
           (input (item . "peanuts") (score . 5))
           (expected . #f))
         ((description . "allergic to everything")
           (property . "allergicTo")
           (input (item . "peanuts") (score . 255))
           (expected . #t))))
     ((description . "testing for shellfish allergy")
       (cases
         ((description . "not allergic to anything")
           (property . "allergicTo")
           (input (item . "shellfish") (score . 0))
           (expected . #f))
         ((description . "allergic only to shellfish")
           (property . "allergicTo")
           (input (item . "shellfish") (score . 4))
           (expected . #t))
         ((description . "allergic to shellfish and something else")
           (property . "allergicTo")
           (input (item . "shellfish") (score . 14))
           (expected . #t))
         ((description . "allergic to something, but not shellfish")
           (property . "allergicTo")
           (input (item . "shellfish") (score . 10))
           (expected . #f))
         ((description . "allergic to everything")
           (property . "allergicTo")
           (input (item . "shellfish") (score . 255))
           (expected . #t))))
     ((description . "testing for strawberries allergy")
       (cases
         ((description . "not allergic to anything")
           (property . "allergicTo")
           (input (item . "strawberries") (score . 0))
           (expected . #f))
         ((description . "allergic only to strawberries")
           (property . "allergicTo")
           (input (item . "strawberries") (score . 8))
           (expected . #t))
         ((description
            .
            "allergic to strawberries and something else")
           (property . "allergicTo")
           (input (item . "strawberries") (score . 28))
           (expected . #t))
         ((description
            .
            "allergic to something, but not strawberries")
           (property . "allergicTo")
           (input (item . "strawberries") (score . 20))
           (expected . #f))
         ((description . "allergic to everything")
           (property . "allergicTo")
           (input (item . "strawberries") (score . 255))
           (expected . #t))))
     ((description . "testing for tomatoes allergy")
       (cases
         ((description . "not allergic to anything")
           (property . "allergicTo")
           (input (item . "tomatoes") (score . 0))
           (expected . #f))
         ((description . "allergic only to tomatoes")
           (property . "allergicTo")
           (input (item . "tomatoes") (score . 16))
           (expected . #t))
         ((description . "allergic to tomatoes and something else")
           (property . "allergicTo")
           (input (item . "tomatoes") (score . 56))
           (expected . #t))
         ((description . "allergic to something, but not tomatoes")
           (property . "allergicTo")
           (input (item . "tomatoes") (score . 40))
           (expected . #f))
         ((description . "allergic to everything")
           (property . "allergicTo")
           (input (item . "tomatoes") (score . 255))
           (expected . #t))))
     ((description . "testing for chocolate allergy")
       (cases
         ((description . "not allergic to anything")
           (property . "allergicTo")
           (input (item . "chocolate") (score . 0))
           (expected . #f))
         ((description . "allergic only to chocolate")
           (property . "allergicTo")
           (input (item . "chocolate") (score . 32))
           (expected . #t))
         ((description . "allergic to chocolate and something else")
           (property . "allergicTo")
           (input (item . "chocolate") (score . 112))
           (expected . #t))
         ((description . "allergic to something, but not chocolate")
           (property . "allergicTo")
           (input (item . "chocolate") (score . 80))
           (expected . #f))
         ((description . "allergic to everything")
           (property . "allergicTo")
           (input (item . "chocolate") (score . 255))
           (expected . #t))))
     ((description . "testing for pollen allergy")
       (cases
         ((description . "not allergic to anything")
           (property . "allergicTo")
           (input (item . "pollen") (score . 0))
           (expected . #f))
         ((description . "allergic only to pollen")
           (property . "allergicTo")
           (input (item . "pollen") (score . 64))
           (expected . #t))
         ((description . "allergic to pollen and something else")
           (property . "allergicTo")
           (input (item . "pollen") (score . 224))
           (expected . #t))
         ((description . "allergic to something, but not pollen")
           (property . "allergicTo")
           (input (item . "pollen") (score . 160))
           (expected . #f))
         ((description . "allergic to everything")
           (property . "allergicTo")
           (input (item . "pollen") (score . 255))
           (expected . #t))))
     ((description . "testing for cats allergy")
       (cases
         ((description . "not allergic to anything")
           (property . "allergicTo")
           (input (item . "cats") (score . 0))
           (expected . #f))
         ((description . "allergic only to cats")
           (property . "allergicTo")
           (input (item . "cats") (score . 128))
           (expected . #t))
         ((description . "allergic to cats and something else")
           (property . "allergicTo")
           (input (item . "cats") (score . 192))
           (expected . #t))
         ((description . "allergic to something, but not cats")
           (property . "allergicTo")
           (input (item . "cats") (score . 64))
           (expected . #f))
         ((description . "allergic to everything")
           (property . "allergicTo")
           (input (item . "cats") (score . 255))
           (expected . #t))))
     ((description . "list when:")
       (comments
         "Given a number, list all things Tom is allergic to")
       (cases
         ((description . "no allergies")
           (property . "list")
           (input (score . 0))
           (expected))
         ((description . "just eggs")
           (property . "list")
           (input (score . 1))
           (expected "eggs"))
         ((description . "just peanuts")
           (property . "list")
           (input (score . 2))
           (expected "peanuts"))
         ((description . "just strawberries")
           (property . "list")
           (input (score . 8))
           (expected "strawberries"))
         ((description . "eggs and peanuts")
           (property . "list")
           (input (score . 3))
           (expected "eggs" "peanuts"))
         ((description . "more than eggs but not peanuts")
           (property . "list")
           (input (score . 5))
           (expected "eggs" "shellfish"))
         ((description . "lots of stuff")
           (property . "list")
           (input (score . 248))
           (expected "strawberries" "tomatoes" "chocolate" "pollen"
             "cats"))
         ((description . "everything")
           (property . "list")
           (input (score . 255))
           (expected "eggs" "peanuts" "shellfish" "strawberries"
             "tomatoes" "chocolate" "pollen" "cats"))
         ((description . "no allergen score parts")
           (property . "list")
           (input (score . 509))
           (expected "eggs" "shellfish" "strawberries" "tomatoes"
             "chocolate" "pollen" "cats"))))))
 (forth
   (exercise . "forth")
   (version . "1.7.1")
   (comments
     "The cases are split into multiple sections, all with the same structure."
     "In all cases, the `expected` key is the resulting stack"
     "after executing the Forth program contained in the `input` key, unless an 'error' exists.")
   (cases
     ((description . "parsing and numbers")
       (cases
         ((description . "numbers just get pushed onto the stack")
           (property . "evaluate")
           (input (instructions "1 2 3 4 5"))
           (expected 1 2 3 4 5))))
     ((description . "addition")
       (cases
         ((description . "can add two numbers")
           (property . "evaluate")
           (input (instructions "1 2 +"))
           (expected 3))
         ((description . "errors if there is nothing on the stack")
           (property . "evaluate")
           (input (instructions "+"))
           (expected (error . "empty stack")))
         ((description
            .
            "errors if there is only one value on the stack")
           (property . "evaluate")
           (input (instructions "1 +"))
           (expected (error . "only one value on the stack")))))
     ((description . "subtraction")
       (cases
         ((description . "can subtract two numbers")
           (property . "evaluate")
           (input (instructions "3 4 -"))
           (expected -1))
         ((description . "errors if there is nothing on the stack")
           (property . "evaluate")
           (input (instructions "-"))
           (expected (error . "empty stack")))
         ((description
            .
            "errors if there is only one value on the stack")
           (property . "evaluate")
           (input (instructions "1 -"))
           (expected (error . "only one value on the stack")))))
     ((description . "multiplication")
       (cases
         ((description . "can multiply two numbers")
           (property . "evaluate")
           (input (instructions "2 4 *"))
           (expected 8))
         ((description . "errors if there is nothing on the stack")
           (property . "evaluate")
           (input (instructions "*"))
           (expected (error . "empty stack")))
         ((description
            .
            "errors if there is only one value on the stack")
           (property . "evaluate")
           (input (instructions "1 *"))
           (expected (error . "only one value on the stack")))))
     ((description . "division")
       (cases
         ((description . "can divide two numbers")
           (property . "evaluate")
           (input (instructions "12 3 /"))
           (expected 4))
         ((description . "performs integer division")
           (property . "evaluate")
           (input (instructions "8 3 /"))
           (expected 2))
         ((description . "errors if dividing by zero")
           (property . "evaluate")
           (input (instructions "4 0 /"))
           (expected (error . "divide by zero")))
         ((description . "errors if there is nothing on the stack")
           (property . "evaluate")
           (input (instructions "/"))
           (expected (error . "empty stack")))
         ((description
            .
            "errors if there is only one value on the stack")
           (property . "evaluate")
           (input (instructions "1 /"))
           (expected (error . "only one value on the stack")))))
     ((description . "combined arithmetic")
       (cases
         ((description . "addition and subtraction")
           (property . "evaluate")
           (input (instructions "1 2 + 4 -"))
           (expected -1))
         ((description . "multiplication and division")
           (property . "evaluate")
           (input (instructions "2 4 * 3 /"))
           (expected 2))))
     ((description . "dup")
       (cases
         ((description . "copies a value on the stack")
           (property . "evaluate")
           (input (instructions "1 dup"))
           (expected 1 1))
         ((description . "copies the top value on the stack")
           (property . "evaluate")
           (input (instructions "1 2 dup"))
           (expected 1 2 2))
         ((description . "errors if there is nothing on the stack")
           (property . "evaluate")
           (input (instructions "dup"))
           (expected (error . "empty stack")))))
     ((description . "drop")
       (cases
         ((description
            .
            "removes the top value on the stack if it is the only one")
           (property . "evaluate")
           (input (instructions "1 drop"))
           (expected))
         ((description
            .
            "removes the top value on the stack if it is not the only one")
           (property . "evaluate")
           (input (instructions "1 2 drop"))
           (expected 1))
         ((description . "errors if there is nothing on the stack")
           (property . "evaluate")
           (input (instructions "drop"))
           (expected (error . "empty stack")))))
     ((description . "swap")
       (cases
         ((description
            .
            "swaps the top two values on the stack if they are the only ones")
           (property . "evaluate")
           (input (instructions "1 2 swap"))
           (expected 2 1))
         ((description
            .
            "swaps the top two values on the stack if they are not the only ones")
           (property . "evaluate")
           (input (instructions "1 2 3 swap"))
           (expected 1 3 2))
         ((description . "errors if there is nothing on the stack")
           (property . "evaluate")
           (input (instructions "swap"))
           (expected (error . "empty stack")))
         ((description
            .
            "errors if there is only one value on the stack")
           (property . "evaluate")
           (input (instructions "1 swap"))
           (expected (error . "only one value on the stack")))))
     ((description . "over")
       (cases
         ((description
            .
            "copies the second element if there are only two")
           (property . "evaluate")
           (input (instructions "1 2 over"))
           (expected 1 2 1))
         ((description
            .
            "copies the second element if there are more than two")
           (property . "evaluate")
           (input (instructions "1 2 3 over"))
           (expected 1 2 3 2))
         ((description . "errors if there is nothing on the stack")
           (property . "evaluate")
           (input (instructions "over"))
           (expected (error . "empty stack")))
         ((description
            .
            "errors if there is only one value on the stack")
           (property . "evaluate")
           (input (instructions "1 over"))
           (expected (error . "only one value on the stack")))))
     ((description . "user-defined words")
       (cases
         ((description . "can consist of built-in words")
           (property . "evaluate")
           (input (instructions ": dup-twice dup dup ;" "1 dup-twice"))
           (expected 1 1 1))
         ((description . "execute in the right order")
           (property . "evaluate")
           (input (instructions ": countup 1 2 3 ;" "countup"))
           (expected 1 2 3))
         ((description . "can override other user-defined words")
           (property . "evaluate")
           (input
             (instructions ": foo dup ;" ": foo dup dup ;" "1 foo"))
           (expected 1 1 1))
         ((description . "can override built-in words")
           (property . "evaluate")
           (input (instructions ": swap dup ;" "1 swap"))
           (expected 1 1))
         ((description . "can override built-in operators")
           (property . "evaluate")
           (input (instructions ": + * ;" "3 4 +"))
           (expected 12))
         ((description
            .
            "can use different words with the same name")
           (property . "evaluate")
           (input
             (instructions
               ": foo 5 ;"
               ": bar foo ;"
               ": foo 6 ;"
               "bar foo"))
           (expected 5 6))
         ((description
            .
            "can define word that uses word with the same name")
           (property . "evaluate")
           (input (instructions ": foo 10 ;" ": foo foo 1 + ;" "foo"))
           (expected 11))
         ((description . "cannot redefine numbers")
           (property . "evaluate")
           (input (instructions ": 1 2 ;"))
           (expected (error . "illegal operation")))
         ((description . "errors if executing a non-existent word")
           (property . "evaluate")
           (input (instructions "foo"))
           (expected (error . "undefined operation")))))
     ((description . "case-insensitivity")
       (cases
         ((description . "DUP is case-insensitive")
           (property . "evaluate")
           (input (instructions "1 DUP Dup dup"))
           (expected 1 1 1 1))
         ((description . "DROP is case-insensitive")
           (property . "evaluate")
           (input (instructions "1 2 3 4 DROP Drop drop"))
           (expected 1))
         ((description . "SWAP is case-insensitive")
           (property . "evaluate")
           (input (instructions "1 2 SWAP 3 Swap 4 swap"))
           (expected 2 3 4 1))
         ((description . "OVER is case-insensitive")
           (property . "evaluate")
           (input (instructions "1 2 OVER Over over"))
           (expected 1 2 1 2 1))
         ((description . "user-defined words are case-insensitive")
           (property . "evaluate")
           (input (instructions ": foo dup ;" "1 FOO Foo foo"))
           (expected 1 1 1 1))
         ((description . "definitions are case-insensitive")
           (property . "evaluate")
           (input (instructions ": SWAP DUP Dup dup ;" "1 swap"))
           (expected 1 1 1 1))))))
 (rail-fence-cipher
   (exercise . "rail-fence-cipher")
   (version . "1.1.0")
   (comments
     "The tests do not expect any normalization or cleaning."
     "That trade is tested in enough other exercises.")
   (cases
     ((description . "encode")
       (cases
         ((description . "encode with two rails")
           (property . "encode")
           (input (msg . "XOXOXOXOXOXOXOXOXO") (rails . 2))
           (expected . "XXXXXXXXXOOOOOOOOO"))
         ((description . "encode with three rails")
           (property . "encode")
           (input (msg . "WEAREDISCOVEREDFLEEATONCE") (rails . 3))
           (expected . "WECRLTEERDSOEEFEAOCAIVDEN"))
         ((description . "encode with ending in the middle")
           (property . "encode")
           (input (msg . "EXERCISES") (rails . 4))
           (expected . "ESXIEECSR"))))
     ((description . "decode")
       (cases
         ((description . "decode with three rails")
           (property . "decode")
           (input (msg . "TEITELHDVLSNHDTISEIIEA") (rails . 3))
           (expected . "THEDEVILISINTHEDETAILS"))
         ((description . "decode with five rails")
           (property . "decode")
           (input (msg . "EIEXMSMESAORIWSCE") (rails . 5))
           (expected . "EXERCISMISAWESOME"))
         ((description . "decode with six rails")
           (property . "decode")
           (input
             (msg .
                  "133714114238148966225439541018335470986172518171757571896261")
             (rails . 6))
           (expected
             .
             "112358132134558914423337761098715972584418167651094617711286"))))))
 (prime-factors
   (exercise . "prime-factors")
   (version . "1.1.0")
   (cases
     ((description
        .
        "returns prime factors for the given input number")
       (cases
         ((description . "no factors")
           (property . "factors")
           (input (value . 1))
           (expected))
         ((description . "prime number")
           (property . "factors")
           (input (value . 2))
           (expected 2))
         ((description . "square of a prime")
           (property . "factors")
           (input (value . 9))
           (expected 3 3))
         ((description . "cube of a prime")
           (property . "factors")
           (input (value . 8))
           (expected 2 2 2))
         ((description . "product of primes and non-primes")
           (property . "factors")
           (input (value . 12))
           (expected 2 2 3))
         ((description . "product of primes")
           (property . "factors")
           (input (value . 901255))
           (expected 5 17 23 461))
         ((description . "factors include a large prime")
           (property . "factors")
           (input (value . 93819012551))
           (expected 11 9539 894119))))))
 (flatten-array
   (exercise . "flatten-array")
   (version . "1.2.0")
   (cases
     ((description . "no nesting")
       (property . "flatten")
       (input (array 0 1 2))
       (expected 0 1 2))
     ((description . "flattens array with just integers present")
       (property . "flatten")
       (input (array 1 (2 3 4 5 6 7) 8))
       (expected 1 2 3 4 5 6 7 8))
     ((description . "5 level nesting")
       (property . "flatten")
       (input (array 0 2 ((2 3) 8 100 4 (((50)))) -2))
       (expected 0 2 2 3 8 100 4 50 -2))
     ((description . "6 level nesting")
       (property . "flatten")
       (input (array 1 (2 ((3)) (4 ((5))) 6 7) 8))
       (expected 1 2 3 4 5 6 7 8))
     ((description . "6 level nest list with null values")
       (property . "flatten")
       (input (array 0 2 ((2 3) 8 ((100)) () ((()))) -2))
       (expected 0 2 2 3 8 100 -2))
     ((description . "all values in nested list are null")
       (property . "flatten")
       (input (array () (((()))) () () ((() ()) ()) ()))
       (expected))))
 (connect
   (exercise . "connect")
   (version . "1.1.0")
   (cases
     ((description . "an empty board has no winner")
       (property . "winner")
       (input
         (board ". . . . ." " . . . . ." "  . . . . ." "   . . . . ."
           "    . . . . ."))
       (expected . ""))
     ((description . "X can win on a 1x1 board")
       (property . "winner")
       (input (board "X"))
       (expected . "X"))
     ((description . "O can win on a 1x1 board")
       (property . "winner")
       (input (board "O"))
       (expected . "O"))
     ((description . "only edges does not make a winner")
       (property . "winner")
       (input
         (board "O O O X" " X . . X" "  X . . X" "   X O O O"))
       (expected . ""))
     ((description . "illegal diagonal does not make a winner")
       (property . "winner")
       (input
         (board "X O . ." " O X X X" "  O X O ." "   . O X ."
           "    X X O O"))
       (expected . ""))
     ((description . "nobody wins crossing adjacent angles")
       (property . "winner")
       (input
         (board "X . . ." " . X O ." "  O . X O" "   . O . X"
           "    . . O ."))
       (expected . ""))
     ((description . "X wins crossing from left to right")
       (property . "winner")
       (input
         (board ". O . ." " O X X X" "  O X O ." "   X X O X"
           "    . O X ."))
       (expected . "X"))
     ((description . "O wins crossing from top to bottom")
       (property . "winner")
       (input
         (board ". O . ." " O X X X" "  O O O ." "   X X O X"
           "    . O X ."))
       (expected . "O"))
     ((description . "X wins using a convoluted path")
       (property . "winner")
       (input
         (board ". X X . ." " X . X . X" "  . X . X ." "   . X X . ."
           "    O O O O O"))
       (expected . "X"))
     ((description . "X wins using a spiral path")
       (property . "winner")
       (input
         (board "O X X X X X X X X" " O X O O O O O O O"
           "  O X O X X X X X O" "   O X O X O O O X O"
           "    O X O X X X O X O" "     O X O O O X O X O"
           "      O X X X X X O X O" "       O O O O O O O X O"
           "        X X X X X X X X O"))
       (expected . "X"))))
 (sublist
   (exercise . "sublist")
   (version . "1.1.0")
   (comments "Lists are ordered and sequential."
     "https://en.wikipedia.org/wiki/List_%28abstract_data_type%29"
     ""
     "Depending on your language, there may need to be some translation"
     "to go from the JSON array to the list representation."
     "The expectation can be used to generate an expected value"
     "based on your implementation (such as a constant 'EQUAL', 'SUBLIST', etc.)."
     ""
     "If appropriate for your track, you'll need to ensure that no pair of expected values are equal."
     "Otherwise, an implementation that always returns a constant value may falsely pass the tests."
     "See https://github.com/exercism/xpython/issues/342")
   (cases
     ((description . "empty lists")
       (property . "sublist")
       (input (listOne) (listTwo))
       (expected . "equal"))
     ((description . "empty list within non empty list")
       (property . "sublist")
       (input (listOne) (listTwo 1 2 3))
       (expected . "sublist"))
     ((description . "non empty list contains empty list")
       (property . "sublist")
       (input (listOne 1 2 3) (listTwo))
       (expected . "superlist"))
     ((description . "list equals itself")
       (property . "sublist")
       (input (listOne 1 2 3) (listTwo 1 2 3))
       (expected . "equal"))
     ((description . "different lists")
       (property . "sublist")
       (input (listOne 1 2 3) (listTwo 2 3 4))
       (expected . "unequal"))
     ((description . "false start")
       (property . "sublist")
       (input (listOne 1 2 5) (listTwo 0 1 2 3 1 2 5 6))
       (expected . "sublist"))
     ((description . "consecutive")
       (property . "sublist")
       (input (listOne 1 1 2) (listTwo 0 1 1 1 2 1 2))
       (expected . "sublist"))
     ((description . "sublist at start")
       (property . "sublist")
       (input (listOne 0 1 2) (listTwo 0 1 2 3 4 5))
       (expected . "sublist"))
     ((description . "sublist in middle")
       (property . "sublist")
       (input (listOne 2 3 4) (listTwo 0 1 2 3 4 5))
       (expected . "sublist"))
     ((description . "sublist at end")
       (property . "sublist")
       (input (listOne 3 4 5) (listTwo 0 1 2 3 4 5))
       (expected . "sublist"))
     ((description . "at start of superlist")
       (property . "sublist")
       (input (listOne 0 1 2 3 4 5) (listTwo 0 1 2))
       (expected . "superlist"))
     ((description . "in middle of superlist")
       (property . "sublist")
       (input (listOne 0 1 2 3 4 5) (listTwo 2 3))
       (expected . "superlist"))
     ((description . "at end of superlist")
       (property . "sublist")
       (input (listOne 0 1 2 3 4 5) (listTwo 3 4 5))
       (expected . "superlist"))
     ((description
        .
        "first list missing element from second list")
       (property . "sublist")
       (input (listOne 1 3) (listTwo 1 2 3))
       (expected . "unequal"))
     ((description
        .
        "second list missing element from first list")
       (property . "sublist")
       (input (listOne 1 2 3) (listTwo 1 3))
       (expected . "unequal"))
     ((description . "order matters to a list")
       (property . "sublist")
       (input (listOne 1 2 3) (listTwo 3 2 1))
       (expected . "unequal"))
     ((description . "same digits but different numbers")
       (property . "sublist")
       (input (listOne 1 0 1) (listTwo 10 1))
       (expected . "unequal"))))
 (word-count
   (exercise . "word-count")
   (version . "1.4.0")
   (comments
     "For each word in the input, count the number of times it appears in the"
     "entire sentence.")
   (cases
     ((description . "count one word")
       (property . "countWords")
       (input (sentence . "word"))
       (expected (word . 1)))
     ((description . "count one of each word")
       (property . "countWords")
       (input (sentence . "one of each"))
       (expected (one . 1) (of . 1) (each . 1)))
     ((description . "multiple occurrences of a word")
       (property . "countWords")
       (input (sentence . "one fish two fish red fish blue fish"))
       (expected (one . 1) (fish . 4) (two . 1) (red . 1)
         (blue . 1)))
     ((description . "handles cramped lists")
       (property . "countWords")
       (input (sentence . "one,two,three"))
       (expected (one . 1) (two . 1) (three . 1)))
     ((description . "handles expanded lists")
       (property . "countWords")
       (input (sentence . "one,\ntwo,\nthree"))
       (expected (one . 1) (two . 1) (three . 1)))
     ((description . "ignore punctuation")
       (property . "countWords")
       (input
         (sentence . "car: carpet as java: javascript!!&@$%^&"))
       (expected (car . 1) (carpet . 1) (as . 1) (java . 1)
         (javascript . 1)))
     ((description . "include numbers")
       (property . "countWords")
       (input (sentence . "testing, 1, 2 testing"))
       (expected (testing . 2) (\x31; . 1) (\x32; . 1)))
     ((description . "normalize case")
       (property . "countWords")
       (input (sentence . "go Go GO Stop stop"))
       (expected (go . 3) (stop . 2)))
     ((description . "with apostrophes")
       (property . "countWords")
       (input (sentence . "First: don't laugh. Then: don't cry."))
       (expected (first . 1) (don\x27;t . 2) (laugh . 1) (then . 1)
         (cry . 1)))
     ((description . "with quotations")
       (property . "countWords")
       (input
         (sentence . "Joe can't tell between 'large' and large."))
       (expected (joe . 1) (can\x27;t . 1) (tell . 1) (between . 1)
         (large . 2) (and . 1)))
     ((description . "substrings from the beginning")
       (property . "countWords")
       (input
         (sentence . "Joe can't tell between app, apple and a."))
       (expected (joe . 1) (can\x27;t . 1) (tell . 1) (between . 1)
         (app . 1) (apple . 1) (and . 1) (a . 1)))
     ((description . "multiple spaces not detected as a word")
       (property . "countWords")
       (input (sentence . " multiple   whitespaces"))
       (expected (multiple . 1) (whitespaces . 1)))
     ((description
        .
        "alternating word separators not detected as a word")
       (property . "countWords")
       (input (sentence . ",\n,one,\n ,two \n 'three'"))
       (expected (one . 1) (two . 1) (three . 1)))))
 (dnd-character
   (exercise . "dnd-character")
   (version . "1.1.0")
   (comments "The random generator 'ability' can be property-tested."
     "The pure function 'modifier' can be tested totally."
     "The random generator 'character' should return some"
     "kind of structure with six random abilities and a"
     "hitpoint score. This structure can be property-tested"
     "in the same way as 'ability' and 'modifier'." ""
     "It may be fun to provide a 'name' property for characters"
     "that may or may not be randomly generated but not tested."
     "" "Many programming languages feature property-based test"
     "frameworks. For a language-agnostic introduction to"
     "property-based testing, see:" ""
     "https://hypothesis.works/articles/what-is-property-based-testing/")
   (cases
     ((description . "ability modifier")
       (cases
         ((description . "ability modifier for score 3 is -4")
           (property . "modifier")
           (input (score . 3))
           (expected . -4))
         ((description . "ability modifier for score 4 is -3")
           (property . "modifier")
           (input (score . 4))
           (expected . -3))
         ((description . "ability modifier for score 5 is -3")
           (property . "modifier")
           (input (score . 5))
           (expected . -3))
         ((description . "ability modifier for score 6 is -2")
           (property . "modifier")
           (input (score . 6))
           (expected . -2))
         ((description . "ability modifier for score 7 is -2")
           (property . "modifier")
           (input (score . 7))
           (expected . -2))
         ((description . "ability modifier for score 8 is -1")
           (property . "modifier")
           (input (score . 8))
           (expected . -1))
         ((description . "ability modifier for score 9 is -1")
           (property . "modifier")
           (input (score . 9))
           (expected . -1))
         ((description . "ability modifier for score 10 is 0")
           (property . "modifier")
           (input (score . 10))
           (expected . 0))
         ((description . "ability modifier for score 11 is 0")
           (property . "modifier")
           (input (score . 11))
           (expected . 0))
         ((description . "ability modifier for score 12 is +1")
           (property . "modifier")
           (input (score . 12))
           (expected . 1))
         ((description . "ability modifier for score 13 is +1")
           (property . "modifier")
           (input (score . 13))
           (expected . 1))
         ((description . "ability modifier for score 14 is +2")
           (property . "modifier")
           (input (score . 14))
           (expected . 2))
         ((description . "ability modifier for score 15 is +2")
           (property . "modifier")
           (input (score . 15))
           (expected . 2))
         ((description . "ability modifier for score 16 is +3")
           (property . "modifier")
           (input (score . 16))
           (expected . 3))
         ((description . "ability modifier for score 17 is +3")
           (property . "modifier")
           (input (score . 17))
           (expected . 3))
         ((description . "ability modifier for score 18 is +4")
           (property . "modifier")
           (input (score . 18))
           (expected . 4))))
     ((description . "random ability is within range")
       (property . "ability")
       (input)
       (expected . "score >= 3 && score <= 18"))
     ((description . "random character is valid")
       (property . "character")
       (input)
       (expected (strength . "strength >= 3 && strength <= 18")
         (dexterity . "dexterity >= 3 && dexterity <= 18")
         (constitution . "constitution >= 3 && constitution <= 18")
         (intelligence . "intelligence >= 3 && intelligence <= 18")
         (wisdom . "wisdom >= 3 && wisdom <= 18")
         (charisma . "charisma >= 3 && charisma <= 18")
         (hitpoints . "hitpoints == 10 + modifier(constitution)")))
     ((description . "each ability is only calculated once")
       (property . "strength")
       (input)
       (expected . "strength == strength"))))
 (grade-school
   (exercise . "grade-school")
   (version . "1.0.1")
   (comments
     "Given students' names along with the grade that they are in, "
     "create a roster for the school.")
   (cases
     ((description
        .
        "Adding a student adds them to the sorted roster")
       (property . "roster")
       (input (students ("Aimee" 2)))
       (expected "Aimee"))
     ((description
        .
        "Adding more student adds them to the sorted roster")
       (property . "roster")
       (input (students ("Blair" 2) ("James" 2) ("Paul" 2)))
       (expected "Blair" "James" "Paul"))
     ((description
        .
        "Adding students to different grades adds them to the same sorted roster")
       (property . "roster")
       (input (students ("Chelsea" 3) ("Logan" 7)))
       (expected "Chelsea" "Logan"))
     ((description
        .
        "Roster returns an empty list if there are no students enrolled")
       (property . "roster")
       (input (students))
       (expected))
     ((description
        .
        "Student names with grades are displayed in the same sorted roster")
       (property . "roster")
       (input
         (students ("Peter" 2) ("Anna" 1) ("Barb" 1) ("Zoe" 2)
           ("Alex" 2) ("Jim" 3) ("Charlie" 1)))
       (expected "Anna" "Barb" "Charlie" "Alex" "Peter" "Zoe"
         "Jim"))
     ((description
        .
        "Grade returns the students in that grade in alphabetical order")
       (property . "grade")
       (input
         (students ("Franklin" 5) ("Bradley" 5) ("Jeff" 1))
         (desiredGrade . 5))
       (expected "Bradley" "Franklin"))
     ((description
        .
        "Grade returns an empty list if there are no students in that grade")
       (property . "grade")
       (input (students) (desiredGrade . 1))
       (expected))))
 (binary
   (exercise . "binary")
   (version . "1.1.0")
   (cases
     ((description . "binary 0 is decimal 0")
       (property . "decimal")
       (input (binary . "0"))
       (expected . 0))
     ((description . "binary 1 is decimal 1")
       (property . "decimal")
       (input (binary . "1"))
       (expected . 1))
     ((description . "binary 10 is decimal 2")
       (property . "decimal")
       (input (binary . "10"))
       (expected . 2))
     ((description . "binary 11 is decimal 3")
       (property . "decimal")
       (input (binary . "11"))
       (expected . 3))
     ((description . "binary 100 is decimal 4")
       (property . "decimal")
       (input (binary . "100"))
       (expected . 4))
     ((description . "binary 1001 is decimal 9")
       (property . "decimal")
       (input (binary . "1001"))
       (expected . 9))
     ((description . "binary 11010 is decimal 26")
       (property . "decimal")
       (input (binary . "11010"))
       (expected . 26))
     ((description . "binary 10001101000 is decimal 1128")
       (property . "decimal")
       (input (binary . "10001101000"))
       (expected . 1128))
     ((description . "binary ignores leading zeros")
       (property . "decimal")
       (input (binary . "000011111"))
       (expected . 31))
     ((description . "2 is not a valid binary digit")
       (property . "decimal")
       (input (binary . "2"))
       (expected))
     ((description
        .
        "a number containing a non-binary digit is invalid")
       (property . "decimal")
       (input (binary . "01201"))
       (expected))
     ((description
        .
        "a number with trailing non-binary characters is invalid")
       (property . "decimal")
       (input (binary . "10nope"))
       (expected))
     ((description
        .
        "a number with leading non-binary characters is invalid")
       (property . "decimal")
       (input (binary . "nope10"))
       (expected))
     ((description
        .
        "a number with internal non-binary characters is invalid")
       (property . "decimal")
       (input (binary . "10nope10"))
       (expected))
     ((description
        .
        "a number and a word whitespace separated is invalid")
       (property . "decimal")
       (input (binary . "001 nope"))
       (expected))))
 (acronym
   (exercise . "acronym")
   (version . "1.7.0")
   (cases
     ((description . "Abbreviate a phrase")
       (cases
         ((description . "basic")
           (property . "abbreviate")
           (input (phrase . "Portable Network Graphics"))
           (expected . "PNG"))
         ((description . "lowercase words")
           (property . "abbreviate")
           (input (phrase . "Ruby on Rails"))
           (expected . "ROR"))
         ((description . "punctuation")
           (property . "abbreviate")
           (input (phrase . "First In, First Out"))
           (expected . "FIFO"))
         ((description . "all caps word")
           (property . "abbreviate")
           (input (phrase . "GNU Image Manipulation Program"))
           (expected . "GIMP"))
         ((description . "punctuation without whitespace")
           (property . "abbreviate")
           (input (phrase . "Complementary metal-oxide semiconductor"))
           (expected . "CMOS"))
         ((description . "very long abbreviation")
           (property . "abbreviate")
           (input
             (phrase
               .
               "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"))
           (expected . "ROTFLSHTMDCOALM"))
         ((description . "consecutive delimiters")
           (property . "abbreviate")
           (input (phrase . "Something - I made up from thin air"))
           (expected . "SIMUFTA"))
         ((description . "apostrophes")
           (property . "abbreviate")
           (input (phrase . "Halley's Comet"))
           (expected . "HC"))
         ((description . "underscore emphasis")
           (property . "abbreviate")
           (input (phrase . "The Road _Not_ Taken"))
           (expected . "TRNT"))))))
 (meetup
   (exercise . "meetup")
   (version . "1.1.0")
   (cases
    ((description . "monteenth of May 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 5)
        (week . "teenth")
        (dayofweek . "Monday"))
      (expected . "2013-05-13"))
    ((description . "monteenth of August 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 8)
        (week . "teenth")
        (dayofweek . "Monday"))
      (expected . "2013-08-19"))
    ((description . "monteenth of September 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 9)
        (week . "teenth")
        (dayofweek . "Monday"))
      (expected . "2013-09-16"))
    ((description . "tuesteenth of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "teenth")
        (dayofweek . "Tuesday"))
      (expected . "2013-03-19"))
    ((description . "tuesteenth of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "teenth")
        (dayofweek . "Tuesday"))
      (expected . "2013-04-16"))
    ((description . "tuesteenth of August 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 8)
        (week . "teenth")
        (dayofweek . "Tuesday"))
      (expected . "2013-08-13"))
    ((description . "wednesteenth of January 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 1)
        (week . "teenth")
        (dayofweek . "Wednesday"))
      (expected . "2013-01-16"))
    ((description . "wednesteenth of February 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 2)
        (week . "teenth")
        (dayofweek . "Wednesday"))
      (expected . "2013-02-13"))
    ((description . "wednesteenth of June 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 6)
        (week . "teenth")
        (dayofweek . "Wednesday"))
      (expected . "2013-06-19"))
    ((description . "thursteenth of May 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 5)
        (week . "teenth")
        (dayofweek . "Thursday"))
      (expected . "2013-05-16"))
    ((description . "thursteenth of June 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 6)
        (week . "teenth")
        (dayofweek . "Thursday"))
      (expected . "2013-06-13"))
    ((description . "thursteenth of September 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 9)
        (week . "teenth")
        (dayofweek . "Thursday"))
      (expected . "2013-09-19"))
    ((description . "friteenth of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "teenth")
        (dayofweek . "Friday"))
      (expected . "2013-04-19"))
    ((description . "friteenth of August 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 8)
        (week . "teenth")
        (dayofweek . "Friday"))
      (expected . "2013-08-16"))
    ((description . "friteenth of September 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 9)
        (week . "teenth")
        (dayofweek . "Friday"))
      (expected . "2013-09-13"))
    ((description . "saturteenth of February 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 2)
        (week . "teenth")
        (dayofweek . "Saturday"))
      (expected . "2013-02-16"))
    ((description . "saturteenth of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "teenth")
        (dayofweek . "Saturday"))
      (expected . "2013-04-13"))
    ((description . "saturteenth of October 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 10)
        (week . "teenth")
        (dayofweek . "Saturday"))
      (expected . "2013-10-19"))
    ((description . "sunteenth of May 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 5)
        (week . "teenth")
        (dayofweek . "Sunday"))
      (expected . "2013-05-19"))
    ((description . "sunteenth of June 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 6)
        (week . "teenth")
        (dayofweek . "Sunday"))
      (expected . "2013-06-16"))
    ((description . "sunteenth of October 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 10)
        (week . "teenth")
        (dayofweek . "Sunday"))
      (expected . "2013-10-13"))
    ((description . "first Monday of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "first")
        (dayofweek . "Monday"))
      (expected . "2013-03-04"))
    ((description . "first Monday of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "first")
        (dayofweek . "Monday"))
      (expected . "2013-04-01"))
    ((description . "first Tuesday of May 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 5)
        (week . "first")
        (dayofweek . "Tuesday"))
      (expected . "2013-05-07"))
    ((description . "first Tuesday of June 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 6)
        (week . "first")
        (dayofweek . "Tuesday"))
      (expected . "2013-06-04"))
    ((description . "first Wednesday of July 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 7)
        (week . "first")
        (dayofweek . "Wednesday"))
      (expected . "2013-07-03"))
    ((description . "first Wednesday of August 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 8)
        (week . "first")
        (dayofweek . "Wednesday"))
      (expected . "2013-08-07"))
    ((description . "first Thursday of September 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 9)
        (week . "first")
        (dayofweek . "Thursday"))
      (expected . "2013-09-05"))
    ((description . "first Thursday of October 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 10)
        (week . "first")
        (dayofweek . "Thursday"))
      (expected . "2013-10-03"))
    ((description . "first Friday of November 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 11)
        (week . "first")
        (dayofweek . "Friday"))
      (expected . "2013-11-01"))
    ((description . "first Friday of December 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 12)
        (week . "first")
        (dayofweek . "Friday"))
      (expected . "2013-12-06"))
    ((description . "first Saturday of January 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 1)
        (week . "first")
        (dayofweek . "Saturday"))
      (expected . "2013-01-05"))
    ((description . "first Saturday of February 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 2)
        (week . "first")
        (dayofweek . "Saturday"))
      (expected . "2013-02-02"))
    ((description . "first Sunday of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "first")
        (dayofweek . "Sunday"))
      (expected . "2013-03-03"))
    ((description . "first Sunday of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "first")
        (dayofweek . "Sunday"))
      (expected . "2013-04-07"))
    ((description . "second Monday of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "second")
        (dayofweek . "Monday"))
      (expected . "2013-03-11"))
    ((description . "second Monday of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "second")
        (dayofweek . "Monday"))
      (expected . "2013-04-08"))
    ((description . "second Tuesday of May 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 5)
        (week . "second")
        (dayofweek . "Tuesday"))
      (expected . "2013-05-14"))
    ((description . "second Tuesday of June 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 6)
        (week . "second")
        (dayofweek . "Tuesday"))
      (expected . "2013-06-11"))
    ((description . "second Wednesday of July 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 7)
        (week . "second")
        (dayofweek . "Wednesday"))
      (expected . "2013-07-10"))
    ((description . "second Wednesday of August 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 8)
        (week . "second")
        (dayofweek . "Wednesday"))
      (expected . "2013-08-14"))
    ((description . "second Thursday of September 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 9)
        (week . "second")
        (dayofweek . "Thursday"))
      (expected . "2013-09-12"))
    ((description . "second Thursday of October 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 10)
        (week . "second")
        (dayofweek . "Thursday"))
      (expected . "2013-10-10"))
    ((description . "second Friday of November 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 11)
        (week . "second")
        (dayofweek . "Friday"))
      (expected . "2013-11-08"))
    ((description . "second Friday of December 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 12)
        (week . "second")
        (dayofweek . "Friday"))
      (expected . "2013-12-13"))
    ((description . "second Saturday of January 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 1)
        (week . "second")
        (dayofweek . "Saturday"))
      (expected . "2013-01-12"))
    ((description . "second Saturday of February 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 2)
        (week . "second")
        (dayofweek . "Saturday"))
      (expected . "2013-02-09"))
    ((description . "second Sunday of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "second")
        (dayofweek . "Sunday"))
      (expected . "2013-03-10"))
    ((description . "second Sunday of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "second")
        (dayofweek . "Sunday"))
      (expected . "2013-04-14"))
    ((description . "third Monday of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "third")
        (dayofweek . "Monday"))
      (expected . "2013-03-18"))
    ((description . "third Monday of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "third")
        (dayofweek . "Monday"))
      (expected . "2013-04-15"))
    ((description . "third Tuesday of May 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 5)
        (week . "third")
        (dayofweek . "Tuesday"))
      (expected . "2013-05-21"))
    ((description . "third Tuesday of June 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 6)
        (week . "third")
        (dayofweek . "Tuesday"))
      (expected . "2013-06-18"))
    ((description . "third Wednesday of July 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 7)
        (week . "third")
        (dayofweek . "Wednesday"))
      (expected . "2013-07-17"))
    ((description . "third Wednesday of August 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 8)
        (week . "third")
        (dayofweek . "Wednesday"))
      (expected . "2013-08-21"))
    ((description . "third Thursday of September 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 9)
        (week . "third")
        (dayofweek . "Thursday"))
      (expected . "2013-09-19"))
    ((description . "third Thursday of October 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 10)
        (week . "third")
        (dayofweek . "Thursday"))
      (expected . "2013-10-17"))
    ((description . "third Friday of November 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 11)
        (week . "third")
        (dayofweek . "Friday"))
      (expected . "2013-11-15"))
    ((description . "third Friday of December 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 12)
        (week . "third")
        (dayofweek . "Friday"))
      (expected . "2013-12-20"))
    ((description . "third Saturday of January 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 1)
        (week . "third")
        (dayofweek . "Saturday"))
      (expected . "2013-01-19"))
    ((description . "third Saturday of February 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 2)
        (week . "third")
        (dayofweek . "Saturday"))
      (expected . "2013-02-16"))
    ((description . "third Sunday of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "third")
        (dayofweek . "Sunday"))
      (expected . "2013-03-17"))
    ((description . "third Sunday of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "third")
        (dayofweek . "Sunday"))
      (expected . "2013-04-21"))
    ((description . "fourth Monday of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "fourth")
        (dayofweek . "Monday"))
      (expected . "2013-03-25"))
    ((description . "fourth Monday of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "fourth")
        (dayofweek . "Monday"))
      (expected . "2013-04-22"))
    ((description . "fourth Tuesday of May 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 5)
        (week . "fourth")
        (dayofweek . "Tuesday"))
      (expected . "2013-05-28"))
    ((description . "fourth Tuesday of June 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 6)
        (week . "fourth")
        (dayofweek . "Tuesday"))
      (expected . "2013-06-25"))
    ((description . "fourth Wednesday of July 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 7)
        (week . "fourth")
        (dayofweek . "Wednesday"))
      (expected . "2013-07-24"))
    ((description . "fourth Wednesday of August 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 8)
        (week . "fourth")
        (dayofweek . "Wednesday"))
      (expected . "2013-08-28"))
    ((description . "fourth Thursday of September 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 9)
        (week . "fourth")
        (dayofweek . "Thursday"))
      (expected . "2013-09-26"))
    ((description . "fourth Thursday of October 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 10)
        (week . "fourth")
        (dayofweek . "Thursday"))
      (expected . "2013-10-24"))
    ((description . "fourth Friday of November 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 11)
        (week . "fourth")
        (dayofweek . "Friday"))
      (expected . "2013-11-22"))
    ((description . "fourth Friday of December 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 12)
        (week . "fourth")
        (dayofweek . "Friday"))
      (expected . "2013-12-27"))
    ((description . "fourth Saturday of January 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 1)
        (week . "fourth")
        (dayofweek . "Saturday"))
      (expected . "2013-01-26"))
    ((description . "fourth Saturday of February 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 2)
        (week . "fourth")
        (dayofweek . "Saturday"))
      (expected . "2013-02-23"))
    ((description . "fourth Sunday of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "fourth")
        (dayofweek . "Sunday"))
      (expected . "2013-03-24"))
    ((description . "fourth Sunday of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "fourth")
        (dayofweek . "Sunday"))
      (expected . "2013-04-28"))
    ((description . "last Monday of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "last")
        (dayofweek . "Monday"))
      (expected . "2013-03-25"))
    ((description . "last Monday of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "last")
        (dayofweek . "Monday"))
      (expected . "2013-04-29"))
    ((description . "last Tuesday of May 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 5)
        (week . "last")
        (dayofweek . "Tuesday"))
      (expected . "2013-05-28"))
    ((description . "last Tuesday of June 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 6)
        (week . "last")
        (dayofweek . "Tuesday"))
      (expected . "2013-06-25"))
    ((description . "last Wednesday of July 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 7)
        (week . "last")
        (dayofweek . "Wednesday"))
      (expected . "2013-07-31"))
    ((description . "last Wednesday of August 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 8)
        (week . "last")
        (dayofweek . "Wednesday"))
      (expected . "2013-08-28"))
    ((description . "last Thursday of September 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 9)
        (week . "last")
        (dayofweek . "Thursday"))
      (expected . "2013-09-26"))
    ((description . "last Thursday of October 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 10)
        (week . "last")
        (dayofweek . "Thursday"))
      (expected . "2013-10-31"))
    ((description . "last Friday of November 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 11)
        (week . "last")
        (dayofweek . "Friday"))
      (expected . "2013-11-29"))
    ((description . "last Friday of December 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 12)
        (week . "last")
        (dayofweek . "Friday"))
      (expected . "2013-12-27"))
    ((description . "last Saturday of January 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 1)
        (week . "last")
        (dayofweek . "Saturday"))
      (expected . "2013-01-26"))
    ((description . "last Saturday of February 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 2)
        (week . "last")
        (dayofweek . "Saturday"))
      (expected . "2013-02-23"))
    ((description . "last Sunday of March 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 3)
        (week . "last")
        (dayofweek . "Sunday"))
      (expected . "2013-03-31"))
    ((description . "last Sunday of April 2013")
      (property . "meetup")
      (input
        (year . 2013)
        (month . 4)
        (week . "last")
        (dayofweek . "Sunday"))
      (expected . "2013-04-28"))
    ((description . "last Wednesday of February 2012")
      (property . "meetup")
      (input
        (year . 2012)
        (month . 2)
        (week . "last")
        (dayofweek . "Wednesday"))
      (expected . "2012-02-29"))
    ((description . "last Wednesday of December 2014")
      (property . "meetup")
      (input
        (year . 2014)
        (month . 12)
        (week . "last")
        (dayofweek . "Wednesday"))
      (expected . "2014-12-31"))
    ((description . "last Sunday of February 2015")
      (property . "meetup")
      (input
        (year . 2015)
        (month . 2)
        (week . "last")
        (dayofweek . "Sunday"))
      (expected . "2015-02-22"))
    ((description . "first Friday of December 2012")
      (property . "meetup")
      (input
        (year . 2012)
        (month . 12)
        (week . "first")
        (dayofweek . "Friday"))
      (expected . "2012-12-07"))))
 (kindergarten-garden
   (exercise . "kindergarten-garden")
   (version . "1.1.1")
   (cases
     ((description . "partial garden")
       (cases
         ((description . "garden with single student")
           (property . "plants")
           (input (diagram . "RC\nGG") (student . "Alice"))
           (expected "radishes" "clover" "grass" "grass"))
         ((description . "different garden with single student")
           (property . "plants")
           (input (diagram . "VC\nRC") (student . "Alice"))
           (expected "violets" "clover" "radishes" "clover"))
         ((description . "garden with two students")
           (property . "plants")
           (input (diagram . "VVCG\nVVRC") (student . "Bob"))
           (expected "clover" "grass" "radishes" "clover"))
         ((description
            .
            "multiple students for the same garden with three students")
           (cases
             ((description . "second student's garden")
               (property . "plants")
               (input (diagram . "VVCCGG\nVVCCGG") (student . "Bob"))
               (expected "clover" "clover" "clover" "clover"))
             ((description . "third student's garden")
               (property . "plants")
               (input (diagram . "VVCCGG\nVVCCGG") (student . "Charlie"))
               (expected "grass" "grass" "grass" "grass"))))))
     ((description . "full garden")
       (cases
         ((description . "first student's garden")
           (property . "plants")
           (input
             (diagram
               .
               "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV")
             (student . "Alice"))
           (expected "violets" "radishes" "violets" "radishes"))
         ((description . "second student's garden")
           (property . "plants")
           (input
             (diagram
               .
               "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV")
             (student . "Bob"))
           (expected "clover" "grass" "clover" "clover"))
         ((description . "second to last student's garden")
           (property . "plants")
           (input
             (diagram
               .
               "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV")
             (student . "Kincaid"))
           (expected "grass" "clover" "clover" "grass"))
         ((description . "last student's garden")
           (property . "plants")
           (input
             (diagram
               .
               "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV")
             (student . "Larry"))
           (expected "grass" "violets" "clover" "violets"))))))
 (circular-buffer
   (exercise . "circular-buffer")
   (version . "1.2.0")
   (comments
    "In general, these circular buffers are expected to be stateful,"
    "and each language will operate on them differently."
    "Tests tend to perform a series of operations, some of which expect a certain result."
    "As such, this common test suite can only say in abstract terms what should be done."
    ""
    "Tests will contain a number of operations. The operation will be specified in the `operation` key."
    "Based on the operation, other keys may be present."
    "read: Reading from the buffer should succeed if and only if `should_succeed` is true."
    "  If it should succeed, it should produce the item at `expected`. "
    "  If it should fail, `expected` will not be present. "
    "write: Writing the item located at `item` should succeed if and only if `should_succeed` is true."
    "overwrite: Write the item located at `item` into the buffer, replacing the oldest item if necessary."
    "clear: Clear the buffer." ""
    "Failure of either `read` or `write` may be indicated in a manner appropriate for your language:"
    "Raising an exception, returning (int, error), returning Option<int>, etc."
    "" "Finally, note that all values are integers."
    "If your language contains generics, you may consider allowing buffers to contain other types."
    "Tests for that are not included here." "")
   (cases
     ((description . "reading empty buffer should fail")
       (property . "run")
       (input
         (capacity . 1)
         (operations ((operation . "read") (should_succeed . #f))))
       (expected))
     ((description . "can read an item just written")
       (property . "run")
       (input
         (capacity . 1)
         (operations
           ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "read")
             (should_succeed . #t)
             (expected . 1))))
       (expected))
     ((description . "each item may only be read once")
       (property . "run")
       (input
         (capacity . 1)
         (operations
           ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "read") (should_succeed . #t) (expected . 1))
           ((operation . "read") (should_succeed . #f))))
       (expected))
     ((description
        .
        "items are read in the order they are written")
       (property . "run")
       (input
         (capacity . 2)
         (operations
           ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "write") (item . 2) (should_succeed . #t))
           ((operation . "read") (should_succeed . #t) (expected . 1))
           ((operation . "read")
             (should_succeed . #t)
             (expected . 2))))
       (expected))
     ((description . "full buffer can't be written to")
       (property . "run")
       (input
         (capacity . 1)
         (operations
           ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "write") (item . 2) (should_succeed . #f))))
       (expected))
     ((description
        .
        "a read frees up capacity for another write")
       (property . "run")
       (input
         (capacity . 1)
         (operations
           ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "read") (should_succeed . #t) (expected . 1))
           ((operation . "write") (item . 2) (should_succeed . #t))
           ((operation . "read")
             (should_succeed . #t)
             (expected . 2))))
       (expected))
     ((description
        .
        "read position is maintained even across multiple writes")
       (property . "run")
       (input
         (capacity . 3)
         (operations ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "write") (item . 2) (should_succeed . #t))
           ((operation . "read") (should_succeed . #t) (expected . 1))
           ((operation . "write") (item . 3) (should_succeed . #t))
           ((operation . "read") (should_succeed . #t) (expected . 2))
           ((operation . "read")
             (should_succeed . #t)
             (expected . 3))))
       (expected))
     ((description . "items cleared out of buffer can't be read")
       (property . "run")
       (input
         (capacity . 1)
         (operations
           ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "clear"))
           ((operation . "read") (should_succeed . #f))))
       (expected))
     ((description . "clear frees up capacity for another write")
       (property . "run")
       (input
         (capacity . 1)
         (operations
           ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "clear"))
           ((operation . "write") (item . 2) (should_succeed . #t))
           ((operation . "read")
             (should_succeed . #t)
             (expected . 2))))
       (expected))
     ((description . "clear does nothing on empty buffer")
       (property . "run")
       (input
         (capacity . 1)
         (operations
           ((operation . "clear"))
           ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "read")
             (should_succeed . #t)
             (expected . 1))))
       (expected))
     ((description
        .
        "overwrite acts like write on non-full buffer")
       (property . "run")
       (input
         (capacity . 2)
         (operations
           ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "overwrite") (item . 2))
           ((operation . "read") (should_succeed . #t) (expected . 1))
           ((operation . "read")
             (should_succeed . #t)
             (expected . 2))))
       (expected))
     ((description
        .
        "overwrite replaces the oldest item on full buffer")
       (property . "run")
       (input
         (capacity . 2)
         (operations ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "write") (item . 2) (should_succeed . #t))
           ((operation . "overwrite") (item . 3))
           ((operation . "read") (should_succeed . #t) (expected . 2))
           ((operation . "read")
             (should_succeed . #t)
             (expected . 3))))
       (expected))
     ((description
        .
        "overwrite replaces the oldest item remaining in buffer following a read")
       (property . "run")
       (input
         (capacity . 3)
         (operations ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "write") (item . 2) (should_succeed . #t))
           ((operation . "write") (item . 3) (should_succeed . #t))
           ((operation . "read") (should_succeed . #t) (expected . 1))
           ((operation . "write") (item . 4) (should_succeed . #t))
           ((operation . "overwrite") (item . 5))
           ((operation . "read") (should_succeed . #t) (expected . 3))
           ((operation . "read") (should_succeed . #t) (expected . 4))
           ((operation . "read")
             (should_succeed . #t)
             (expected . 5))))
       (expected))
     ((description
        .
        "initial clear does not affect wrapping around")
       (property . "run")
       (input
         (capacity . 2)
         (operations ((operation . "clear"))
           ((operation . "write") (item . 1) (should_succeed . #t))
           ((operation . "write") (item . 2) (should_succeed . #t))
           ((operation . "overwrite") (item . 3))
           ((operation . "overwrite") (item . 4))
           ((operation . "read") (should_succeed . #t) (expected . 3))
           ((operation . "read") (should_succeed . #t) (expected . 4))
           ((operation . "read") (should_succeed . #f))))
       (expected))))
 (raindrops
   (exercise . "raindrops")
   (version . "1.1.0")
   (cases
     ((description . "the sound for 1 is 1")
       (property . "convert")
       (input (number . 1))
       (expected . "1"))
     ((description . "the sound for 3 is Pling")
       (property . "convert")
       (input (number . 3))
       (expected . "Pling"))
     ((description . "the sound for 5 is Plang")
       (property . "convert")
       (input (number . 5))
       (expected . "Plang"))
     ((description . "the sound for 7 is Plong")
       (property . "convert")
       (input (number . 7))
       (expected . "Plong"))
     ((description
        .
        "the sound for 6 is Pling as it has a factor 3")
       (property . "convert")
       (input (number . 6))
       (expected . "Pling"))
     ((description
        .
        "2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base")
       (property . "convert")
       (input (number . 8))
       (expected . "8"))
     ((description
        .
        "the sound for 9 is Pling as it has a factor 3")
       (property . "convert")
       (input (number . 9))
       (expected . "Pling"))
     ((description
        .
        "the sound for 10 is Plang as it has a factor 5")
       (property . "convert")
       (input (number . 10))
       (expected . "Plang"))
     ((description
        .
        "the sound for 14 is Plong as it has a factor of 7")
       (property . "convert")
       (input (number . 14))
       (expected . "Plong"))
     ((description
        .
        "the sound for 15 is PlingPlang as it has factors 3 and 5")
       (property . "convert")
       (input (number . 15))
       (expected . "PlingPlang"))
     ((description
        .
        "the sound for 21 is PlingPlong as it has factors 3 and 7")
       (property . "convert")
       (input (number . 21))
       (expected . "PlingPlong"))
     ((description
        .
        "the sound for 25 is Plang as it has a factor 5")
       (property . "convert")
       (input (number . 25))
       (expected . "Plang"))
     ((description
        .
        "the sound for 27 is Pling as it has a factor 3")
       (property . "convert")
       (input (number . 27))
       (expected . "Pling"))
     ((description
        .
        "the sound for 35 is PlangPlong as it has factors 5 and 7")
       (property . "convert")
       (input (number . 35))
       (expected . "PlangPlong"))
     ((description
        .
        "the sound for 49 is Plong as it has a factor 7")
       (property . "convert")
       (input (number . 49))
       (expected . "Plong"))
     ((description . "the sound for 52 is 52")
       (property . "convert")
       (input (number . 52))
       (expected . "52"))
     ((description
        .
        "the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7")
       (property . "convert")
       (input (number . 105))
       (expected . "PlingPlangPlong"))
     ((description
        .
        "the sound for 3125 is Plang as it has a factor 5")
       (property . "convert")
       (input (number . 3125))
       (expected . "Plang"))))
 (grains
   (exercise . "grains")
   (version . "1.2.0")
   (comments
     "The final tests of square test error conditions"
     "In these cases you should expect an error as is idiomatic for your language")
   (cases
     ((description
        .
        "returns the number of grains on the square")
       (cases
         ((description . "1")
           (property . "square")
           (input (square . 1))
           (expected . 1))
         ((description . "2")
           (property . "square")
           (input (square . 2))
           (expected . 2))
         ((description . "3")
           (property . "square")
           (input (square . 3))
           (expected . 4))
         ((description . "4")
           (property . "square")
           (input (square . 4))
           (expected . 8))
         ((description . "16")
           (property . "square")
           (input (square . 16))
           (expected . 32768))
         ((description . "32")
           (property . "square")
           (input (square . 32))
           (expected . 2147483648))
         ((description . "64")
           (property . "square")
           (input (square . 64))
           (expected . 9223372036854775808))
         ((description . "square 0 raises an exception")
           (property . "square")
           (input (square . 0))
           (expected (error . "square must be between 1 and 64")))
         ((description . "negative square raises an exception")
           (property . "square")
           (input (square . -1))
           (expected (error . "square must be between 1 and 64")))
         ((description
            .
            "square greater than 64 raises an exception")
           (property . "square")
           (input (square . 65))
           (expected (error . "square must be between 1 and 64")))))
     ((description
        .
        "returns the total number of grains on the board")
       (property . "total")
       (input)
       (expected . 18446744073709551615))))
 (house
   (exercise . "house")
   (version . "2.2.0")
   (comments
     "JSON doesn't allow for multi-line strings, so all verses are presented "
     "here as arrays of strings. It's up to the test generator to join the "
     "lines together with line breaks."
     "Some languages test for the verse() method, which takes a start verse "
     "and optional end verse, but other languages have only tested for the full poem."
     "For those languages in the latter category, you may wish to only "
     "implement the full song test and leave the rest alone, ignoring the startVerse "
     "and endVerse fields.")
   (cases
     ((description
        .
        "Return specified verse or series of verses")
       (cases
         ((description . "verse one - the house that jack built")
           (property . "recite")
           (input (startVerse . 1) (endVerse . 1))
           (expected "This is the house that Jack built."))
         ((description . "verse two - the malt that lay")
           (property . "recite")
           (input (startVerse . 2) (endVerse . 2))
           (expected
             "This is the malt that lay in the house that Jack built."))
         ((description . "verse three - the rat that ate")
           (property . "recite")
           (input (startVerse . 3) (endVerse . 3))
           (expected
             "This is the rat that ate the malt that lay in the house that Jack built."))
         ((description . "verse four - the cat that killed")
           (property . "recite")
           (input (startVerse . 4) (endVerse . 4))
           (expected
             "This is the cat that killed the rat that ate the malt that lay in the house that Jack built."))
         ((description . "verse five - the dog that worried")
           (property . "recite")
           (input (startVerse . 5) (endVerse . 5))
           (expected
             "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."))
         ((description
            .
            "verse six - the cow with the crumpled horn")
           (property . "recite")
           (input (startVerse . 6) (endVerse . 6))
           (expected
             "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."))
         ((description . "verse seven - the maiden all forlorn")
           (property . "recite")
           (input (startVerse . 7) (endVerse . 7))
           (expected
             "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."))
         ((description
            .
            "verse eight - the man all tattered and torn")
           (property . "recite")
           (input (startVerse . 8) (endVerse . 8))
           (expected
             "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."))
         ((description
            .
            "verse nine - the priest all shaven and shorn")
           (property . "recite")
           (input (startVerse . 9) (endVerse . 9))
           (expected
             "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."))
         ((description
            .
            "verse 10 - the rooster that crowed in the morn")
           (property . "recite")
           (input (startVerse . 10) (endVerse . 10))
           (expected
             "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."))
         ((description . "verse 11 - the farmer sowing his corn")
           (property . "recite")
           (input (startVerse . 11) (endVerse . 11))
           (expected
             "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."))
         ((description
            .
            "verse 12 - the horse and the hound and the horn")
           (property . "recite")
           (input (startVerse . 12) (endVerse . 12))
           (expected
             "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."))
         ((description . "multiple verses")
           (property . "recite")
           (input (startVerse . 4) (endVerse . 8))
           (expected
             "This is the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."))
         ((description . "full rhyme")
           (property . "recite")
           (input (startVerse . 1) (endVerse . 12))
           (expected "This is the house that Jack built."
             "This is the malt that lay in the house that Jack built."
             "This is the rat that ate the malt that lay in the house that Jack built."
             "This is the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
             "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."))))))
 (satellite
   (exercise . "satellite")
   (version . "2.0.0")
   (cases
     ((description . "Empty tree")
       (property . "treeFromTraversals")
       (input (preorder) (inorder))
       (expected))
     ((description . "Tree with one item")
       (property . "treeFromTraversals")
       (input (preorder "a") (inorder "a"))
       (expected (v . "a") (l) (r)))
     ((description . "Tree with many items")
       (property . "treeFromTraversals")
       (input
         (preorder "a" "i" "x" "f" "r")
         (inorder "i" "a" "f" "x" "r"))
       (expected
         (v . "a")
         (l (v . "i") (l) (r))
         (r (v . "x") (l (v . "f") (l) (r)) (r (v . "r") (l) (r)))))
     ((description . "Reject traversals of different length")
       (property . "treeFromTraversals")
       (input (preorder "a" "b") (inorder "b" "a" "r"))
       (expected (error . "traversals must have the same length")))
     ((description
        .
        "Reject inconsistent traversals of same length")
       (property . "treeFromTraversals")
       (input (preorder "x" "y" "z") (inorder "a" "b" "c"))
       (expected
         (error . "traversals must have the same elements")))
     ((description . "Reject traversals with repeated items")
       (property . "treeFromTraversals")
       (input (preorder "a" "b" "a") (inorder "b" "a" "a"))
       (expected
         (error . "traversals must contain unique items")))))
 (complex-numbers
   (exercise . "complex-numbers")
   (version . "1.3.0")
   (comments
     " The canonical data assumes mathematically correct real   "
     " numbers. The testsuites should consider rounding errors  "
     " instead of testing for exact values for any non-integer  "
     " tests.                                                   "
     " Complex numbers z are represented as arrays [x, y] so    "
     " that z = x + i * y.                                      "
     " Pi is represented as a string \"pi\", euler's number is  "
     " represented as \"e\".                                    ")
   (cases
     ((description . "Real part")
       (cases
         ((description . "Real part of a purely real number")
           (property . "real")
           (input (z 1 0))
           (expected . 1))
         ((description . "Real part of a purely imaginary number")
           (property . "real")
           (input (z 0 1))
           (expected . 0))
         ((description
            .
            "Real part of a number with real and imaginary part")
           (property . "real")
           (input (z 1 2))
           (expected . 1))))
     ((description . "Imaginary part")
       (cases
         ((description . "Imaginary part of a purely real number")
           (property . "imaginary")
           (input (z 1 0))
           (expected . 0))
         ((description
            .
            "Imaginary part of a purely imaginary number")
           (property . "imaginary")
           (input (z 0 1))
           (expected . 1))
         ((description
            .
            "Imaginary part of a number with real and imaginary part")
           (property . "imaginary")
           (input (z 1 2))
           (expected . 2))))
     ((description . "Imaginary unit")
       (property . "mul")
       (input (z1 0 1) (z2 0 1))
       (expected -1 0))
     ((description . "Arithmetic")
       (cases
         ((description . "Addition")
           (cases
             ((description . "Add purely real numbers")
               (property . "add")
               (input (z1 1 0) (z2 2 0))
               (expected 3 0))
             ((description . "Add purely imaginary numbers")
               (property . "add")
               (input (z1 0 1) (z2 0 2))
               (expected 0 3))
             ((description . "Add numbers with real and imaginary part")
               (property . "add")
               (input (z1 1 2) (z2 3 4))
               (expected 4 6))))
         ((description . "Subtraction")
           (cases
             ((description . "Subtract purely real numbers")
               (property . "sub")
               (input (z1 1 0) (z2 2 0))
               (expected -1 0))
             ((description . "Subtract purely imaginary numbers")
               (property . "sub")
               (input (z1 0 1) (z2 0 2))
               (expected 0 -1))
             ((description
                .
                "Subtract numbers with real and imaginary part")
               (property . "sub")
               (input (z1 1 2) (z2 3 4))
               (expected -2 -2))))
         ((description . "Multiplication")
           (cases
             ((description . "Multiply purely real numbers")
               (property . "mul")
               (input (z1 1 0) (z2 2 0))
               (expected 2 0))
             ((description . "Multiply purely imaginary numbers")
               (property . "mul")
               (input (z1 0 1) (z2 0 2))
               (expected -2 0))
             ((description
                .
                "Multiply numbers with real and imaginary part")
               (property . "mul")
               (input (z1 1 2) (z2 3 4))
               (expected -5 10))))
         ((description . "Division")
           (cases
             ((description . "Divide purely real numbers")
               (property . "div")
               (input (z1 1 0) (z2 2 0))
               (expected 0.5 0))
             ((description . "Divide purely imaginary numbers")
               (property . "div")
               (input (z1 0 1) (z2 0 2))
               (expected 0.5 0))
             ((description
                .
                "Divide numbers with real and imaginary part")
               (property . "div")
               (input (z1 1 2) (z2 3 4))
               (expected 0.44 0.08))))))
     ((description . "Absolute value")
       (cases
         ((description
            .
            "Absolute value of a positive purely real number")
           (property . "abs")
           (input (z 5 0))
           (expected . 5))
         ((description
            .
            "Absolute value of a negative purely real number")
           (property . "abs")
           (input (z -5 0))
           (expected . 5))
         ((description
            .
            "Absolute value of a purely imaginary number with positive imaginary part")
           (property . "abs")
           (input (z 0 5))
           (expected . 5))
         ((description
            .
            "Absolute value of a purely imaginary number with negative imaginary part")
           (property . "abs")
           (input (z 0 -5))
           (expected . 5))
         ((description
            .
            "Absolute value of a number with real and imaginary part")
           (property . "abs")
           (input (z 3 4))
           (expected . 5))))
     ((description . "Complex conjugate")
       (cases
         ((description . "Conjugate a purely real number")
           (property . "conjugate")
           (input (z 5 0))
           (expected 5 0))
         ((description . "Conjugate a purely imaginary number")
           (property . "conjugate")
           (input (z 0 5))
           (expected 0 -5))
         ((description
            .
            "Conjugate a number with real and imaginary part")
           (property . "conjugate")
           (input (z 1 1))
           (expected 1 -1))))
     ((description . "Complex exponential function")
       (comments
         " Defining the exponential function can be optional.       "
         " If the language used does not have sine and cosine       "
         " functions in the standard library, this will be          "
         " significantly more difficult than the rest of the exer-  "
         " cise and should probably not be part of the problem.     "
         " The recommended implementation uses Euler's formula      "
         " exp(ix) = cos(x) + i * sin(x). This is not an ideal sol- "
         " ution but works for the purpose of teaching complex      "
         " numbers.                                                 ")
       (cases
         ((description . "Euler's identity/formula")
           (property . "exp")
           (input (z 0 "pi"))
           (expected -1 0))
         ((description . "Exponential of 0")
           (property . "exp")
           (input (z 0 0))
           (expected 1 0))
         ((description . "Exponential of a purely real number")
           (property . "exp")
           (input (z 1 0))
           (expected "e" 0))
         ((description
            .
            "Exponential of a number with real and imaginary part")
           (property . "exp")
           (input (z "ln(2)" "pi"))
           (expected -2 0))))))
 (saddle-points
   (exercise . "saddle-points")
   (version . "1.5.0")
   (comments "Matrix rows and columns are 1-indexed.")
   (cases
     ((description . "Can identify single saddle point")
       (comments "This is the README example.")
       (property . "saddlePoints")
       (input (matrix (9 8 7) (5 3 2) (6 6 7)))
       (expected ((row . 2) (column . 1))))
     ((description
        .
        "Can identify that empty matrix has no saddle points")
       (property . "saddlePoints")
       (input (matrix ()))
       (expected))
     ((description
        .
        "Can identify lack of saddle points when there are none")
       (property . "saddlePoints")
       (input (matrix (1 2 3) (3 1 2) (2 3 1)))
       (expected))
     ((description
        .
        "Can identify multiple saddle points in a column")
       (property . "saddlePoints")
       (input (matrix (4 5 4) (3 5 5) (1 5 4)))
       (expected
         ((row . 1) (column . 2))
         ((row . 2) (column . 2))
         ((row . 3) (column . 2))))
     ((description
        .
        "Can identify multiple saddle points in a row")
       (property . "saddlePoints")
       (input (matrix (6 7 8) (5 5 5) (7 5 6)))
       (expected
         ((row . 2) (column . 1))
         ((row . 2) (column . 2))
         ((row . 2) (column . 3))))
     ((description
        .
        "Can identify saddle point in bottom right corner")
       (comments
         "This is a permutation of the README matrix designed to test"
         "off-by-one errors.")
       (property . "saddlePoints")
       (input (matrix (8 7 9) (6 7 6) (3 2 5)))
       (expected ((row . 3) (column . 3))))
     ((description
        .
        "Can identify saddle points in a non square matrix")
       (property . "saddlePoints")
       (input (matrix (3 1 3) (3 2 4)))
       (expected
         ((row . 1) (column . 3))
         ((row . 1) (column . 1))))
     ((description
        .
        "Can identify that saddle points in a single column matrix are those with the minimum value")
       (property . "saddlePoints")
       (input (matrix (2) (1) (4) (1)))
       (expected
         ((row . 2) (column . 1))
         ((row . 4) (column . 1))))
     ((description
        .
        "Can identify that saddle points in a single row matrix are those with the maximum value")
       (property . "saddlePoints")
       (input (matrix (2 5 3 5)))
       (expected
         ((row . 1) (column . 2))
         ((row . 1) (column . 4))))))
 (sieve
   (exercise . "sieve")
   (version . "1.1.0")
   (cases
     ((description . "no primes under two")
       (property . "primes")
       (input (limit . 1))
       (expected))
     ((description . "find first prime")
       (property . "primes")
       (input (limit . 2))
       (expected 2))
     ((description . "find primes up to 10")
       (property . "primes")
       (input (limit . 10))
       (expected 2 3 5 7))
     ((description . "limit is prime")
       (property . "primes")
       (input (limit . 13))
       (expected 2 3 5 7 11 13))
     ((description . "find primes up to 1000")
       (property . "primes")
       (input (limit . 1000))
       (expected 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61
        67 71 73 79 83 89 97 101 103 107 109 113 127 131 137 139 149
        151 157 163 167 173 179 181 191 193 197 199 211 223 227 229
        233 239 241 251 257 263 269 271 277 281 283 293 307 311 313
        317 331 337 347 349 353 359 367 373 379 383 389 397 401 409
        419 421 431 433 439 443 449 457 461 463 467 479 487 491 499
        503 509 521 523 541 547 557 563 569 571 577 587 593 599 601
        607 613 617 619 631 641 643 647 653 659 661 673 677 683 691
        701 709 719 727 733 739 743 751 757 761 769 773 787 797 809
        811 821 823 827 829 839 853 857 859 863 877 881 883 887 907
        911 919 929 937 941 947 953 967 971 977 983 991 997))))
 (darts
   (exercise . "darts")
   (version . "2.2.0")
   (comments
     "Return the correct amount earned by a dart's landing position.")
   (cases
     ((property . "score")
       (description . "Missed target")
       (input (x . -9) (y . 9))
       (expected . 0))
     ((property . "score")
       (description . "On the outer circle")
       (input (x . 0) (y . 10))
       (expected . 1))
     ((property . "score")
       (description . "On the middle circle")
       (input (x . -5) (y . 0))
       (expected . 5))
     ((property . "score")
       (description . "On the inner circle")
       (input (x . 0) (y . -1))
       (expected . 10))
     ((property . "score")
       (description . "Exactly on centre")
       (input (x . 0) (y . 0))
       (expected . 10))
     ((property . "score")
       (description . "Near the centre")
       (input (x . -0.1) (y . -0.1))
       (expected . 10))
     ((property . "score")
       (description . "Just within the inner circle")
       (input (x . 0.7) (y . 0.7))
       (expected . 10))
     ((property . "score")
       (description . "Just outside the inner circle")
       (input (x . 0.8) (y . -0.8))
       (expected . 5))
     ((property . "score")
       (description . "Just within the middle circle")
       (input (x . -3.5) (y . 3.5))
       (expected . 5))
     ((property . "score")
       (description . "Just outside the middle circle")
       (input (x . -3.6) (y . -3.6))
       (expected . 1))
     ((property . "score")
       (description . "Just within the outer circle")
       (input (x . -7.0) (y . 7.0))
       (expected . 1))
     ((property . "score")
       (description . "Just outside the outer circle")
       (input (x . 7.1) (y . -7.1))
       (expected . 0))
     ((property . "score")
       (description
         .
         "Asymmetric position between the inner and middle circles")
       (input (x . 0.5) (y . -4))
       (expected . 5))))
 (luhn
   (exercise . "luhn")
   (version . "1.6.1")
   (cases
     ((description . "single digit strings can not be valid")
       (property . "valid")
       (input (value . "1"))
       (expected . #f))
     ((description . "a single zero is invalid")
       (property . "valid")
       (input (value . "0"))
       (expected . #f))
     ((description
        .
        "a simple valid SIN that remains valid if reversed")
       (property . "valid")
       (input (value . "059"))
       (expected . #t))
     ((description
        .
        "a simple valid SIN that becomes invalid if reversed")
       (property . "valid")
       (input (value . "59"))
       (expected . #t))
     ((description . "a valid Canadian SIN")
       (property . "valid")
       (input (value . "055 444 285"))
       (expected . #t))
     ((description . "invalid Canadian SIN")
       (property . "valid")
       (input (value . "055 444 286"))
       (expected . #f))
     ((description . "invalid credit card")
       (property . "valid")
       (input (value . "8273 1232 7352 0569"))
       (expected . #f))
     ((description
        .
        "valid number with an even number of digits")
       (property . "valid")
       (input (value . "095 245 88"))
       (expected . #t))
     ((description . "valid number with an odd number of spaces")
       (property . "valid")
       (input (value . "234 567 891 234"))
       (expected . #t))
     ((description
        .
        "valid strings with a non-digit added at the end become invalid")
       (property . "valid")
       (input (value . "059a"))
       (expected . #f))
     ((description
        .
        "valid strings with punctuation included become invalid")
       (property . "valid")
       (input (value . "055-444-285"))
       (expected . #f))
     ((description
        .
        "valid strings with symbols included become invalid")
       (property . "valid")
       (input (value . "055# 444$ 285"))
       (expected . #f))
     ((description . "single zero with space is invalid")
       (property . "valid")
       (input (value . " 0"))
       (expected . #f))
     ((description . "more than a single zero is valid")
       (property . "valid")
       (input (value . "0000 0"))
       (expected . #t))
     ((description
        .
        "input digit 9 is correctly converted to output digit 9")
       (property . "valid")
       (input (value . "091"))
       (expected . #t))
     ((comments
        "Convert non-digits to their ascii values and then offset them by 48 sometimes accidentally declare an invalid string to be valid."
        "This test is designed to avoid that solution.")
       (description
         .
         "using ascii value for non-doubled non-digit isn't allowed")
       (property . "valid")
       (input (value . "055b 444 285"))
       (expected . #f))
     ((comments
        "Convert non-digits to their ascii values and then offset them by 48 sometimes accidentally declare an invalid string to be valid."
        "This test is designed to avoid that solution.")
       (description
         .
         "using ascii value for doubled non-digit isn't allowed")
       (property . "valid")
       (input (value . ":9"))
       (expected . #f))))
 (hamming
   (exercise . "hamming")
   (version . "2.3.0")
   (comments
     "Language implementations vary on the issue of unequal length strands."
     "A language may elect to simplify this task by only presenting equal"
     "length test cases.  For languages handling unequal length strands as"
     "error condition, unequal length test cases are included here and are"
     "indicated with an error object.  Language idioms of errors or exceptions"
     "should be followed.  Alternative interpretations such as ignoring excess"
     "length at the end are not represented here.")
   (cases
     ((description . "empty strands")
       (property . "distance")
       (input (strand1 . "") (strand2 . ""))
       (expected . 0))
     ((description . "single letter identical strands")
       (property . "distance")
       (input (strand1 . "A") (strand2 . "A"))
       (expected . 0))
     ((description . "single letter different strands")
       (property . "distance")
       (input (strand1 . "G") (strand2 . "T"))
       (expected . 1))
     ((description . "long identical strands")
       (property . "distance")
       (input
         (strand1 . "GGACTGAAATCTG")
         (strand2 . "GGACTGAAATCTG"))
       (expected . 0))
     ((description . "long different strands")
       (property . "distance")
       (input
         (strand1 . "GGACGGATTCTG")
         (strand2 . "AGGACGGATTCT"))
       (expected . 9))
     ((description . "disallow first strand longer")
       (property . "distance")
       (input (strand1 . "AATG") (strand2 . "AAA"))
       (expected
         (error . "left and right strands must be of equal length")))
     ((description . "disallow second strand longer")
       (property . "distance")
       (input (strand1 . "ATA") (strand2 . "AGTG"))
       (expected
         (error . "left and right strands must be of equal length")))
     ((description . "disallow left empty strand")
       (property . "distance")
       (input (strand1 . "") (strand2 . "G"))
       (expected (error . "left strand must not be empty")))
     ((description . "disallow right empty strand")
       (property . "distance")
       (input (strand1 . "G") (strand2 . ""))
       (expected (error . "right strand must not be empty")))))
 (wordy
   (exercise . "wordy")
   (version . "1.5.0")
   (comments
     "The tests that expect an 'error' should be implemented to raise"
     "an error, or indicate a failure. Implement this in a way that"
     "makes sense for your language.")
   (cases
    ((description . "just a number")
      (property . "answer")
      (input (question . "What is 5?"))
      (expected . 5))
    ((description . "addition")
      (property . "answer")
      (input (question . "What is 1 plus 1?"))
      (expected . 2))
    ((description . "more addition")
      (property . "answer")
      (input (question . "What is 53 plus 2?"))
      (expected . 55))
    ((description . "addition with negative numbers")
      (property . "answer")
      (input (question . "What is -1 plus -10?"))
      (expected . -11))
    ((description . "large addition")
      (property . "answer")
      (input (question . "What is 123 plus 45678?"))
      (expected . 45801))
    ((description . "subtraction")
      (property . "answer")
      (input (question . "What is 4 minus -12?"))
      (expected . 16))
    ((description . "multiplication")
      (property . "answer")
      (input (question . "What is -3 multiplied by 25?"))
      (expected . -75))
    ((description . "division")
      (property . "answer")
      (input (question . "What is 33 divided by -3?"))
      (expected . -11))
    ((description . "multiple additions")
      (property . "answer")
      (input (question . "What is 1 plus 1 plus 1?"))
      (expected . 3))
    ((description . "addition and subtraction")
      (property . "answer")
      (input (question . "What is 1 plus 5 minus -2?"))
      (expected . 8))
    ((description . "multiple subtraction")
      (property . "answer")
      (input (question . "What is 20 minus 4 minus 13?"))
      (expected . 3))
    ((description . "subtraction then addition")
      (property . "answer")
      (input (question . "What is 17 minus 6 plus 3?"))
      (expected . 14))
    ((description . "multiple multiplication")
      (property . "answer")
      (input
        (question . "What is 2 multiplied by -2 multiplied by 3?"))
      (expected . -12))
    ((description . "addition and multiplication")
      (property . "answer")
      (input (question . "What is -3 plus 7 multiplied by -2?"))
      (expected . -8))
    ((description . "multiple division")
      (property . "answer")
      (input
        (question . "What is -12 divided by 2 divided by -3?"))
      (expected . 2))
    ((description . "unknown operation")
      (property . "answer")
      (input (question . "What is 52 cubed?"))
      (expected (error . "unknown operation")))
    ((description . "Non math question")
      (property . "answer")
      (input
        (question . "Who is the President of the United States?"))
      (expected (error . "unknown operation")))
    ((description . "reject problem missing an operand")
      (property . "answer")
      (input (question . "What is 1 plus?"))
      (expected (error . "syntax error")))
    ((description
       .
       "reject problem with no operands or operators")
      (property . "answer")
      (input (question . "What is?"))
      (expected (error . "syntax error")))
    ((description . "reject two operations in a row")
      (property . "answer")
      (input (question . "What is 1 plus plus 2?"))
      (expected (error . "syntax error")))
    ((description . "reject two numbers in a row")
      (property . "answer")
      (input (question . "What is 1 plus 2 1?"))
      (expected (error . "syntax error")))
    ((description . "reject postfix notation")
      (property . "answer")
      (input (question . "What is 1 2 plus?"))
      (expected (error . "syntax error")))
    ((description . "reject prefix notation")
      (property . "answer")
      (input (question . "What is plus 1 2?"))
      (expected (error . "syntax error")))))
 (pythagorean-triplet
   (exercise . "pythagorean-triplet")
   (version . "1.0.0")
   (cases
     ((description . "triplets whose sum is 12")
       (property . "tripletsWithSum")
       (input (n . 12))
       (expected (3 4 5)))
     ((description . "triplets whose sum is 108")
       (property . "tripletsWithSum")
       (input (n . 108))
       (expected (27 36 45)))
     ((description . "triplets whose sum is 1000")
       (property . "tripletsWithSum")
       (input (n . 1000))
       (expected (200 375 425)))
     ((description . "no matching triplets for 1001")
       (property . "tripletsWithSum")
       (input (n . 1001))
       (expected))
     ((description . "returns all matching triplets")
       (property . "tripletsWithSum")
       (input (n . 90))
       (expected (9 40 41) (15 36 39)))
     ((description . "several matching triplets")
       (property . "tripletsWithSum")
       (input (n . 840))
       (expected (40 399 401) (56 390 394) (105 360 375)
         (120 350 370) (140 336 364) (168 315 357) (210 280 350)
         (240 252 348)))
     ((description . "triplets for large number")
       (property . "tripletsWithSum")
       (input (n . 30000))
       (expected (1200 14375 14425) (1875 14000 14125)
         (5000 12000 13000) (6000 11250 12750) (7500 10000 12500)))))
 (micro-blog
   (exercise . "micro-blog")
   (version . "1.0.0")
   (comments
     "This exercise is only applicable to languages that use UTF-8, UTF-16"
     "or other variable width Unicode compatible encoding as their internal"
     "string representation." ""
     "This exercise is probably too easy in languages that use Unicode aware"
     "string slicing." ""
     "When adding additional tests to the problem specification, consider that"
     "in progress solutions might not fail due to UTF-8 and UTF-16"
     "differences." ""
     "Avoid adding tests that involve characters (graphemes) that are made up"
     "of multiple characters, or introduce them as a more advanced step."
     ""
     "Consider adding a track specific hint.md about if your language uses"
     "UTF-8, UTF-16 or other for its internal string representation.")
   (cases
     ((description . "Truncate a micro blog post")
       (cases
         ((description . "English language short")
           (property . "truncate")
           (input (phrase . "Hi"))
           (expected . "Hi"))
         ((description . "English language long")
           (property . "truncate")
           (input (phrase . "Hello there"))
           (expected . "Hello"))
         ((description . "German language short (broth)")
           (property . "truncate")
           (input (phrase . "brühe"))
           (expected . "brühe"))
         ((description
            .
            "German language long (bear carpet → beards)")
           (property . "truncate")
           (input (phrase . "Bärteppich"))
           (expected . "Bärte"))
         ((description . "Bulgarian language short (good)")
           (property . "truncate")
           (input (phrase . "Добър"))
           (expected . "Добър"))
         ((description . "Greek language short (health)")
           (property . "truncate")
           (input (phrase . "υγειά"))
           (expected . "υγειά"))
         ((description . "Maths short")
           (property . "truncate")
           (input (phrase . "a=πr²"))
           (expected . "a=πr²"))
         ((description . "Maths long")
           (property . "truncate")
           (input (phrase . "∅⊊ℕ⊊ℤ⊊ℚ⊊ℝ⊊ℂ"))
           (expected . "∅⊊ℕ⊊ℤ"))
         ((description . "English and emoji short")
           (property . "truncate")
           (input (phrase . "Fly 🛫"))
           (expected . "Fly 🛫"))
         ((description . "Emoji short")
           (property . "truncate")
           (input (phrase . "💇"))
           (expected . "💇"))
         ((description . "Emoji long")
           (property . "truncate")
           (input (phrase . "❄🌡🤧🤒🏥🕰😀"))
           (expected . "❄🌡🤧🤒🏥"))
         ((description . "Royal Flush?")
           (property . "truncate")
           (input (phrase . "🃎🂸🃅🃋🃍🃁🃊"))
           (expected . "🃎🂸🃅🃋🃍"))))))
 (isogram
   (exercise . "isogram")
   (comments
     "An isogram is a word or phrase without a repeating letter.")
   (version . "1.7.0")
   (cases
     ((description . "Check if the given string is an isogram")
       (comments
         "Output should be a boolean denoting if the string is a isogram or not.")
       (cases
         ((description . "empty string")
           (property . "isIsogram")
           (input (phrase . ""))
           (expected . #t))
         ((description . "isogram with only lower case characters")
           (property . "isIsogram")
           (input (phrase . "isogram"))
           (expected . #t))
         ((description . "word with one duplicated character")
           (property . "isIsogram")
           (input (phrase . "eleven"))
           (expected . #f))
         ((description
            .
            "word with one duplicated character from the end of the alphabet")
           (property . "isIsogram")
           (input (phrase . "zzyzx"))
           (expected . #f))
         ((description . "longest reported english isogram")
           (property . "isIsogram")
           (input (phrase . "subdermatoglyphic"))
           (expected . #t))
         ((description
            .
            "word with duplicated character in mixed case")
           (property . "isIsogram")
           (input (phrase . "Alphabet"))
           (expected . #f))
         ((description
            .
            "word with duplicated character in mixed case, lowercase first")
           (property . "isIsogram")
           (input (phrase . "alphAbet"))
           (expected . #f))
         ((description . "hypothetical isogrammic word with hyphen")
           (property . "isIsogram")
           (input (phrase . "thumbscrew-japingly"))
           (expected . #t))
         ((description
            .
            "hypothetical word with duplicated character following hyphen")
           (property . "isIsogram")
           (input (phrase . "thumbscrew-jappingly"))
           (expected . #f))
         ((description . "isogram with duplicated hyphen")
           (property . "isIsogram")
           (input (phrase . "six-year-old"))
           (expected . #t))
         ((description . "made-up name that is an isogram")
           (property . "isIsogram")
           (input (phrase . "Emily Jung Schwartzkopf"))
           (expected . #t))
         ((description . "duplicated character in the middle")
           (property . "isIsogram")
           (input (phrase . "accentor"))
           (expected . #f))
         ((description . "same first and last characters")
           (property . "isIsogram")
           (input (phrase . "angola"))
           (expected . #f))))))
 (rectangles
   (exercise . "rectangles")
   (version . "1.1.0")
   (comments
     "The inputs are represented as arrays of strings to improve readability in this JSON file."
     "Your track may choose whether to present the input as a single string (concatenating all the lines) or as the list.")
   (cases
     ((description . "no rows")
       (property . "rectangles")
       (input (strings))
       (expected . 0))
     ((description . "no columns")
       (property . "rectangles")
       (input (strings ""))
       (expected . 0))
     ((description . "no rectangles")
       (property . "rectangles")
       (input (strings " "))
       (expected . 0))
     ((description . "one rectangle")
       (property . "rectangles")
       (input (strings "+-+" "| |" "+-+"))
       (expected . 1))
     ((description . "two rectangles without shared parts")
       (property . "rectangles")
       (input (strings "  +-+" "  | |" "+-+-+" "| |  " "+-+  "))
       (expected . 2))
     ((description . "five rectangles with shared parts")
       (property . "rectangles")
       (input (strings "  +-+" "  | |" "+-+-+" "| | |" "+-+-+"))
       (expected . 5))
     ((description . "rectangle of height 1 is counted")
       (property . "rectangles")
       (input (strings "+--+" "+--+"))
       (expected . 1))
     ((description . "rectangle of width 1 is counted")
       (property . "rectangles")
       (input (strings "++" "||" "++"))
       (expected . 1))
     ((description . "1x1 square is counted")
       (property . "rectangles")
       (input (strings "++" "++"))
       (expected . 1))
     ((description . "only complete rectangles are counted")
       (property . "rectangles")
       (input (strings "  +-+" "    |" "+-+-+" "| | -" "+-+-+"))
       (expected . 1))
     ((description . "rectangles can be of different sizes")
       (property . "rectangles")
       (input
         (strings "+------+----+" "|      |    |" "+---+--+    |"
           "|   |       |" "+---+-------+"))
       (expected . 3))
     ((description
        .
        "corner is required for a rectangle to be complete")
       (property . "rectangles")
       (input
         (strings "+------+----+" "|      |    |" "+------+    |"
           "|   |       |" "+---+-------+"))
       (expected . 2))
     ((description . "large input with many rectangles")
       (property . "rectangles")
       (input
         (strings "+---+--+----+" "|   +--+----+" "+---+--+    |"
           "|   +--+----+" "+---+--+--+-+" "+---+--+--+-+"
           "+------+  | |" "          +-+"))
       (expected . 60))))
 (leap
   (exercise . "leap")
   (version . "1.6.0")
   (cases
     ((description . "year not divisible by 4 in common year")
       (property . "leapYear")
       (input (year . 2015))
       (expected . #f))
     ((description
        .
        "year divisible by 2, not divisible by 4 in common year")
       (property . "leapYear")
       (input (year . 1970))
       (expected . #f))
     ((description
        .
        "year divisible by 4, not divisible by 100 in leap year")
       (property . "leapYear")
       (input (year . 1996))
       (expected . #t))
     ((description
        .
        "year divisible by 4 and 5 is still a leap year")
       (property . "leapYear")
       (input (year . 1960))
       (expected . #t))
     ((description
        .
        "year divisible by 100, not divisible by 400 in common year")
       (property . "leapYear")
       (input (year . 2100))
       (expected . #f))
     ((description
        .
        "year divisible by 100 but not by 3 is still not a leap year")
       (property . "leapYear")
       (input (year . 1900))
       (expected . #f))
     ((description . "year divisible by 400 in leap year")
       (property . "leapYear")
       (input (year . 2000))
       (expected . #t))
     ((description
        .
        "year divisible by 400 but not by 125 is still a leap year")
       (property . "leapYear")
       (input (year . 2400))
       (expected . #t))
     ((description
        .
        "year divisible by 200, not divisible by 400 in common year")
       (property . "leapYear")
       (input (year . 1800))
       (expected . #f))))
 (alphametics
   (exercise . "alphametics")
   (version . "1.3.0")
   (cases
     ((description . "Solve the alphametics puzzle")
       (cases
         ((description . "puzzle with three letters")
           (property . "solve")
           (input (puzzle . "I + BB == ILL"))
           (expected (I . 1) (B . 9) (L . 0)))
         ((description
            .
            "solution must have unique value for each letter")
           (property . "solve")
           (input (puzzle . "A == B"))
           (expected))
         ((description . "leading zero solution is invalid")
           (property . "solve")
           (input (puzzle . "ACA + DD == BD"))
           (expected))
         ((description . "puzzle with two digits final carry")
           (property . "solve")
           (input
             (puzzle
               .
               "A + A + A + A + A + A + A + A + A + A + A + B == BCC"))
           (expected (A . 9) (B . 1) (C . 0)))
         ((description . "puzzle with four letters")
           (property . "solve")
           (input (puzzle . "AS + A == MOM"))
           (expected (A . 9) (S . 2) (M . 1) (O . 0)))
         ((description . "puzzle with six letters")
           (property . "solve")
           (input (puzzle . "NO + NO + TOO == LATE"))
           (expected (N . 7) (O . 4) (T . 9) (L . 1) (A . 0) (E . 2)))
         ((description . "puzzle with seven letters")
           (property . "solve")
           (input (puzzle . "HE + SEES + THE == LIGHT"))
           (expected (E . 4) (G . 2) (H . 5) (I . 0) (L . 1) (S . 9)
             (T . 7)))
         ((description . "puzzle with eight letters")
           (property . "solve")
           (input (puzzle . "SEND + MORE == MONEY"))
           (expected (S . 9) (E . 5) (N . 6) (D . 7) (M . 1) (O . 0)
             (R . 8) (Y . 2)))
         ((description . "puzzle with ten letters")
           (property . "solve")
           (input
             (puzzle
               .
               "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE"))
           (expected (A . 5) (D . 3) (E . 4) (F . 7) (G . 8) (N . 0)
             (O . 2) (R . 1) (S . 6) (T . 9)))
         ((description . "puzzle with ten letters and 199 addends")
           (property . "solve")
           (input
             (puzzle
               .
               "THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES"))
           (expected (A . 1) (E . 0) (F . 5) (H . 8) (I . 7) (L . 2)
             (O . 6) (R . 3) (S . 4) (T . 9)))))))
 (sum-of-multiples
   (exercise . "sum-of-multiples")
   (version . "1.5.0")
   (cases
     ((description . "no multiples within limit")
       (property . "sum")
       (input (factors 3 5) (limit . 1))
       (expected . 0))
     ((description . "one factor has multiples within limit")
       (property . "sum")
       (input (factors 3 5) (limit . 4))
       (expected . 3))
     ((description . "more than one multiple within limit")
       (property . "sum")
       (input (factors 3) (limit . 7))
       (expected . 9))
     ((description
        .
        "more than one factor with multiples within limit")
       (property . "sum")
       (input (factors 3 5) (limit . 10))
       (expected . 23))
     ((description . "each multiple is only counted once")
       (property . "sum")
       (input (factors 3 5) (limit . 100))
       (expected . 2318))
     ((description . "a much larger limit")
       (property . "sum")
       (input (factors 3 5) (limit . 1000))
       (expected . 233168))
     ((description . "three factors")
       (property . "sum")
       (input (factors 7 13 17) (limit . 20))
       (expected . 51))
     ((description . "factors not relatively prime")
       (property . "sum")
       (input (factors 4 6) (limit . 15))
       (expected . 30))
     ((description
        .
        "some pairs of factors relatively prime and some not")
       (property . "sum")
       (input (factors 5 6 8) (limit . 150))
       (expected . 4419))
     ((description . "one factor is a multiple of another")
       (property . "sum")
       (input (factors 5 25) (limit . 51))
       (expected . 275))
     ((description . "much larger factors")
       (property . "sum")
       (input (factors 43 47) (limit . 10000))
       (expected . 2203160))
     ((description . "all numbers are multiples of 1")
       (property . "sum")
       (input (factors 1) (limit . 100))
       (expected . 4950))
     ((description . "no factors means an empty sum")
       (property . "sum")
       (input (factors) (limit . 10000))
       (expected . 0))
     ((description . "the only multiple of 0 is 0")
       (property . "sum")
       (input (factors 0) (limit . 1))
       (expected . 0))
     ((description
        .
        "the factor 0 does not affect the sum of multiples of other factors")
       (property . "sum")
       (input (factors 3 0) (limit . 4))
       (expected . 3))
     ((description
        .
        "solutions using include-exclude must extend to cardinality greater than 3")
       (property . "sum")
       (input (factors 2 3 5 7 11) (limit . 10000))
       (expected . 39614537))))
 (pig-latin
   (exercise . "pig-latin")
   (version . "1.2.0")
   (cases
     ((description
        .
        "ay is added to words that start with vowels")
       (cases
         ((description . "word beginning with a")
           (property . "translate")
           (input (phrase . "apple"))
           (expected . "appleay"))
         ((description . "word beginning with e")
           (property . "translate")
           (input (phrase . "ear"))
           (expected . "earay"))
         ((description . "word beginning with i")
           (property . "translate")
           (input (phrase . "igloo"))
           (expected . "iglooay"))
         ((description . "word beginning with o")
           (property . "translate")
           (input (phrase . "object"))
           (expected . "objectay"))
         ((description . "word beginning with u")
           (property . "translate")
           (input (phrase . "under"))
           (expected . "underay"))
         ((description
            .
            "word beginning with a vowel and followed by a qu")
           (property . "translate")
           (input (phrase . "equal"))
           (expected . "equalay"))))
     ((description
        .
        "first letter and ay are moved to the end of words that start with consonants")
       (cases
         ((description . "word beginning with p")
           (property . "translate")
           (input (phrase . "pig"))
           (expected . "igpay"))
         ((description . "word beginning with k")
           (property . "translate")
           (input (phrase . "koala"))
           (expected . "oalakay"))
         ((description . "word beginning with x")
           (property . "translate")
           (input (phrase . "xenon"))
           (expected . "enonxay"))
         ((description
            .
            "word beginning with q without a following u")
           (property . "translate")
           (input (phrase . "qat"))
           (expected . "atqay"))))
     ((description
        .
        "some letter clusters are treated like a single consonant")
       (cases
         ((description . "word beginning with ch")
           (property . "translate")
           (input (phrase . "chair"))
           (expected . "airchay"))
         ((description . "word beginning with qu")
           (property . "translate")
           (input (phrase . "queen"))
           (expected . "eenquay"))
         ((description
            .
            "word beginning with qu and a preceding consonant")
           (property . "translate")
           (input (phrase . "square"))
           (expected . "aresquay"))
         ((description . "word beginning with th")
           (property . "translate")
           (input (phrase . "therapy"))
           (expected . "erapythay"))
         ((description . "word beginning with thr")
           (property . "translate")
           (input (phrase . "thrush"))
           (expected . "ushthray"))
         ((description . "word beginning with sch")
           (property . "translate")
           (input (phrase . "school"))
           (expected . "oolschay"))))
     ((description
        .
        "some letter clusters are treated like a single vowel")
       (cases
         ((description . "word beginning with yt")
           (property . "translate")
           (input (phrase . "yttria"))
           (expected . "yttriaay"))
         ((description . "word beginning with xr")
           (property . "translate")
           (input (phrase . "xray"))
           (expected . "xrayay"))))
     ((description
        .
        "position of y in a word determines if it is a consonant or a vowel")
       (cases
         ((description
            .
            "y is treated like a consonant at the beginning of a word")
           (property . "translate")
           (input (phrase . "yellow"))
           (expected . "ellowyay"))
         ((description
            .
            "y is treated like a vowel at the end of a consonant cluster")
           (property . "translate")
           (input (phrase . "rhythm"))
           (expected . "ythmrhay"))
         ((description . "y as second letter in two letter word")
           (property . "translate")
           (input (phrase . "my"))
           (expected . "ymay"))))
     ((description . "phrases are translated")
       (cases
         ((description . "a whole phrase")
           (property . "translate")
           (input (phrase . "quick fast run"))
           (expected . "ickquay astfay unray"))))))
 (grep
   (exercise . "grep")
   (version . "1.2.0")
   (comments
    " JSON doesn't allow for multi-line strings, so all   "
    " outputs are presented here as arrays of strings.    "
    " It's up to the test generator to join the lines     "
    " together with line breaks.                          "
    "                                                     "
    " The tests are divided into two groups:              "
    "  - Grepping a single file                           "
    "  - Grepping multiple files at once                  "
    "                                                     "
    " The language track implementing this exercise       "
    " should ensure that when the tests run, three files  "
    " are created with the following contents. The file   "
    " names and their contents are listed below:          "
    "                                                     "
    " iliad.txt                                           "
    "   ---------------------------------------------     "
    "   |Achilles sing, O Goddess! Peleus' son;     |     "
    "   |His wrath pernicious, who ten thousand woes|     "
    "   |Caused to Achaia's host, sent many a soul  |     "
    "   |Illustrious into Ades premature,           |     "
    "   |And Heroes gave (so stood the will of Jove)|     "
    "   |To dogs and to all ravening fowls a prey,  |     "
    "   |When fierce dispute had separated once     |     "
    "   |The noble Chief Achilles from the son      |     "
    "   |Of Atreus, Agamemnon, King of men.         |     "
    "   ---------------------------------------------     "
    "                                                     "
    " midsummer-night.txt                                 "
    "   -----------------------------------------------   "
    "   |I do entreat your grace to pardon me.        |   "
    "   |I know not by what power I am made bold,     |   "
    "   |Nor how it may concern my modesty,           |   "
    "   |In such a presence here to plead my thoughts;|   "
    "   |But I beseech your grace that I may know     |   "
    "   |The worst that may befall me in this case,   |   "
    "   |If I refuse to wed Demetrius.                |   "
    "   -----------------------------------------------   "
    "                                                     "
    " paradise-lost.txt                                   "
    "   ------------------------------------------------- "
    "   |Of Mans First Disobedience, and the Fruit      | "
    "   |Of that Forbidden Tree, whose mortal tast      | "
    "   |Brought Death into the World, and all our woe, | "
    "   |With loss of Eden, till one greater Man        | "
    "   |Restore us, and regain the blissful Seat,      | "
    "   |Sing Heav'nly Muse, that on the secret top     | "
    "   |Of Oreb, or of Sinai, didst inspire            | "
    "   |That Shepherd, who first taught the chosen Seed| "
    "   ------------------------------------------------- ")
   (cases
     ((description . "Test grepping a single file")
       (cases
         ((description . "One file, one match, no flags")
           (property . "grep")
           (input (pattern . "Agamemnon") (flags) (files "iliad.txt"))
           (expected "Of Atreus, Agamemnon, King of men."))
         ((description
            .
            "One file, one match, print line numbers flag")
           (property . "grep")
           (input
             (pattern . "Forbidden")
             (flags "-n")
             (files "paradise-lost.txt"))
           (expected "2:Of that Forbidden Tree, whose mortal tast"))
         ((description
            .
            "One file, one match, case-insensitive flag")
           (property . "grep")
           (input
             (pattern . "FORBIDDEN")
             (flags "-i")
             (files "paradise-lost.txt"))
           (expected "Of that Forbidden Tree, whose mortal tast"))
         ((description
            .
            "One file, one match, print file names flag")
           (property . "grep")
           (input
             (pattern . "Forbidden")
             (flags "-l")
             (files "paradise-lost.txt"))
           (expected "paradise-lost.txt"))
         ((description
            .
            "One file, one match, match entire lines flag")
           (property . "grep")
           (input
             (pattern . "With loss of Eden, till one greater Man")
             (flags "-x")
             (files "paradise-lost.txt"))
           (expected "With loss of Eden, till one greater Man"))
         ((description . "One file, one match, multiple flags")
           (property . "grep")
           (input
             (pattern . "OF ATREUS, Agamemnon, KIng of MEN.")
             (flags "-n" "-i" "-x")
             (files "iliad.txt"))
           (expected "9:Of Atreus, Agamemnon, King of men."))
         ((description . "One file, several matches, no flags")
           (property . "grep")
           (input
             (pattern . "may")
             (flags)
             (files "midsummer-night.txt"))
           (expected
             "Nor how it may concern my modesty,"
             "But I beseech your grace that I may know"
             "The worst that may befall me in this case,"))
         ((description
            .
            "One file, several matches, print line numbers flag")
           (property . "grep")
           (input
             (pattern . "may")
             (flags "-n")
             (files "midsummer-night.txt"))
           (expected
             "3:Nor how it may concern my modesty,"
             "5:But I beseech your grace that I may know"
             "6:The worst that may befall me in this case,"))
         ((description
            .
            "One file, several matches, match entire lines flag")
           (property . "grep")
           (input
             (pattern . "may")
             (flags "-x")
             (files "midsummer-night.txt"))
           (expected))
         ((description
            .
            "One file, several matches, case-insensitive flag")
           (property . "grep")
           (input
             (pattern . "ACHILLES")
             (flags "-i")
             (files "iliad.txt"))
           (expected
             "Achilles sing, O Goddess! Peleus' son;"
             "The noble Chief Achilles from the son"))
         ((description . "One file, several matches, inverted flag")
           (property . "grep")
           (input
             (pattern . "Of")
             (flags "-v")
             (files "paradise-lost.txt"))
           (expected "Brought Death into the World, and all our woe,"
             "With loss of Eden, till one greater Man"
             "Restore us, and regain the blissful Seat,"
             "Sing Heav'nly Muse, that on the secret top"
             "That Shepherd, who first taught the chosen Seed"))
         ((description . "One file, no matches, various flags")
           (property . "grep")
           (input
             (pattern . "Gandalf")
             (flags "-n" "-l" "-x" "-i")
             (files "iliad.txt"))
           (expected))
         ((description
            .
            "One file, one match, file flag takes precedence over line flag")
           (property . "grep")
           (input
             (pattern . "ten")
             (flags "-n" "-l")
             (files "iliad.txt"))
           (expected "iliad.txt"))
         ((description
            .
            "One file, several matches, inverted and match entire lines flags")
           (property . "grep")
           (input
             (pattern . "Illustrious into Ades premature,")
             (flags "-x" "-v")
             (files "iliad.txt"))
           (expected "Achilles sing, O Goddess! Peleus' son;"
             "His wrath pernicious, who ten thousand woes"
             "Caused to Achaia's host, sent many a soul"
             "And Heroes gave (so stood the will of Jove)"
             "To dogs and to all ravening fowls a prey,"
             "When fierce dispute had separated once"
             "The noble Chief Achilles from the son"
             "Of Atreus, Agamemnon, King of men."))))
     ((description . "Test grepping multiples files at once")
       (cases
         ((description . "Multiple files, one match, no flags")
           (property . "grep")
           (input
             (pattern . "Agamemnon")
             (flags)
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected "iliad.txt:Of Atreus, Agamemnon, King of men."))
         ((description . "Multiple files, several matches, no flags")
           (property . "grep")
           (input
             (pattern . "may")
             (flags)
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected
             "midsummer-night.txt:Nor how it may concern my modesty,"
             "midsummer-night.txt:But I beseech your grace that I may know"
             "midsummer-night.txt:The worst that may befall me in this case,"))
         ((description
            .
            "Multiple files, several matches, print line numbers flag")
           (property . "grep")
           (input
             (pattern . "that")
             (flags "-n")
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected
             "midsummer-night.txt:5:But I beseech your grace that I may know"
             "midsummer-night.txt:6:The worst that may befall me in this case,"
             "paradise-lost.txt:2:Of that Forbidden Tree, whose mortal tast"
             "paradise-lost.txt:6:Sing Heav'nly Muse, that on the secret top"))
         ((description
            .
            "Multiple files, one match, print file names flag")
           (property . "grep")
           (input
             (pattern . "who")
             (flags "-l")
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected "iliad.txt" "paradise-lost.txt"))
         ((description
            .
            "Multiple files, several matches, case-insensitive flag")
           (property . "grep")
           (input
             (pattern . "TO")
             (flags "-i")
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected "iliad.txt:Caused to Achaia's host, sent many a soul"
             "iliad.txt:Illustrious into Ades premature,"
             "iliad.txt:And Heroes gave (so stood the will of Jove)"
             "iliad.txt:To dogs and to all ravening fowls a prey,"
             "midsummer-night.txt:I do entreat your grace to pardon me."
             "midsummer-night.txt:In such a presence here to plead my thoughts;"
             "midsummer-night.txt:If I refuse to wed Demetrius."
             "paradise-lost.txt:Brought Death into the World, and all our woe,"
             "paradise-lost.txt:Restore us, and regain the blissful Seat,"
             "paradise-lost.txt:Sing Heav'nly Muse, that on the secret top"))
         ((description
            .
            "Multiple files, several matches, inverted flag")
           (property . "grep")
           (input
             (pattern . "a")
             (flags "-v")
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected
             "iliad.txt:Achilles sing, O Goddess! Peleus' son;"
             "iliad.txt:The noble Chief Achilles from the son"
             "midsummer-night.txt:If I refuse to wed Demetrius."))
         ((description
            .
            "Multiple files, one match, match entire lines flag")
           (property . "grep")
           (input
             (pattern . "But I beseech your grace that I may know")
             (flags "-x")
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected
             "midsummer-night.txt:But I beseech your grace that I may know"))
         ((description . "Multiple files, one match, multiple flags")
           (property . "grep")
           (input
             (pattern . "WITH LOSS OF EDEN, TILL ONE GREATER MAN")
             (flags "-n" "-i" "-x")
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected
             "paradise-lost.txt:4:With loss of Eden, till one greater Man"))
         ((description . "Multiple files, no matches, various flags")
           (property . "grep")
           (input
             (pattern . "Frodo")
             (flags "-n" "-l" "-x" "-i")
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected))
         ((description
            .
            "Multiple files, several matches, file flag takes precedence over line number flag")
           (property . "grep")
           (input
             (pattern . "who")
             (flags "-n" "-l")
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected "iliad.txt" "paradise-lost.txt"))
         ((description
            .
            "Multiple files, several matches, inverted and match entire lines flags")
           (property . "grep")
           (input
             (pattern . "Illustrious into Ades premature,")
             (flags "-x" "-v")
             (files
               "iliad.txt"
               "midsummer-night.txt"
               "paradise-lost.txt"))
           (expected "iliad.txt:Achilles sing, O Goddess! Peleus' son;"
            "iliad.txt:His wrath pernicious, who ten thousand woes"
            "iliad.txt:Caused to Achaia's host, sent many a soul"
            "iliad.txt:And Heroes gave (so stood the will of Jove)"
            "iliad.txt:To dogs and to all ravening fowls a prey,"
            "iliad.txt:When fierce dispute had separated once"
            "iliad.txt:The noble Chief Achilles from the son"
            "iliad.txt:Of Atreus, Agamemnon, King of men."
            "midsummer-night.txt:I do entreat your grace to pardon me."
            "midsummer-night.txt:I know not by what power I am made bold,"
            "midsummer-night.txt:Nor how it may concern my modesty,"
            "midsummer-night.txt:In such a presence here to plead my thoughts;"
            "midsummer-night.txt:But I beseech your grace that I may know"
            "midsummer-night.txt:The worst that may befall me in this case,"
            "midsummer-night.txt:If I refuse to wed Demetrius."
            "paradise-lost.txt:Of Mans First Disobedience, and the Fruit"
            "paradise-lost.txt:Of that Forbidden Tree, whose mortal tast"
            "paradise-lost.txt:Brought Death into the World, and all our woe,"
            "paradise-lost.txt:With loss of Eden, till one greater Man"
            "paradise-lost.txt:Restore us, and regain the blissful Seat,"
            "paradise-lost.txt:Sing Heav'nly Muse, that on the secret top"
            "paradise-lost.txt:Of Oreb, or of Sinai, didst inspire"
            "paradise-lost.txt:That Shepherd, who first taught the chosen Seed"))))))
 (rational-numbers
   (exercise . "rational-numbers")
   (version . "1.1.0")
   (comments
     " The canonical data assumes mathematically correct real   "
     " numbers. The testsuites should consider rounding errors  "
     " instead of testing for exact values for any non-integer  "
     " tests.                                                   "
     " Rational numbers r are represented as arrays [a, b] so   "
     " that r = a/b.                                            ")
   (cases
     ((description . "Arithmetic")
       (cases
         ((description . "Addition")
           (cases
             ((description . "Add two positive rational numbers")
               (property . "add")
               (input (r1 1 2) (r2 2 3))
               (expected 7 6))
             ((description
                .
                "Add a positive rational number and a negative rational number")
               (property . "add")
               (input (r1 1 2) (r2 -2 3))
               (expected -1 6))
             ((description . "Add two negative rational numbers")
               (property . "add")
               (input (r1 -1 2) (r2 -2 3))
               (expected -7 6))
             ((description
                .
                "Add a rational number to its additive inverse")
               (property . "add")
               (input (r1 1 2) (r2 -1 2))
               (expected 0 1))))
         ((description . "Subtraction")
           (cases
             ((description . "Subtract two positive rational numbers")
               (property . "sub")
               (input (r1 1 2) (r2 2 3))
               (expected -1 6))
             ((description
                .
                "Subtract a positive rational number and a negative rational number")
               (property . "sub")
               (input (r1 1 2) (r2 -2 3))
               (expected 7 6))
             ((description . "Subtract two negative rational numbers")
               (property . "sub")
               (input (r1 -1 2) (r2 -2 3))
               (expected 1 6))
             ((description . "Subtract a rational number from itself")
               (property . "sub")
               (input (r1 1 2) (r2 1 2))
               (expected 0 1))))
         ((description . "Multiplication")
           (cases
             ((description . "Multiply two positive rational numbers")
               (property . "mul")
               (input (r1 1 2) (r2 2 3))
               (expected 1 3))
             ((description
                .
                "Multiply a negative rational number by a positive rational number")
               (property . "mul")
               (input (r1 -1 2) (r2 2 3))
               (expected -1 3))
             ((description . "Multiply two negative rational numbers")
               (property . "mul")
               (input (r1 -1 2) (r2 -2 3))
               (expected 1 3))
             ((description
                .
                "Multiply a rational number by its reciprocal")
               (property . "mul")
               (input (r1 1 2) (r2 2 1))
               (expected 1 1))
             ((description . "Multiply a rational number by 1")
               (property . "mul")
               (input (r1 1 2) (r2 1 1))
               (expected 1 2))
             ((description . "Multiply a rational number by 0")
               (property . "mul")
               (input (r1 1 2) (r2 0 1))
               (expected 0 1))))
         ((description . "Division")
           (cases
             ((description . "Divide two positive rational numbers")
               (property . "div")
               (input (r1 1 2) (r2 2 3))
               (expected 3 4))
             ((description
                .
                "Divide a positive rational number by a negative rational number")
               (property . "div")
               (input (r1 1 2) (r2 -2 3))
               (expected -3 4))
             ((description . "Divide two negative rational numbers")
               (property . "div")
               (input (r1 -1 2) (r2 -2 3))
               (expected 3 4))
             ((description . "Divide a rational number by 1")
               (property . "div")
               (input (r1 1 2) (r2 1 1))
               (expected 1 2))))))
     ((description . "Absolute value")
       (cases
         ((description
            .
            "Absolute value of a positive rational number")
           (property . "abs")
           (input (r 1 2))
           (expected 1 2))
         ((description
            .
            "Absolute value of a positive rational number with negative numerator and denominator")
           (property . "abs")
           (input (r -1 -2))
           (expected 1 2))
         ((description
            .
            "Absolute value of a negative rational number")
           (property . "abs")
           (input (r -1 2))
           (expected 1 2))
         ((description
            .
            "Absolute value of a negative rational number with negative denominator")
           (property . "abs")
           (input (r 1 -2))
           (expected 1 2))
         ((description . "Absolute value of zero")
           (property . "abs")
           (input (r 0 1))
           (expected 0 1))))
     ((description . "Exponentiation of a rational number")
       (cases
         ((description
            .
            "Raise a positive rational number to a positive integer power")
           (property . "exprational")
           (input (r 1 2) (n . 3))
           (expected 1 8))
         ((description
            .
            "Raise a negative rational number to a positive integer power")
           (property . "exprational")
           (input (r -1 2) (n . 3))
           (expected -1 8))
         ((description . "Raise zero to an integer power")
           (property . "exprational")
           (input (r 0 1) (n . 5))
           (expected 0 1))
         ((description . "Raise one to an integer power")
           (property . "exprational")
           (input (r 1 1) (n . 4))
           (expected 1 1))
         ((description
            .
            "Raise a positive rational number to the power of zero")
           (property . "exprational")
           (input (r 1 2) (n . 0))
           (expected 1 1))
         ((description
            .
            "Raise a negative rational number to the power of zero")
           (property . "exprational")
           (input (r -1 2) (n . 0))
           (expected 1 1))))
     ((description
        .
        "Exponentiation of a real number to a rational number")
       (cases
         ((description
            .
            "Raise a real number to a positive rational number")
           (property . "expreal")
           (input (x . 8) (r 4 3))
           (expected . 16.0))
         ((description
            .
            "Raise a real number to a negative rational number")
           (property . "expreal")
           (input (x . 9) (r -1 2))
           (expected . 0.3333333333333333))
         ((description
            .
            "Raise a real number to a zero rational number")
           (property . "expreal")
           (input (x . 2) (r 0 1))
           (expected . 1.0))))
     ((description . "Reduction to lowest terms")
       (cases
         ((description
            .
            "Reduce a positive rational number to lowest terms")
           (property . "reduce")
           (input (r 2 4))
           (expected 1 2))
         ((description
            .
            "Reduce a negative rational number to lowest terms")
           (property . "reduce")
           (input (r -4 6))
           (expected -2 3))
         ((description
            .
            "Reduce a rational number with a negative denominator to lowest terms")
           (property . "reduce")
           (input (r 3 -9))
           (expected -1 3))
         ((description . "Reduce zero to lowest terms")
           (property . "reduce")
           (input (r 0 6))
           (expected 0 1))
         ((description . "Reduce an integer to lowest terms")
           (property . "reduce")
           (input (r -14 7))
           (expected -2 1))
         ((description . "Reduce one to lowest terms")
           (property . "reduce")
           (input (r 13 13))
           (expected 1 1))))))
 (twelve-days
   (exercise . "twelve-days")
   (version . "1.2.0")
   (comments
     "JSON doesn't allow for multi-line strings, so all verses are presented "
     "here as arrays of strings. It's up to the test generator to join the "
     "lines together with line breaks.")
   (cases
     ((description . "verse")
       (cases
         ((description . "first day a partridge in a pear tree")
           (property . "recite")
           (input (startVerse . 1) (endVerse . 1))
           (expected
             "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."))
         ((description . "second day two turtle doves")
           (property . "recite")
           (input (startVerse . 2) (endVerse . 2))
           (expected
             "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "third day three french hens")
           (property . "recite")
           (input (startVerse . 3) (endVerse . 3))
           (expected
             "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "fourth day four calling birds")
           (property . "recite")
           (input (startVerse . 4) (endVerse . 4))
           (expected
             "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "fifth day five gold rings")
           (property . "recite")
           (input (startVerse . 5) (endVerse . 5))
           (expected
             "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "sixth day six geese-a-laying")
           (property . "recite")
           (input (startVerse . 6) (endVerse . 6))
           (expected
             "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "seventh day seven swans-a-swimming")
           (property . "recite")
           (input (startVerse . 7) (endVerse . 7))
           (expected
             "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "eighth day eight maids-a-milking")
           (property . "recite")
           (input (startVerse . 8) (endVerse . 8))
           (expected
             "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "ninth day nine ladies dancing")
           (property . "recite")
           (input (startVerse . 9) (endVerse . 9))
           (expected
             "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "tenth day ten lords-a-leaping")
           (property . "recite")
           (input (startVerse . 10) (endVerse . 10))
           (expected
             "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "eleventh day eleven pipers piping")
           (property . "recite")
           (input (startVerse . 11) (endVerse . 11))
           (expected
             "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "twelfth day twelve drummers drumming")
           (property . "recite")
           (input (startVerse . 12) (endVerse . 12))
           (expected
             "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))))
     ((description . "lyrics")
       (cases
         ((description . "recites first three verses of the song")
           (property . "recite")
           (input (startVerse . 1) (endVerse . 3))
           (expected
             "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
             "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
             "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description
            .
            "recites three verses from the middle of the song")
           (property . "recite")
           (input (startVerse . 4) (endVerse . 6))
           (expected
             "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))
         ((description . "recites the whole song")
           (property . "recite")
           (input (startVerse . 1) (endVerse . 12))
           (expected
             "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
             "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
             "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
             "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."))))))
 (hello-world
   (exercise . "hello-world")
   (version . "1.1.0")
   (cases
     ((description . "Say Hi!")
       (property . "hello")
       (input)
       (expected . "Hello, World!"))))
 (zipper
   (exercise . "zipper")
   (version . "1.1.0")
   (comments
     " The test cases for this exercise include an initial tree and a     "
     " series of operations to perform on the initial tree.               "
     "                                                                    "
     " Trees are encoded as nested objects. Each node in the tree has     "
     " three members: 'value', 'left', and 'right'. Each value is a       "
     " number (for simplicity). Left and right are trees. An empty node   "
     " is encoded as null.                                                "
     "                                                                    "
     " Each operation in the operations list is an object. The function   "
     " name is listed under 'operation'. If the function requires         "
     " arguments, the argument is listed under 'item'. Some functions     "
     " require values (i.e.  numbers), while others require trees.        "
     " Comments are always optional and can be used almost anywhere.      ")
   (cases
     ((description . "data is retained")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations ((operation . "to_tree"))))
       (expected
         (type . "tree")
         (value
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))))
     ((description . "left, right and value")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations
           ((operation . "left"))
           ((operation . "right"))
           ((operation . "value"))))
       (expected (type . "int") (value . 3)))
     ((description . "dead end")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations ((operation . "left")) ((operation . "left"))))
       (expected (type . "zipper") (value)))
     ((description . "tree from deep focus")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations
           ((operation . "left"))
           ((operation . "right"))
           ((operation . "to_tree"))))
       (expected
         (type . "tree")
         (value
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))))
     ((description . "traversing up from top")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations ((operation . "up"))))
       (expected (type . "zipper") (value)))
     ((description . "left, right, and up")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations ((operation . "left")) ((operation . "up"))
           ((operation . "right")) ((operation . "up"))
           ((operation . "left")) ((operation . "right"))
           ((operation . "value"))))
       (expected (type . "int") (value . 3)))
     ((description . "set_value")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations
           ((operation . "left"))
           ((operation . "set_value") (item . 5))
           ((operation . "to_tree"))))
       (expected
         (type . "tree")
         (value
           (value . 1)
           (left (value . 5) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))))
     ((description . "set_value after traversing up")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations ((operation . "left")) ((operation . "right"))
           ((operation . "up")) ((operation . "set_value") (item . 5))
           ((operation . "to_tree"))))
       (expected
         (type . "tree")
         (value
           (value . 1)
           (left (value . 5) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))))
     ((description . "set_left with leaf")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations
           ((operation . "left"))
           ((operation . "set_left") (item (value . 5) (left) (right)))
           ((operation . "to_tree"))))
       (expected
         (type . "tree")
         (value
           (value . 1)
           (left
             (value . 2)
             (left (value . 5) (left) (right))
             (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))))
     ((description . "set_right with null")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations
           ((operation . "left"))
           ((operation . "set_right") (item))
           ((operation . "to_tree"))))
       (expected
         (type . "tree")
         (value
           (value . 1)
           (left (value . 2) (left) (right))
           (right (value . 4) (left) (right)))))
     ((description . "set_right with subtree")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations
           ((operation . "set_right")
             (item
               (value . 6)
               (left (value . 7) (left) (right))
               (right (value . 8) (left) (right))))
           ((operation . "to_tree"))))
       (expected
         (type . "tree")
         (value
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right
             (value . 6)
             (left (value . 7) (left) (right))
             (right (value . 8) (left) (right))))))
     ((description . "set_value on deep focus")
       (property . "expectedValue")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations
           ((operation . "left"))
           ((operation . "right"))
           ((operation . "set_value") (item . 5))
           ((operation . "to_tree"))))
       (expected
         (type . "tree")
         (value
           (value . 1)
           (left (value . 2) (left) (right (value . 5) (left) (right)))
           (right (value . 4) (left) (right)))))
     ((description . "different paths to same zipper")
       (property . "sameResultFromOperations")
       (input
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations
           ((operation . "left"))
           ((operation . "up"))
           ((operation . "right"))))
       (expected
         (type . "zipper")
         (initialTree
           (value . 1)
           (left (value . 2) (left) (right (value . 3) (left) (right)))
           (right (value . 4) (left) (right)))
         (operations ((operation . "right")))))))
 (scale-generator
   (exercise . "scale-generator")
   (version . "2.0.0")
   (cases
     ((comments
        "These tests have no interval."
        "The chromatic scale is considered the default scale")
       (description . "Chromatic scales")
       (cases
         ((description . "Chromatic scale with sharps")
           (property . "chromatic")
           (input (tonic . "C"))
           (expected "C" "C#" "D" "D#" "E" "F" "F#" "G" "G#" "A" "A#"
             "B"))
         ((description . "Chromatic scale with flats")
           (property . "chromatic")
           (input (tonic . "F"))
           (expected "F" "Gb" "G" "Ab" "A" "Bb" "B" "C" "Db" "D" "Eb"
             "E"))))
     ((comments
        "These tests all have intervals and are explorations of different"
        "traversals of the scale.")
       (description . "Scales with specified intervals")
       (cases
         ((description . "Simple major scale")
           (comments
             "The simplest major scale, with no sharps or flats.")
           (property . "interval")
           (input (tonic . "C") (intervals . "MMmMMMm"))
           (expected "C" "D" "E" "F" "G" "A" "B"))
         ((description . "Major scale with sharps")
           (property . "interval")
           (input (tonic . "G") (intervals . "MMmMMMm"))
           (expected "G" "A" "B" "C" "D" "E" "F#"))
         ((description . "Major scale with flats")
           (property . "interval")
           (input (tonic . "F") (intervals . "MMmMMMm"))
           (expected "F" "G" "A" "Bb" "C" "D" "E"))
         ((description . "Minor scale with sharps")
           (property . "interval")
           (input (tonic . "f#") (intervals . "MmMMmMM"))
           (expected "F#" "G#" "A" "B" "C#" "D" "E"))
         ((description . "Minor scale with flats")
           (property . "interval")
           (input (tonic . "bb") (intervals . "MmMMmMM"))
           (expected "Bb" "C" "Db" "Eb" "F" "Gb" "Ab"))
         ((description . "Dorian mode")
           (property . "interval")
           (input (tonic . "d") (intervals . "MmMMMmM"))
           (expected "D" "E" "F" "G" "A" "B" "C"))
         ((description . "Mixolydian mode")
           (property . "interval")
           (input (tonic . "Eb") (intervals . "MMmMMmM"))
           (expected "Eb" "F" "G" "Ab" "Bb" "C" "Db"))
         ((description . "Lydian mode")
           (property . "interval")
           (input (tonic . "a") (intervals . "MMMmMMm"))
           (expected "A" "B" "C#" "D#" "E" "F#" "G#"))
         ((description . "Phrygian mode")
           (property . "interval")
           (input (tonic . "e") (intervals . "mMMMmMM"))
           (expected "E" "F" "G" "A" "B" "C" "D"))
         ((description . "Locrian mode")
           (property . "interval")
           (input (tonic . "g") (intervals . "mMMmMMM"))
           (expected "G" "Ab" "Bb" "C" "Db" "Eb" "F"))
         ((comments
            "Note that this case introduces the accidental interval (A)")
           (description . "Harmonic minor")
           (property . "interval")
           (input (tonic . "d") (intervals . "MmMMmAm"))
           (expected "D" "E" "F" "G" "A" "Bb" "Db"))
         ((description . "Octatonic")
           (property . "interval")
           (input (tonic . "C") (intervals . "MmMmMmMm"))
           (expected "C" "D" "D#" "F" "F#" "G#" "A" "B"))
         ((description . "Hexatonic")
           (property . "interval")
           (input (tonic . "Db") (intervals . "MMMMMM"))
           (expected "Db" "Eb" "F" "G" "A" "B"))
         ((description . "Pentatonic")
           (property . "interval")
           (input (tonic . "A") (intervals . "MMAMA"))
           (expected "A" "B" "C#" "E" "F#"))
         ((description . "Enigmatic")
           (property . "interval")
           (input (tonic . "G") (intervals . "mAMMMmm"))
           (expected "G" "G#" "B" "C#" "D#" "F" "F#"))))))
 (scrabble-score
   (exercise . "scrabble-score")
   (version . "1.1.0")
   (cases
     ((description . "lowercase letter")
       (property . "score")
       (input (word . "a"))
       (expected . 1))
     ((description . "uppercase letter")
       (property . "score")
       (input (word . "A"))
       (expected . 1))
     ((description . "valuable letter")
       (property . "score")
       (input (word . "f"))
       (expected . 4))
     ((description . "short word")
       (property . "score")
       (input (word . "at"))
       (expected . 2))
     ((description . "short, valuable word")
       (property . "score")
       (input (word . "zoo"))
       (expected . 12))
     ((description . "medium word")
       (property . "score")
       (input (word . "street"))
       (expected . 6))
     ((description . "medium, valuable word")
       (property . "score")
       (input (word . "quirky"))
       (expected . 22))
     ((description . "long, mixed-case word")
       (property . "score")
       (input (word . "OxyphenButazone"))
       (expected . 41))
     ((description . "english-like word")
       (property . "score")
       (input (word . "pinata"))
       (expected . 8))
     ((description . "empty input")
       (property . "score")
       (input (word . ""))
       (expected . 0))
     ((description . "entire alphabet available")
       (property . "score")
       (input (word . "abcdefghijklmnopqrstuvwxyz"))
       (expected . 87))))
 (dominoes
   (exercise . "dominoes")
   (version . "2.1.0")
   (comments "Inputs are given as lists of two-element lists."
    "Feel free to convert the input to a sensible type in the specific language"
    "For example, if the target language has 2-tuples, that is a good candidate."
    ""
    "There are two levels of this exercise that can be implemented and/or tested:"
    ""
    "1: Given a list of dominoes, determine whether it can be made into a chain."
    "Under this scheme, the submitted code only needs to return a boolean."
    "The test code only needs to check that that boolean value matches up."
    ""
    "2: Given a list of dominoes, determine one possible chain, if one exists, or else conclude that none can be made."
    "Under this scheme, the submitted code needs to either return a chain, or signal that none exists."
    "Different languages may do this differently:"
    "return Option<Vector<Domino>>, return ([]Domino, error), raise exception, etc."
    "The test code needs to check that the returned chain is correct (see below)."
    ""
    "It's infeasible to list every single possible result chain in this file."
    "That's because for even a simple list [(1, 2), (2, 3), (3, 1)],"
    "the possible chains are that order, any rotation of that order,"
    "and any rotation of that order with all dominoes reversed."
    ""
    "For this reason, this JSON file will only list whether a chain is possible."
    "Tracks wishing to verify correct results of the second level must separately perform this verification."
    "" "The properties to verify are:"
    "1. The submitted code claims there is a chain if and only if there actually is one."
    "2. The number of dominoes in the output equals the number of dominoes in the input."
    "3a. For each adjacent pair of dominoes ... (a, b), (c, d) ...: b is equal to c."
    "3b. For the dominoes on the ends (a, b) ... (c, d): a is equal to d."
    "4. Every domino appears in the output an equal number of times as the number of times it appears in the input."
    "(in other words, the dominoes in the output are the same dominoes as the ones in the input)"
    ""
    "Feel free to examine the Rust track for ideas on implementing the second level verification.")
   (cases
     ((description . "empty input = empty output")
       (property . "canChain")
       (input (dominoes))
       (expected . #t))
     ((description . "singleton input = singleton output")
       (property . "canChain")
       (input (dominoes (1 1)))
       (expected . #t))
     ((description . "singleton that can't be chained")
       (property . "canChain")
       (input (dominoes (1 2)))
       (expected . #f))
     ((description . "three elements")
       (property . "canChain")
       (input (dominoes (1 2) (3 1) (2 3)))
       (expected . #t))
     ((description . "can reverse dominoes")
       (property . "canChain")
       (input (dominoes (1 2) (1 3) (2 3)))
       (expected . #t))
     ((description . "can't be chained")
       (property . "canChain")
       (input (dominoes (1 2) (4 1) (2 3)))
       (expected . #f))
     ((description . "disconnected - simple")
       (comments "This meets the requirement of being possibly-Euclidean."
         "All vertices have even degree."
         "Nevertheless, there is no chain here, as there's no way to get from 1 to 2."
         "This test (and the two following) prevent solutions from using the even-degree test as the sole criterion,"
         "as that is not a sufficient condition.")
       (property . "canChain")
       (input (dominoes (1 1) (2 2)))
       (expected . #f))
     ((description . "disconnected - double loop")
       (property . "canChain")
       (input (dominoes (1 2) (2 1) (3 4) (4 3)))
       (expected . #f))
     ((description . "disconnected - single isolated")
       (property . "canChain")
       (input (dominoes (1 2) (2 3) (3 1) (4 4)))
       (expected . #f))
     ((description . "need backtrack")
       (comments
         "Some solutions may make a chain out of (1, 2), (2, 3), (3, 1)"
         "then decide that since there are no more dominoes containing a 1,"
         "there is no chain possible."
         "There is indeed a chain here, so this test checks for this line of reasoning."
         "You need to place the (2, 4) after the (1, 2) rather than the (2, 3).")
       (property . "canChain")
       (input (dominoes (1 2) (2 3) (3 1) (2 4) (2 4)))
       (expected . #t))
     ((description . "separate loops")
       (property . "canChain")
       (input (dominoes (1 2) (2 3) (3 1) (1 1) (2 2) (3 3)))
       (expected . #t))
     ((description . "nine elements")
       (property . "canChain")
       (input
         (dominoes (1 2) (5 3) (3 1) (1 2) (2 4) (1 6) (2 3) (3 4)
           (5 6)))
       (expected . #t))))
 (resistor-color-trio
   (exercise . "resistor-color-trio")
   (version . "1.0.0")
   (cases
     ((description . "Orange and orange and black")
       (property . "label")
       (input (colors "orange" "orange" "black"))
       (expected (value . 33) (unit . "ohms")))
     ((description . "Blue and grey and brown")
       (property . "label")
       (input (colors "blue" "grey" "brown"))
       (expected (value . 680) (unit . "ohms")))
     ((description . "Red and black and red")
       (property . "label")
       (input (colors "red" "black" "red"))
       (expected (value . 2) (unit . "kiloohms")))
     ((description . "Green and brown and orange")
       (property . "label")
       (input (colors "green" "brown" "orange"))
       (expected (value . 51) (unit . "kiloohms")))
     ((description . "Yellow and violet and yellow")
       (property . "label")
       (input (colors "yellow" "violet" "yellow"))
       (expected (value . 470) (unit . "kiloohms")))))
 (triangle
   (exercise . "triangle")
   (version . "1.2.1")
   (comments
     " Pursuant to discussion in #202, we have decided NOT to test triangles "
     " where all side lengths are positive but a + b = c. e.g:               "
     " (2, 4, 2, Isosceles), (1, 3, 4, Scalene).                             "
     " It's true that the triangle inequality admits such triangles.These    "
     " triangles have zero area, however.                                    "
     " They're degenerate triangles with all three vertices collinear.       "
     " (In contrast, we will test (0, 0, 0, Illegal), as it is a point)      "
     " The tests assert properties of the triangle are true or false.        "
     " See: https://github.com/exercism/problem-specifications/issues/379 for disscussion  "
     " of this approach                                                      "
     " How you handle invalid triangles is up to you. These tests suggest a  "
     " triangle is returned, but all of its properties are false. But you    "
     " could also have the creation of an invalid triangle return an error   "
     " or exception. Choose what is idiomatic for your language.             ")
   (cases
     ((description . "equilateral triangle")
       (cases
         ((description . "all sides are equal")
           (property . "equilateral")
           (input (sides 2 2 2))
           (expected . #t))
         ((description . "any side is unequal")
           (property . "equilateral")
           (input (sides 2 3 2))
           (expected . #f))
         ((description . "no sides are equal")
           (property . "equilateral")
           (input (sides 5 4 6))
           (expected . #f))
         ((description . "all zero sides is not a triangle")
           (property . "equilateral")
           (input (sides 0 0 0))
           (expected . #f))
         ((comments
            " Your track may choose to skip this test    "
            " and deal only with integers if appropriate ")
           (description . "sides may be floats")
           (property . "equilateral")
           (input (sides 0.5 0.5 0.5))
           (expected . #t))))
     ((description . "isosceles triangle")
       (cases
         ((description . "last two sides are equal")
           (property . "isosceles")
           (input (sides 3 4 4))
           (expected . #t))
         ((description . "first two sides are equal")
           (property . "isosceles")
           (input (sides 4 4 3))
           (expected . #t))
         ((description . "first and last sides are equal")
           (property . "isosceles")
           (input (sides 4 3 4))
           (expected . #t))
         ((description . "equilateral triangles are also isosceles")
           (property . "isosceles")
           (input (sides 4 4 4))
           (expected . #t))
         ((description . "no sides are equal")
           (property . "isosceles")
           (input (sides 2 3 4))
           (expected . #f))
         ((description . "first triangle inequality violation")
           (property . "isosceles")
           (input (sides 1 1 3))
           (expected . #f))
         ((description . "second triangle inequality violation")
           (property . "isosceles")
           (input (sides 1 3 1))
           (expected . #f))
         ((description . "third triangle inequality violation")
           (property . "isosceles")
           (input (sides 3 1 1))
           (expected . #f))
         ((comments
            " Your track may choose to skip this test    "
            " and deal only with integers if appropriate ")
           (property . "isosceles")
           (description . "sides may be floats")
           (input (sides 0.5 0.4 0.5))
           (expected . #t))))
     ((description . "scalene triangle")
       (cases
         ((description . "no sides are equal")
           (property . "scalene")
           (input (sides 5 4 6))
           (expected . #t))
         ((description . "all sides are equal")
           (property . "scalene")
           (input (sides 4 4 4))
           (expected . #f))
         ((description . "two sides are equal")
           (property . "scalene")
           (input (sides 4 4 3))
           (expected . #f))
         ((description . "may not violate triangle inequality")
           (property . "scalene")
           (input (sides 7 3 2))
           (expected . #f))
         ((comments
            " Your track may choose to skip this test    "
            " and deal only with integers if appropriate ")
           (description . "sides may be floats")
           (property . "scalene")
           (input (sides 0.5 0.4 0.6))
           (expected . #t))))))
 (reverse-string
   (exercise . "reverse-string")
   (version . "1.2.0")
   (comments
     "If property based testing tools are available, a good property to test is reversing a string twice: reverse(reverse(string)) == string")
   (cases
     ((description . "an empty string")
       (property . "reverse")
       (input (value . ""))
       (expected . ""))
     ((description . "a word")
       (property . "reverse")
       (input (value . "robot"))
       (expected . "tobor"))
     ((description . "a capitalized word")
       (property . "reverse")
       (input (value . "Ramen"))
       (expected . "nemaR"))
     ((description . "a sentence with punctuation")
       (property . "reverse")
       (input (value . "I'm hungry!"))
       (expected . "!yrgnuh m'I"))
     ((description . "a palindrome")
       (property . "reverse")
       (input (value . "racecar"))
       (expected . "racecar"))
     ((description . "an even-sized word")
       (property . "reverse")
       (input (value . "drawer"))
       (expected . "reward"))))
 (go-counting
   (exercise . "go-counting")
   (version . "1.0.0")
   (comments "Territory consists of [x, y] coordinate pairs.")
   (cases
     ((description . "Black corner territory on 5x5 board")
       (property . "territory")
       (input
         (board "  B  " " B B " "B W B" " W W " "  W  ")
         (x . 0)
         (y . 1))
       (expected (owner . "BLACK") (territory (0 0) (0 1) (1 0))))
     ((description . "White center territory on 5x5 board")
       (property . "territory")
       (input
         (board "  B  " " B B " "B W B" " W W " "  W  ")
         (x . 2)
         (y . 3))
       (expected (owner . "WHITE") (territory (2 3))))
     ((description . "Open corner territory on 5x5 board")
       (property . "territory")
       (input
         (board "  B  " " B B " "B W B" " W W " "  W  ")
         (x . 1)
         (y . 4))
       (expected (owner . "NONE") (territory (0 3) (0 4) (1 4))))
     ((description . "A stone and not a territory on 5x5 board")
       (property . "territory")
       (input
         (board "  B  " " B B " "B W B" " W W " "  W  ")
         (x . 1)
         (y . 1))
       (expected (owner . "NONE") (territory)))
     ((description
        .
        "Invalid because X is too low for 5x5 board")
       (property . "territory")
       (input
         (board "  B  " " B B " "B W B" " W W " "  W  ")
         (x . -1)
         (y . 1))
       (expected (error . "Invalid coordinate")))
     ((description
        .
        "Invalid because X is too high for 5x5 board")
       (property . "territory")
       (input
         (board "  B  " " B B " "B W B" " W W " "  W  ")
         (x . 5)
         (y . 1))
       (expected (error . "Invalid coordinate")))
     ((description
        .
        "Invalid because Y is too low for 5x5 board")
       (property . "territory")
       (input
         (board "  B  " " B B " "B W B" " W W " "  W  ")
         (x . 1)
         (y . -1))
       (expected (error . "Invalid coordinate")))
     ((description
        .
        "Invalid because Y is too high for 5x5 board")
       (property . "territory")
       (input
         (board "  B  " " B B " "B W B" " W W " "  W  ")
         (x . 1)
         (y . 5))
       (expected (error . "Invalid coordinate")))
     ((description . "One territory is the whole board")
       (property . "territories")
       (input (board " "))
       (expected
         (territoryBlack)
         (territoryWhite)
         (territoryNone (0 0))))
     ((description . "Two territory rectangular board")
       (property . "territories")
       (input (board " BW " " BW "))
       (expected
         (territoryBlack (0 0) (0 1))
         (territoryWhite (3 0) (3 1))
         (territoryNone)))
     ((description . "Two region rectangular board")
       (property . "territories")
       (input (board " B "))
       (expected
         (territoryBlack (0 0) (2 0))
         (territoryWhite)
         (territoryNone)))))
 (custom-set
   (exercise . "custom-set")
   (version . "1.3.0")
   (comments
     "These tests cover the core components of a set data structure: checking"
     "presence, adding, comparing and basic set operations. Other features"
     "such as deleting elements, checking size, sorting are not tested, but"
     "you can add them if they are interesting in your language"
     ""
     "Tests about mixed-type sets are not included because the ability"
     "to implement that will vary by language. If your language supports it"
     "and you want to implement mixed-type sets, feel free.")
   (cases
     ((description
        .
        "Returns true if the set contains no elements")
       (cases
         ((description . "sets with no elements are empty")
           (property . "empty")
           (input (set))
           (expected . #t))
         ((description . "sets with elements are not empty")
           (property . "empty")
           (input (set 1))
           (expected . #f))))
     ((description
        .
        "Sets can report if they contain an element")
       (cases
         ((description . "nothing is contained in an empty set")
           (property . "contains")
           (input (set) (element . 1))
           (expected . #f))
         ((description . "when the element is in the set")
           (property . "contains")
           (input (set 1 2 3) (element . 1))
           (expected . #t))
         ((description . "when the element is not in the set")
           (property . "contains")
           (input (set 1 2 3) (element . 4))
           (expected . #f))))
     ((description
        .
        "A set is a subset if all of its elements are contained in the other set")
       (cases
         ((description
            .
            "empty set is a subset of another empty set")
           (property . "subset")
           (input (set1) (set2))
           (expected . #t))
         ((description . "empty set is a subset of non-empty set")
           (property . "subset")
           (input (set1) (set2 1))
           (expected . #t))
         ((description
            .
            "non-empty set is not a subset of empty set")
           (property . "subset")
           (input (set1 1) (set2))
           (expected . #f))
         ((description
            .
            "set is a subset of set with exact same elements")
           (property . "subset")
           (input (set1 1 2 3) (set2 1 2 3))
           (expected . #t))
         ((description
            .
            "set is a subset of larger set with same elements")
           (property . "subset")
           (input (set1 1 2 3) (set2 4 1 2 3))
           (expected . #t))
         ((description
            .
            "set is not a subset of set that does not contain its elements")
           (property . "subset")
           (input (set1 1 2 3) (set2 4 1 3))
           (expected . #f))))
     ((description
        .
        "Sets are disjoint if they share no elements")
       (cases
         ((description . "the empty set is disjoint with itself")
           (property . "disjoint")
           (input (set1) (set2))
           (expected . #t))
         ((description . "empty set is disjoint with non-empty set")
           (property . "disjoint")
           (input (set1) (set2 1))
           (expected . #t))
         ((description . "non-empty set is disjoint with empty set")
           (property . "disjoint")
           (input (set1 1) (set2))
           (expected . #t))
         ((description
            .
            "sets are not disjoint if they share an element")
           (property . "disjoint")
           (input (set1 1 2) (set2 2 3))
           (expected . #f))
         ((description
            .
            "sets are disjoint if they share no elements")
           (property . "disjoint")
           (input (set1 1 2) (set2 3 4))
           (expected . #t))))
     ((description . "Sets with the same elements are equal")
       (cases
         ((description . "empty sets are equal")
           (property . "equal")
           (input (set1) (set2))
           (expected . #t))
         ((description . "empty set is not equal to non-empty set")
           (property . "equal")
           (input (set1) (set2 1 2 3))
           (expected . #f))
         ((description . "non-empty set is not equal to empty set")
           (property . "equal")
           (input (set1 1 2 3) (set2))
           (expected . #f))
         ((description . "sets with the same elements are equal")
           (property . "equal")
           (input (set1 1 2) (set2 2 1))
           (expected . #t))
         ((description
            .
            "sets with different elements are not equal")
           (property . "equal")
           (input (set1 1 2 3) (set2 1 2 4))
           (expected . #f))
         ((description
            .
            "set is not equal to larger set with same elements")
           (property . "equal")
           (input (set1 1 2 3) (set2 1 2 3 4))
           (expected . #f))))
     ((description . "Unique elements can be added to a set")
       (cases
         ((description . "add to empty set")
           (property . "add")
           (input (set) (element . 3))
           (expected 3))
         ((description . "add to non-empty set")
           (property . "add")
           (input (set 1 2 4) (element . 3))
           (expected 1 2 3 4))
         ((description
            .
            "adding an existing element does not change the set")
           (property . "add")
           (input (set 1 2 3) (element . 3))
           (expected 1 2 3))))
     ((description
        .
        "Intersection returns a set of all shared elements")
       (cases
         ((description
            .
            "intersection of two empty sets is an empty set")
           (property . "intersection")
           (input (set1) (set2))
           (expected))
         ((description
            .
            "intersection of an empty set and non-empty set is an empty set")
           (property . "intersection")
           (input (set1) (set2 3 2 5))
           (expected))
         ((description
            .
            "intersection of a non-empty set and an empty set is an empty set")
           (property . "intersection")
           (input (set1 1 2 3 4) (set2))
           (expected))
         ((description
            .
            "intersection of two sets with no shared elements is an empty set")
           (property . "intersection")
           (input (set1 1 2 3) (set2 4 5 6))
           (expected))
         ((description
            .
            "intersection of two sets with shared elements is a set of the shared elements")
           (property . "intersection")
           (input (set1 1 2 3 4) (set2 3 2 5))
           (expected 2 3))))
     ((description
        .
        "Difference (or Complement) of a set is a set of all elements that are only in the first set")
       (cases
         ((description
            .
            "difference of two empty sets is an empty set")
           (property . "difference")
           (input (set1) (set2))
           (expected))
         ((description
            .
            "difference of empty set and non-empty set is an empty set")
           (property . "difference")
           (input (set1) (set2 3 2 5))
           (expected))
         ((description
            .
            "difference of a non-empty set and an empty set is the non-empty set")
           (property . "difference")
           (input (set1 1 2 3 4) (set2))
           (expected 1 2 3 4))
         ((description
            .
            "difference of two non-empty sets is a set of elements that are only in the first set")
           (property . "difference")
           (input (set1 3 2 1) (set2 2 4))
           (expected 1 3))))
     ((description
        .
        "Union returns a set of all elements in either set")
       (cases
         ((description . "union of empty sets is an empty set")
           (property . "union")
           (input (set1) (set2))
           (expected))
         ((description
            .
            "union of an empty set and non-empty set is the non-empty set")
           (property . "union")
           (input (set1) (set2 2))
           (expected 2))
         ((description
            .
            "union of a non-empty set and empty set is the non-empty set")
           (property . "union")
           (input (set1 1 3) (set2))
           (expected 1 3))
         ((description
            .
            "union of non-empty sets contains all unique elements")
           (property . "union")
           (input (set1 1 3) (set2 2 3))
           (expected 3 2 1))))))
 (resistor-color
   (exercise . "resistor-color")
   (version . "1.0.0")
   (cases
     ((description . "Color codes")
       (cases
         ((description . "Black")
           (property . "colorCode")
           (input (color . "black"))
           (expected . 0))
         ((description . "White")
           (property . "colorCode")
           (input (color . "white"))
           (expected . 9))
         ((description . "Orange")
           (property . "colorCode")
           (input (color . "orange"))
           (expected . 3))))
     ((description . "Colors")
       (property . "colors")
       (input)
       (expected "black" "brown" "red" "orange" "yellow" "green"
         "blue" "violet" "grey" "white"))))
 (sgf-parsing
   (exercise . "sgf-parsing")
   (version . "1.2.0")
   (cases
     ((description . "empty input")
       (property . "parse")
       (input (encoded . ""))
       (expected (error . "tree missing")))
     ((description . "tree with no nodes")
       (property . "parse")
       (input (encoded . "()"))
       (expected (error . "tree with no nodes")))
     ((description . "node without tree")
       (property . "parse")
       (input (encoded . ";"))
       (expected (error . "tree missing")))
     ((description . "node without properties")
       (property . "parse")
       (input (encoded . "(;)"))
       (expected (properties) (children)))
     ((description . "single node tree")
       (property . "parse")
       (input (encoded . "(;A[B])"))
       (expected (properties (A "B")) (children)))
     ((description . "multiple properties")
       (property . "parse")
       (input (encoded . "(;A[b]C[d])"))
       (expected (properties (A "b") (C "d")) (children)))
     ((description . "properties without delimiter")
       (property . "parse")
       (input (encoded . "(;A)"))
       (expected (error . "properties without delimiter")))
     ((description . "all lowercase property")
       (property . "parse")
       (input (encoded . "(;a[b])"))
       (expected (error . "property must be in uppercase")))
     ((description . "upper and lowercase property")
       (property . "parse")
       (input (encoded . "(;Aa[b])"))
       (expected (error . "property must be in uppercase")))
     ((description . "two nodes")
       (property . "parse")
       (input (encoded . "(;A[B];B[C])"))
       (expected
         (properties (A "B"))
         (children ((properties (B "C")) (children)))))
     ((description . "two child trees")
       (property . "parse")
       (input (encoded . "(;A[B](;B[C])(;C[D]))"))
       (expected
         (properties (A "B"))
         (children
           ((properties (B "C")) (children))
           ((properties (C "D")) (children)))))
     ((description . "multiple property values")
       (property . "parse")
       (input (encoded . "(;A[b][c][d])"))
       (expected (properties (A "b" "c" "d")) (children)))
     ((description . "escaped property")
       (property . "parse")
       (input (encoded . "(;A[\\]b\\nc\\nd\\t\\te \\n\\]])"))
       (expected
         (properties (A "]b\\nc\\nd  e \\n]"))
         (children)))))
 (queen-attack
   (exercise . "queen-attack")
   (version . "2.3.0")
   (comments
     "Testing invalid positions will vary by language. The expected"
     "value of 'error' is there to indicate some sort of failure should"
     "occur, while a 0 means no failure."
     "Some languages implement tests beyond this set, such as checking"
     "for two pieces being placed on the same position, representing"
     "the board graphically, or using standard chess notation. Those"
     "tests can be offered as extra credit")
   (cases
     ((description
        .
        "Test creation of Queens with valid and invalid positions")
       (cases
         ((description . "queen with a valid position")
           (property . "create")
           (input (queen (position (row . 2) (column . 2))))
           (expected . 0))
         ((description . "queen must have positive row")
           (property . "create")
           (input (queen (position (row . -2) (column . 2))))
           (expected (error . "row not positive")))
         ((description . "queen must have row on board")
           (property . "create")
           (input (queen (position (row . 8) (column . 4))))
           (expected (error . "row not on board")))
         ((description . "queen must have positive column")
           (property . "create")
           (input (queen (position (row . 2) (column . -2))))
           (expected (error . "column not positive")))
         ((description . "queen must have column on board")
           (property . "create")
           (input (queen (position (row . 4) (column . 8))))
           (expected (error . "column not on board")))))
     ((description
        .
        "Test the ability of one queen to attack another")
       (cases
         ((description . "can not attack")
           (property . "canAttack")
           (input
             (white_queen (position (row . 2) (column . 4)))
             (black_queen (position (row . 6) (column . 6))))
           (expected . #f))
         ((description . "can attack on same row")
           (property . "canAttack")
           (input
             (white_queen (position (row . 2) (column . 4)))
             (black_queen (position (row . 2) (column . 6))))
           (expected . #t))
         ((description . "can attack on same column")
           (property . "canAttack")
           (input
             (white_queen (position (row . 4) (column . 5)))
             (black_queen (position (row . 2) (column . 5))))
           (expected . #t))
         ((description . "can attack on first diagonal")
           (property . "canAttack")
           (input
             (white_queen (position (row . 2) (column . 2)))
             (black_queen (position (row . 0) (column . 4))))
           (expected . #t))
         ((description . "can attack on second diagonal")
           (property . "canAttack")
           (input
             (white_queen (position (row . 2) (column . 2)))
             (black_queen (position (row . 3) (column . 1))))
           (expected . #t))
         ((description . "can attack on third diagonal")
           (property . "canAttack")
           (input
             (white_queen (position (row . 2) (column . 2)))
             (black_queen (position (row . 1) (column . 1))))
           (expected . #t))
         ((description . "can attack on fourth diagonal")
           (property . "canAttack")
           (input
             (white_queen (position (row . 1) (column . 7)))
             (black_queen (position (row . 0) (column . 6))))
           (expected . #t))))))
 (diffie-hellman
   (exercise . "diffie-hellman")
   (version . "1.0.0")
   (comments "Optional tests to consider:" "* Validation of parameters:"
     "  Validate that `p`, `g` are valid."
     "  Validate that keys given as inputs are valid."
     "  Resources that show what happens if parameters are not validated:"
     "  http://cryptopals.com/sets/5/challenges/34"
     "  http://cryptopals.com/sets/5/challenges/35"
     "* Large numbers:"
     "  Although the calculations fundamentally do not require large numbers,"
     "  this is a reasonable real-world use for them"
     "  and it may be instructive to have an exercise on their use."
     "  Consult tracks with this exercise (such as the Go track) for possible inputs to use.")
   (cases
     ((description . "private key is in range 1 .. p")
       (property . "privateKeyIsInRange")
       (input)
       (expected (greaterThan . 1) (lessThan . "p")))
     ((description . "private key is random")
       (property . "privateKeyIsRandom")
       (input)
       (expected (random . #t)))
     ((description
        .
        "can calculate public key using private key")
       (property . "publicKey")
       (input (p . 23) (g . 5) (privateKey . 6))
       (expected . 8))
     ((description
        .
        "can calculate secret using other party's public key")
       (property . "secret")
       (input (p . 23) (theirPublicKey . 19) (myPrivateKey . 6))
       (expected . 2))
     ((description . "key exchange")
       (property . "keyExchange")
       (input (p . 23) (g . 5) (alicePrivateKey . "privateKey(p)")
         (bobPrivateKey . "privateKey(p)")
         (alicePublicKey . "publicKey(p, g, alicePrivateKey)")
         (bobPublicKey . "publicKey(p, g, bobPrivateKey)")
         (secretA . "secret(p, bobPublicKey, alicePrivateKey)")
         (secretB . "secret(p, alicePublicKey, bobPrivateKey)"))
       (expected . "secretA == secretB"))))
 (tournament
   (exercise . "tournament")
   (version . "1.4.0")
   (comments
     "The inputs and outputs are represented as arrays of strings to"
     "improve readability in this JSON file."
     "Your track may choose whether to present the input as a single"
     "string (concatenating all the lines) or as the list."
     "In most cases, it seems to make sense to expect the output as"
     "a single string.")
   (cases
     ((description . "just the header if no input")
       (property . "tally")
       (input (rows))
       (expected
         "Team                           | MP |  W |  D |  L |  P"))
     ((description
        .
        "a win is three points, a loss is zero points")
       (property . "tally")
       (input (rows "Allegoric Alaskans;Blithering Badgers;win"))
       (expected
         "Team                           | MP |  W |  D |  L |  P"
         "Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3"
         "Blithering Badgers             |  1 |  0 |  0 |  1 |  0"))
     ((description . "a win can also be expressed as a loss")
       (property . "tally")
       (input (rows "Blithering Badgers;Allegoric Alaskans;loss"))
       (expected
         "Team                           | MP |  W |  D |  L |  P"
         "Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3"
         "Blithering Badgers             |  1 |  0 |  0 |  1 |  0"))
     ((description . "a different team can win")
       (property . "tally")
       (input (rows "Blithering Badgers;Allegoric Alaskans;win"))
       (expected
         "Team                           | MP |  W |  D |  L |  P"
         "Blithering Badgers             |  1 |  1 |  0 |  0 |  3"
         "Allegoric Alaskans             |  1 |  0 |  0 |  1 |  0"))
     ((description . "a draw is one point each")
       (property . "tally")
       (input (rows "Allegoric Alaskans;Blithering Badgers;draw"))
       (expected
         "Team                           | MP |  W |  D |  L |  P"
         "Allegoric Alaskans             |  1 |  0 |  1 |  0 |  1"
         "Blithering Badgers             |  1 |  0 |  1 |  0 |  1"))
     ((description . "There can be more than one match")
       (property . "tally")
       (input
         (rows
           "Allegoric Alaskans;Blithering Badgers;win"
           "Allegoric Alaskans;Blithering Badgers;win"))
       (expected
         "Team                           | MP |  W |  D |  L |  P"
         "Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6"
         "Blithering Badgers             |  2 |  0 |  0 |  2 |  0"))
     ((description . "There can be more than one winner")
       (property . "tally")
       (input
         (rows
           "Allegoric Alaskans;Blithering Badgers;loss"
           "Allegoric Alaskans;Blithering Badgers;win"))
       (expected
         "Team                           | MP |  W |  D |  L |  P"
         "Allegoric Alaskans             |  2 |  1 |  0 |  1 |  3"
         "Blithering Badgers             |  2 |  1 |  0 |  1 |  3"))
     ((description . "There can be more than two teams")
       (property . "tally")
       (input
         (rows
           "Allegoric Alaskans;Blithering Badgers;win"
           "Blithering Badgers;Courageous Californians;win"
           "Courageous Californians;Allegoric Alaskans;loss"))
       (expected
         "Team                           | MP |  W |  D |  L |  P"
         "Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6"
         "Blithering Badgers             |  2 |  1 |  0 |  1 |  3"
         "Courageous Californians        |  2 |  0 |  0 |  2 |  0"))
     ((description . "typical input")
       (property . "tally")
       (input
         (rows "Allegoric Alaskans;Blithering Badgers;win"
           "Devastating Donkeys;Courageous Californians;draw"
           "Devastating Donkeys;Allegoric Alaskans;win"
           "Courageous Californians;Blithering Badgers;loss"
           "Blithering Badgers;Devastating Donkeys;loss"
           "Allegoric Alaskans;Courageous Californians;win"))
       (expected "Team                           | MP |  W |  D |  L |  P"
         "Devastating Donkeys            |  3 |  2 |  1 |  0 |  7"
         "Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6"
         "Blithering Badgers             |  3 |  1 |  0 |  2 |  3"
         "Courageous Californians        |  3 |  0 |  1 |  2 |  1"))
     ((description
        .
        "incomplete competition (not all pairs have played)")
       (property . "tally")
       (input
         (rows
           "Allegoric Alaskans;Blithering Badgers;loss"
           "Devastating Donkeys;Allegoric Alaskans;loss"
           "Courageous Californians;Blithering Badgers;draw"
           "Allegoric Alaskans;Courageous Californians;win"))
       (expected "Team                           | MP |  W |  D |  L |  P"
         "Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6"
         "Blithering Badgers             |  2 |  1 |  1 |  0 |  4"
         "Courageous Californians        |  2 |  0 |  1 |  1 |  1"
         "Devastating Donkeys            |  1 |  0 |  0 |  1 |  0"))
     ((description . "ties broken alphabetically")
       (property . "tally")
       (input
         (rows "Courageous Californians;Devastating Donkeys;win"
           "Allegoric Alaskans;Blithering Badgers;win"
           "Devastating Donkeys;Allegoric Alaskans;loss"
           "Courageous Californians;Blithering Badgers;win"
           "Blithering Badgers;Devastating Donkeys;draw"
           "Allegoric Alaskans;Courageous Californians;draw"))
       (expected "Team                           | MP |  W |  D |  L |  P"
         "Allegoric Alaskans             |  3 |  2 |  1 |  0 |  7"
         "Courageous Californians        |  3 |  2 |  1 |  0 |  7"
         "Blithering Badgers             |  3 |  0 |  1 |  2 |  1"
         "Devastating Donkeys            |  3 |  0 |  1 |  2 |  1"))))
 (transpose
   (exercise . "transpose")
   (version . "1.1.0")
   (comments
     "JSON doesn't allow for multi-line strings, so all multi-line input is "
     "presented here as arrays of strings. It's up to the test generator to join the "
     "lines together with line breaks.")
   (cases
     ((description . "empty string")
       (property . "transpose")
       (input (lines))
       (expected))
     ((description . "two characters in a row")
       (property . "transpose")
       (input (lines "A1"))
       (expected "A" "1"))
     ((description . "two characters in a column")
       (property . "transpose")
       (input (lines "A" "1"))
       (expected "A1"))
     ((description . "simple")
       (property . "transpose")
       (input (lines "ABC" "123"))
       (expected "A1" "B2" "C3"))
     ((description . "single line")
       (property . "transpose")
       (input (lines "Single line."))
       (expected "S" "i" "n" "g" "l" "e" " " "l" "i" "n" "e" "."))
     ((description . "first line longer than second line")
       (property . "transpose")
       (input (lines "The fourth line." "The fifth line."))
       (expected "TT" "hh" "ee" "  " "ff" "oi" "uf" "rt" "th" "h "
         " l" "li" "in" "ne" "e." "."))
     ((description . "second line longer than first line")
       (property . "transpose")
       (input (lines "The first line." "The second line."))
       (expected "TT" "hh" "ee" "  " "fs" "ie" "rc" "so" "tn" " d"
         "l " "il" "ni" "en" ".e" " ."))
     ((description . "mixed line length")
       (property . "transpose")
       (input
         (lines
           "The longest line."
           "A long line."
           "A longer line."
           "A line."))
       (expected "TAAA" "h   " "elll" " ooi" "lnnn" "ogge" "n e."
         "glr" "ei " "snl" "tei" " .n" "l e" "i ." "n" "e" "."))
     ((description . "square")
       (property . "transpose")
       (input (lines "HEART" "EMBER" "ABUSE" "RESIN" "TREND"))
       (expected "HEART" "EMBER" "ABUSE" "RESIN" "TREND"))
     ((description . "rectangle")
       (property . "transpose")
       (input (lines "FRACTURE" "OUTLINED" "BLOOMING" "SEPTETTE"))
       (expected "FOBS" "RULE" "ATOP" "CLOT" "TIME" "UNIT" "RENT"
         "EDGE"))
     ((description . "triangle")
       (property . "transpose")
       (input (lines "T" "EE" "AAA" "SSSS" "EEEEE" "RRRRRR"))
       (expected "TEASER" " EASER" "  ASER" "   SER" "    ER"
         "     R"))))
 (list-ops
   (exercise . "list-ops")
   (version . "2.4.1")
   (comments
     "Though there are no specifications here for dealing with large lists,"
     "implementers may add tests for handling large lists to ensure that the"
     "solutions have thought about performance concerns.")
   (cases
     ((description
        .
        "append entries to a list and return the new list")
       (cases
         ((description . "empty lists")
           (property . "append")
           (input (list1) (list2))
           (expected))
         ((description . "list to empty list")
           (property . "append")
           (input (list1) (list2 1 2 3 4))
           (expected 1 2 3 4))
         ((description . "non-empty lists")
           (property . "append")
           (input (list1 1 2) (list2 2 3 4 5))
           (expected 1 2 2 3 4 5))))
     ((description . "concatenate a list of lists")
       (cases
         ((description . "empty list")
           (property . "concat")
           (input (lists))
           (expected))
         ((description . "list of lists")
           (property . "concat")
           (input (lists (1 2) (3) () (4 5 6)))
           (expected 1 2 3 4 5 6))
         ((description . "list of nested lists")
           (property . "concat")
           (input (lists ((1) (2)) ((3)) (()) ((4 5 6))))
           (expected (1) (2) (3) () (4 5 6)))))
     ((description
        .
        "filter list returning only values that satisfy the filter function")
       (cases
         ((description . "empty list")
           (property . "filter")
           (input (list) (function . "(x) -> x modulo 2 == 1"))
           (expected))
         ((description . "non-empty list")
           (property . "filter")
           (input (list 1 2 3 5) (function . "(x) -> x modulo 2 == 1"))
           (expected 1 3 5))))
     ((description . "returns the length of a list")
       (cases
         ((description . "empty list")
           (property . "length")
           (input (list))
           (expected . 0))
         ((description . "non-empty list")
           (property . "length")
           (input (list 1 2 3 4))
           (expected . 4))))
     ((description
        .
        "return a list of elements whose values equal the list value transformed by the mapping function")
       (cases
         ((description . "empty list")
           (property . "map")
           (input (list) (function . "(x) -> x + 1"))
           (expected))
         ((description . "non-empty list")
           (property . "map")
           (input (list 1 3 5 7) (function . "(x) -> x + 1"))
           (expected 2 4 6 8))))
     ((description
        .
        "folds (reduces) the given list from the left with a function")
       (cases
         ((description . "empty list")
           (property . "foldl")
           (input (list) (initial . 2) (function . "(x, y) -> x * y"))
           (expected . 2))
         ((description
            .
            "direction independent function applied to non-empty list")
           (property . "foldl")
           (input
             (list 1 2 3 4)
             (initial . 5)
             (function . "(x, y) -> x + y"))
           (expected . 15))
         ((description
            .
            "direction dependent function applied to non-empty list")
           (property . "foldl")
           (input
             (list 2 5)
             (initial . 5)
             (function . "(x, y) -> x / y"))
           (expected . 0))))
     ((description
        .
        "folds (reduces) the given list from the right with a function")
       (cases
         ((description . "empty list")
           (property . "foldr")
           (input (list) (initial . 2) (function . "(x, y) -> x * y"))
           (expected . 2))
         ((description
            .
            "direction independent function applied to non-empty list")
           (property . "foldr")
           (input
             (list 1 2 3 4)
             (initial . 5)
             (function . "(x, y) -> x + y"))
           (expected . 15))
         ((description
            .
            "direction dependent function applied to non-empty list")
           (property . "foldr")
           (input
             (list 2 5)
             (initial . 5)
             (function . "(x, y) -> x / y"))
           (expected . 2))))
     ((description . "reverse the elements of the list")
       (cases
         ((description . "empty list")
           (property . "reverse")
           (input (list))
           (expected))
         ((description . "non-empty list")
           (property . "reverse")
           (input (list 1 3 5 7))
           (expected 7 5 3 1))
         ((description . "list of lists is not flattened")
           (property . "reverse")
           (input (list (1 2) (3) () (4 5 6)))
           (expected (4 5 6) () (3) (1 2)))))))
 (largest-series-product
   (exercise . "largest-series-product")
   (version . "1.2.0")
   (comments "Different languages may handle errors differently."
     "e.g. raise exceptions, return (int, error), return Option<int>, etc."
     "Some languages specifically test the string->digits conversion"
     "and the 'slices of size N' operation."
     "These cases *deliberately* do not cover those two operations."
     "Those are implementation details."
     "Testing them constrains implementations,"
     "and not all implementations use these operations."
     "e.g. The implementation which makes a single pass through the digits.")
   (cases
     ((description
        .
        "finds the largest product if span equals length")
       (property . "largestProduct")
       (input (digits . "29") (span . 2))
       (expected . 18))
     ((description
        .
        "can find the largest product of 2 with numbers in order")
       (property . "largestProduct")
       (input (digits . "0123456789") (span . 2))
       (expected . 72))
     ((description . "can find the largest product of 2")
       (property . "largestProduct")
       (input (digits . "576802143") (span . 2))
       (expected . 48))
     ((description
        .
        "can find the largest product of 3 with numbers in order")
       (property . "largestProduct")
       (input (digits . "0123456789") (span . 3))
       (expected . 504))
     ((description . "can find the largest product of 3")
       (property . "largestProduct")
       (input (digits . "1027839564") (span . 3))
       (expected . 270))
     ((description
        .
        "can find the largest product of 5 with numbers in order")
       (property . "largestProduct")
       (input (digits . "0123456789") (span . 5))
       (expected . 15120))
     ((description
        .
        "can get the largest product of a big number")
       (property . "largestProduct")
       (input
         (digits
           .
           "73167176531330624919225119674426574742355349194934")
         (span . 6))
       (expected . 23520))
     ((description . "reports zero if the only digits are zero")
       (property . "largestProduct")
       (input (digits . "0000") (span . 2))
       (expected . 0))
     ((description . "reports zero if all spans include zero")
       (property . "largestProduct")
       (input (digits . "99099") (span . 3))
       (expected . 0))
     ((description . "rejects span longer than string length")
       (property . "largestProduct")
       (input (digits . "123") (span . 4))
       (expected
         (error . "span must be smaller than string length")))
     ((comments
        "There may be some confusion about whether this should be 1 or error."
        "The reasoning for it being 1 is this:"
        "There is one 0-character string contained in the empty string."
        "That's the empty string itself."
        "The empty product is 1 (the identity for multiplication)."
        "Therefore LSP('', 0) is 1."
        "It's NOT the case that LSP('', 0) takes max of an empty list."
        "So there is no error." "Compare against LSP('123', 4):"
        "There are zero 4-character strings in '123'."
        "So LSP('123', 4) really DOES take the max of an empty list."
        "So LSP('123', 4) errors and LSP('', 0) does NOT.")
       (description
         .
         "reports 1 for empty string and empty product (0 span)")
       (property . "largestProduct")
       (input (digits . "") (span . 0))
       (expected . 1))
     ((comments
        "As above, there is one 0-character string in '123'."
        "So again no error. It's the empty product, 1.")
       (description
         .
         "reports 1 for nonempty string and empty product (0 span)")
       (property . "largestProduct")
       (input (digits . "123") (span . 0))
       (expected . 1))
     ((description . "rejects empty string and nonzero span")
       (property . "largestProduct")
       (input (digits . "") (span . 1))
       (expected
         (error . "span must be smaller than string length")))
     ((description . "rejects invalid character in digits")
       (property . "largestProduct")
       (input (digits . "1234a5") (span . 2))
       (expected
         (error . "digits input must only contain digits")))
     ((description . "rejects negative span")
       (property . "largestProduct")
       (input (digits . "12345") (span . -1))
       (expected (error . "span must be greater than zero")))))
 (minesweeper
   (exercise . "minesweeper")
   (version . "1.1.0")
   (comments
     " The expected outputs are represented as arrays of strings to   "
     " improve readability in this JSON file.                         "
     " Your track may choose whether to present the input as a single "
     " string (concatenating all the lines) or as the list.           ")
   (cases
     ((description . "no rows")
       (property . "annotate")
       (input (minefield))
       (expected))
     ((description . "no columns")
       (property . "annotate")
       (input (minefield ""))
       (expected ""))
     ((description . "no mines")
       (property . "annotate")
       (input (minefield "   " "   " "   "))
       (expected "   " "   " "   "))
     ((description . "minefield with only mines")
       (property . "annotate")
       (input (minefield "***" "***" "***"))
       (expected "***" "***" "***"))
     ((description . "mine surrounded by spaces")
       (property . "annotate")
       (input (minefield "   " " * " "   "))
       (expected "111" "1*1" "111"))
     ((description . "space surrounded by mines")
       (property . "annotate")
       (input (minefield "***" "* *" "***"))
       (expected "***" "*8*" "***"))
     ((description . "horizontal line")
       (property . "annotate")
       (input (minefield " * * "))
       (expected "1*2*1"))
     ((description . "horizontal line, mines at edges")
       (property . "annotate")
       (input (minefield "*   *"))
       (expected "*1 1*"))
     ((description . "vertical line")
       (property . "annotate")
       (input (minefield " " "*" " " "*" " "))
       (expected "1" "*" "2" "*" "1"))
     ((description . "vertical line, mines at edges")
       (property . "annotate")
       (input (minefield "*" " " " " " " "*"))
       (expected "*" "1" " " "1" "*"))
     ((description . "cross")
       (property . "annotate")
       (input (minefield "  *  " "  *  " "*****" "  *  " "  *  "))
       (expected " 2*2 " "25*52" "*****" "25*52" " 2*2 "))
     ((description . "large minefield")
       (property . "annotate")
       (input
         (minefield " *  * " "  *   " "    * " "   * *" " *  * "
           "      "))
       (expected "1*22*1" "12*322" " 123*2" "112*4*" "1*22*2"
         "111111"))))
 (run-length-encoding
   (exercise . "run-length-encoding")
   (version . "1.1.0")
   (cases
     ((description . "run-length encode a string")
       (cases
         ((description . "empty string")
           (property . "encode")
           (input (string . ""))
           (expected . ""))
         ((description
            .
            "single characters only are encoded without count")
           (property . "encode")
           (input (string . "XYZ"))
           (expected . "XYZ"))
         ((description . "string with no single characters")
           (property . "encode")
           (input (string . "AABBBCCCC"))
           (expected . "2A3B4C"))
         ((description
            .
            "single characters mixed with repeated characters")
           (property . "encode")
           (input
             (string
               .
               "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"))
           (expected . "12WB12W3B24WB"))
         ((description . "multiple whitespace mixed in string")
           (property . "encode")
           (input (string . "  hsqq qww  "))
           (expected . "2 hs2q q2w2 "))
         ((description . "lowercase characters")
           (property . "encode")
           (input (string . "aabbbcccc"))
           (expected . "2a3b4c"))))
     ((description . "run-length decode a string")
       (cases
         ((description . "empty string")
           (property . "decode")
           (input (string . ""))
           (expected . ""))
         ((description . "single characters only")
           (property . "decode")
           (input (string . "XYZ"))
           (expected . "XYZ"))
         ((description . "string with no single characters")
           (property . "decode")
           (input (string . "2A3B4C"))
           (expected . "AABBBCCCC"))
         ((description
            .
            "single characters with repeated characters")
           (property . "decode")
           (input (string . "12WB12W3B24WB"))
           (expected
             .
             "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"))
         ((description . "multiple whitespace mixed in string")
           (property . "decode")
           (input (string . "2 hs2q q2w2 "))
           (expected . "  hsqq qww  "))
         ((description . "lower case string")
           (property . "decode")
           (input (string . "2a3b4c"))
           (expected . "aabbbcccc"))))
     ((description . "encode and then decode")
       (cases
         ((description
            .
            "encode followed by decode gives original string")
           (property . "consistency")
           (input (string . "zzz ZZ  zZ"))
           (expected . "zzz ZZ  zZ"))))))
 (gigasecond
   (exercise . "gigasecond")
   (version . "2.0.0")
   (comments
     "The basic test is to add one gigasecond to a few ordinary dates."
     "Most test programs currently check only the date and ignore the time."
     "For languages with a native date-time type though, expected times"
     "here show the correct seconds, ignoring leap seconds."
     "The date and time formats here are per"
     "http://www.ecma-international.org/ecma-262/5.1/#sec-15.9.1.15."
     "" "Finally, as a demonstration but not really a test,"
     "some languages demonstrate the add function by inviting the"
     "solver to include their birthdate in either the solution code"
     "or test program.  The test program then shows or tests their"
     "gigasecond anniversary.")
   (cases
     ((description . "Add one gigasecond to the input.")
       (cases
         ((description . "date only specification of time")
           (property . "add")
           (input (moment . "2011-04-25"))
           (expected . "2043-01-01T01:46:40"))
         ((description
            .
            "second test for date only specification of time")
           (property . "add")
           (input (moment . "1977-06-13"))
           (expected . "2009-02-19T01:46:40"))
         ((description
            .
            "third test for date only specification of time")
           (property . "add")
           (input (moment . "1959-07-19"))
           (expected . "1991-03-27T01:46:40"))
         ((description . "full time specified")
           (property . "add")
           (input (moment . "2015-01-24T22:00:00"))
           (expected . "2046-10-02T23:46:40"))
         ((description . "full time with day roll-over")
           (property . "add")
           (input (moment . "2015-01-24T23:59:59"))
           (expected . "2046-10-03T01:46:39"))))))
 (yacht
   (exercise . "yacht")
   (version . "1.2.0")
   (comments
     "The dice are represented always as a list of exactly five integers"
     "with values between 1 and 6 inclusive. The category is an string."
     "the categories are 'ones' to 'sixes'," "Then 'full house',"
     "     'four of a kind'" "     'little straight' 1-5"
     "     'big straight' 2-6"
     "     'choice', sometimes called Chance"
     "     'yacht', or five of a kind")
   (cases
    ((description . "Yacht")
      (property . "score")
      (input (dice 5 5 5 5 5) (category . "yacht"))
      (expected . 50))
    ((description . "Not Yacht")
      (property . "score")
      (input (dice 1 3 3 2 5) (category . "yacht"))
      (expected . 0))
    ((description . "Ones")
      (property . "score")
      (input (dice 1 1 1 3 5) (category . "ones"))
      (expected . 3))
    ((description . "Ones, out of order")
      (property . "score")
      (input (dice 3 1 1 5 1) (category . "ones"))
      (expected . 3))
    ((description . "No ones")
      (property . "score")
      (input (dice 4 3 6 5 5) (category . "ones"))
      (expected . 0))
    ((description . "Twos")
      (property . "score")
      (input (dice 2 3 4 5 6) (category . "twos"))
      (expected . 2))
    ((description . "Fours")
      (property . "score")
      (input (dice 1 4 1 4 1) (category . "fours"))
      (expected . 8))
    ((description . "Yacht counted as threes")
      (property . "score")
      (input (dice 3 3 3 3 3) (category . "threes"))
      (expected . 15))
    ((description . "Yacht of 3s counted as fives")
      (property . "score")
      (input (dice 3 3 3 3 3) (category . "fives"))
      (expected . 0))
    ((description . "Sixes")
      (property . "score")
      (input (dice 2 3 4 5 6) (category . "sixes"))
      (expected . 6))
    ((description . "Full house two small, three big")
      (property . "score")
      (input (dice 2 2 4 4 4) (category . "full house"))
      (expected . 16))
    ((description . "Full house three small, two big")
      (property . "score")
      (input (dice 5 3 3 5 3) (category . "full house"))
      (expected . 19))
    ((description . "Two pair is not a full house")
      (property . "score")
      (input (dice 2 2 4 4 5) (category . "full house"))
      (expected . 0))
    ((description . "Four of a kind is not a full house")
      (property . "score")
      (input (dice 1 4 4 4 4) (category . "full house"))
      (expected . 0))
    ((description . "Yacht is not a full house")
      (property . "score")
      (input (dice 2 2 2 2 2) (category . "full house"))
      (expected . 0))
    ((description . "Four of a Kind")
      (property . "score")
      (input (dice 6 6 4 6 6) (category . "four of a kind"))
      (expected . 24))
    ((description . "Yacht can be scored as Four of a Kind")
      (property . "score")
      (input (dice 3 3 3 3 3) (category . "four of a kind"))
      (expected . 12))
    ((description . "Full house is not Four of a Kind")
      (property . "score")
      (input (dice 3 3 3 5 5) (category . "four of a kind"))
      (expected . 0))
    ((description . "Little Straight")
      (property . "score")
      (input (dice 3 5 4 1 2) (category . "little straight"))
      (expected . 30))
    ((description . "Little Straight as Big Straight")
      (property . "score")
      (input (dice 1 2 3 4 5) (category . "big straight"))
      (expected . 0))
    ((description . "Four in order but not a little straight")
      (property . "score")
      (input (dice 1 1 2 3 4) (category . "little straight"))
      (expected . 0))
    ((description . "No pairs but not a little straight")
      (property . "score")
      (input (dice 1 2 3 4 6) (category . "little straight"))
      (expected . 0))
    ((description
       .
       "Minimum is 1, maximum is 5, but not a little straight")
      (property . "score")
      (input (dice 1 1 3 4 5) (category . "little straight"))
      (expected . 0))
    ((description . "Big Straight")
      (property . "score")
      (input (dice 4 6 2 5 3) (category . "big straight"))
      (expected . 30))
    ((description . "Big Straight as little straight")
      (property . "score")
      (input (dice 6 5 4 3 2) (category . "little straight"))
      (expected . 0))
    ((description . "No pairs but not a big straight")
      (property . "score")
      (input (dice 6 5 4 3 1) (category . "big straight"))
      (expected . 0))
    ((description . "Choice")
      (property . "score")
      (input (dice 3 3 5 6 6) (category . "choice"))
      (expected . 23))
    ((description . "Yacht as choice")
      (property . "score")
      (input (dice 2 2 2 2 2) (category . "choice"))
      (expected . 10))))
 (pascals-triangle
   (exercise . "pascals-triangle")
   (version . "1.5.0")
   (comments
     "Expectations are represented here as an array of arrays."
     "How you represent this idiomatically in your language is up to you.")
   (cases
     ((description
        .
        "Given a count, return a collection of that many rows of pascal's triangle")
       (cases
         ((description . "zero rows")
           (property . "rows")
           (input (count . 0))
           (expected))
         ((description . "single row")
           (property . "rows")
           (input (count . 1))
           (expected (1)))
         ((description . "two rows")
           (property . "rows")
           (input (count . 2))
           (expected (1) (1 1)))
         ((description . "three rows")
           (property . "rows")
           (input (count . 3))
           (expected (1) (1 1) (1 2 1)))
         ((description . "four rows")
           (property . "rows")
           (input (count . 4))
           (expected (1) (1 1) (1 2 1) (1 3 3 1)))
         ((description . "five rows")
           (property . "rows")
           (input (count . 5))
           (expected (1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1)))
         ((description . "six rows")
           (property . "rows")
           (input (count . 6))
           (expected (1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1)
             (1 5 10 10 5 1)))
         ((description . "ten rows")
           (property . "rows")
           (input (count . 10))
           (expected (1) (1 1) (1 2 1) (1 3 3 1) (1 4 6 4 1) (1 5 10 10 5 1)
             (1 6 15 20 15 6 1) (1 7 21 35 35 21 7 1)
             (1 8 28 56 70 56 28 8 1) (1 9 36 84 126 126 84 36 9 1)))))))
 (crypto-square
   (exercise . "crypto-square")
   (version . "3.2.0")
   (cases
     ((description
        .
        "empty plaintext results in an empty ciphertext")
       (property . "ciphertext")
       (input (plaintext . ""))
       (expected . ""))
     ((description . "Lowercase")
       (property . "ciphertext")
       (input (plaintext . "A"))
       (expected . "a"))
     ((description . "Remove spaces")
       (property . "ciphertext")
       (input (plaintext . "  b "))
       (expected . "b"))
     ((description . "Remove punctuation")
       (property . "ciphertext")
       (input (plaintext . "@1,%!"))
       (expected . "1"))
     ((description
        .
        "9 character plaintext results in 3 chunks of 3 characters")
       (property . "ciphertext")
       (input (plaintext . "This is fun!"))
       (expected . "tsf hiu isn"))
     ((description
        .
        "8 character plaintext results in 3 chunks, the last one with a trailing space")
       (property . "ciphertext")
       (input (plaintext . "Chill out."))
       (expected . "clu hlt io "))
     ((description
        .
        "54 character plaintext results in 7 chunks, the last two with trailing spaces")
       (property . "ciphertext")
       (input
         (plaintext
           .
           "If man was meant to stay on the ground, god would have given us roots."))
       (expected
         .
         "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "))))
 (bowling
   (exercise . "bowling")
   (version . "1.2.0")
   (comments "Students should implement roll and score methods."
     "Roll should accept a single integer."
     "Score should return the game's final score, when possible"
     "For brevity the tests display all the previous rolls in an array;"
     "each element of the previousRolls array should be passed to the roll method"
     "and each of those previous rolls is expected to succeed."
     "" "Two properties are tested:" ""
     "`score`: All rolls succeed, and taking the score gives the expected result."
     "The expected result may be an integer score or an error."
     ""
     "`roll`: All previousRolls succeed, and rolling the number of pins in `roll` produces the expected result."
     "Currently, all cases of this type result in errors." ""
     "In all error cases you should expect an error as is idiomatic for your language"
     "whether that be via exceptions, optional values, or otherwise.")
   (cases
    ((description
       .
       "should be able to score a game with all zeros")
      (property . "score")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
      (expected . 0))
    ((description
       .
       "should be able to score a game with no strikes or spares")
      (property . "score")
      (input
        (previousRolls 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6))
      (expected . 90))
    ((description
       .
       "a spare followed by zeros is worth ten points")
      (property . "score")
      (input
        (previousRolls 6 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
      (expected . 10))
    ((description
       .
       "points scored in the roll after a spare are counted twice")
      (property . "score")
      (input
        (previousRolls 6 4 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
      (expected . 16))
    ((description
       .
       "consecutive spares each get a one roll bonus")
      (property . "score")
      (input
        (previousRolls 5 5 3 7 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
      (expected . 31))
    ((description
       .
       "a spare in the last frame gets a one roll bonus that is counted once")
      (property . "score")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 7))
      (expected . 17))
    ((description
       .
       "a strike earns ten points in a frame with a single roll")
      (property . "score")
      (input
        (previousRolls 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
      (expected . 10))
    ((description
       .
       "points scored in the two rolls after a strike are counted twice as a bonus")
      (property . "score")
      (input
        (previousRolls 10 5 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
      (expected . 26))
    ((description
       .
       "consecutive strikes each get the two roll bonus")
      (property . "score")
      (input (previousRolls 10 10 10 5 3 0 0 0 0 0 0 0 0 0 0 0 0))
      (expected . 81))
    ((description
       .
       "a strike in the last frame gets a two roll bonus that is counted once")
      (property . "score")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 1))
      (expected . 18))
    ((description
       .
       "rolling a spare with the two roll bonus does not get a bonus roll")
      (property . "score")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 3))
      (expected . 20))
    ((description
       .
       "strikes with the two roll bonus do not get bonus rolls")
      (property . "score")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10
         10))
      (expected . 30))
    ((description
       .
       "a strike with the one roll bonus after a spare in the last frame does not get a bonus")
      (property . "score")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 10))
      (expected . 20))
    ((description . "all strikes is a perfect game")
      (property . "score")
      (input (previousRolls 10 10 10 10 10 10 10 10 10 10 10 10))
      (expected . 300))
    ((description . "rolls cannot score negative points")
      (property . "roll")
      (input (previousRolls) (roll . -1))
      (expected (error . "Negative roll is invalid")))
    ((description . "a roll cannot score more than 10 points")
      (property . "roll")
      (input (previousRolls) (roll . 11))
      (expected (error . "Pin count exceeds pins on the lane")))
    ((description
       .
       "two rolls in a frame cannot score more than 10 points")
      (property . "roll")
      (input (previousRolls 5) (roll . 6))
      (expected (error . "Pin count exceeds pins on the lane")))
    ((description
       .
       "bonus roll after a strike in the last frame cannot score more than 10 points")
      (property . "roll")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10)
        (roll . 11))
      (expected (error . "Pin count exceeds pins on the lane")))
    ((description
       .
       "two bonus rolls after a strike in the last frame cannot score more than 10 points")
      (property . "roll")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 5)
        (roll . 6))
      (expected (error . "Pin count exceeds pins on the lane")))
    ((description
       .
       "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike")
      (property . "score")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 6))
      (expected . 26))
    ((description
       .
       "the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike")
      (property . "roll")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 6)
        (roll . 10))
      (expected (error . "Pin count exceeds pins on the lane")))
    ((description
       .
       "second bonus roll after a strike in the last frame cannot score more than 10 points")
      (property . "roll")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10)
        (roll . 11))
      (expected (error . "Pin count exceeds pins on the lane")))
    ((description . "an unstarted game cannot be scored")
      (property . "score")
      (input (previousRolls))
      (expected
        (error .
          "Score cannot be taken until the end of the game")))
    ((description . "an incomplete game cannot be scored")
      (property . "score")
      (input (previousRolls 0 0))
      (expected
        (error .
          "Score cannot be taken until the end of the game")))
    ((description
       .
       "cannot roll if game already has ten frames")
      (property . "roll")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
        (roll . 0))
      (expected (error . "Cannot roll after game is over")))
    ((description
       .
       "bonus rolls for a strike in the last frame must be rolled before score can be calculated")
      (property . "score")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10))
      (expected
        (error .
          "Score cannot be taken until the end of the game")))
    ((description
       .
       "both bonus rolls for a strike in the last frame must be rolled before score can be calculated")
      (property . "score")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10))
      (expected
        (error .
          "Score cannot be taken until the end of the game")))
    ((description
       .
       "bonus roll for a spare in the last frame must be rolled before score can be calculated")
      (property . "score")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3))
      (expected
        (error .
          "Score cannot be taken until the end of the game")))
    ((description . "cannot roll after bonus roll for spare")
      (property . "roll")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 2)
        (roll . 2))
      (expected (error . "Cannot roll after game is over")))
    ((description . "cannot roll after bonus rolls for strike")
      (property . "roll")
      (input
        (previousRolls 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 3 2)
        (roll . 2))
      (expected (error . "Cannot roll after game is over")))))
 (etl (exercise . "etl")
      (version . "2.0.1")
      (cases
        ((comments
           "Transforms a set of legacy Scrabble data stored as letters per score"
           "to a set of data stored score per letter."
           "Note:  The expected input data for these tests should have"
           "integer keys (not stringified numbers as shown in the JSON below"
           "Unless the language prohibits that, please implement these tests"
           "such that keys are integers. e.g. in JavaScript, it might look "
           "like `transform( { 1: ['A'] } );`")
          (description . "Transform legacy to new")
          (cases
            ((description . "single letter")
              (property . "transform")
              (input (legacy (\x31; "A")))
              (expected (a . 1)))
            ((description . "single score with multiple letters")
              (property . "transform")
              (input (legacy (\x31; "A" "E" "I" "O" "U")))
              (expected (a . 1) (e . 1) (i . 1) (o . 1) (u . 1)))
            ((description . "multiple scores with multiple letters")
              (property . "transform")
              (input (legacy (\x31; "A" "E") (\x32; "D" "G")))
              (expected (a . 1) (d . 2) (e . 1) (g . 2)))
            ((description
               .
               "multiple scores with differing numbers of letters")
              (property . "transform")
              (input
                (legacy (\x31; "A" "E" "I" "O" "U" "L" "N" "R" "S" "T")
                  (\x32; "D" "G") (\x33; "B" "C" "M" "P")
                  (\x34; "F" "H" "V" "W" "Y") (\x35; "K") (\x38; "J" "X")
                  (\x31;0 "Q" "Z")))
              (expected (a . 1) (b . 3) (c . 3) (d . 2) (e . 1) (f . 4)
               (g . 2) (h . 4) (i . 1) (j . 8) (k . 5) (l . 1) (m . 3)
               (n . 1) (o . 1) (p . 3) (q . 10) (r . 1) (s . 1) (t . 1)
               (u . 1) (v . 4) (w . 4) (x . 8) (y . 4) (z . 10)))))))
 (markdown
   (exercise . "markdown")
   (version . "1.4.0")
   (comments
     "Markdown is a shorthand for creating HTML from text strings.")
   (cases
     ((description . "parses normal text as a paragraph")
       (property . "parse")
       (input (markdown . "This will be a paragraph"))
       (expected . "<p>This will be a paragraph</p>"))
     ((description . "parsing italics")
       (property . "parse")
       (input (markdown . "_This will be italic_"))
       (expected . "<p><em>This will be italic</em></p>"))
     ((description . "parsing bold text")
       (property . "parse")
       (input (markdown . "__This will be bold__"))
       (expected . "<p><strong>This will be bold</strong></p>"))
     ((description . "mixed normal, italics and bold text")
       (property . "parse")
       (input (markdown . "This will _be_ __mixed__"))
       (expected
         .
         "<p>This will <em>be</em> <strong>mixed</strong></p>"))
     ((description . "with h1 header level")
       (property . "parse")
       (input (markdown . "# This will be an h1"))
       (expected . "<h1>This will be an h1</h1>"))
     ((description . "with h2 header level")
       (property . "parse")
       (input (markdown . "## This will be an h2"))
       (expected . "<h2>This will be an h2</h2>"))
     ((description . "with h6 header level")
       (property . "parse")
       (input (markdown . "###### This will be an h6"))
       (expected . "<h6>This will be an h6</h6>"))
     ((description . "unordered lists")
       (property . "parse")
       (input (markdown . "* Item 1\n* Item 2"))
       (expected . "<ul><li>Item 1</li><li>Item 2</li></ul>"))
     ((description . "With a little bit of everything")
       (property . "parse")
       (input
         (markdown . "# Header!\n* __Bold Item__\n* _Italic Item_"))
       (expected
         .
         "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"))
     ((description
        .
        "with markdown symbols in the header text that should not be interpreted")
       (property . "parse")
       (input
         (markdown . "# This is a header with # and * in the text"))
       (expected
         .
         "<h1>This is a header with # and * in the text</h1>"))
     ((description
        .
        "with markdown symbols in the list item text that should not be interpreted")
       (property . "parse")
       (input
         (markdown
           .
           "* Item 1 with a # in the text\n* Item 2 with * in the text"))
       (expected
         .
         "<ul><li>Item 1 with a # in the text</li><li>Item 2 with * in the text</li></ul>"))
     ((description
        .
        "with markdown symbols in the paragraph text that should not be interpreted")
       (property . "parse")
       (input
         (markdown . "This is a paragraph with # and * in the text"))
       (expected
         .
         "<p>This is a paragraph with # and * in the text</p>"))
     ((description
        .
        "unordered lists close properly with preceding and following lines")
       (property . "parse")
       (input
         (markdown
           .
           "# Start a list\n* Item 1\n* Item 2\nEnd a list"))
       (expected
         .
         "<h1>Start a list</h1><ul><li>Item 1</li><li>Item 2</li></ul><p>End a list</p>"))))
 (nucleotide-count
   (exercise . "nucleotide-count")
   (version . "1.3.0")
   (cases
     ((description . "count all nucleotides in a strand")
       (cases
         ((description . "empty strand")
           (property . "nucleotideCounts")
           (input (strand . ""))
           (expected (A . 0) (C . 0) (G . 0) (T . 0)))
         ((description
            .
            "can count one nucleotide in single-character input")
           (property . "nucleotideCounts")
           (input (strand . "G"))
           (expected (A . 0) (C . 0) (G . 1) (T . 0)))
         ((description . "strand with repeated nucleotide")
           (property . "nucleotideCounts")
           (input (strand . "GGGGGGG"))
           (expected (A . 0) (C . 0) (G . 7) (T . 0)))
         ((description . "strand with multiple nucleotides")
           (property . "nucleotideCounts")
           (input
             (strand
               .
               "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"))
           (expected (A . 20) (C . 12) (G . 17) (T . 21)))
         ((description . "strand with invalid nucleotides")
           (property . "nucleotideCounts")
           (input (strand . "AGXXACT"))
           (expected (error . "Invalid nucleotide in strand")))))))
 (resistor-color-duo
   (exercise . "resistor-color-duo")
   (version . "2.1.0")
   (cases
     ((description . "Brown and black")
       (property . "value")
       (input (colors "brown" "black"))
       (expected . 10))
     ((description . "Blue and grey")
       (property . "value")
       (input (colors "blue" "grey"))
       (expected . 68))
     ((description . "Yellow and violet")
       (property . "value")
       (input (colors "yellow" "violet"))
       (expected . 47))
     ((description . "Orange and orange")
       (property . "value")
       (input (colors "orange" "orange"))
       (expected . 33))
     ((description . "Ignore additional colors")
       (property . "value")
       (input (colors "green" "brown" "orange"))
       (expected . 51))))
 (palindrome-products
   (exercise . "palindrome-products")
   (version . "1.2.0")
   (cases
     ((description
        .
        "finds the smallest palindrome from single digit factors")
       (property . "smallest")
       (input (min . 1) (max . 9))
       (expected (value . 1) (factors (1 1))))
     ((description
        .
        "finds the largest palindrome from single digit factors")
       (property . "largest")
       (input (min . 1) (max . 9))
       (expected (value . 9) (factors (1 9) (3 3))))
     ((description
        .
        "find the smallest palindrome from double digit factors")
       (property . "smallest")
       (input (min . 10) (max . 99))
       (expected (value . 121) (factors (11 11))))
     ((description
        .
        "find the largest palindrome from double digit factors")
       (property . "largest")
       (input (min . 10) (max . 99))
       (expected (value . 9009) (factors (91 99))))
     ((description
        .
        "find smallest palindrome from triple digit factors")
       (property . "smallest")
       (input (min . 100) (max . 999))
       (expected (value . 10201) (factors (101 101))))
     ((description
        .
        "find the largest palindrome from triple digit factors")
       (property . "largest")
       (input (min . 100) (max . 999))
       (expected (value . 906609) (factors (913 993))))
     ((description
        .
        "find smallest palindrome from four digit factors")
       (property . "smallest")
       (input (min . 1000) (max . 9999))
       (expected (value . 1002001) (factors (1001 1001))))
     ((description
        .
        "find the largest palindrome from four digit factors")
       (property . "largest")
       (input (min . 1000) (max . 9999))
       (expected (value . 99000099) (factors (9901 9999))))
     ((description
        .
        "empty result for smallest if no palindrome in the range")
       (property . "smallest")
       (input (min . 1002) (max . 1003))
       (expected (value) (factors)))
     ((description
        .
        "empty result for largest if no palindrome in the range")
       (property . "largest")
       (input (min . 15) (max . 15))
       (expected (value) (factors)))
     ((description
        .
        "error result for smallest if min is more than max")
       (property . "smallest")
       (input (min . 10000) (max . 1))
       (expected (error . "min must be <= max")))
     ((description
        .
        "error result for largest if min is more than max")
       (property . "largest")
       (input (min . 2) (max . 1))
       (expected (error . "min must be <= max")))))
 (knapsack
   (exercise . "knapsack")
   (version . "1.0.0")
   (comments
     "Depending on the language, the input type can be modified")
   (cases
     ((description . "no items")
       (property . "maximumValue")
       (input (maximumWeight . 100) (items))
       (expected . 0))
     ((description . "one item, too heavy")
       (property . "maximumValue")
       (input
         (maximumWeight . 10)
         (items ((weight . 100) (value . 1))))
       (expected . 0))
     ((description . "five items (cannot be greedy by weight)")
       (property . "maximumValue")
       (input
         (maximumWeight . 10)
         (items ((weight . 2) (value . 5)) ((weight . 2) (value . 5))
           ((weight . 2) (value . 5)) ((weight . 2) (value . 5))
           ((weight . 10) (value . 21))))
       (expected . 21))
     ((description . "five items (cannot be greedy by value)")
       (property . "maximumValue")
       (input
         (maximumWeight . 10)
         (items ((weight . 2) (value . 20)) ((weight . 2) (value . 20))
           ((weight . 2) (value . 20)) ((weight . 2) (value . 20))
           ((weight . 10) (value . 50))))
       (expected . 80))
     ((description . "example knapsack")
       (property . "maximumValue")
       (input
         (maximumWeight . 10)
         (items
           ((weight . 5) (value . 10))
           ((weight . 4) (value . 40))
           ((weight . 6) (value . 30))
           ((weight . 4) (value . 50))))
       (expected . 90))
     ((description . "8 items")
       (property . "maximumValue")
       (input
         (maximumWeight . 104)
         (items ((weight . 25) (value . 350)) ((weight . 35) (value . 400))
           ((weight . 45) (value . 450)) ((weight . 5) (value . 20))
           ((weight . 25) (value . 70)) ((weight . 3) (value . 8))
           ((weight . 2) (value . 5)) ((weight . 2) (value . 5))))
       (expected . 900))
     ((description . "15 items")
       (property . "maximumValue")
       (input
         (maximumWeight . 750)
         (items ((weight . 70) (value . 135)) ((weight . 73) (value . 139))
           ((weight . 77) (value . 149)) ((weight . 80) (value . 150))
           ((weight . 82) (value . 156)) ((weight . 87) (value . 163))
           ((weight . 90) (value . 173)) ((weight . 94) (value . 184))
           ((weight . 98) (value . 192)) ((weight . 106) (value . 201))
           ((weight . 110) (value . 210))
           ((weight . 113) (value . 214))
           ((weight . 115) (value . 221))
           ((weight . 118) (value . 229))
           ((weight . 120) (value . 240))))
       (expected . 1458))))
 (two-fer
   (exercise . "two-fer")
   (version . "1.2.0")
   (cases
     ((description . "no name given")
       (property . "twoFer")
       (input (name))
       (expected . "One for you, one for me."))
     ((description . "a name given")
       (property . "twoFer")
       (input (name . "Alice"))
       (expected . "One for Alice, one for me."))
     ((description . "another name given")
       (property . "twoFer")
       (input (name . "Bob"))
       (expected . "One for Bob, one for me."))))
 (anagram
   (exercise . "anagram")
   (version . "1.5.0")
   (cases
     ((description . "no matches")
       (property . "findAnagrams")
       (input
         (subject . "diaper")
         (candidates "hello" "world" "zombies" "pants"))
       (expected))
     ((description . "detects two anagrams")
       (property . "findAnagrams")
       (input
         (subject . "master")
         (candidates "stream" "pigeon" "maters"))
       (expected "stream" "maters"))
     ((description . "does not detect anagram subsets")
       (property . "findAnagrams")
       (input (subject . "good") (candidates "dog" "goody"))
       (expected))
     ((description . "detects anagram")
       (property . "findAnagrams")
       (input
         (subject . "listen")
         (candidates "enlists" "google" "inlets" "banana"))
       (expected "inlets"))
     ((description . "detects three anagrams")
       (property . "findAnagrams")
       (input
         (subject . "allergy")
         (candidates "gallery" "ballerina" "regally" "clergy"
           "largely" "leading"))
       (expected "gallery" "regally" "largely"))
     ((description
        .
        "detects multiple anagrams with different case")
       (property . "findAnagrams")
       (input (subject . "nose") (candidates "Eons" "ONES"))
       (expected "Eons" "ONES"))
     ((description
        .
        "does not detect non-anagrams with identical checksum")
       (property . "findAnagrams")
       (input (subject . "mass") (candidates "last"))
       (expected))
     ((description . "detects anagrams case-insensitively")
       (property . "findAnagrams")
       (input
         (subject . "Orchestra")
         (candidates "cashregister" "Carthorse" "radishes"))
       (expected "Carthorse"))
     ((description
        .
        "detects anagrams using case-insensitive subject")
       (property . "findAnagrams")
       (input
         (subject . "Orchestra")
         (candidates "cashregister" "carthorse" "radishes"))
       (expected "carthorse"))
     ((description
        .
        "detects anagrams using case-insensitive possible matches")
       (property . "findAnagrams")
       (input
         (subject . "orchestra")
         (candidates "cashregister" "Carthorse" "radishes"))
       (expected "Carthorse"))
     ((description
        .
        "does not detect an anagram if the original word is repeated")
       (property . "findAnagrams")
       (input (subject . "go") (candidates "go Go GO"))
       (expected))
     ((description
        .
        "anagrams must use all letters exactly once")
       (property . "findAnagrams")
       (input (subject . "tapper") (candidates "patter"))
       (expected))
     ((description
        .
        "words are not anagrams of themselves (case-insensitive)")
       (property . "findAnagrams")
       (input
         (subject . "BANANA")
         (candidates "BANANA" "Banana" "banana"))
       (expected))
     ((description
        .
        "words other than themselves can be anagrams")
       (property . "findAnagrams")
       (input
         (subject . "LISTEN")
         (candidates "Listen" "Silent" "LISTEN"))
       (expected "Silent"))))
 (phone-number
   (exercise . "phone-number")
   (version . "1.7.0")
   (cases
     ((description . "Cleanup user-entered phone numbers")
       (comments
         " Returns the cleaned phone number if given number is valid, "
         " else returns error object. Note that number is not formatted,"
         " just a 10-digit number is returned.                        ")
       (cases
         ((description . "cleans the number")
           (property . "clean")
           (input (phrase . "(223) 456-7890"))
           (expected . "2234567890"))
         ((description . "cleans numbers with dots")
           (property . "clean")
           (input (phrase . "223.456.7890"))
           (expected . "2234567890"))
         ((description . "cleans numbers with multiple spaces")
           (property . "clean")
           (input (phrase . "223 456   7890   "))
           (expected . "2234567890"))
         ((description . "invalid when 9 digits")
           (property . "clean")
           (input (phrase . "123456789"))
           (expected (error . "incorrect number of digits")))
         ((description
            .
            "invalid when 11 digits does not start with a 1")
           (property . "clean")
           (input (phrase . "22234567890"))
           (expected (error . "11 digits must start with 1")))
         ((description . "valid when 11 digits and starting with 1")
           (property . "clean")
           (input (phrase . "12234567890"))
           (expected . "2234567890"))
         ((description
            .
            "valid when 11 digits and starting with 1 even with punctuation")
           (property . "clean")
           (input (phrase . "+1 (223) 456-7890"))
           (expected . "2234567890"))
         ((description . "invalid when more than 11 digits")
           (property . "clean")
           (input (phrase . "321234567890"))
           (expected (error . "more than 11 digits")))
         ((description . "invalid with letters")
           (property . "clean")
           (input (phrase . "123-abc-7890"))
           (expected (error . "letters not permitted")))
         ((description . "invalid with punctuations")
           (property . "clean")
           (input (phrase . "123-@:!-7890"))
           (expected (error . "punctuations not permitted")))
         ((description . "invalid if area code starts with 0")
           (property . "clean")
           (input (phrase . "(023) 456-7890"))
           (expected (error . "area code cannot start with zero")))
         ((description . "invalid if area code starts with 1")
           (property . "clean")
           (input (phrase . "(123) 456-7890"))
           (expected (error . "area code cannot start with one")))
         ((description . "invalid if exchange code starts with 0")
           (property . "clean")
           (input (phrase . "(223) 056-7890"))
           (expected (error . "exchange code cannot start with zero")))
         ((description . "invalid if exchange code starts with 1")
           (property . "clean")
           (input (phrase . "(223) 156-7890"))
           (expected (error . "exchange code cannot start with one")))
         ((description
            .
            "invalid if area code starts with 0 on valid 11-digit number")
           (property . "clean")
           (input (phrase . "1 (023) 456-7890"))
           (expected (error . "area code cannot start with zero")))
         ((description
            .
            "invalid if area code starts with 1 on valid 11-digit number")
           (property . "clean")
           (input (phrase . "1 (123) 456-7890"))
           (expected (error . "area code cannot start with one")))
         ((description
            .
            "invalid if exchange code starts with 0 on valid 11-digit number")
           (property . "clean")
           (input (phrase . "1 (223) 056-7890"))
           (expected (error . "exchange code cannot start with zero")))
         ((description
            .
            "invalid if exchange code starts with 1 on valid 11-digit number")
           (property . "clean")
           (input (phrase . "1 (223) 156-7890"))
           (expected
             (error . "exchange code cannot start with one")))))))
 (bob (exercise . "bob")
      (version . "1.4.0")
      (cases
       ((description . "stating something")
         (property . "response")
         (input (heyBob . "Tom-ay-to, tom-aaaah-to."))
         (expected . "Whatever."))
       ((description . "shouting")
         (property . "response")
         (input (heyBob . "WATCH OUT!"))
         (expected . "Whoa, chill out!"))
       ((description . "shouting gibberish")
         (property . "response")
         (input (heyBob . "FCECDFCAAB"))
         (expected . "Whoa, chill out!"))
       ((description . "asking a question")
         (property . "response")
         (input
           (heyBob . "Does this cryogenic chamber make me look fat?"))
         (expected . "Sure."))
       ((description . "asking a numeric question")
         (property . "response")
         (input (heyBob . "You are, what, like 15?"))
         (expected . "Sure."))
       ((description . "asking gibberish")
         (property . "response")
         (input (heyBob . "fffbbcbeab?"))
         (expected . "Sure."))
       ((description . "talking forcefully")
         (property . "response")
         (input (heyBob . "Let's go make out behind the gym!"))
         (expected . "Whatever."))
       ((description . "using acronyms in regular speech")
         (property . "response")
         (input
           (heyBob . "It's OK if you don't want to go to the DMV."))
         (expected . "Whatever."))
       ((description . "forceful question")
         (property . "response")
         (input (heyBob . "WHAT THE HELL WERE YOU THINKING?"))
         (expected . "Calm down, I know what I'm doing!"))
       ((description . "shouting numbers")
         (property . "response")
         (input (heyBob . "1, 2, 3 GO!"))
         (expected . "Whoa, chill out!"))
       ((description . "no letters")
         (property . "response")
         (input (heyBob . "1, 2, 3"))
         (expected . "Whatever."))
       ((description . "question with no letters")
         (property . "response")
         (input (heyBob . "4?"))
         (expected . "Sure."))
       ((description . "shouting with special characters")
         (property . "response")
         (input
           (heyBob . "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"))
         (expected . "Whoa, chill out!"))
       ((description . "shouting with no exclamation mark")
         (property . "response")
         (input (heyBob . "I HATE THE DMV"))
         (expected . "Whoa, chill out!"))
       ((description . "statement containing question mark")
         (property . "response")
         (input (heyBob . "Ending with ? means a question."))
         (expected . "Whatever."))
       ((description . "non-letters with question")
         (property . "response")
         (input (heyBob . ":) ?"))
         (expected . "Sure."))
       ((description . "prattling on")
         (property . "response")
         (input (heyBob . "Wait! Hang on. Are you going to be OK?"))
         (expected . "Sure."))
       ((description . "silence")
         (property . "response")
         (input (heyBob . ""))
         (expected . "Fine. Be that way!"))
       ((description . "prolonged silence")
         (property . "response")
         (input (heyBob . "          "))
         (expected . "Fine. Be that way!"))
       ((description . "alternate silence")
         (property . "response")
         (input (heyBob . "\t\t\t\t\t\t\t\t\t\t"))
         (expected . "Fine. Be that way!"))
       ((description . "multiple line question")
         (property . "response")
         (input
           (heyBob
             .
             "\nDoes this cryogenic chamber make me look fat?\nNo."))
         (expected . "Whatever."))
       ((description . "starting with whitespace")
         (property . "response")
         (input (heyBob . "         hmmmmmmm..."))
         (expected . "Whatever."))
       ((description . "ending with whitespace")
         (property . "response")
         (input
           (heyBob . "Okay if like my  spacebar  quite a bit?   "))
         (expected . "Sure."))
       ((description . "other whitespace")
         (property . "response")
         (input (heyBob . "\n\r \t"))
         (expected . "Fine. Be that way!"))
       ((description . "non-question ending with whitespace")
         (property . "response")
         (input
           (heyBob
             .
             "This is a statement ending with whitespace      "))
         (expected . "Whatever."))))
 (affine-cipher
   (exercise . "affine-cipher")
   (version . "2.0.0")
   (comments
     "The test are divided into two groups: "
     "* Encoding from English to affine cipher"
     "* Decoding from affine cipher to all-lowercase-mashed-together English")
   (cases
     ((description . "encode")
       (comments
         "Test encoding from English to ciphertext with keys")
       (cases
         ((description . "encode yes")
           (property . "encode")
           (input (phrase . "yes") (key (a . 5) (b . 7)))
           (expected . "xbt"))
         ((description . "encode no")
           (property . "encode")
           (input (phrase . "no") (key (a . 15) (b . 18)))
           (expected . "fu"))
         ((description . "encode OMG")
           (property . "encode")
           (input (phrase . "OMG") (key (a . 21) (b . 3)))
           (expected . "lvz"))
         ((description . "encode O M G")
           (property . "encode")
           (input (phrase . "O M G") (key (a . 25) (b . 47)))
           (expected . "hjp"))
         ((description . "encode mindblowingly")
           (property . "encode")
           (input (phrase . "mindblowingly") (key (a . 11) (b . 15)))
           (expected . "rzcwa gnxzc dgt"))
         ((description . "encode numbers")
           (property . "encode")
           (input
             (phrase . "Testing,1 2 3, testing.")
             (key (a . 3) (b . 4)))
           (expected . "jqgjc rw123 jqgjc rw"))
         ((description . "encode deep thought")
           (property . "encode")
           (input
             (phrase . "Truth is fiction.")
             (key (a . 5) (b . 17)))
           (expected . "iynia fdqfb ifje"))
         ((description . "encode all the letters")
           (property . "encode")
           (input
             (phrase . "The quick brown fox jumps over the lazy dog.")
             (key (a . 17) (b . 33)))
           (expected . "swxtj npvyk lruol iejdc blaxk swxmh qzglf"))
         ((description . "encode with a not coprime to m")
           (property . "encode")
           (input (phrase . "This is a test.") (key (a . 6) (b . 17)))
           (expected (error . "a and m must be coprime.")))))
     ((description . "decode")
       (comments
         "Test decoding from ciphertext to English with keys")
       (cases
         ((description . "decode exercism")
           (property . "decode")
           (input (phrase . "tytgn fjr") (key (a . 3) (b . 7)))
           (expected . "exercism"))
         ((description . "decode a sentence")
           (property . "decode")
           (input
             (phrase . "qdwju nqcro muwhn odqun oppmd aunwd o")
             (key (a . 19) (b . 16)))
           (expected . "anobstacleisoftenasteppingstone"))
         ((description . "decode numbers")
           (property . "decode")
           (input
             (phrase . "odpoz ub123 odpoz ub")
             (key (a . 25) (b . 7)))
           (expected . "testing123testing"))
         ((description . "decode all the letters")
           (property . "decode")
           (input
             (phrase . "swxtj npvyk lruol iejdc blaxk swxmh qzglf")
             (key (a . 17) (b . 33)))
           (expected . "thequickbrownfoxjumpsoverthelazydog"))
         ((description . "decode with no spaces in input")
           (property . "decode")
           (input
             (phrase . "swxtjnpvyklruoliejdcblaxkswxmhqzglf")
             (key (a . 17) (b . 33)))
           (expected . "thequickbrownfoxjumpsoverthelazydog"))
         ((description . "decode with too many spaces")
           (property . "decode")
           (input
             (phrase . "vszzm    cly   yd cg    qdp")
             (key (a . 15) (b . 16)))
           (expected . "jollygreengiant"))
         ((description . "decode with a not coprime to m")
           (property . "decode")
           (input (phrase . "Test") (key (a . 13) (b . 5)))
           (expected (error . "a and m must be coprime.")))))))
 (poker
   (exercise . "poker")
   (version . "1.1.0")
   (cases
    ((description . "single hand always wins")
      (property . "bestHands")
      (input (hands "4S 5S 7H 8D JC"))
      (expected "4S 5S 7H 8D JC"))
    ((description . "highest card out of all hands wins")
      (property . "bestHands")
      (input
        (hands "4D 5S 6S 8D 3C" "2S 4C 7S 9H 10H" "3S 4S 5D 6H JH"))
      (expected "3S 4S 5D 6H JH"))
    ((description . "a tie has multiple winners")
      (property . "bestHands")
      (input
        (hands
          "4D 5S 6S 8D 3C"
          "2S 4C 7S 9H 10H"
          "3S 4S 5D 6H JH"
          "3H 4H 5C 6C JD"))
      (expected "3S 4S 5D 6H JH" "3H 4H 5C 6C JD"))
    ((description
       .
       "multiple hands with the same high cards, tie compares next highest ranked, down to last card")
      (property . "bestHands")
      (input (hands "3S 5H 6S 8D 7H" "2S 5D 6D 8C 7S"))
      (expected "3S 5H 6S 8D 7H"))
    ((description . "one pair beats high card")
      (property . "bestHands")
      (input (hands "4S 5H 6C 8D KH" "2S 4H 6S 4D JH"))
      (expected "2S 4H 6S 4D JH"))
    ((description . "highest pair wins")
      (property . "bestHands")
      (input (hands "4S 2H 6S 2D JH" "2S 4H 6C 4D JD"))
      (expected "2S 4H 6C 4D JD"))
    ((description . "two pairs beats one pair")
      (property . "bestHands")
      (input (hands "2S 8H 6S 8D JH" "4S 5H 4C 8C 5C"))
      (expected "4S 5H 4C 8C 5C"))
    ((description
       .
       "both hands have two pairs, highest ranked pair wins")
      (property . "bestHands")
      (input (hands "2S 8H 2D 8D 3H" "4S 5H 4C 8S 5D"))
      (expected "2S 8H 2D 8D 3H"))
    ((description
       .
       "both hands have two pairs, with the same highest ranked pair, tie goes to low pair")
      (property . "bestHands")
      (input (hands "2S QS 2C QD JH" "JD QH JS 8D QC"))
      (expected "JD QH JS 8D QC"))
    ((description
       .
       "both hands have two identically ranked pairs, tie goes to remaining card (kicker)")
      (property . "bestHands")
      (input (hands "JD QH JS 8D QC" "JS QS JC 2D QD"))
      (expected "JD QH JS 8D QC"))
    ((description . "three of a kind beats two pair")
      (property . "bestHands")
      (input (hands "2S 8H 2H 8D JH" "4S 5H 4C 8S 4H"))
      (expected "4S 5H 4C 8S 4H"))
    ((description
       .
       "both hands have three of a kind, tie goes to highest ranked triplet")
      (property . "bestHands")
      (input (hands "2S 2H 2C 8D JH" "4S AH AS 8C AD"))
      (expected "4S AH AS 8C AD"))
    ((description
       .
       "with multiple decks, two players can have same three of a kind, ties go to highest remaining cards")
      (property . "bestHands")
      (input (hands "4S AH AS 7C AD" "4S AH AS 8C AD"))
      (expected "4S AH AS 8C AD"))
    ((description . "a straight beats three of a kind")
      (property . "bestHands")
      (input (hands "4S 5H 4C 8D 4H" "3S 4D 2S 6D 5C"))
      (expected "3S 4D 2S 6D 5C"))
    ((description . "aces can end a straight (10 J Q K A)")
      (property . "bestHands")
      (input (hands "4S 5H 4C 8D 4H" "10D JH QS KD AC"))
      (expected "10D JH QS KD AC"))
    ((description . "aces can start a straight (A 2 3 4 5)")
      (property . "bestHands")
      (input (hands "4S 5H 4C 8D 4H" "4D AH 3S 2D 5C"))
      (expected "4D AH 3S 2D 5C"))
    ((description
       .
       "both hands with a straight, tie goes to highest ranked card")
      (property . "bestHands")
      (input (hands "4S 6C 7S 8D 5H" "5S 7H 8S 9D 6H"))
      (expected "5S 7H 8S 9D 6H"))
    ((description
       .
       "even though an ace is usually high, a 5-high straight is the lowest-scoring straight")
      (property . "bestHands")
      (input (hands "2H 3C 4D 5D 6H" "4S AH 3S 2D 5H"))
      (expected "2H 3C 4D 5D 6H"))
    ((description . "flush beats a straight")
      (property . "bestHands")
      (input (hands "4C 6H 7D 8D 5H" "2S 4S 5S 6S 7S"))
      (expected "2S 4S 5S 6S 7S"))
    ((description
       .
       "both hands have a flush, tie goes to high card, down to the last one if necessary")
      (property . "bestHands")
      (input (hands "4H 7H 8H 9H 6H" "2S 4S 5S 6S 7S"))
      (expected "4H 7H 8H 9H 6H"))
    ((description . "full house beats a flush")
      (property . "bestHands")
      (input (hands "3H 6H 7H 8H 5H" "4S 5H 4C 5D 4H"))
      (expected "4S 5H 4C 5D 4H"))
    ((description
       .
       "both hands have a full house, tie goes to highest-ranked triplet")
      (property . "bestHands")
      (input (hands "4H 4S 4D 9S 9D" "5H 5S 5D 8S 8D"))
      (expected "5H 5S 5D 8S 8D"))
    ((description
       .
       "with multiple decks, both hands have a full house with the same triplet, tie goes to the pair")
      (property . "bestHands")
      (input (hands "5H 5S 5D 9S 9D" "5H 5S 5D 8S 8D"))
      (expected "5H 5S 5D 9S 9D"))
    ((description . "four of a kind beats a full house")
      (property . "bestHands")
      (input (hands "4S 5H 4D 5D 4H" "3S 3H 2S 3D 3C"))
      (expected "3S 3H 2S 3D 3C"))
    ((description
       .
       "both hands have four of a kind, tie goes to high quad")
      (property . "bestHands")
      (input (hands "2S 2H 2C 8D 2D" "4S 5H 5S 5D 5C"))
      (expected "4S 5H 5S 5D 5C"))
    ((description
       .
       "with multiple decks, both hands with identical four of a kind, tie determined by kicker")
      (property . "bestHands")
      (input (hands "3S 3H 2S 3D 3C" "3S 3H 4S 3D 3C"))
      (expected "3S 3H 4S 3D 3C"))
    ((description . "straight flush beats four of a kind")
      (property . "bestHands")
      (input (hands "4S 5H 5S 5D 5C" "7S 8S 9S 6S 10S"))
      (expected "7S 8S 9S 6S 10S"))
    ((description
       .
       "both hands have straight flush, tie goes to highest-ranked card")
      (property . "bestHands")
      (input (hands "4H 6H 7H 8H 5H" "5S 7S 8S 9S 6S"))
      (expected "5S 7S 8S 9S 6S"))))
 (proverb
   (exercise . "proverb")
   (version . "1.1.0")
   (comments
     "JSON doesn't allow for multi-line strings, so all expected outputs are presented "
     "here as arrays of strings. It's up to the test generator to join the "
     "lines together with line breaks. ")
   (cases
     ((description . "zero pieces")
       (property . "recite")
       (input (strings))
       (expected))
     ((description . "one piece")
       (property . "recite")
       (input (strings "nail"))
       (expected "And all for the want of a nail."))
     ((description . "two pieces")
       (property . "recite")
       (input (strings "nail" "shoe"))
       (expected
         "For want of a nail the shoe was lost."
         "And all for the want of a nail."))
     ((description . "three pieces")
       (property . "recite")
       (input (strings "nail" "shoe" "horse"))
       (expected
         "For want of a nail the shoe was lost."
         "For want of a shoe the horse was lost."
         "And all for the want of a nail."))
     ((description . "full proverb")
       (property . "recite")
       (input
         (strings "nail" "shoe" "horse" "rider" "message" "battle"
           "kingdom"))
       (expected "For want of a nail the shoe was lost."
         "For want of a shoe the horse was lost."
         "For want of a horse the rider was lost."
         "For want of a rider the message was lost."
         "For want of a message the battle was lost."
         "For want of a battle the kingdom was lost."
         "And all for the want of a nail."))
     ((description . "four pieces modernized")
       (property . "recite")
       (input (strings "pin" "gun" "soldier" "battle"))
       (expected
         "For want of a pin the gun was lost."
         "For want of a gun the soldier was lost."
         "For want of a soldier the battle was lost."
         "And all for the want of a pin."))))
 (trinary
   (exercise . "trinary")
   (version . "1.1.0")
   (cases
     ((description
        .
        "returns the decimal representation of the input trinary value")
       (cases
         ((description . "trinary 1 is decimal 1")
           (property . "toDecimal")
           (input (trinary . 1))
           (expected . 1))
         ((description . "trinary 2 is decimal 2")
           (property . "toDecimal")
           (input (trinary . 2))
           (expected . 2))
         ((description . "trinary 10 is decimal 3")
           (property . "toDecimal")
           (input (trinary . 10))
           (expected . 3))
         ((description . "trinary 11 is decimal 4")
           (property . "toDecimal")
           (input (trinary . 11))
           (expected . 4))
         ((description . "trinary 100 is decimal 9")
           (property . "toDecimal")
           (input (trinary . 100))
           (expected . 9))
         ((description . "trinary 112 is decimal 14")
           (property . "toDecimal")
           (input (trinary . 112))
           (expected . 14))
         ((description . "trinary 222 is decimal 26")
           (property . "toDecimal")
           (input (trinary . 222))
           (expected . 26))
         ((description . "trinary 1122000120 is decimal 32091")
           (property . "toDecimal")
           (input (trinary . 1122000120))
           (expected . 32091))
         ((description . "invalid trinary digits returns 0")
           (property . "toDecimal")
           (input (trinary . "1234"))
           (expected . 0))
         ((description . "invalid word as input returns 0")
           (property . "toDecimal")
           (input (trinary . "carrot"))
           (expected . 0))
         ((description
            .
            "invalid numbers with letters as input returns 0")
           (property . "toDecimal")
           (input (trinary . "0a1b2c"))
           (expected . 0))))))
 (atbash-cipher
   (exercise . "atbash-cipher")
   (version . "1.2.0")
   (comments
     "The tests are divided into two groups: "
     "* Encoding from English to atbash cipher"
     "* Decoding from atbash cipher to all-lowercase-mashed-together English")
   (cases
     ((description . "encode")
       (comments "Test encoding from English to atbash")
       (cases
         ((description . "encode yes")
           (property . "encode")
           (input (phrase . "yes"))
           (expected . "bvh"))
         ((description . "encode no")
           (property . "encode")
           (input (phrase . "no"))
           (expected . "ml"))
         ((description . "encode OMG")
           (property . "encode")
           (input (phrase . "OMG"))
           (expected . "lnt"))
         ((description . "encode spaces")
           (property . "encode")
           (input (phrase . "O M G"))
           (expected . "lnt"))
         ((description . "encode mindblowingly")
           (property . "encode")
           (input (phrase . "mindblowingly"))
           (expected . "nrmwy oldrm tob"))
         ((description . "encode numbers")
           (property . "encode")
           (input (phrase . "Testing,1 2 3, testing."))
           (expected . "gvhgr mt123 gvhgr mt"))
         ((description . "encode deep thought")
           (property . "encode")
           (input (phrase . "Truth is fiction."))
           (expected . "gifgs rhurx grlm"))
         ((description . "encode all the letters")
           (property . "encode")
           (input
             (phrase . "The quick brown fox jumps over the lazy dog."))
           (expected . "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"))))
     ((description . "decode")
       (comments "Test decoding from atbash to English")
       (cases
         ((description . "decode exercism")
           (property . "decode")
           (input (phrase . "vcvix rhn"))
           (expected . "exercism"))
         ((description . "decode a sentence")
           (property . "decode")
           (input (phrase . "zmlyh gzxov rhlug vmzhg vkkrm thglm v"))
           (expected . "anobstacleisoftenasteppingstone"))
         ((description . "decode numbers")
           (property . "decode")
           (input (phrase . "gvhgr mt123 gvhgr mt"))
           (expected . "testing123testing"))
         ((description . "decode all the letters")
           (property . "decode")
           (input
             (phrase . "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"))
           (expected . "thequickbrownfoxjumpsoverthelazydog"))
         ((description . "decode with too many spaces")
           (property . "decode")
           (input (phrase . "vc vix    r hn"))
           (expected . "exercism"))
         ((description . "decode with no spaces")
           (property . "decode")
           (input (phrase . "zmlyhgzxovrhlugvmzhgvkkrmthglmv"))
           (expected . "anobstacleisoftenasteppingstone"))))))
 (beer-song
   (exercise . "beer-song")
   (version . "2.1.0")
   (cases
     ((description . "verse")
       (cases
         ((description . "single verse")
           (cases
             ((description . "first generic verse")
               (property . "recite")
               (input (startBottles . 99) (takeDown . 1))
               (expected
                 "99 bottles of beer on the wall, 99 bottles of beer."
                 "Take one down and pass it around, 98 bottles of beer on the wall."))
             ((description . "last generic verse")
               (property . "recite")
               (input (startBottles . 3) (takeDown . 1))
               (expected
                 "3 bottles of beer on the wall, 3 bottles of beer."
                 "Take one down and pass it around, 2 bottles of beer on the wall."))
             ((description . "verse with 2 bottles")
               (property . "recite")
               (input (startBottles . 2) (takeDown . 1))
               (expected
                 "2 bottles of beer on the wall, 2 bottles of beer."
                 "Take one down and pass it around, 1 bottle of beer on the wall."))
             ((description . "verse with 1 bottle")
               (property . "recite")
               (input (startBottles . 1) (takeDown . 1))
               (expected
                 "1 bottle of beer on the wall, 1 bottle of beer."
                 "Take it down and pass it around, no more bottles of beer on the wall."))
             ((description . "verse with 0 bottles")
               (property . "recite")
               (input (startBottles . 0) (takeDown . 1))
               (expected
                 "No more bottles of beer on the wall, no more bottles of beer."
                 "Go to the store and buy some more, 99 bottles of beer on the wall."))))))
     ((description . "lyrics")
       (cases
         ((description . "multiple verses")
           (cases
             ((description . "first two verses")
               (property . "recite")
               (input (startBottles . 99) (takeDown . 2))
               (expected "99 bottles of beer on the wall, 99 bottles of beer."
                 "Take one down and pass it around, 98 bottles of beer on the wall."
                 "" "98 bottles of beer on the wall, 98 bottles of beer."
                 "Take one down and pass it around, 97 bottles of beer on the wall."))
             ((description . "last three verses")
               (property . "recite")
               (input (startBottles . 2) (takeDown . 3))
               (expected "2 bottles of beer on the wall, 2 bottles of beer."
                 "Take one down and pass it around, 1 bottle of beer on the wall."
                 "" "1 bottle of beer on the wall, 1 bottle of beer."
                 "Take it down and pass it around, no more bottles of beer on the wall."
                 ""
                 "No more bottles of beer on the wall, no more bottles of beer."
                 "Go to the store and buy some more, 99 bottles of beer on the wall."))
             ((description . "all verses")
               (property . "recite")
               (input (startBottles . 99) (takeDown . 100))
               (expected
                "99 bottles of beer on the wall, 99 bottles of beer."
                "Take one down and pass it around, 98 bottles of beer on the wall."
                "" "98 bottles of beer on the wall, 98 bottles of beer."
                "Take one down and pass it around, 97 bottles of beer on the wall."
                "" "97 bottles of beer on the wall, 97 bottles of beer."
                "Take one down and pass it around, 96 bottles of beer on the wall."
                "" "96 bottles of beer on the wall, 96 bottles of beer."
                "Take one down and pass it around, 95 bottles of beer on the wall."
                "" "95 bottles of beer on the wall, 95 bottles of beer."
                "Take one down and pass it around, 94 bottles of beer on the wall."
                "" "94 bottles of beer on the wall, 94 bottles of beer."
                "Take one down and pass it around, 93 bottles of beer on the wall."
                "" "93 bottles of beer on the wall, 93 bottles of beer."
                "Take one down and pass it around, 92 bottles of beer on the wall."
                "" "92 bottles of beer on the wall, 92 bottles of beer."
                "Take one down and pass it around, 91 bottles of beer on the wall."
                "" "91 bottles of beer on the wall, 91 bottles of beer."
                "Take one down and pass it around, 90 bottles of beer on the wall."
                "" "90 bottles of beer on the wall, 90 bottles of beer."
                "Take one down and pass it around, 89 bottles of beer on the wall."
                "" "89 bottles of beer on the wall, 89 bottles of beer."
                "Take one down and pass it around, 88 bottles of beer on the wall."
                "" "88 bottles of beer on the wall, 88 bottles of beer."
                "Take one down and pass it around, 87 bottles of beer on the wall."
                "" "87 bottles of beer on the wall, 87 bottles of beer."
                "Take one down and pass it around, 86 bottles of beer on the wall."
                "" "86 bottles of beer on the wall, 86 bottles of beer."
                "Take one down and pass it around, 85 bottles of beer on the wall."
                "" "85 bottles of beer on the wall, 85 bottles of beer."
                "Take one down and pass it around, 84 bottles of beer on the wall."
                "" "84 bottles of beer on the wall, 84 bottles of beer."
                "Take one down and pass it around, 83 bottles of beer on the wall."
                "" "83 bottles of beer on the wall, 83 bottles of beer."
                "Take one down and pass it around, 82 bottles of beer on the wall."
                "" "82 bottles of beer on the wall, 82 bottles of beer."
                "Take one down and pass it around, 81 bottles of beer on the wall."
                "" "81 bottles of beer on the wall, 81 bottles of beer."
                "Take one down and pass it around, 80 bottles of beer on the wall."
                "" "80 bottles of beer on the wall, 80 bottles of beer."
                "Take one down and pass it around, 79 bottles of beer on the wall."
                "" "79 bottles of beer on the wall, 79 bottles of beer."
                "Take one down and pass it around, 78 bottles of beer on the wall."
                "" "78 bottles of beer on the wall, 78 bottles of beer."
                "Take one down and pass it around, 77 bottles of beer on the wall."
                "" "77 bottles of beer on the wall, 77 bottles of beer."
                "Take one down and pass it around, 76 bottles of beer on the wall."
                "" "76 bottles of beer on the wall, 76 bottles of beer."
                "Take one down and pass it around, 75 bottles of beer on the wall."
                "" "75 bottles of beer on the wall, 75 bottles of beer."
                "Take one down and pass it around, 74 bottles of beer on the wall."
                "" "74 bottles of beer on the wall, 74 bottles of beer."
                "Take one down and pass it around, 73 bottles of beer on the wall."
                "" "73 bottles of beer on the wall, 73 bottles of beer."
                "Take one down and pass it around, 72 bottles of beer on the wall."
                "" "72 bottles of beer on the wall, 72 bottles of beer."
                "Take one down and pass it around, 71 bottles of beer on the wall."
                "" "71 bottles of beer on the wall, 71 bottles of beer."
                "Take one down and pass it around, 70 bottles of beer on the wall."
                "" "70 bottles of beer on the wall, 70 bottles of beer."
                "Take one down and pass it around, 69 bottles of beer on the wall."
                "" "69 bottles of beer on the wall, 69 bottles of beer."
                "Take one down and pass it around, 68 bottles of beer on the wall."
                "" "68 bottles of beer on the wall, 68 bottles of beer."
                "Take one down and pass it around, 67 bottles of beer on the wall."
                "" "67 bottles of beer on the wall, 67 bottles of beer."
                "Take one down and pass it around, 66 bottles of beer on the wall."
                "" "66 bottles of beer on the wall, 66 bottles of beer."
                "Take one down and pass it around, 65 bottles of beer on the wall."
                "" "65 bottles of beer on the wall, 65 bottles of beer."
                "Take one down and pass it around, 64 bottles of beer on the wall."
                "" "64 bottles of beer on the wall, 64 bottles of beer."
                "Take one down and pass it around, 63 bottles of beer on the wall."
                "" "63 bottles of beer on the wall, 63 bottles of beer."
                "Take one down and pass it around, 62 bottles of beer on the wall."
                "" "62 bottles of beer on the wall, 62 bottles of beer."
                "Take one down and pass it around, 61 bottles of beer on the wall."
                "" "61 bottles of beer on the wall, 61 bottles of beer."
                "Take one down and pass it around, 60 bottles of beer on the wall."
                "" "60 bottles of beer on the wall, 60 bottles of beer."
                "Take one down and pass it around, 59 bottles of beer on the wall."
                "" "59 bottles of beer on the wall, 59 bottles of beer."
                "Take one down and pass it around, 58 bottles of beer on the wall."
                "" "58 bottles of beer on the wall, 58 bottles of beer."
                "Take one down and pass it around, 57 bottles of beer on the wall."
                "" "57 bottles of beer on the wall, 57 bottles of beer."
                "Take one down and pass it around, 56 bottles of beer on the wall."
                "" "56 bottles of beer on the wall, 56 bottles of beer."
                "Take one down and pass it around, 55 bottles of beer on the wall."
                "" "55 bottles of beer on the wall, 55 bottles of beer."
                "Take one down and pass it around, 54 bottles of beer on the wall."
                "" "54 bottles of beer on the wall, 54 bottles of beer."
                "Take one down and pass it around, 53 bottles of beer on the wall."
                "" "53 bottles of beer on the wall, 53 bottles of beer."
                "Take one down and pass it around, 52 bottles of beer on the wall."
                "" "52 bottles of beer on the wall, 52 bottles of beer."
                "Take one down and pass it around, 51 bottles of beer on the wall."
                "" "51 bottles of beer on the wall, 51 bottles of beer."
                "Take one down and pass it around, 50 bottles of beer on the wall."
                "" "50 bottles of beer on the wall, 50 bottles of beer."
                "Take one down and pass it around, 49 bottles of beer on the wall."
                "" "49 bottles of beer on the wall, 49 bottles of beer."
                "Take one down and pass it around, 48 bottles of beer on the wall."
                "" "48 bottles of beer on the wall, 48 bottles of beer."
                "Take one down and pass it around, 47 bottles of beer on the wall."
                "" "47 bottles of beer on the wall, 47 bottles of beer."
                "Take one down and pass it around, 46 bottles of beer on the wall."
                "" "46 bottles of beer on the wall, 46 bottles of beer."
                "Take one down and pass it around, 45 bottles of beer on the wall."
                "" "45 bottles of beer on the wall, 45 bottles of beer."
                "Take one down and pass it around, 44 bottles of beer on the wall."
                "" "44 bottles of beer on the wall, 44 bottles of beer."
                "Take one down and pass it around, 43 bottles of beer on the wall."
                "" "43 bottles of beer on the wall, 43 bottles of beer."
                "Take one down and pass it around, 42 bottles of beer on the wall."
                "" "42 bottles of beer on the wall, 42 bottles of beer."
                "Take one down and pass it around, 41 bottles of beer on the wall."
                "" "41 bottles of beer on the wall, 41 bottles of beer."
                "Take one down and pass it around, 40 bottles of beer on the wall."
                "" "40 bottles of beer on the wall, 40 bottles of beer."
                "Take one down and pass it around, 39 bottles of beer on the wall."
                "" "39 bottles of beer on the wall, 39 bottles of beer."
                "Take one down and pass it around, 38 bottles of beer on the wall."
                "" "38 bottles of beer on the wall, 38 bottles of beer."
                "Take one down and pass it around, 37 bottles of beer on the wall."
                "" "37 bottles of beer on the wall, 37 bottles of beer."
                "Take one down and pass it around, 36 bottles of beer on the wall."
                "" "36 bottles of beer on the wall, 36 bottles of beer."
                "Take one down and pass it around, 35 bottles of beer on the wall."
                "" "35 bottles of beer on the wall, 35 bottles of beer."
                "Take one down and pass it around, 34 bottles of beer on the wall."
                "" "34 bottles of beer on the wall, 34 bottles of beer."
                "Take one down and pass it around, 33 bottles of beer on the wall."
                "" "33 bottles of beer on the wall, 33 bottles of beer."
                "Take one down and pass it around, 32 bottles of beer on the wall."
                "" "32 bottles of beer on the wall, 32 bottles of beer."
                "Take one down and pass it around, 31 bottles of beer on the wall."
                "" "31 bottles of beer on the wall, 31 bottles of beer."
                "Take one down and pass it around, 30 bottles of beer on the wall."
                "" "30 bottles of beer on the wall, 30 bottles of beer."
                "Take one down and pass it around, 29 bottles of beer on the wall."
                "" "29 bottles of beer on the wall, 29 bottles of beer."
                "Take one down and pass it around, 28 bottles of beer on the wall."
                "" "28 bottles of beer on the wall, 28 bottles of beer."
                "Take one down and pass it around, 27 bottles of beer on the wall."
                "" "27 bottles of beer on the wall, 27 bottles of beer."
                "Take one down and pass it around, 26 bottles of beer on the wall."
                "" "26 bottles of beer on the wall, 26 bottles of beer."
                "Take one down and pass it around, 25 bottles of beer on the wall."
                "" "25 bottles of beer on the wall, 25 bottles of beer."
                "Take one down and pass it around, 24 bottles of beer on the wall."
                "" "24 bottles of beer on the wall, 24 bottles of beer."
                "Take one down and pass it around, 23 bottles of beer on the wall."
                "" "23 bottles of beer on the wall, 23 bottles of beer."
                "Take one down and pass it around, 22 bottles of beer on the wall."
                "" "22 bottles of beer on the wall, 22 bottles of beer."
                "Take one down and pass it around, 21 bottles of beer on the wall."
                "" "21 bottles of beer on the wall, 21 bottles of beer."
                "Take one down and pass it around, 20 bottles of beer on the wall."
                "" "20 bottles of beer on the wall, 20 bottles of beer."
                "Take one down and pass it around, 19 bottles of beer on the wall."
                "" "19 bottles of beer on the wall, 19 bottles of beer."
                "Take one down and pass it around, 18 bottles of beer on the wall."
                "" "18 bottles of beer on the wall, 18 bottles of beer."
                "Take one down and pass it around, 17 bottles of beer on the wall."
                "" "17 bottles of beer on the wall, 17 bottles of beer."
                "Take one down and pass it around, 16 bottles of beer on the wall."
                "" "16 bottles of beer on the wall, 16 bottles of beer."
                "Take one down and pass it around, 15 bottles of beer on the wall."
                "" "15 bottles of beer on the wall, 15 bottles of beer."
                "Take one down and pass it around, 14 bottles of beer on the wall."
                "" "14 bottles of beer on the wall, 14 bottles of beer."
                "Take one down and pass it around, 13 bottles of beer on the wall."
                "" "13 bottles of beer on the wall, 13 bottles of beer."
                "Take one down and pass it around, 12 bottles of beer on the wall."
                "" "12 bottles of beer on the wall, 12 bottles of beer."
                "Take one down and pass it around, 11 bottles of beer on the wall."
                "" "11 bottles of beer on the wall, 11 bottles of beer."
                "Take one down and pass it around, 10 bottles of beer on the wall."
                "" "10 bottles of beer on the wall, 10 bottles of beer."
                "Take one down and pass it around, 9 bottles of beer on the wall."
                "" "9 bottles of beer on the wall, 9 bottles of beer."
                "Take one down and pass it around, 8 bottles of beer on the wall."
                "" "8 bottles of beer on the wall, 8 bottles of beer."
                "Take one down and pass it around, 7 bottles of beer on the wall."
                "" "7 bottles of beer on the wall, 7 bottles of beer."
                "Take one down and pass it around, 6 bottles of beer on the wall."
                "" "6 bottles of beer on the wall, 6 bottles of beer."
                "Take one down and pass it around, 5 bottles of beer on the wall."
                "" "5 bottles of beer on the wall, 5 bottles of beer."
                "Take one down and pass it around, 4 bottles of beer on the wall."
                "" "4 bottles of beer on the wall, 4 bottles of beer."
                "Take one down and pass it around, 3 bottles of beer on the wall."
                "" "3 bottles of beer on the wall, 3 bottles of beer."
                "Take one down and pass it around, 2 bottles of beer on the wall."
                "" "2 bottles of beer on the wall, 2 bottles of beer."
                "Take one down and pass it around, 1 bottle of beer on the wall."
                "" "1 bottle of beer on the wall, 1 bottle of beer."
                "Take it down and pass it around, no more bottles of beer on the wall."
                ""
                "No more bottles of beer on the wall, no more bottles of beer."
                "Go to the store and buy some more, 99 bottles of beer on the wall."))))))))
 (space-age
   (exercise . "space-age")
   (version . "1.2.0")
   (cases
     ((description . "age on Earth")
       (property . "age")
       (input (planet . "Earth") (seconds . 1000000000))
       (expected . 31.69))
     ((description . "age on Mercury")
       (property . "age")
       (input (planet . "Mercury") (seconds . 2134835688))
       (expected . 280.88))
     ((description . "age on Venus")
       (property . "age")
       (input (planet . "Venus") (seconds . 189839836))
       (expected . 9.78))
     ((description . "age on Mars")
       (property . "age")
       (input (planet . "Mars") (seconds . 2129871239))
       (expected . 35.88))
     ((description . "age on Jupiter")
       (property . "age")
       (input (planet . "Jupiter") (seconds . 901876382))
       (expected . 2.41))
     ((description . "age on Saturn")
       (property . "age")
       (input (planet . "Saturn") (seconds . 2000000000))
       (expected . 2.15))
     ((description . "age on Uranus")
       (property . "age")
       (input (planet . "Uranus") (seconds . 1210123456))
       (expected . 0.46))
     ((description . "age on Neptune")
       (property . "age")
       (input (planet . "Neptune") (seconds . 1821023456))
       (expected . 0.35))))
 (say (exercise . "say")
      (version . "1.2.0")
      (comments
        "An 'error' object is used as expected value to indicate that the"
        "input value is out of the range described in the exercise.")
      (cases
        ((description . "zero")
          (property . "say")
          (input (number . 0))
          (expected . "zero"))
        ((description . "one")
          (property . "say")
          (input (number . 1))
          (expected . "one"))
        ((description . "fourteen")
          (property . "say")
          (input (number . 14))
          (expected . "fourteen"))
        ((description . "twenty")
          (property . "say")
          (input (number . 20))
          (expected . "twenty"))
        ((description . "twenty-two")
          (property . "say")
          (input (number . 22))
          (expected . "twenty-two"))
        ((description . "one hundred")
          (property . "say")
          (input (number . 100))
          (expected . "one hundred"))
        ((description . "one hundred twenty-three")
          (property . "say")
          (input (number . 123))
          (expected . "one hundred twenty-three"))
        ((description . "one thousand")
          (property . "say")
          (input (number . 1000))
          (expected . "one thousand"))
        ((description . "one thousand two hundred thirty-four")
          (property . "say")
          (input (number . 1234))
          (expected . "one thousand two hundred thirty-four"))
        ((description . "one million")
          (property . "say")
          (input (number . 1000000))
          (expected . "one million"))
        ((description
           .
           "one million two thousand three hundred forty-five")
          (property . "say")
          (input (number . 1002345))
          (expected
            .
            "one million two thousand three hundred forty-five"))
        ((description . "one billion")
          (property . "say")
          (input (number . 1000000000))
          (expected . "one billion"))
        ((description . "a big number")
          (property . "say")
          (input (number . 987654321123))
          (expected
            .
            "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three"))
        ((description . "numbers below zero are out of range")
          (property . "say")
          (input (number . -1))
          (expected (error . "input out of range")))
        ((description
           .
           "numbers above 999,999,999,999 are out of range")
          (property . "say")
          (input (number . 1000000000000))
          (expected (error . "input out of range")))))
 (binary-search-tree
   (exercise . "binary-search-tree")
   (version . "1.0.0")
   (comments "Each test case assumes an empty/new tree."
    "As per exercism/problem-specifications#996 key 'treeData' counts as an input"
    "to test generators."
    "The key 'treeData' represents an array of numbers for which the data should be "
    "inserted/added to the tree as it appears in the array from left to right."
    "e.g. treeData: ['2', '1', '3', '6', '7', '5']"
    "Insert 2. Insert 1. Insert 3. Insert 6, so on..."
    "This canonical-data does not restrict the data type of array elements to either"
    "strings or integers."
    "The key 'expected' represents tree state as JSON object of schema :"
    "{" "    'title':'nodeObject'," "    'type':'object',"
    "    'properties':{" "        'data':{"
    "            'type':'string'" "        },"
    "        'left':{" "            'type':'nodeObject'"
    "        }," "        'right':{"
    "            'type':'nodeObject'" "        }" "    },"
    "    'required':['data', 'left', 'right']" "}")
   (cases
     ((description . "data is retained")
       (property . "data")
       (input (treeData "4"))
       (expected (data . "4") (left) (right)))
     ((description . "insert data at proper node")
       (cases
         ((description . "smaller number at left node")
           (property . "data")
           (input (treeData "4" "2"))
           (expected
             (data . "4")
             (left (data . "2") (left) (right))
             (right)))
         ((description . "same number at left node")
           (property . "data")
           (input (treeData "4" "4"))
           (expected
             (data . "4")
             (left (data . "4") (left) (right))
             (right)))
         ((description . "greater number at right node")
           (property . "data")
           (input (treeData "4" "5"))
           (expected
             (data . "4")
             (left)
             (right (data . "5") (left) (right))))))
     ((description . "can create complex tree")
       (property . "data")
       (input (treeData "4" "2" "6" "1" "3" "5" "7"))
       (expected
         (data . "4")
         (left
           (data . "2")
           (left (data . "1") (left) (right))
           (right (data . "3") (left) (right)))
         (right
           (data . "6")
           (left (data . "5") (left) (right))
           (right (data . "7") (left) (right)))))
     ((description . "can sort data")
       (cases
         ((description . "can sort single number")
           (property . "sortedData")
           (input (treeData "2"))
           (expected "2"))
         ((description
            .
            "can sort if second number is smaller than first")
           (property . "sortedData")
           (input (treeData "2" "1"))
           (expected "1" "2"))
         ((description
            .
            "can sort if second number is same as first")
           (property . "sortedData")
           (input (treeData "2" "2"))
           (expected "2" "2"))
         ((description
            .
            "can sort if second number is greater than first")
           (property . "sortedData")
           (input (treeData "2" "3"))
           (expected "2" "3"))
         ((description . "can sort complex tree")
           (property . "sortedData")
           (input (treeData "2" "1" "3" "6" "7" "5"))
           (expected "1" "2" "3" "5" "6" "7"))))))
 (rna-transcription
   (exercise . "rna-transcription")
   (version . "1.3.0")
   (cases
     ((description . "Empty RNA sequence")
       (property . "toRna")
       (input (dna . ""))
       (expected . ""))
     ((description . "RNA complement of cytosine is guanine")
       (property . "toRna")
       (input (dna . "C"))
       (expected . "G"))
     ((description . "RNA complement of guanine is cytosine")
       (property . "toRna")
       (input (dna . "G"))
       (expected . "C"))
     ((description . "RNA complement of thymine is adenine")
       (property . "toRna")
       (input (dna . "T"))
       (expected . "A"))
     ((description . "RNA complement of adenine is uracil")
       (property . "toRna")
       (input (dna . "A"))
       (expected . "U"))
     ((description . "RNA complement")
       (property . "toRna")
       (input (dna . "ACGTGGTCTTAA"))
       (expected . "UGCACCAGAAUU"))))
 (secret-handshake
   (exercise . "secret-handshake")
   (version . "1.2.0")
   (comments
     " In a discussion in https://github.com/exercism/problem-specifications/pull/794 and    "
     " https://github.com/exercism/problem-specifications/issues/335 it has been decided to  "
     " only include numbers between 0 and 31 (00000 to 11111) in the canonical "
     " test data.                                                              "
     "                                                                         "
     " This is to allow for different implementations in different tracks and  "
     " not restrict solutions to bitwise or modulo-based algorithms.           "
     "                                                                         "
     " Tracks may include additional tests for numbers > 31 in their test      "
     " suites. In this case, 32 (100000) should yield the same result as 0,    "
     " 33 (100001) should yield the same result as 1, and so on.               ")
   (cases
     ((description . "Create a handshake for a number")
       (cases
         ((description . "wink for 1")
           (property . "commands")
           (input (number . 1))
           (expected "wink"))
         ((description . "double blink for 10")
           (property . "commands")
           (input (number . 2))
           (expected "double blink"))
         ((description . "close your eyes for 100")
           (property . "commands")
           (input (number . 4))
           (expected "close your eyes"))
         ((description . "jump for 1000")
           (property . "commands")
           (input (number . 8))
           (expected "jump"))
         ((description . "combine two actions")
           (property . "commands")
           (input (number . 3))
           (expected "wink" "double blink"))
         ((description . "reverse two actions")
           (property . "commands")
           (input (number . 19))
           (expected "double blink" "wink"))
         ((description
            .
            "reversing one action gives the same action")
           (property . "commands")
           (input (number . 24))
           (expected "jump"))
         ((description
            .
            "reversing no actions still gives no actions")
           (property . "commands")
           (input (number . 16))
           (expected))
         ((description . "all possible actions")
           (property . "commands")
           (input (number . 15))
           (expected "wink" "double blink" "close your eyes" "jump"))
         ((description . "reverse all possible actions")
           (property . "commands")
           (input (number . 31))
           (expected "jump" "close your eyes" "double blink" "wink"))
         ((description . "do nothing for zero")
           (property . "commands")
           (input (number . 0))
           (expected))))))
 (perfect-numbers
   (exercise . "perfect-numbers")
   (version . "1.1.0")
   (cases
     ((description . "Perfect numbers")
       (cases
         ((description
            .
            "Smallest perfect number is classified correctly")
           (property . "classify")
           (input (number . 6))
           (expected . "perfect"))
         ((description
            .
            "Medium perfect number is classified correctly")
           (property . "classify")
           (input (number . 28))
           (expected . "perfect"))
         ((description
            .
            "Large perfect number is classified correctly")
           (property . "classify")
           (input (number . 33550336))
           (expected . "perfect"))))
     ((description . "Abundant numbers")
       (cases
         ((description
            .
            "Smallest abundant number is classified correctly")
           (property . "classify")
           (input (number . 12))
           (expected . "abundant"))
         ((description
            .
            "Medium abundant number is classified correctly")
           (property . "classify")
           (input (number . 30))
           (expected . "abundant"))
         ((description
            .
            "Large abundant number is classified correctly")
           (property . "classify")
           (input (number . 33550335))
           (expected . "abundant"))))
     ((description . "Deficient numbers")
       (cases
         ((description
            .
            "Smallest prime deficient number is classified correctly")
           (property . "classify")
           (input (number . 2))
           (expected . "deficient"))
         ((description
            .
            "Smallest non-prime deficient number is classified correctly")
           (property . "classify")
           (input (number . 4))
           (expected . "deficient"))
         ((description
            .
            "Medium deficient number is classified correctly")
           (property . "classify")
           (input (number . 32))
           (expected . "deficient"))
         ((description
            .
            "Large deficient number is classified correctly")
           (property . "classify")
           (input (number . 33550337))
           (expected . "deficient"))
         ((description
            .
            "Edge case (no factors other than itself) is classified correctly")
           (property . "classify")
           (input (number . 1))
           (expected . "deficient"))))
     ((description . "Invalid inputs")
       (cases
         ((description . "Zero is rejected (not a natural number)")
           (property . "classify")
           (input (number . 0))
           (expected
             (error .
               "Classification is only possible for natural numbers.")))
         ((description
            .
            "Negative integer is rejected (not a natural number)")
           (property . "classify")
           (input (number . -1))
           (expected
             (error .
               "Classification is only possible for natural numbers.")))))))
 (change
   (exercise . "change")
   (version . "1.3.0")
   (comments
     "Given an infinite supply of coins with different values, "
     "find the smallest number of coins needed to make a desired "
     "amount of change.")
   (cases
     ((description . "single coin change")
       (property . "findFewestCoins")
       (input (coins 1 5 10 25 100) (target . 25))
       (expected 25))
     ((description . "multiple coin change")
       (property . "findFewestCoins")
       (input (coins 1 5 10 25 100) (target . 15))
       (expected 5 10))
     ((description . "change with Lilliputian Coins")
       (property . "findFewestCoins")
       (input (coins 1 4 15 20 50) (target . 23))
       (expected 4 4 15))
     ((description . "change with Lower Elbonia Coins")
       (property . "findFewestCoins")
       (input (coins 1 5 10 21 25) (target . 63))
       (expected 21 21 21))
     ((description . "large target values")
       (property . "findFewestCoins")
       (input (coins 1 2 5 10 20 50 100) (target . 999))
       (expected 2 2 5 20 20 50 100 100 100 100 100 100 100 100
         100))
     ((description
        .
        "possible change without unit coins available")
       (property . "findFewestCoins")
       (input (coins 2 5 10 20 50) (target . 21))
       (expected 2 2 2 5 10))
     ((description
        .
        "another possible change without unit coins available")
       (property . "findFewestCoins")
       (input (coins 4 5) (target . 27))
       (expected 4 4 4 5 5 5))
     ((description . "no coins make 0 change")
       (property . "findFewestCoins")
       (input (coins 1 5 10 21 25) (target . 0))
       (expected))
     ((description
        .
        "error testing for change smaller than the smallest of coins")
       (property . "findFewestCoins")
       (input (coins 5 10) (target . 3))
       (expected (error . "can't make target with given coins")))
     ((description
        .
        "error if no combination can add up to target")
       (property . "findFewestCoins")
       (input (coins 5 10) (target . 94))
       (expected (error . "can't make target with given coins")))
     ((description . "cannot find negative change values")
       (property . "findFewestCoins")
       (input (coins 1 2 5) (target . -5))
       (expected (error . "target can't be negative")))))
 (difference-of-squares
   (exercise . "difference-of-squares")
   (version . "1.2.0")
   (cases
     ((description
        .
        "Square the sum of the numbers up to the given number")
       (cases
         ((description . "square of sum 1")
           (property . "squareOfSum")
           (input (number . 1))
           (expected . 1))
         ((description . "square of sum 5")
           (property . "squareOfSum")
           (input (number . 5))
           (expected . 225))
         ((description . "square of sum 100")
           (property . "squareOfSum")
           (input (number . 100))
           (expected . 25502500))))
     ((description
        .
        "Sum the squares of the numbers up to the given number")
       (cases
         ((description . "sum of squares 1")
           (property . "sumOfSquares")
           (input (number . 1))
           (expected . 1))
         ((description . "sum of squares 5")
           (property . "sumOfSquares")
           (input (number . 5))
           (expected . 55))
         ((description . "sum of squares 100")
           (property . "sumOfSquares")
           (input (number . 100))
           (expected . 338350))))
     ((description
        .
        "Subtract sum of squares from square of sums")
       (cases
         ((description . "difference of squares 1")
           (property . "differenceOfSquares")
           (input (number . 1))
           (expected . 0))
         ((description . "difference of squares 5")
           (property . "differenceOfSquares")
           (input (number . 5))
           (expected . 170))
         ((description . "difference of squares 100")
           (property . "differenceOfSquares")
           (input (number . 100))
           (expected . 25164150))))))
 (armstrong-numbers
   (exercise . "armstrong-numbers")
   (version . "1.1.0")
   (cases
     ((description . "Zero is an Armstrong number")
       (property . "isArmstrongNumber")
       (input (number . 0))
       (expected . #t))
     ((description
        .
        "Single digit numbers are Armstrong numbers")
       (property . "isArmstrongNumber")
       (input (number . 5))
       (expected . #t))
     ((description . "There are no 2 digit Armstrong numbers")
       (property . "isArmstrongNumber")
       (input (number . 10))
       (expected . #f))
     ((description
        .
        "Three digit number that is an Armstrong number")
       (property . "isArmstrongNumber")
       (input (number . 153))
       (expected . #t))
     ((description
        .
        "Three digit number that is not an Armstrong number")
       (property . "isArmstrongNumber")
       (input (number . 100))
       (expected . #f))
     ((description
        .
        "Four digit number that is an Armstrong number")
       (property . "isArmstrongNumber")
       (input (number . 9474))
       (expected . #t))
     ((description
        .
        "Four digit number that is not an Armstrong number")
       (property . "isArmstrongNumber")
       (input (number . 9475))
       (expected . #f))
     ((description
        .
        "Seven digit number that is an Armstrong number")
       (property . "isArmstrongNumber")
       (input (number . 9926315))
       (expected . #t))
     ((description
        .
        "Seven digit number that is not an Armstrong number")
       (property . "isArmstrongNumber")
       (input (number . 9926314))
       (expected . #f))))
 (variable-length-quantity
   (exercise . "variable-length-quantity")
   (version . "1.2.0")
   (comments
     "JSON doesn't allow hexadecimal literals."
     "All numbers are given as decimal literals instead."
     "An error should be expected for incomplete sequences."
     "It is highly recommended that your track's test generator display all numbers as hexadecimal literals.")
   (cases
     ((description
        .
        "Encode a series of integers, producing a series of bytes.")
       (cases
         ((description . "zero")
           (property . "encode")
           (input (integers 0))
           (expected 0))
         ((description . "arbitrary single byte")
           (property . "encode")
           (input (integers 64))
           (expected 64))
         ((description . "largest single byte")
           (property . "encode")
           (input (integers 127))
           (expected 127))
         ((description . "smallest double byte")
           (property . "encode")
           (input (integers 128))
           (expected 129 0))
         ((description . "arbitrary double byte")
           (property . "encode")
           (input (integers 8192))
           (expected 192 0))
         ((description . "largest double byte")
           (property . "encode")
           (input (integers 16383))
           (expected 255 127))
         ((description . "smallest triple byte")
           (property . "encode")
           (input (integers 16384))
           (expected 129 128 0))
         ((description . "arbitrary triple byte")
           (property . "encode")
           (input (integers 1048576))
           (expected 192 128 0))
         ((description . "largest triple byte")
           (property . "encode")
           (input (integers 2097151))
           (expected 255 255 127))
         ((description . "smallest quadruple byte")
           (property . "encode")
           (input (integers 2097152))
           (expected 129 128 128 0))
         ((description . "arbitrary quadruple byte")
           (property . "encode")
           (input (integers 134217728))
           (expected 192 128 128 0))
         ((description . "largest quadruple byte")
           (property . "encode")
           (input (integers 268435455))
           (expected 255 255 255 127))
         ((description . "smallest quintuple byte")
           (property . "encode")
           (input (integers 268435456))
           (expected 129 128 128 128 0))
         ((description . "arbitrary quintuple byte")
           (property . "encode")
           (input (integers 4278190080))
           (expected 143 248 128 128 0))
         ((description . "maximum 32-bit integer input")
           (property . "encode")
           (input (integers 4294967295))
           (expected 143 255 255 255 127))
         ((description . "two single-byte values")
           (property . "encode")
           (input (integers 64 127))
           (expected 64 127))
         ((description . "two multi-byte values")
           (property . "encode")
           (input (integers 16384 1193046))
           (expected 129 128 0 200 232 86))
         ((description . "many multi-byte values")
           (property . "encode")
           (input (integers 8192 1193046 268435455 0 16383 16384))
           (expected 192 0 200 232 86 255 255 255 127 0 255 127 129 128
             0))))
     ((description
        .
        "Decode a series of bytes, producing a series of integers.")
       (cases
         ((description . "one byte")
           (property . "decode")
           (input (integers 127))
           (expected 127))
         ((description . "two bytes")
           (property . "decode")
           (input (integers 192 0))
           (expected 8192))
         ((description . "three bytes")
           (property . "decode")
           (input (integers 255 255 127))
           (expected 2097151))
         ((description . "four bytes")
           (property . "decode")
           (input (integers 129 128 128 0))
           (expected 2097152))
         ((description . "maximum 32-bit integer")
           (property . "decode")
           (input (integers 143 255 255 255 127))
           (expected 4294967295))
         ((description . "incomplete sequence causes error")
           (property . "decode")
           (input (integers 255))
           (expected (error . "incomplete sequence")))
         ((description
            .
            "incomplete sequence causes error, even if value is zero")
           (property . "decode")
           (input (integers 128))
           (expected (error . "incomplete sequence")))
         ((description . "multiple values")
           (property . "decode")
           (input
             (integers 192 0 200 232 86 255 255 255 127 0 255 127 129 128
               0))
           (expected 8192 1193046 268435455 0 16383 16384))))))
 (book-store
   (exercise . "book-store")
   (version . "1.4.0")
   (cases
     ((description
        .
        "Return the total basket price after applying the best discount.")
       (comments
         "Calculate lowest price for a shopping basket containing books only from "
         "a single series.  There is no discount advantage for having more than "
         "one copy of any single book in a grouping."
         "implementors should use proper fixed-point or currency data types of the "
         "corresponding language and not float."
         "All 'expected' amounts are in cents.")
       (cases
         ((property . "total")
           (description . "Only a single book")
           (comments "Suggested grouping, [[1]].")
           (input (basket 1))
           (expected . 800))
         ((property . "total")
           (description . "Two of the same book")
           (comments "Suggested grouping, [[2],[2]].")
           (input (basket 2 2))
           (expected . 1600))
         ((property . "total")
           (description . "Empty basket")
           (comments "Suggested grouping, [].")
           (input (basket))
           (expected . 0))
         ((property . "total")
           (description . "Two different books")
           (comments "Suggested grouping, [[1,2]].")
           (input (basket 1 2))
           (expected . 1520))
         ((property . "total")
           (description . "Three different books")
           (comments "Suggested grouping, [[1,2,3]].")
           (input (basket 1 2 3))
           (expected . 2160))
         ((property . "total")
           (description . "Four different books")
           (comments "Suggested grouping, [[1,2,3,4]].")
           (input (basket 1 2 3 4))
           (expected . 2560))
         ((property . "total")
           (description . "Five different books")
           (comments "Suggested grouping, [[1,2,3,4,5]].")
           (input (basket 1 2 3 4 5))
           (expected . 3000))
         ((property . "total")
           (description
             .
             "Two groups of four is cheaper than group of five plus group of three")
           (comments "Suggested grouping, [[1,2,3,4],[1,2,3,5]].")
           (input (basket 1 1 2 2 3 3 4 5))
           (expected . 5120))
         ((property . "total")
           (description
             .
             "Two groups of four is cheaper than groups of five and three")
           (comments
             "Suggested grouping, [[1,2,4,5],[1,3,4,5]]. This differs from the other 'two groups of four' test in that it will fail for solutions that add books to groups in the order in which they appear in the list.")
           (input (basket 1 1 2 3 4 4 5 5))
           (expected . 5120))
         ((property . "total")
           (description
             .
             "Group of four plus group of two is cheaper than two groups of three")
           (comments "Suggested grouping, [[1,2,3,4],[1,2]].")
           (input (basket 1 1 2 2 3 4))
           (expected . 4080))
         ((property . "total")
           (description
             .
             "Two each of first 4 books and 1 copy each of rest")
           (comments "Suggested grouping, [[1,2,3,4,5],[1,2,3,4]].")
           (input (basket 1 1 2 2 3 3 4 4 5))
           (expected . 5560))
         ((property . "total")
           (description . "Two copies of each book")
           (comments "Suggested grouping, [[1,2,3,4,5],[1,2,3,4,5]].")
           (input (basket 1 1 2 2 3 3 4 4 5 5))
           (expected . 6000))
         ((property . "total")
           (description
             .
             "Three copies of first book and 2 each of remaining")
           (comments
             "Suggested grouping, [[1,2,3,4,5],[1,2,3,4,5],[1]].")
           (input (basket 1 1 2 2 3 3 4 4 5 5 1))
           (expected . 6800))
         ((property . "total")
           (description
             .
             "Three each of first 2 books and 2 each of remaining books")
           (comments
             "Suggested grouping, [[1,2,3,4,5],[1,2,3,4,5],[1,2]].")
           (input (basket 1 1 2 2 3 3 4 4 5 5 1 2))
           (expected . 7520))
         ((property . "total")
           (description
             .
             "Four groups of four are cheaper than two groups each of five and three")
           (comments
             "Suggested grouping, [[1,2,3,4],[1,2,3,5],[1,2,3,4],[1,2,3,5]].")
           (input (basket 1 1 2 2 3 3 4 5 1 1 2 2 3 3 4 5))
           (expected . 10240))))))
 (two-bucket
   (exercise . "two-bucket")
   (version . "1.4.0")
   (cases
     ((description
        .
        "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one")
       (property . "measure")
       (input
         (bucketOne . 3)
         (bucketTwo . 5)
         (goal . 1)
         (startBucket . "one"))
       (expected
         (moves . 4)
         (goalBucket . "one")
         (otherBucket . 5)))
     ((description
        .
        "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two")
       (property . "measure")
       (input
         (bucketOne . 3)
         (bucketTwo . 5)
         (goal . 1)
         (startBucket . "two"))
       (expected
         (moves . 8)
         (goalBucket . "two")
         (otherBucket . 3)))
     ((description
        .
        "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one")
       (property . "measure")
       (input
         (bucketOne . 7)
         (bucketTwo . 11)
         (goal . 2)
         (startBucket . "one"))
       (expected
         (moves . 14)
         (goalBucket . "one")
         (otherBucket . 11)))
     ((description
        .
        "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two")
       (property . "measure")
       (input
         (bucketOne . 7)
         (bucketTwo . 11)
         (goal . 2)
         (startBucket . "two"))
       (expected
         (moves . 18)
         (goalBucket . "two")
         (otherBucket . 7)))
     ((description
        .
        "Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two")
       (property . "measure")
       (input
         (bucketOne . 1)
         (bucketTwo . 3)
         (goal . 3)
         (startBucket . "two"))
       (expected
         (moves . 1)
         (goalBucket . "two")
         (otherBucket . 0)))
     ((description
        .
        "Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two")
       (property . "measure")
       (input
         (bucketOne . 2)
         (bucketTwo . 3)
         (goal . 3)
         (startBucket . "one"))
       (expected
         (moves . 2)
         (goalBucket . "two")
         (otherBucket . 2)))))
 (pov (exercise . "pov")
      (version . "1.3.0")
      (cases
        ((description
           .
           "Reroot a tree so that its root is the specified node.")
          (comments
            "In this way, the tree is presented from the point of view of the specified node."
            ""
            "If appropriate for your track, you may test that the input tree is not modified."
            ""
            "Note that when rerooting upon a target node that has both parents and children,"
            "it does not matter whether the former parent comes before or after the former children."
            "Please account for this when checking correctness of the resulting trees."
            "One suggested method is to only check two things:"
            "1) The root of the returned tree is the root that was passed in to from_pov."
            "2) The sorted edge list of the returned tree is the same as the sorted edge list of the expected tree.")
          (cases
            ((description
               .
               "Results in the same tree if the input tree is a singleton")
              (property . "fromPov")
              (input (tree (label . "x")) (from . "x"))
              (expected (label . "x")))
            ((description
               .
               "Can reroot a tree with a parent and one sibling")
              (property . "fromPov")
              (input
                (tree
                  (label . "parent")
                  (children ((label . "x")) ((label . "sibling"))))
                (from . "x"))
              (expected
                (label . "x")
                (children
                  ((label . "parent") (children ((label . "sibling")))))))
            ((description
               .
               "Can reroot a tree with a parent and many siblings")
              (property . "fromPov")
              (input
                (tree
                  (label . "parent")
                  (children
                    ((label . "a"))
                    ((label . "x"))
                    ((label . "b"))
                    ((label . "c"))))
                (from . "x"))
              (expected
                (label . "x")
                (children
                  ((label . "parent")
                    (children
                      ((label . "a"))
                      ((label . "b"))
                      ((label . "c")))))))
            ((description
               .
               "Can reroot a tree with new root deeply nested in tree")
              (property . "fromPov")
              (input
                (tree
                  (label . "level-0")
                  (children
                    ((label . "level-1")
                      (children
                        ((label . "level-2")
                          (children
                            ((label . "level-3")
                              (children ((label . "x"))))))))))
                (from . "x"))
              (expected
                (label . "x")
                (children
                  ((label . "level-3")
                    (children
                      ((label . "level-2")
                        (children
                          ((label . "level-1")
                            (children ((label . "level-0")))))))))))
            ((description
               .
               "Moves children of the new root to same level as former parent")
              (property . "fromPov")
              (input
                (tree
                  (label . "parent")
                  (children
                    ((label . "x")
                      (children ((label . "kid-0")) ((label . "kid-1"))))))
                (from . "x"))
              (expected
                (label . "x")
                (children
                  ((label . "kid-0"))
                  ((label . "kid-1"))
                  ((label . "parent")))))
            ((description . "Can reroot a complex tree with cousins")
              (property . "fromPov")
              (input
                (tree
                  (label . "grandparent")
                  (children
                    ((label . "parent")
                      (children
                        ((label . "x")
                          (children
                            ((label . "kid-0"))
                            ((label . "kid-1"))))
                        ((label . "sibling-0"))
                        ((label . "sibling-1"))))
                    ((label . "uncle")
                      (children
                        ((label . "cousin-0"))
                        ((label . "cousin-1"))))))
                (from . "x"))
              (expected
                (label . "x")
                (children
                  ((label . "kid-1"))
                  ((label . "kid-0"))
                  ((label . "parent")
                    (children
                      ((label . "sibling-0"))
                      ((label . "sibling-1"))
                      ((label . "grandparent")
                        (children
                          ((label . "uncle")
                            (children
                              ((label . "cousin-0"))
                              ((label . "cousin-1")))))))))))
            ((description
               .
               "Errors if target does not exist in a singleton tree")
              (property . "fromPov")
              (input (tree (label . "x")) (from . "nonexistent"))
              (expected))
            ((description
               .
               "Errors if target does not exist in a large tree")
              (property . "fromPov")
              (input
                (tree
                  (label . "parent")
                  (children
                    ((label . "x")
                      (children ((label . "kid-0")) ((label . "kid-1"))))
                    ((label . "sibling-0"))
                    ((label . "sibling-1"))))
                (from . "nonexistent"))
              (expected))))
        ((description
           .
           "Given two nodes, find the path between them")
          (comments
            "A typical implementation would first reroot the tree on one of the two nodes."
            ""
            "If appropriate for your track, you may test that the input tree is not modified.")
          (cases
            ((description . "Can find path to parent")
              (property . "pathTo")
              (input
                (from . "x")
                (to . "parent")
                (tree
                  (label . "parent")
                  (children ((label . "x")) ((label . "sibling")))))
              (expected "x" "parent"))
            ((description . "Can find path to sibling")
              (property . "pathTo")
              (input
                (from . "x")
                (to . "b")
                (tree
                  (label . "parent")
                  (children
                    ((label . "a"))
                    ((label . "x"))
                    ((label . "b"))
                    ((label . "c")))))
              (expected "x" "parent" "b"))
            ((description . "Can find path to cousin")
              (property . "pathTo")
              (input
                (from . "x")
                (to . "cousin-1")
                (tree
                  (label . "grandparent")
                  (children
                    ((label . "parent")
                      (children
                        ((label . "x")
                          (children
                            ((label . "kid-0"))
                            ((label . "kid-1"))))
                        ((label . "sibling-0"))
                        ((label . "sibling-1"))))
                    ((label . "uncle")
                      (children
                        ((label . "cousin-0"))
                        ((label . "cousin-1")))))))
              (expected "x" "parent" "grandparent" "uncle" "cousin-1"))
            ((description . "Can find path not involving root")
              (property . "pathTo")
              (input
                (from . "x")
                (to . "sibling-1")
                (tree
                  (label . "grandparent")
                  (children
                    ((label . "parent")
                      (children
                        ((label . "x"))
                        ((label . "sibling-0"))
                        ((label . "sibling-1")))))))
              (expected "x" "parent" "sibling-1"))
            ((description . "Can find path from nodes other than x")
              (property . "pathTo")
              (input
                (from . "a")
                (to . "c")
                (tree
                  (label . "parent")
                  (children
                    ((label . "a"))
                    ((label . "x"))
                    ((label . "b"))
                    ((label . "c")))))
              (expected "a" "parent" "c"))
            ((description . "Errors if destination does not exist")
              (property . "pathTo")
              (input
                (from . "x")
                (to . "nonexistent")
                (tree
                  (label . "parent")
                  (children
                    ((label . "x")
                      (children ((label . "kid-0")) ((label . "kid-1"))))
                    ((label . "sibling-0"))
                    ((label . "sibling-1")))))
              (expected))
            ((description . "Errors if source does not exist")
              (property . "pathTo")
              (input
                (from . "nonexistent")
                (to . "x")
                (tree
                  (label . "parent")
                  (children
                    ((label . "x")
                      (children ((label . "kid-0")) ((label . "kid-1"))))
                    ((label . "sibling-0"))
                    ((label . "sibling-1")))))
              (expected))))))
 (matching-brackets
   (exercise . "matching-brackets")
   (version . "2.0.0")
   (cases
     ((description . "paired square brackets")
       (property . "isPaired")
       (input (value . "[]"))
       (expected . #t))
     ((description . "empty string")
       (property . "isPaired")
       (input (value . ""))
       (expected . #t))
     ((description . "unpaired brackets")
       (property . "isPaired")
       (input (value . "[["))
       (expected . #f))
     ((description . "wrong ordered brackets")
       (property . "isPaired")
       (input (value . "}{"))
       (expected . #f))
     ((description . "wrong closing bracket")
       (property . "isPaired")
       (input (value . "{]"))
       (expected . #f))
     ((description . "paired with whitespace")
       (property . "isPaired")
       (input (value . "{ }"))
       (expected . #t))
     ((description . "partially paired brackets")
       (property . "isPaired")
       (input (value . "{[])"))
       (expected . #f))
     ((description . "simple nested brackets")
       (property . "isPaired")
       (input (value . "{[]}"))
       (expected . #t))
     ((description . "several paired brackets")
       (property . "isPaired")
       (input (value . "{}[]"))
       (expected . #t))
     ((description . "paired and nested brackets")
       (property . "isPaired")
       (input (value . "([{}({}[])])"))
       (expected . #t))
     ((description . "unopened closing brackets")
       (property . "isPaired")
       (input (value . "{[)][]}"))
       (expected . #f))
     ((description . "unpaired and nested brackets")
       (property . "isPaired")
       (input (value . "([{])"))
       (expected . #f))
     ((description . "paired and wrong nested brackets")
       (property . "isPaired")
       (input (value . "[({]})"))
       (expected . #f))
     ((description . "paired and incomplete brackets")
       (property . "isPaired")
       (input (value . "{}["))
       (expected . #f))
     ((description . "too many closing brackets")
       (property . "isPaired")
       (input (value . "[]]"))
       (expected . #f))
     ((description . "math expression")
       (property . "isPaired")
       (input (value . "(((185 + 223.85) * 15) - 543)/2"))
       (expected . #t))
     ((description . "complex latex expression")
       (property . "isPaired")
       (input
         (value
           .
           "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)"))
       (expected . #t))))
 (rotational-cipher
   (exercise . "rotational-cipher")
   (version . "1.2.0")
   (comments "The tests are a series of rotation tests: ")
   (cases
     ((description . "Test rotation from English to ROTn")
       (cases
         ((description . "rotate a by 0, same output as input")
           (property . "rotate")
           (input (text . "a") (shiftKey . 0))
           (expected . "a"))
         ((description . "rotate a by 1")
           (property . "rotate")
           (input (text . "a") (shiftKey . 1))
           (expected . "b"))
         ((description . "rotate a by 26, same output as input")
           (property . "rotate")
           (input (text . "a") (shiftKey . 26))
           (expected . "a"))
         ((description . "rotate m by 13")
           (property . "rotate")
           (input (text . "m") (shiftKey . 13))
           (expected . "z"))
         ((description . "rotate n by 13 with wrap around alphabet")
           (property . "rotate")
           (input (text . "n") (shiftKey . 13))
           (expected . "a"))
         ((description . "rotate capital letters")
           (property . "rotate")
           (input (text . "OMG") (shiftKey . 5))
           (expected . "TRL"))
         ((description . "rotate spaces")
           (property . "rotate")
           (input (text . "O M G") (shiftKey . 5))
           (expected . "T R L"))
         ((description . "rotate numbers")
           (property . "rotate")
           (input (text . "Testing 1 2 3 testing") (shiftKey . 4))
           (expected . "Xiwxmrk 1 2 3 xiwxmrk"))
         ((description . "rotate punctuation")
           (property . "rotate")
           (input (text . "Let's eat, Grandma!") (shiftKey . 21))
           (expected . "Gzo'n zvo, Bmviyhv!"))
         ((description . "rotate all letters")
           (property . "rotate")
           (input
             (text . "The quick brown fox jumps over the lazy dog.")
             (shiftKey . 13))
           (expected
             .
             "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."))))))
 (isbn-verifier
   (exercise . "isbn-verifier")
   (version . "2.7.0")
   (comments
     "An expected value of true indicates a valid ISBN-10, "
     "whereas false means the ISBN-10 is invalid.")
   (cases
     ((description . "valid isbn number")
       (property . "isValid")
       (input (isbn . "3-598-21508-8"))
       (expected . #t))
     ((description . "invalid isbn check digit")
       (property . "isValid")
       (input (isbn . "3-598-21508-9"))
       (expected . #f))
     ((description
        .
        "valid isbn number with a check digit of 10")
       (property . "isValid")
       (input (isbn . "3-598-21507-X"))
       (expected . #t))
     ((description . "check digit is a character other than X")
       (property . "isValid")
       (input (isbn . "3-598-21507-A"))
       (expected . #f))
     ((description . "invalid character in isbn")
       (property . "isValid")
       (input (isbn . "3-598-P1581-X"))
       (expected . #f))
     ((description . "X is only valid as a check digit")
       (property . "isValid")
       (input (isbn . "3-598-2X507-9"))
       (expected . #f))
     ((description . "valid isbn without separating dashes")
       (property . "isValid")
       (input (isbn . "3598215088"))
       (expected . #t))
     ((description
        .
        "isbn without separating dashes and X as check digit")
       (property . "isValid")
       (input (isbn . "359821507X"))
       (expected . #t))
     ((description . "isbn without check digit and dashes")
       (property . "isValid")
       (input (isbn . "359821507"))
       (expected . #f))
     ((description . "too long isbn and no dashes")
       (property . "isValid")
       (input (isbn . "3598215078X"))
       (expected . #f))
     ((description . "too short isbn")
       (property . "isValid")
       (input (isbn . "00"))
       (expected . #f))
     ((description . "isbn without check digit")
       (property . "isValid")
       (input (isbn . "3-598-21507"))
       (expected . #f))
     ((description . "check digit of X should not be used for 0")
       (property . "isValid")
       (input (isbn . "3-598-21515-X"))
       (expected . #f))
     ((description . "empty isbn")
       (property . "isValid")
       (input (isbn . ""))
       (expected . #f))
     ((description . "input is 9 characters")
       (property . "isValid")
       (input (isbn . "134456729"))
       (expected . #f))
     ((description . "invalid characters are not ignored")
       (property . "isValid")
       (input (isbn . "3132P34035"))
       (expected . #f))
     ((description
        .
        "input is too long but contains a valid isbn")
       (property . "isValid")
       (input (isbn . "98245726788"))
       (expected . #f))))
 (high-scores
   (exercise . "high-scores")
   (version . "4.0.0")
   (comments "This is meant to be an easy exercise to practise: "
     "* arrays as simple lists" "* instantiating a class"
     "Consider adding a track specific recommendation in the track's hint.md."
     "Consider linking to a explanatory blogpost or beginner level tutorials for both topics."
     "See Ruby Track hint.md for an example.")
   (cases
     ((description . "List of scores")
       (property . "scores")
       (input (scores 30 50 20 70))
       (expected 30 50 20 70))
     ((description . "Latest score")
       (property . "latest")
       (input (scores 100 0 90 30))
       (expected . 30))
     ((description . "Personal best")
       (property . "personalBest")
       (input (scores 40 100 70))
       (expected . 100))
     ((description . "Top 3 scores")
       (cases
         ((description . "Personal top three from a list of scores")
           (property . "personalTopThree")
           (input (scores 10 30 90 30 100 20 10 0 30 40 40 70 70))
           (expected 100 90 70))
         ((description . "Personal top highest to lowest")
           (property . "personalTopThree")
           (input (scores 20 10 30))
           (expected 30 20 10))
         ((description . "Personal top when there is a tie")
           (property . "personalTopThree")
           (input (scores 40 20 40 30))
           (expected 40 40 30))
         ((description . "Personal top when there are less than 3")
           (property . "personalTopThree")
           (input (scores 30 70))
           (expected 70 30))
         ((description . "Personal top when there is only one")
           (property . "personalTopThree")
           (input (scores 40))
           (expected 40))))))
 (protein-translation
   (exercise . "protein-translation")
   (version . "1.1.1")
   (cases
     ((description
        .
        "Translate input RNA sequences into proteins")
       (cases
        ((description . "Methionine RNA sequence")
          (property . "proteins")
          (input (strand . "AUG"))
          (expected "Methionine"))
        ((description . "Phenylalanine RNA sequence 1")
          (property . "proteins")
          (input (strand . "UUU"))
          (expected "Phenylalanine"))
        ((description . "Phenylalanine RNA sequence 2")
          (property . "proteins")
          (input (strand . "UUC"))
          (expected "Phenylalanine"))
        ((description . "Leucine RNA sequence 1")
          (property . "proteins")
          (input (strand . "UUA"))
          (expected "Leucine"))
        ((description . "Leucine RNA sequence 2")
          (property . "proteins")
          (input (strand . "UUG"))
          (expected "Leucine"))
        ((description . "Serine RNA sequence 1")
          (property . "proteins")
          (input (strand . "UCU"))
          (expected "Serine"))
        ((description . "Serine RNA sequence 2")
          (property . "proteins")
          (input (strand . "UCC"))
          (expected "Serine"))
        ((description . "Serine RNA sequence 3")
          (property . "proteins")
          (input (strand . "UCA"))
          (expected "Serine"))
        ((description . "Serine RNA sequence 4")
          (property . "proteins")
          (input (strand . "UCG"))
          (expected "Serine"))
        ((description . "Tyrosine RNA sequence 1")
          (property . "proteins")
          (input (strand . "UAU"))
          (expected "Tyrosine"))
        ((description . "Tyrosine RNA sequence 2")
          (property . "proteins")
          (input (strand . "UAC"))
          (expected "Tyrosine"))
        ((description . "Cysteine RNA sequence 1")
          (property . "proteins")
          (input (strand . "UGU"))
          (expected "Cysteine"))
        ((description . "Cysteine RNA sequence 2")
          (property . "proteins")
          (input (strand . "UGC"))
          (expected "Cysteine"))
        ((description . "Tryptophan RNA sequence")
          (property . "proteins")
          (input (strand . "UGG"))
          (expected "Tryptophan"))
        ((description . "STOP codon RNA sequence 1")
          (property . "proteins")
          (input (strand . "UAA"))
          (expected))
        ((description . "STOP codon RNA sequence 2")
          (property . "proteins")
          (input (strand . "UAG"))
          (expected))
        ((description . "STOP codon RNA sequence 3")
          (property . "proteins")
          (input (strand . "UGA"))
          (expected))
        ((description
           .
           "Translate RNA strand into correct protein list")
          (property . "proteins")
          (input (strand . "AUGUUUUGG"))
          (expected "Methionine" "Phenylalanine" "Tryptophan"))
        ((description
           .
           "Translation stops if STOP codon at beginning of sequence")
          (property . "proteins")
          (input (strand . "UAGUGG"))
          (expected))
        ((description
           .
           "Translation stops if STOP codon at end of two-codon sequence")
          (property . "proteins")
          (input (strand . "UGGUAG"))
          (expected "Tryptophan"))
        ((description
           .
           "Translation stops if STOP codon at end of three-codon sequence")
          (property . "proteins")
          (input (strand . "AUGUUUUAA"))
          (expected "Methionine" "Phenylalanine"))
        ((description
           .
           "Translation stops if STOP codon in middle of three-codon sequence")
          (property . "proteins")
          (input (strand . "UGGUAGUGG"))
          (expected "Tryptophan"))
        ((description
           .
           "Translation stops if STOP codon in middle of six-codon sequence")
          (property . "proteins")
          (input (strand . "UGGUGUUAUUAAUGGUUU"))
          (expected "Tryptophan" "Cysteine" "Tyrosine"))))))
 (series
   (exercise . "series")
   (version . "1.0.0")
   (cases
     ((description . "slices of one from one")
       (property . "slices")
       (input (series . "1") (sliceLength . 1))
       (expected "1"))
     ((description . "slices of one from two")
       (property . "slices")
       (input (series . "12") (sliceLength . 1))
       (expected "1" "2"))
     ((description . "slices of two")
       (property . "slices")
       (input (series . "35") (sliceLength . 2))
       (expected "35"))
     ((description . "slices of two overlap")
       (property . "slices")
       (input (series . "9142") (sliceLength . 2))
       (expected "91" "14" "42"))
     ((description . "slices can include duplicates")
       (property . "slices")
       (input (series . "777777") (sliceLength . 3))
       (expected "777" "777" "777" "777"))
     ((description . "slices of a long series")
       (property . "slices")
       (input (series . "918493904243") (sliceLength . 5))
       (expected "91849" "18493" "84939" "49390" "93904" "39042"
         "90424" "04243"))
     ((description . "slice length is too large")
       (property . "slices")
       (input (series . "12345") (sliceLength . 6))
       (expected
         (error .
           "slice length cannot be greater than series length")))
     ((description . "slice length cannot be zero")
       (property . "slices")
       (input (series . "12345") (sliceLength . 0))
       (expected (error . "slice length cannot be zero")))
     ((description . "slice length cannot be negative")
       (property . "slices")
       (input (series . "123") (sliceLength . -1))
       (expected (error . "slice length cannot be negative")))
     ((description . "empty series is invalid")
       (property . "slices")
       (input (series . "") (sliceLength . 1))
       (expected (error . "series cannot be empty")))))
 (roman-numerals
   (exercise . "roman-numerals")
   (version . "1.2.0")
   (cases
     ((description . "1 is a single I")
       (property . "roman")
       (input (number . 1))
       (expected . "I"))
     ((description . "2 is two I's")
       (property . "roman")
       (input (number . 2))
       (expected . "II"))
     ((description . "3 is three I's")
       (property . "roman")
       (input (number . 3))
       (expected . "III"))
     ((description . "4, being 5 - 1, is IV")
       (property . "roman")
       (input (number . 4))
       (expected . "IV"))
     ((description . "5 is a single V")
       (property . "roman")
       (input (number . 5))
       (expected . "V"))
     ((description . "6, being 5 + 1, is VI")
       (property . "roman")
       (input (number . 6))
       (expected . "VI"))
     ((description . "9, being 10 - 1, is IX")
       (property . "roman")
       (input (number . 9))
       (expected . "IX"))
     ((description . "20 is two X's")
       (property . "roman")
       (input (number . 27))
       (expected . "XXVII"))
     ((description . "48 is not 50 - 2 but rather 40 + 8")
       (property . "roman")
       (input (number . 48))
       (expected . "XLVIII"))
     ((description
        .
        "49 is not 40 + 5 + 4 but rather 50 - 10 + 10 - 1")
       (property . "roman")
       (input (number . 49))
       (expected . "XLIX"))
     ((description . "50 is a single L")
       (property . "roman")
       (input (number . 59))
       (expected . "LIX"))
     ((description . "90, being 100 - 10, is XC")
       (property . "roman")
       (input (number . 93))
       (expected . "XCIII"))
     ((description . "100 is a single C")
       (property . "roman")
       (input (number . 141))
       (expected . "CXLI"))
     ((description . "60, being 50 + 10, is LX")
       (property . "roman")
       (input (number . 163))
       (expected . "CLXIII"))
     ((description . "400, being 500 - 100, is CD")
       (property . "roman")
       (input (number . 402))
       (expected . "CDII"))
     ((description . "500 is a single D")
       (property . "roman")
       (input (number . 575))
       (expected . "DLXXV"))
     ((description . "900, being 1000 - 100, is CM")
       (property . "roman")
       (input (number . 911))
       (expected . "CMXI"))
     ((description . "1000 is a single M")
       (property . "roman")
       (input (number . 1024))
       (expected . "MXXIV"))
     ((description . "3000 is three M's")
       (property . "roman")
       (input (number . 3000))
       (expected . "MMM"))))
 (diamond
   (exercise . "diamond")
   (version . "1.1.0")
   (comments
     " The tests contained within this canonical data file are suitable   "
     " for value-based testing, in which each test case checks that the   "
     " value returned by the function under test is in every way          "
     " identical to a given expected value.                               "
     "                                                                    "
     " This exercise is also amenable to property-based testing, in which "
     " each test case verifies that the value returned by the function    "
     " under test exhibits a specific desired property.                   "
     "                                                                    "
     " Several tracks (notably, C# and Go) forgo the value-based tests    "
     " below in favor of property-based tests. If you are feeling         "
     " adventurous and would like to use this exercise to introduce the   "
     " concept of property-based testing to participants in your track,   "
     " please ignore the value-based tests below and instead reference    "
     " the test suites in the aforementioned tracks.                      ")
   (cases
     ((description . "Degenerate case with a single 'A' row")
       (property . "rows")
       (input (letter . "A"))
       (expected "A"))
     ((description
        .
        "Degenerate case with no row containing 3 distinct groups of spaces")
       (property . "rows")
       (input (letter . "B"))
       (expected " A " "B B" " A "))
     ((description
        .
        "Smallest non-degenerate case with odd diamond side length")
       (property . "rows")
       (input (letter . "C"))
       (expected "  A  " " B B " "C   C" " B B " "  A  "))
     ((description
        .
        "Smallest non-degenerate case with even diamond side length")
       (property . "rows")
       (input (letter . "D"))
       (expected "   A   " "  B B  " " C   C " "D     D" " C   C "
         "  B B  " "   A   "))
     ((description . "Largest possible diamond")
       (property . "rows")
       (input (letter . "Z"))
       (expected
        "                         A                         "
        "                        B B                        "
        "                       C   C                       "
        "                      D     D                      "
        "                     E       E                     "
        "                    F         F                    "
        "                   G           G                   "
        "                  H             H                  "
        "                 I               I                 "
        "                J                 J                "
        "               K                   K               "
        "              L                     L              "
        "             M                       M             "
        "            N                         N            "
        "           O                           O           "
        "          P                             P          "
        "         Q                               Q         "
        "        R                                 R        "
        "       S                                   S       "
        "      T                                     T      "
        "     U                                       U     "
        "    V                                         V    "
        "   W                                           W   "
        "  X                                             X  "
        " Y                                               Y "
        "Z                                                 Z"
        " Y                                               Y "
        "  X                                             X  "
        "   W                                           W   "
        "    V                                         V    "
        "     U                                       U     "
        "      T                                     T      "
        "       S                                   S       "
        "        R                                 R        "
        "         Q                               Q         "
        "          P                             P          "
        "           O                           O           "
        "            N                         N            "
        "             M                       M             "
        "              L                     L              "
        "               K                   K               "
        "                J                 J                "
        "                 I               I                 "
        "                  H             H                  "
        "                   G           G                   "
        "                    F         F                    "
        "                     E       E                     "
        "                      D     D                      "
        "                       C   C                       "
        "                        B B                        "
        "                         A                         "))))
 (spiral-matrix
   (exercise . "spiral-matrix")
   (version . "1.1.0")
   (cases
     ((description . "empty spiral")
       (property . "spiralMatrix")
       (input (size . 0))
       (expected))
     ((description . "trivial spiral")
       (property . "spiralMatrix")
       (input (size . 1))
       (expected (1)))
     ((description . "spiral of size 2")
       (property . "spiralMatrix")
       (input (size . 2))
       (expected (1 2) (4 3)))
     ((description . "spiral of size 3")
       (property . "spiralMatrix")
       (input (size . 3))
       (expected (1 2 3) (8 9 4) (7 6 5)))
     ((description . "spiral of size 4")
       (property . "spiralMatrix")
       (input (size . 4))
       (expected (1 2 3 4) (12 13 14 5) (11 16 15 6) (10 9 8 7)))
     ((description . "spiral of size 5")
       (property . "spiralMatrix")
       (input (size . 5))
       (expected (1 2 3 4 5) (16 17 18 19 6) (15 24 25 20 7)
         (14 23 22 21 8) (13 12 11 10 9))))))
