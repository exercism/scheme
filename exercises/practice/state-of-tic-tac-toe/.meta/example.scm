(import (rnrs))

(define (winner? bitset)
  (exists
    (lambda (line) (= line (logand bitset line)))
    '(#x007 #x070 #x700 #x111 #x222 #x444 #x124 #x421)))

(define (placement board player)
  (let outer ((board board)
              (bitset 0))
    (if (null? board)
      bitset
      (let inner ((row (string->list (car board)))
                  (bitset (ash bitset 1)))
        (cond
          ((null? row)
            (outer (cdr board) bitset))
          ((char=? (car row) player)
            (inner (cdr row) (logior (ash bitset 1) 1)))
          (else
            (inner (cdr row) (ash bitset 1))))))))

(define (gamestate board)
  (let* ((placement-x (placement board #\X))
         (placement-o (placement board #\O))
         (winner-x (winner? placement-x))
         (winner-o (winner? placement-o))
         (count-x (bitwise-bit-count placement-x))
         (count-o (bitwise-bit-count placement-o)))
    (cond
      ((< count-x count-o)
        (error 'gamestate "Wrong turn order: O started"))
      ((< (+ count-o 1) count-x)
        (error 'gamestate "Wrong turn order: X went twice"))
      ((or (and winner-x (= count-o count-x))
           (and winner-o (= count-x (+ count-o 1)))
           (and winner-x winner-o))
        (error 'gamestate "Impossible board: game should have ended after the game was won"))
      ((or winner-x winner-o)
        'win)
      ((= (+ count-x count-o) 9)
        'draw)
      (else
        'ongoing))))
