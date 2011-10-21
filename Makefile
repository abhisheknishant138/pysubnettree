# Makefile not needed to build module. Use "python setup.py install" instead.
#
# This Makefile generates the SWIG wrappers and the documentation.

DISTFILES=COPYING Makefile README SubnetTree.cc SubnetTree.h \
	SubnetTree.i SubnetTree.py SubnetTree_wrap.cc patricia.c patricia.h setup.py test.py

CLEAN=build SubnetTree_wrap.cc SubnetTree.py README.html *.pyc 

VERSION=`test -e VERSION && cat VERSION || cat ../VERSION`
BUILD=build
TGZ=pysubnettree-$(VERSION)

all: SubnetTree_wrap.cpp

SubnetTree_wrap.cpp SubnetTree.py: SubnetTree.i SubnetTree.h
	swig -c++ -python -o SubnetTree_wrap.cc SubnetTree.i

clean:
	rm -rf $(CLEAN)

dist:
	@install -d $(BUILD)
	@rm -rf $(BUILD)/$(TGZ)
	@mkdir $(BUILD)/$(TGZ)
	@cp -rp $(DISTFILES) $(BUILD)/$(TGZ)
	cd $(BUILD) && tar czvf $(TGZ).tar.gz $(TGZ)
	@rm -rf $(BUILD)/$(TGZ)
	@echo "Package: $(BUILD)/$(TGZ).tar.gz"

distclean:
	rm -rf $(BUILD)
