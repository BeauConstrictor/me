IN   := site/
OUT  := build/
CHEF := ./chef
VARS :=

VARS += -d NAME beauconstrictor
VARS += -d EMAIL beauconstrictor@tilde.team

.PHONY: all
all:
	@bash -ec '\
		rm -rf "$(OUT)"; \
		find "$(IN)" -print0 | while IFS= read -r -d "" file; do \
		outpath="$(OUT)/$${file#site/}"; \
		src="$$file"; \
		case "$$outpath" in \
			*.gmi) outpath="$${outpath%.*}.html" ;; \
		esac; \
		echo "$$src -> $$outpath" ; \
		if [ -d "$$file" ]; then \
		  mkdir -p "$$outpath"; \
		else \
		  $(CHEF) $(VARS) -o "$$outpath" "$$src"; \
		fi; \
	done'

.PHONY: clean
clean:
	rm -rf "$(OUT)"

.PHONY: run
run: all
	@python -m http.server -d "$(OUT)/"
