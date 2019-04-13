@ECHO OFF
@ECHO OFF

if "%1" == "" goto param_default

if NOT EXIST %1\lazarus.exe goto erro_param

if NOT EXIST %1\tools\lazres.exe GOTO erro_lazres

:Comum
%1\tools\lazres.exe ACBrComum.lrs TACBrEAD.bmp TACBrAAC.bmp
move ACBrComum.lrs ..\ACBrComum
echo.
echo "****************************************"
echo "* Arquivo   ACBrDiversos.lrs   gerado  *"
echo "****************************************"
echo.

:Diversos
%1\tools\lazres.exe ACBrDiversos.lrs TACBrCalculadora.bmp TACBrExtenso.bmp TACBrValidador.bmp TACBrTroco.bmp TACBrCMC7.bmp TACBrFala.bmp TACBrGIF.bmp TACBrBarCode.bmp TACBrEnterTab.bmp
move ACBrDiversos.lrs ..\ACBrDiversos
echo.
echo "****************************************"
echo "* Arquivo   ACBrDiversos.lrs   gerado  *"
echo "****************************************"
echo.

:Serial
%1\tools\lazres.exe ACBrSerial.lrs TACBrECF.bmp TACBrGAV.bmp TACBrCHQ.bmp TACBrLCB.bmp TACBrDIS.bmp TACBrBAL.bmp TACBrTER.bmp TACBrETQ.bmp TACBrRFD.bmp
move ACBrSerial.lrs ..\ACBrSerial
echo.
echo "****************************************"
echo "* Arquivo   ACBrSerial.lrs   gerado    *"
echo "****************************************"
echo.

:TEFD
%1\tools\lazres.exe ACBrTEFD.lrs TACBrTEFD.bmp
move ACBrTEFD.lrs ..\ACBrTEFD
echo.
echo "****************************************"
echo "* Arquivo   ACBrTEFD.lrs   gerado      *"
echo "****************************************"
echo.

:TCP
%1\tools\lazres.exe ACBrTCP.lrs TACBrTCPServer.bmp TACBrCEP.bmp TACBrIBGE.bmp TACBrCNIEE.bmp
move ACBrTCP.lrs ..\ACBrTCP
echo.
echo "****************************************"
echo "* Arquivo   ACBrTCP.lrs   gerado       *"
echo "****************************************"
echo.

:SPED
%1\tools\lazres.exe ACBrSpedFiscal.lrs TACBrSpedFiscal.bmp
%1\tools\lazres.exe ACBrSpedContabil.lrs TACBrSpedContabil.bmp
%1\tools\lazres.exe ACBrSpedPisCofins.lrs TACBrSpedPisCofins.bmp
move ACBrSpedFiscal.lrs ..\ACBrSPED\ACBrSPEDFiscal
move ACBrSpedContabil.lrs ..\ACBrSPED\ACBrSPEDContabil
move ACBrSpedPisCofins.lrs ..\ACBrSPED\ACBrSpedPisCofins
echo.
echo "****************************************"
echo "* Arquivo  ACBrSpedFiscal.lrs   gerado *"
echo "* Arquivo  ACBrSpedContabil.lrs gerado *"
echo "****************************************"
echo.

:PAF
%1\tools\lazres.exe ACBrPAF.lrs TACBrPAF.bmp
move ACBrPAF.lrs ..\ACBrPAF
echo.
echo "****************************************"
echo "* Arquivo   ACBrPAF.lrs   gerado       *"
echo "****************************************"
echo.

:Boleto
%1\tools\lazres.exe ACBrBoleto.lrs TACBrBoleto.bmp
%1\tools\lazres.exe ACBrBoletoFCFortes.lrs TACBrBoletoFCFortes.bmp
%1\tools\lazres.exe ACBrBoletoFCLazReport.lrs TACBrBoletoFCLazReport.bmp ..\ACBrBoleto\FCLazReport_Padrao.lrf ..\ACBrBoleto\FCLazReport_CompEntrega.lrf ..\ACBrBoleto\FCLazReport_Carne.lrf

move ACBrBoleto.lrs ..\ACBrBoleto
move ACBrBoletoFCFortes.lrs ..\ACBrBoleto
move ACBrBoletoFCLazReport.lrs ..\ACBrBoleto
echo.
echo "****************************************"
echo "* Arquivo   ACBrBoleto.lrs   gerado    *"
echo "*    ACBrBoletoFCFortes.lrs  gerado    *"
echo "****************************************"
echo.

:NFe
%1\tools\lazres.exe ACBrNFe.lrs TACBrNFe.bmp TACBrDANFeQR.bmp TACBrDANFeRave.bmp TACBrDANFeRaveCB.bmp TACBrDANFeRL.bmp
move ACBrNFe.lrs ..\ACBrNFe
echo.
echo "****************************************"
echo "* Arquivo    ACBrNFe.lrs     gerado    *"
echo "****************************************"
echo.

:Sintegra
%1\tools\lazres.exe ACBrSintegra.lrs TACBrSintegra.bmp
move ACBrSintegra.lrs ..\ACBrSintegra
echo.
echo "****************************************"
echo "* Arquivo   ACBrSintegra.lrs   gerado  *"
echo "****************************************"
echo.


GOTO fim

:param_default
Compila_LRS.bat c:\lazarus
goto :fim

:erro_param
ECHO "Informe o diretorio do Lazarus. Exemplo:"
echo.
ECHO "Compila_LRS.bat c:\lazarus"
goto :fim

:erro_lazres
ECHO "Arquivo:"
echo %1\tools\lazres.exe
ECHO "nao encontrado... Favor compilar o projeto:  lazres.lpi"
goto fim

:fim
echo "Tecle ENTER para sair" .
pause