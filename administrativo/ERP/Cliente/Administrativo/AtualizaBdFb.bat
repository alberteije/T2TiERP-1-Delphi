@echo off
cd "C:\Arquivos de programas\Firebird\Firebird_2_5\bin"
isql -i 'C:\T2Ti\atualiza.sql' 'C:\T2Ti\Dados\T2TIERP_17.FDB' -user sysdba -pass masterkey