solution := 

chez := scheme
guile := guile

help :
	echo 'Run make chez or make guile'

check-all : chez guile

chez :
	$(chez) --script test.scm $(solution)

guile :
	$(guile) test.scm $(solution)

.PHONY : help check-all chez guile
