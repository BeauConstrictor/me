IN   := site/
OUT  := build/
CHEF := ./chef
VARS :=

.PHONY: all
all:
	@./all

.PHONY: clean
clean:
	rm -rf "$(OUT)"

.PHONY: run
run: gopher

.PHONY: http
http:
	@python -m http.server -d "$(OUT)/html/"

.PHONY: gopher
gopher:
	gophernicus -r "$(OUT)/gopher/"
