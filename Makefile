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

NAMES ?= sh ksh bash dash zsh mksh pdksh 
DIRS  ?= /bin /usr/bin /usr/pkg/bin /usr/local/bin

.for s in ${NAMES}
.for d in ${DIRS}
SHELLS += ${d}/${s}
.endfor
.endfor

.PHONY: test_all
test_all:
	@set -e; \
	for sh in ${SHELLS}; do \
		if test -x $$sh; then \
			$(MAKE) test SH=$$sh; \
		fi; \
	done

##########################################################

.include <mkc.files.mk>
