;DELPHIPATH=c:\Archivos de programa\Borland\Delphi7
DELPHIPATH=h:\prog\Delphi7
REPORTMANPATH=c:\prog\toni\cvsroot\reportman\reportman;c:\prog\toni\zeos\src\component;c:\prog\toni\zeos\src\dbc;c:\prog\toni\zeos\src\core;c:\prog\toni\zeos\src\parse;c:\prog\toni\zeos\src\parsesql;c:\prog\toni\zeos\src\plain
PACKAGESPATH="$(DELPHIPATH)\Projects\Bpl"
COMPILE="$(DELPHIPATH)\bin\dcc32" -LN$(PACKAGESPATH) -LE$(PACKAGESPATH) -U"$(REPORTMANPATH);$(DELPHIPATH)\projects\bpl" -I"$(REPORTMANPATH)"
IMPLIB="h:\progd\cbuilder6\bin\implib" 
all: clean packages reportman webplugin prerelease

reportman: reportmanutils reportmanserver reportmanutilsxp reportmanserverxp

webplugin:   
        make clean_noexe
        cd repman
        cd utils
        cd metaview
        $(COMPILE) -DFORWEBAX metaview.dpr
        $(COMPILE) -DFORWEBAX metaviewxp.dpr
        cd ..
        cd metaprint
        $(COMPILE) -DFORWEBAX metaprint.dpr
        $(COMPILE) -DFORWEBAX metaprintxp.dpr
        cd ..
        cd ..
        cd ..
        
        cd server
        cd config
        $(COMPILE) -DFORWEBAX repserverconfig.dpr
        $(COMPILE) -DFORWEBAX repserverconfigxp.dpr
        cd ..
        cd ..

        cd webactivex
        $(COMPILE)  -DFORWEBAX WebReportManX.dpr
        generatecab
        cd ..

prerelease:
        cd webactivex
        generatecab
        cd ..

        -del /S /Q ..\prerelease
        -mkdir ..\prerelease
        copy repman\repmandxp.exe ..\prerelease
        copy repman\utils\rptranslator\rptranslateres.* ..\prerelease
        copy repman\reportmanres.* ..\prerelease
        copy repman\repmandxp.exe.manifest ..\prerelease
        copy repman\repmand.exe ..\prerelease
        copy repman\dbxdrivers.ini ..\prerelease
        copy repman\dbxconnections.ini ..\prerelease
        copy repman\repsamples\sample4.rep ..\prerelease
        copy repman\repsamples\biolife.cds ..\prerelease
        copy drivers\win32\*.* ..\prerelease
        copy repman\utils\printrep\printrep.exe ..\prerelease
        copy repman\utils\printrep\printrep.exe.manifest ..\prerelease
        copy repman\utils\printrep\printrepxp.exe ..\prerelease
        copy repman\utils\printrep\printrepxp.exe.manifest ..\prerelease
        copy repman\utils\metaview\metaviewxp.exe ..\prerelease
        copy repman\utils\metaview\metaviewxp.exe.manifest ..\prerelease
        copy repman\utils\metaview\metaview.exe ..\prerelease
        copy repman\utils\metaview\metaview.exe.manifest ..\prerelease
        copy repman\utils\printreptopdf\printreptopdf.exe ..\prerelease
        copy repman\utils\metaprint\metaprint.exe ..\prerelease
        copy repman\utils\metaprint\metaprint.exe.manifest ..\prerelease
        copy repman\utils\metaprint\metaprintxp.exe ..\prerelease
        copy repman\utils\metaprint\metaprintxp.exe.manifest ..\prerelease
        copy repman\utils\txttorep\txttorep.exe ..\prerelease
        copy repman\utils\reptotxt\reptotxt.exe ..\prerelease
        copy repman\utils\rptranslator\rptranslate.exe ..\prerelease
        copy repman\utils\rptranslator\rptranslate.exe.manifest ..\prerelease
        copy repman\utils\compilerep\compilerep.exe ..\prerelease
        copy drivers\win32\upx.exe ..\prerelease
        copy repman\utils\unixtodos\unixtodos.exe ..\prerelease
        copy server\app\reportserverapp.exe ..\prerelease
        copy server\app\reportserverapp.exe.manifest ..\prerelease
        copy server\app\reportserverappxp.exe ..\prerelease
        copy server\app\reportserverappxp.exe.manifest ..\prerelease
        copy server\app\reportservercon.exe ..\prerelease
        copy server\config\repserverconfig.exe ..\prerelease
        copy server\config\repserverconfig.exe.manifest ..\prerelease
        copy server\config\repserverconfigxp.exe ..\prerelease
        copy server\config\repserverconfigxp.exe.manifest ..\prerelease
        copy server\service\repserverservice.exe ..\prerelease
        copy server\service\repserviceinstall.exe ..\prerelease
        copy server\service\repserviceinstall.exe.manifest ..\prerelease
        copy server\web\repwebexe.exe ..\prerelease
        copy server\web\repwebserver.dll ..\prerelease
        copy webactivex\WebReportManX.cab ..\prerelease
        copy activex\ReportMan.ocx ..\prerelease
        -mkdir ..\prerelease\doc
        -mkdir ..\prerelease\tutorial
        xcopy /s doc\tutorial ..\prerelease\tutorial
        xcopy /s doc\doc ..\prerelease\doc


