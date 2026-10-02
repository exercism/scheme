chez := scheme

ci:
	echo "(run-all-tests 'list-ops 'robot-name 'acronym)" | $(chez) -q script/ci.ss

clean:
	find exercises -name '*.so' -delete
	find exercises -name '*~' -delete

.PHONY: ci clean
