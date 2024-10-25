{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado � tabela [FISCAL_APURACAO_ICMS] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2010 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit FiscalApuracaoIcmsController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon,
  Biblioteca;

type
  TFiscalApuracaoIcmsController = class(TController)
  protected
  public
    //consultar
    function FiscalApuracaoIcms(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
  end;

implementation

uses
  FiscalApuracaoIcmsVO, T2TiORM, SA,
  //
  ViewSpedC190VO, ViewSpedC390VO, ViewSpedC490VO;

{ TFiscalApuracaoIcmsController }

var
  objFiscalApuracaoIcms: TFiscalApuracaoIcmsVO;
  Resultado: Boolean;

function TFiscalApuracaoIcmsController.FiscalApuracaoIcms(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
var
  ApuracaoIcmsAnterior: TFiscalApuracaoIcmsVO;
  ListaNFeAnalitico: TObjectList<TViewSpedC190VO>;
  ListaC390: TObjectList<TViewSpedC390VO>;
  ListaC490: TObjectList<TViewSpedC490VO>;
  //
  i: Integer;
  FiltroLocal: String;
  //
  VL_TOT_DEBITOS, VL_TOT_CREDITOS, VL_SLD_APURADO: Extended;
begin
  Result := TJSONArray.Create;
  try
    VL_TOT_DEBITOS := 0;
    VL_TOT_CREDITOS := 0;
    VL_SLD_APURADO := 0;
    //
    pFiltro := StringReplace(pFiltro, '|', '/', [rfReplaceAll]);

    ApuracaoIcmsAnterior := TT2TiORM.ConsultarUmObjeto<TFiscalApuracaoIcmsVO>('COMPETENCIA=' + QuotedStr(PeriodoAnterior(pFiltro)), False);
    objFiscalApuracaoIcms := TT2TiORM.ConsultarUmObjeto<TFiscalApuracaoIcmsVO>('COMPETENCIA=' + QuotedStr(pFiltro), False);

    // Se n�o existe registro para o per�odo atual, cria objeto
    if not Assigned(objFiscalApuracaoIcms) then
    begin
      objFiscalApuracaoIcms := TFiscalApuracaoIcmsVO.Create;
      objFiscalApuracaoIcms.IdEmpresa := Sessao(pSessao).IdEmpresa;
      objFiscalApuracaoIcms.Competencia := pFiltro;
    end;

    {$REGION 'REGISTRO E110 - Campo 10 - VL_SLD_CREDOR_ANT'}
    // Se existir o per�odo anterior, pega o saldo credor
    if Assigned(ApuracaoIcmsAnterior) then
      objFiscalApuracaoIcms.ValorSaldoCredorAnterior := ApuracaoIcmsAnterior.ValorSaldoCredorTransp;
    {$ENDREGION}

    {$REGION 'REGISTRO E110 - Campo 02 - VL_TOT_DEBITOS'}
    {
      Campo 02 - Valida��o: o valor informado deve corresponder ao somat�rio de todos os documentos fiscais de sa�da que
      geram d�bito de ICMS. Deste somat�rio, est�o exclu�dos os documentos extempor�neos (COD_SIT com valor igual �01�),
      os documentos complementares extempor�neos (COD_SIT com valor igual �07�) e os documentos fiscais com CFOP 5605.
      Devem ser inclu�dos os documentos fiscais com CFOP igual a 1605.
      O valor neste campo deve ser igual � soma dos VL_ICMS de todos os registros C190, C320, C390, C490, C590, C690,
      C790, D190, D300, D390, D410, D590, D690, D696, com as datas dos campos DT_DOC (C300, C405, C600, D300,
      D355, D400, D600) ou DT_E_S (C100, C500) ou DT_DOC_FIN (C700, D695) ou DT_A_P (D100, D500) dentro do
      per�odo informado no registro E100.
    }

    // REGISTRO C190: REGISTRO ANAL�TICO DO DOCUMENTO (C�DIGO 01, 1B, 04 ,55 e 65).
    FiltroLocal := 'extract(month from(DATA_EMISSAO))=' + Copy(pFiltro, 1, 2) + ' and extract(year from(DATA_EMISSAO))=' + Copy(pFiltro, 4, 4);
    ListaNFeAnalitico := TT2TiORM.Consultar<TViewSpedC190VO>(FiltroLocal, False);
    if assigned(ListaNFeAnalitico) then
    begin
      for i := 0 to ListaNFeAnalitico.Count - 1 do
      begin
        VL_TOT_DEBITOS := VL_TOT_DEBITOS + TViewSpedC190VO(ListaNFeAnalitico.Items[i]).SomaValorIcms;
      end; // for i := 0 to ListaNFeAnalitico.Count - 1 do
    end; // if Assigned(ListaNFeAnalitico) then

    // REGISTRO C390: REGISTRO ANAL�TICO DAS NOTAS FISCAIS DE VENDA A CONSUMIDOR (C�DIGO 02)
    FiltroLocal := 'extract(month from(DATA_EMISSAO))=' + Copy(pFiltro, 1, 2) + ' and extract(year from(DATA_EMISSAO))=' + Copy(pFiltro, 4, 4);
    ListaC390 := TT2TiORM.Consultar<TViewSpedC390VO>(FiltroLocal, False);
    if assigned(ListaC390) then
    begin
      for i := 0 to ListaC390.Count - 1 do
      begin
        VL_TOT_DEBITOS := VL_TOT_DEBITOS + TViewSpedC390VO(ListaC390.Items[i]).SomaICMS;
      end; // for i := 0 to ListaC390.Count - 1 do
    end; // if Assigned(ListaC390) then

    // REGISTRO C490: REGISTRO ANAL�TICO DO MOVIMENTO DI�RIO (C�DIGO 02, 2D e 60).
    FiltroLocal := 'extract(month from(DATA_VENDA))=' + Copy(pFiltro, 1, 2) + ' and extract(year from(DATA_VENDA))=' + Copy(pFiltro, 4, 4);
    ListaC490 := TT2TiORM.Consultar<TViewSpedC490VO>(FiltroLocal, False);
    if assigned(ListaC490) then
    begin
      for i := 0 to ListaC490.Count - 1 do
      begin
        VL_TOT_DEBITOS := VL_TOT_DEBITOS + TViewSpedC490VO(ListaC490.Items[i]).SomaICMS;
      end; // for i := 0 to ListaC490.Count - 1 do
    end; // if Assigned(ListaC490) then

    objFiscalApuracaoIcms.ValorTotalDebito := VL_TOT_DEBITOS;
    {$ENDREGION}

    {$REGION 'REGISTRO E110 - Campo 06 - VL_TOT_CREDITOS'}
    {
      Campo 06 - Valida��o: o valor informado deve corresponder ao somat�rio de todos os documentos fiscais de entrada que
      geram cr�dito de ICMS. O valor neste campo deve ser igual � soma dos VL_ICMS de todos os registros C190, C590, D190
      e D590. Deste somat�rio, est�o exclu�dos os documentos fiscais com CFOP 1605 e inclu�dos os documentos fiscais com
      CFOP 5605. Os documentos fiscais devem ser somados conforme o per�odo informado no registro E100 e a data informada
      no campo DT_E_S (C100, C500) ou campo DT_A_P (D100, D500), exceto se COD_SIT do documento for igual a �01�
      (extempor�neo) ou igual a 07 (NF Complementar extempor�nea), cujo valor ser� somado no primeiro per�odo de apura��o
      informado no registro E100.
    }
    // REGISTRO C190: REGISTRO ANAL�TICO DO DOCUMENTO (C�DIGO 01, 1B, 04 ,55 e 65).
    FiltroLocal := 'extract(month from(DATA_EMISSAO))=' + Copy(pFiltro, 1, 2) + ' and extract(year from(DATA_EMISSAO))=' + Copy(pFiltro, 4, 4);
    ListaNFeAnalitico := TT2TiORM.Consultar<TViewSpedC190VO>(FiltroLocal, False);
    if assigned(ListaNFeAnalitico) then
    begin
      for i := 0 to ListaNFeAnalitico.Count - 1 do
      begin
        VL_TOT_CREDITOS := VL_TOT_CREDITOS + TViewSpedC190VO(ListaNFeAnalitico.Items[i]).SomaValorIcms;
      end; // for i := 0 to ListaNFeAnalitico.Count - 1 do
    end; // if Assigned(ListaNFeAnalitico) then

    // REGISTRO C390: REGISTRO ANAL�TICO DAS NOTAS FISCAIS DE VENDA A CONSUMIDOR (C�DIGO 02)
    FiltroLocal := 'extract(month from(DATA_EMISSAO))=' + Copy(pFiltro, 1, 2) + ' and extract(year from(DATA_EMISSAO))=' + Copy(pFiltro, 4, 4);
    ListaC390 := TT2TiORM.Consultar<TViewSpedC390VO>(FiltroLocal, False);
    if assigned(ListaC390) then
    begin
      for i := 0 to ListaC390.Count - 1 do
      begin
        VL_TOT_CREDITOS := VL_TOT_CREDITOS + TViewSpedC390VO(ListaC390.Items[i]).SomaICMS;
      end; // for i := 0 to ListaC390.Count - 1 do
    end; // if Assigned(ListaC390) then

    // REGISTRO C490: REGISTRO ANAL�TICO DO MOVIMENTO DI�RIO (C�DIGO 02, 2D e 60).
    FiltroLocal := 'extract(month from(DATA_VENDA))=' + Copy(pFiltro, 1, 2) + ' and extract(year from(DATA_VENDA))=' + Copy(pFiltro, 4, 4);
    ListaC490 := TT2TiORM.Consultar<TViewSpedC490VO>(FiltroLocal, False);
    if assigned(ListaC490) then
    begin
      for i := 0 to ListaC490.Count - 1 do
      begin
        VL_TOT_CREDITOS := VL_TOT_CREDITOS + TViewSpedC490VO(ListaC490.Items[i]).SomaICMS;
      end; // for i := 0 to ListaC490.Count - 1 do
    end; // if Assigned(ListaC490) then

    objFiscalApuracaoIcms.ValorTotalCredito := VL_TOT_CREDITOS;
    {$ENDREGION}

    {$REGION 'REGISTRO E110 - Campos 11 e 14 - VL_SLD_APURADO e VL_SLD_CREDOR_TRANSPORTAR'}
    {
      Campo 11 - Valida��o: o valor informado deve ser preenchido com base na express�o: soma do total de d�bitos
      (VL_TOT_DEBITOS) com total de ajustes (VL_AJ_DEBITOS +VL_TOT_AJ_DEBITOS) com total de estorno de cr�dito
      (VL_ESTORNOS_CRED) menos a soma do total de cr�ditos (VL_TOT_CREDITOS) com total de ajuste de cr�ditos
      (VL_,AJ_CREDITOS + VL_TOT_AJ_CREDITOS) com total de estorno de d�bito (VL_ESTORNOS_DEB) com saldo
      credor do per�odo anterior (VL_SLD_CREDOR_ANT). Se o valor da express�o for maior ou igual a �0� (zero), ent�o este
      valor deve ser informado neste campo e o campo 14 (VL_SLD_CREDOR_TRANSPORTAR) deve ser igual a �0� (zero).
      Se o valor da express�o for menor que �0� (zero), ent�o este campo deve ser preenchido com �0� (zero) e o valor absoluto
      da express�o deve ser informado no campo VL_SLD_CREDOR_TRANSPORTAR.
    }
    VL_SLD_APURADO := VL_TOT_DEBITOS - VL_TOT_CREDITOS + objFiscalApuracaoIcms.ValorSaldoCredorAnterior;
    if VL_SLD_APURADO >= 0 then
    begin
      objFiscalApuracaoIcms.ValorSaldoApurado := VL_SLD_APURADO;
      objFiscalApuracaoIcms.ValorSaldoCredorTransp := 0;
    end
    else
    begin
      objFiscalApuracaoIcms.ValorSaldoApurado := 0;
      objFiscalApuracaoIcms.ValorSaldoCredorTransp := VL_SLD_APURADO * -1;
    end;
    {$ENDREGION}

    {$REGION 'REGISTRO E110 - Campo 13 - VL_ICMS_RECOLHER'}
    {
      Campo 13 � Valida��o: o valor informado deve corresponder � diferen�a entre o campo VL_SLD_APURADO e o campo
      VL_TOT_DED. Se o resultado dessa opera��o for negativo, informe o valor zero neste campo, e o valor absoluto
      correspondente no campo VL_SLD_CREDOR_TRANSPORTAR. Verificar se a legisla��o da UF permite que dedu��o
      seja maior que o saldo devedor.
    }
    if VL_SLD_APURADO >= 0 then
      objFiscalApuracaoIcms.ValorIcmsRecolher := VL_SLD_APURADO
    else
      objFiscalApuracaoIcms.ValorIcmsRecolher := 0;
    {$ENDREGION}

    if objFiscalApuracaoIcms.Id > 0 then
      TT2TiORM.Alterar(objFiscalApuracaoIcms)
    else
      TT2TiORM.Inserir(objFiscalApuracaoIcms);

    Result.AddElement(objFiscalApuracaoIcms.ToJSON);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(result.ToString);
end;

end.
