# HARFBUZZ

HARFBUZZ_VERSION := 0.9.19
HARFBUZZ_URL := http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-$(HARFBUZZ_VERSION).tar.bz2
PKGS += harfbuzz
ifeq ($(call need_pkg,"harfbuzz"),)
PKGS_FOUND += harfbuzz
endif

$(TARBALLS)/harfbuzz-$(HARFBUZZ_VERSION).tar.bz2:
	$(call download,$(HARFBUZZ_URL))

.sum-harfbuzz: harfbuzz-$(HARFBUZZ_VERSION).tar.bz2

harfbuzz: harfbuzz-$(HARFBUZZ_VERSION).tar.bz2 .sum-harfbuzz
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

DEPS_harfbuzz = freetype2 $(DEPS_freetype2)

.harfbuzz: harfbuzz
	cd $< && env NOCONFIGURE=1 sh autogen.sh
	cd $< && $(HOSTVARS) CFLAGS="$(CFLAGS)" ./configure $(HOSTCONF) --with-icu=no
	cd $< && $(MAKE) install
	touch $@
