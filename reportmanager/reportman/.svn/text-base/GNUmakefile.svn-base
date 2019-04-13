kylix_bin=/opt/kylix3/bin
compile=$(kylix_bin)/dcc


all: packages repman

repman:
	cd repman
	$(comile) repmand.dpr
	cd ..



clean:
	-rm -Rf *.dcu repman/*.dcu
	-rm -Rf *.hpp *.tds *.map *.a *.bpi
	-rm -Rf repman/*.map
	-rm -Rf *.dpu repman/*.dpu
	-rm -Rf *.~* repman/*.~*
	-rm -Rf *.exe repman/*.exe
	-rm -Rf *.o repman/*.o
	-rm -Rf *.dcp repman/*.dcp
	-rm -Rf *.ow repman/*.ow
	-rm -Rf *.rst repman/*.rst
	-rm -Rf repman/utils/metaview/*.dcu
	-rm -Rf repman/utils/metaview/*.dpu
	-rm -Rf repman/utils/metaview/*.~*
	-rm -Rf repman/utils/metaprint/*.~*
	-rm -Rf repman/utils/metaprint/*.dcu
	-rm -Rf repman/utils/metaprint/*.dpu
	-rm -Rf repman/utils/metaview/*.~*
	-rm -Rf repman/utils/reptotxt/*.dcu
	-rm -Rf repman/utils/reptotxt/*.dpu
	-rm -Rf repman/utils/txttorep/*.~*
	-rm -Rf repman/utils/txttorep/*.dpu
	-rm -Rf repman/utils/txttorep/*.dcu
	-rm -Rf repman/utils/reptotxt/*.~*
	-rm -Rf repman/utils/printrep/*.~*
	-rm -Rf repman/utils/printreptopdf/*.~*
	-rm -Rf repman/utils/printrep/*.dcu
	-rm -Rf repman/utils/printreptopdf/*.dcu
	-rm -Rf repman/utils/startup/startup.bin
	-rm -Rf repman/utils/startup/*.dcu
	-rm -Rf repman/utils/startup/*.~*
	-rm -Rf repman/utils/startup/*.dpu
	-rm -Rf repman/meta.rpmf
	-rm -Rf server/app/*.~*
	-rm -Rf server/app/*.dcu
	-rm -Rf server/app/*.dpu
	-rm -Rf server/app/reportserverapp
	-rm -Rf server/app/reportservercon
	-rm -Rf server/config/repserverconfig
	-rm -Rf server/config/*.dcu
	-rm -Rf server/config/*.dpu
	-rm -Rf server/config/*.~*
	-rm -Rf server/web/*.~*
	-rm -Rf server/web/*.dcu
	-rm -Rf server/web/*.dpu
	-rm -Rf server/web/repwebexe

	

	-rm tests/eval/project1
	-rm tests/metafiles/metafile
	-rm tests/objinsp/project1
	-rm tests/params/project1
	-rm tests/qpainter/project2
	-rm tests/ruler/project1
	-rm repman/utils/reptotxt/reptotxt
	-rm repman/utils/txttorep/txttorep
	-rm repman/utils/printrep/printrep
	-rm repman/utils/printreptopdf/printreptopdf
	-rm repman/utils/metaprint/metaprint
	-rm repman/utils/metaview/metaview
	-rm tests/repmand/*.so tests/repmand/*.so.1 tests/repmand/*.so.2
	-rm tests/repmand/repmand
	-rm tests/repmand/dbxdrivers
	-rm tests/repmand/dbxconnections
	-rm tests/repmand/metaview
	-rm tests/repmand/metaprint
	-rm repman/repmand
	-rm tests/repmand/printrep
	-rm tests/repmand/Project1
	-rm tests/repmand/sample4.rep
	-rm tests/repmand/biolife.cds
	-rm tests/repmand/*.0
	-rm tests/repmand/*.tar
	-rm tests/repmand/*.gz
	-rm tests/repmand/meta.rpmf
	-rm tests/repmand/reptotxt
	-rm tests/repmand/txttorep
	-rm tests/clxreport/Project1
	-rm tests/clxreport/*.dcu
	-rm tests/clxreport/*.~*
	-rm tests/clxreport/Project2
	-rm tests/printbug/*.~*
	-rm tests/printbug/Project1
	-rm tests/printbug/*.dcu
	-rm tests/pdf/pdftest
	-rm tests/pdf/*.dcu
	-rm tests/pdf/*.~*
real_clean: clean
	-rm -Rf  *.bpl
	-rm -Rf  *.so
packages:
	$(compile) rppack.dpk
	$(compile) rppackv.dpk
	$(compile) rppackdesign.dpk
