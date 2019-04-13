kylix_bin=/opt/kylix3/bin
#kylix_bin=/home/toni/kylix3/bin
drivers_path=../../drivers/linux
net_path=../../../reportmannet
rpversion=2_9a

install:
	make clean
	cp $(kylix_bin)/libqtintf-6.9-qt2.3.so .
	cp $(kylix_bin)/libborqt-6.9-qt2.3.so .
	cp $(kylix_bin)/libmidas.so.1 .
	cp $(kylix_bin)/libborunwind.so.6.0 .
	cp $(drivers_path)/libsqldb2.so .
	cp $(drivers_path)/libsqlib.so .
	cp $(drivers_path)/libsqlinf.so .
	cp $(drivers_path)/libsqlmy.so.1 .
	cp $(drivers_path)/libsqlmy23.so .
	cp $(drivers_path)/libsqlpg.so .
	cp $(drivers_path)/libsqlora.so .
	cp $(drivers_path)/libdbxoodbc.so .
	cp $(drivers_path)/dbxres.en.1 .
	mkdir apilib
	mkdir apilib/sample
	cp ../../dll/libreportmanapi.so ../../dll/libreportmanapiqt.so apilib
	cp ../gcctest/test.cc ../gcctest/testqtlin.cc ../gcctest/GNUmakefile ../gcctest/testqtlin.sh ../gcctest/test.sh ../../rpreportmanapi.h ../../rpreportmanapiqt.h apilib/sample
	cp ../../repman/repmand .
	cp ../../repman/dbxdrivers .
	cp ../../repman/dbxconnections .
	cp ../../repman/utils/metaprint/metaprint .
	cp ../../repman/utils/metaview/metaview .
	cp ../../repman/utils/printrep/printrep .
	cp ../../repman/utils/reptotxt/reptotxt .
	cp ../../repman/utils/txttorep/txttorep .
#	Patchelf for execshield execution
	cp ../../repman/utils/startup/startup.bin repmand.bin
	cp ../../repman/utils/startup/startupk2.bin .
	./patchelf repmand.bin
	./patchelf startupk2.bin
	cp repmand.bin metaview.bin
	cp repmand.bin printrep.bin
	cp printrep.bin printreptopdf.bin
	cp printrep.bin reportserverapp.bin
	cp printrep.bin reportservercon.bin
	cp printrep.bin repserverconfig.bin
	cp printrep.bin metaprint.bin
	cp printrep.bin repwebexe.bin
	cp printrep.bin repwebexex.bin
	cp ../../server/app/reportserverapp .
	cp ../../server/app/reportservercon .
	cp ../../server/config/repserverconfig .
	cp ../../server/web/repwebexe .
	cp ../../server/web/repwebexex .
	cp ../../server/web/.htaccess .
	cp ../../repman/utils/printreptopdf/printreptopdf .
	cp ../../repman/reportmanres.es .
	cp ../../repman/reportmanres.fr .
	cp ../../repman/reportmanres.en .
	cp ../../repman/reportmanres.cat reportmanres.ca
	cp ../../repman/reportmanres.pt .
	cp ../../repman/reportmanres.it .
	cp ../../repman/reportmanres.de .
	cp ../../LICENSE.TXT .
#	cp ../../repman/repmand.es .
	-cp ../clxreport/Project1 .
	cp ../../repman/repsamples/sample4.rep .
	cp ../clxreport/biolife.cds .
	cp biolife.cds apilib/sample
	cp sample4.rep apilib/sample
	mkdir doc
	cp ../../doc/doc/*.html doc
	mkdir doc/images
	mkdir doc/units
	cp ../../doc/doc/units/*.html doc/units
	cp ../../doc/doc/images/*.jpg doc/images
	mkdir net
	mkdir net2
	cp $(net_path)/output/printreport.exe net
	cp $(net_path)/output/*.dll net
	cp $(net_path)/output2/printreport.exe net2
	cp $(net_path)/output2/printreport.exe.config net2
	cp $(net_path)/output2/*.dll net2
#	include repmand.es when linux translation done
#	Patching for execution on execshield
	./patchelf repmand
	./patchelf printreptopdf
	./patchelf reportservercon
	./patchelf reportserverapp
	./patchelf repserverconfig
	./patchelf repwebexe
	./patchelf repwebexex
	./patchelf reptotxt
	./patchelf txttorep
	./patchelf printrep
	./patchelf metaview
	./patchelf metaprint
	./patchelf apilib/libreportmanapiqt.so
	./patchelf apilib/libreportmanapi.so
	./patchelf libborqt-6.9-qt2.3.so
	./patchelf libdbxoodbc.so
	./patchelf libqtintf-6.9-qt2.3.so
	./patchelf libsqldb2.so
	./patchelf libsqlib.so
	./patchelf libsqlinf.so
	./patchelf libsqlmy23.so
	./patchelf libsqlora.so
	./patchelf libsqlpg.so
	./patchelf libborunwind.so.6.0
	tar c libdbxoodbc.txt LICENSE.TXT sample4.rep biolife.cds reportmanres.pt reportmanres.it reportmanres.de reportmanres.ca reportmanres.en reportmanres.es reportmanres.fr repmand dbxdrivers dbxconnections repmand repmand.sh repmand.bin README *.so *.so.1 dbxres.en.1 libborunwind.so.6.0 startupk2.bin net net2 > rpdesigner-$(rpversion).i386.tar
	gzip rpdesigner-$(rpversion).i386.tar
	tar c LICENSE.TXT reportserverapp reportserverapp.sh reportserverapp.bin reportservercon reportservercon.sh reportservercon.bin repserverconfig repserverconfig.sh repserverconfig.bin metaprint metaprint.sh metaprint.bin metaview metaview.sh metaview.bin printrep printrep.sh printrep.bin printreptopdf printreptopdf.sh printreptopdf.bin reptotxt txttorep repwebexe repwebexe.bin repwebexex repwebexex.bin .htaccess > rpservercline-$(rpversion).i386.tar
	gzip rpservercline-$(rpversion).i386.tar
	tar c LICENSE.TXT apilib > rplibapi-$(rpversion).i386.tar
	gzip rplibapi-$(rpversion).i386.tar
	tar c LICENSE.TXT doc > rpdocs-$(rpversion).i386.tar
	gzip rpdocs-$(rpversion).i386.tar
clean:
	-rm -f *.so *.so.1 *.so.2 *.so.1.0
	-rm -f repmand
	-rm -f dbxconnections dbxdrivers metaprint metaview printrep printreptopdf
	-rm -f reptotxt txttorep repserverconfig reportservercon repwebexe
	-rm -f *.gz
	-rm -f *.rep
	-rm -f *.cds
	-rm -Rf doc
	-rm -f *.rpmf
	-rm -f *.tar
	-rm -f *.pdf
	-rm -f repmand.es
	-rm -f reportmanres*
	-rm -f LICENSE.TXT
	-rm -f dbxres.en.*
	-rm -f reportserverapp
	-rm -f *.bin
	-rm -f .htaccess
	-rm -Rf apilib
	-rm -f libborunwind.so.6.0
	-rm -Rf net
	-rm -Rf net2
