(import (rnrs))

(define (orbital-period planet)
  (case planet
    ((mercury) 0.2408467)
    ((venus) 0.61519726)
    ((earth) 1.0)
    ((mars) 1.8808158)
    ((jupiter) 11.862615)
    ((saturn) 29.447498)
    ((uranus) 84.016846)
    ((neptune) 164.79132)
    (else (error 'orbital-period "not a planet" planet))))

(define (age planet seconds)
  (/ seconds (* (orbital-period planet) 31557600)))
