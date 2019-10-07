chez := scheme

problem-specifications := git@github.com:exercism/problem-specifications.git

doc-files := \
	ABOUT \
	INSTALLATION \
	RESOURCES \
	TESTS

implementations := \
	affine-cipher \
	queen-attack \
	matching-brackets \
	pangram \
	binary-search \
	hello-world \
	leap \
	hamming \
	atbash-cipher \
	grains \
	anagram \
	pascals-triangle \
	rna-transcription \
	difference-of-squares \
	nucleotide-count \
	scrabble-score \
	two-fer \
	word-count \
	knapsack \
	raindrops \
	phone-number \
	bob \
	prime-factors \
	transpose \
	rotational-cipher \
	perfect-numbers \
	change \
	sieve

track-documentation := $(foreach doc,$(doc-files),docs/$(doc).md)

exercisms := $(foreach exercism,$(implementations),exercises/$(exercism))

readme-splice := config/exercise-readme-insert.md

track-requirements := \
	../problem-specifications \
	bin/configlet \
	code/stub-makefile \
	$(readme-splice) \
	$(exercisms) \
	config.json

# run given expression after loading load.ss
exercise = echo $(1) | $(chez) -q load.ss

default : track

# exercism/problem-specifications repo
../problem-specifications :
	cd .. && git clone $(problem-specifications)

# configlet binary
bin/configlet :
	./bin/fetch-configlet

# configuration
config.json : code/config.ss
	$(call exercise, "(make-config)")

# documentation
docs/%.md : code/md.ss code/docs/%.ss
	$(call exercise, "(put-doc '$(@F:.md=))")

$(readme-splice) : $(track-documentation)
	cp docs/TESTS.md $@

# exercises
exercises/% : code/md.ss code/test.ss code/track.ss code/exercises/%/* code/stub-makefile
	$(call exercise, "(make-exercism '$(@F))")

# build track
track : $(track-requirements)
	./bin/configlet generate .
	./bin/configlet lint .

# send a list of implementations to run stub-makefile tests on
ci :
	echo "(run-ci '($(implementations)))" | $(chez) -q "code/ci.ss"

clean :
	find . -name "*.so" -exec rm {} \;
	find . -name "*~" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	rm -rf _build
	rm ci

.PHONY : track clean

