compo:
	cp ../../*.pas ../../*.conf ../../*.res ../../*.dpk ../../*.dcr ../../*.conf ../../*.dof ../../*.kof ../../*.ddp ../../*.xfm ../../*.dfm ../../*.cfg ../../*.cpp ../../*.bpk ../../*.inc .
	mkdir sample
	cp ../../tests/clxreport/Unit1.* sample
	cp ../../tests/clxreport/Project1.* sample
	cp ../../repman/repsamples/sample4.rep sample
	cp ../../repman/repsamples/biolife.cds sample
	zip repman.zip *.pas *.conf *.res *.dpk *.dcr *.conf *.dof *.kof *.ddp *.xfm *.dfm *.cfg *.cpp *.bpk *.inc README
	zip -r repman.zip sample

clean:
	-rm *.pas *.conf *.res *.dpk *.dcr *.conf *.dof *.kof *.ddp *.xfm *.dfm *.cfg *.cpp *.bpk *.inc
	-rm -Rf sample
	-rm GNUmakefile~
	
