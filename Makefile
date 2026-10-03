chez := scheme

ci:
	./bin/verify-exercises

clean:
	find exercises -name '*.so' -delete
	find exercises -name '*~' -delete

.PHONY: ci clean
