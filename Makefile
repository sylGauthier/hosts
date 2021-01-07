PREFIX=/etc

EXTENSIONS=$(shell xargs -i find {} -type f < select | grep -v -f unselect)

all: hosts

base/hosts: base/urls
	for u in $$(cat base/urls) ; do \
		printf "fetching $$u...\n"; \
		wget "$$u" -O - 2> /dev/null | tr -d '\015' >> base/hosts || die "couldn't download from $$u"; \
		printf "\n\n" >> base/hosts; \
	done

hosts: base/hosts select unselect $(EXTENSIONS)
	cat $< > $@
	for i in $(EXTENSIONS) ; do \
		printf "adding $$i\n"; \
		cat "$$i" >> $@; \
	done

clean:
	rm -f base/hosts hosts

install: hosts
	cp hosts $(PREFIX)
