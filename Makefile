problem-specifications := git@github.com:exercism/problem-specifications.git

default : track

../problem-specifications :
	cd .. && git clone $(problem-specifications)

bin/configlet :
	./bin/fetch-configlet

config.json : load.ss code/config.ss
	echo "(make-config)" | scheme -q $<

build : load.ss ../problem-specifications
	echo "(build-implementations)" | scheme -q $<

test : load.ss
	echo "(for-each verify-exercism implementations)" | scheme -q $<

track : ../problem-specifications config.json bin/configlet
	make build && make test && ./bin/configlet fmt . && ./bin/configlet lint .

clean :
	find . -name "*.so" -exec rm {} \;
	find . -name "*~" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	rm -rf _build

