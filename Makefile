##########################################################
# build system -- mk-configure

FILES               =	pipestatus
FILESDIR_pipestatus =	${BINDIR}

DOCFILES ?=		NEWS README
FILES    +=		${DOCFILES}
SCRIPTS  +=		pipestatus_demo
FILESDIR  =		${DATADIR}/doc/pipestatus
SCRIPTSDIR=		${FILESDIR}

##########################################################
SH ?= /bin/sh

.PHONY: test
test:
	@printf " ---------------\nSH=%s\n" ${SH}; \
	set -e; cd ${.CURDIR}; ${SH} ./selftest; echo succeeded

NAMES ?= bash dash zsh mksh oksh pdksh ksh sh
DIRS  ?= /usr/pkg/bin /usr/local/bin /usr/xpg4/bin /usr/bin /bin

.for s in ${NAMES}
.for d in ${DIRS}
SHELLS += ${d}/${s}
.endfor
.endfor

.PHONY: test_all
test_all:
	@set -e; cd ${.CURDIR}; \
	for sh in ${SHELLS}; do \
		if test -x $$sh; then \
			printf '%s... ' "$$sh"; \
			$$sh ./selftest; \
			echo 'succeeded'; \
		fi; \
	done

##########################################################

.include <mkc.files.mk>
