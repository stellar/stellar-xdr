XFILES := $(wildcard *.x)
PREPROCESS_FLAGS ?=

.PHONY: preprocess

preprocess:
	@for f in $(XFILES); do \
		stellar-xdr xfile preprocess $(PREPROCESS_FLAGS) "$$f" > "$$f.tmp" && mv "$$f.tmp" "$$f"; \
	done
	git diff