reportmanutils:
        cd repman
        $(COMPILE) -DREPMANRELEASE repmand.dpr
        cd utils\reptotxt
        $(COMPILE) reptotxt.dpr
        cd ..
        cd txttorep
        $(COMPILE) txttorep.dpr
        cd ..
        cd printreptopdf
        $(COMPILE) -DREPMANRELEASE printreptopdf.dpr
        cd ..
        cd printrep
        $(COMPILE) -DREPMANRELEASE printrep.dpr
        cd ..
        cd startup
        $(COMPILE) startup.dpr
        cd ..
        cd unixtodos
        $(COMPILE) unixtodos.dpr
        cd ..
        cd compilerep
        $(COMPILE) compilerep.dpr
        cd ..

        cd ..
        cd ..

reportmanserver:
        cd server
        cd app
        $(COMPILE) -DREPMANRELEASE reportserverapp.dpr
        $(COMPILE) -DREPMANRELEASE reportservercon.dpr
        cd ..
        cd web
        $(COMPILE) -DREPMANRELEASE repwebexe.dpr
        cd ..
        cd ..


designerxp:
        cd repman
        $(COMPILE) -DREPMANRELEASE repmandxp.dpr
        cd ..

reportmanutilsxp: designerxp
        cd repman

        cd utils
        cd printrep
        $(COMPILE) -DREPMANRELEASE printrepxp.dpr
        cd ..
        cd rptranslator
        $(COMPILE) rptranslate.dpr
        cd ..


        cd ..
        cd ..

        cd activex
        $(COMPILE) -DREPMANRELEASE Reportman.dpr
        $(IMPLIB) Reportman.lib Reportman.ocx
        cd ..

reportmanserverxp:
        cd server
        cd app
        $(COMPILE) -DREPMANRELEASE reportserverappxp.dpr
        cd ..
        cd service
        $(COMPILE) -DREPMANRELEASE repserverservice.dpr
        $(COMPILE) repserviceinstall.dpr
        cd ..
        cd web
        $(COMPILE) -DREPMANRELEASE repwebserver.dpr
        cd ..
        cd ..

packages: rtlpackages vcldesignpackages designtimepackages clxpackages designpackages

rtlpackages:
        $(COMPILE) -DREPMANRELEASE rppack_del.dpk
        $(COMPILE) -DREPMANRELEASE rppackvcl_del.dpk
designpackages:
        $(COMPILE) -DREPMANRELEASE rppackdesigntime_del.dpk
clxpackages:
        $(COMPILE) -DREPMANRELEASE rppackv_del.dpk
vcldesignpackages:
        $(COMPILE) -DREPMANRELEASE rppackdesignvcl_del.dpk
designtimepackages:
        $(COMPILE) -DREPMANRELEASE rppackdesigntime_del.dpk


clean_noexe:
        -del /s *.dcu
        -del /s *.dpu
        -del /s *.~*
        -del /s *.o
        -del /s *.dcp
        -del /s *.ow
        -del /s *.ppw
        -del /s *.rst
        -del *.hpp
        -del /s *.obj
        -del /s *.tds
        -del *.bpl
        -del *.bpi
        -del activex\*.lib
        -del /s *.pdb


clean:  clean_noexe
        -del /s repman\*.exe
        -del /s server\*.exe
        -del /s tests\*.exe
        -del /s repman\*.bin
        -del /s server\*.bin
        -del *.dll
        -del /s server\*.dll
        -del /s *.ocx
        -del /s *.rsp



        -del tests\eval\project1
        -del tests\metafiles\metafile
        -del tests\objinsp\project1
        -del tests\params\project1
        -del tests\qpainter\project2
        -del tests\ruler\project1
        -del repman\utils\reptotxt\reptotxt
        -del repman\utils\txttorep\txttorep
        -del repman\utils\printrep\printrep
        -del repman\utils\metaprint\metaprint
        -del repman\utils\metaview\metaview
        -del /s /q install\Output
        -rmdir install\Output
real_clean:      clean
        -del /s *.bpl
        -del /s *.so
