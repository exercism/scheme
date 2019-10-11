chez := scheme

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
	../problem-specifications \
	bin/configlet \
	closet/skeleton-makefile \
	closet/specifications.fasl \
	closet/config.fasl \
	$(readme-splice) \
	$(exercisms) \
	config.json

# run given expression after loading load.ss
exercise = echo $(1) | $(chez) -q load.ss

default : track

# exercism/problem-specifications repo
../problem-specifications :
	cd .. && git clone $(problem-specifications)

closet/specifications.fasl : ../problem-specifications
	$(call exercise, "(persist-specifications)")

closet/config.fasl : config/track.ss
	$(call exercise, "(persist-config)")

config.json : closet/config.fasl
	$(call exercise, "(make-config)")

# configlet binary
bin/configlet :
	./bin/fetch-configlet

# documentation
docs/%.md : code/markdown.sls code/docs/%.ss
	$(call exercise, "(put-doc '$(@F:.md=))")

$(readme-splice) : $(track-documentation)
	cp docs/TESTS.md $@

# exercises
exercises/% : code/markdown.sls closet/test.ss code/track.ss code/exercises/%/* closet/skeleton-makefile
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

