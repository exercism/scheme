solution := 

chez := scheme
guile := guile

help :
	echo "Test your solutions from the command line by calling make *, where * is the name of your scheme."

check-all : chez guile

chez :
	$(chez) --script test.scm $(solution)

guile :
	$(guile) -q test.scm $(solution)

.PHONY : help check-all check-chez check-guile
