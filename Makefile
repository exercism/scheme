chez := scheme

problem-specifications-rev := c6cd8f27b20aa931457bce4377214cb62fbe4187
problem-specifications := git@github.com:exercism/problem-specifications.git

doc-files := \
	ABOUT \
	INSTALLATION \
	RESOURCES \
	TESTS

implementations := \
	collatz-conjecture \
	forth \
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
	Makefile \
	../problem-specifications \
	bin/configlet \
	input/skeleton-makefile \
	input/specifications.ss \
	$(readme-splice) \
	$(exercisms) \
	config.json

# run given expression upon loading the code
exercise = echo $(1) | $(chez) -q load.ss

default : track

# PROBLEM-SPECIFICATIONS
../problem-specifications :
	cd .. && git clone $(problem-specifications)
	cd $@ && git checkout $(problem-specifications-rev)

input/specifications.ss : ../problem-specifications
	$(call exercise, "(persist-specifications)")

# CONFIG
config.json : config/track.ss
	$(call exercise, "(make-config)")

# configlet binary
bin/configlet :
	./bin/fetch-configlet

# documentation
docs/%.md : code/markdown.sls input/docs/%.ss
	$(call exercise, "(put-doc '$(@F:.md=))")

$(readme-splice) : $(track-documentation)
	cp docs/TESTS.md $@

# exercises
exercises/% : code/*.sls input/skeleton-* code/track.ss input/exercises/%/*
	$(call exercise, "(make-exercism '$(@F))")

# build track
track : $(track-requirements)
	./bin/configlet generate .
	./bin/configlet fmt .
	./bin/configlet lint .

# send a list of implementations to run stub-makefile tests on
ci :
	echo "(run-ci '($(implementations)))" | $(chez) -q "script/ci.ss"

clean :
	find . -name "*.so" -exec rm {} \;
	find . -name "*~" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	rm -rf _build ci

.PHONY : track clean
