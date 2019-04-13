{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [PATRIM_GRUPO_BEM] 
                                                                                
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
unit PatrimGrupoBemVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ContabilContaVO, ContabilHistoricoVO;

type
  [TEntity]
  [TTable('PATRIM_GRUPO_BEM')]
  TPatrimGrupoBemVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FCODIGO: String;
    FNOME: String;
    FDESCRICAO: String;
    FCONTA_ATIVO_IMOBILIZADO: String;
    FCONTA_DEPRECIACAO_ACUMULADA: String;
    FCONTA_DESPESA_DEPRECIACAO: String;
    FCODIGO_HISTORICO: Integer;

    FDescricaoContaAtivoImobilizado: String;
    FDescricaoContaDepreciacaoAcumulada: String;
    FDescricaoContaDespesaDepreciacao: String;
    FDescricaoHistorico: String;

    FDescricaoContaAtivoImobilizadoVO: TContabilContaVO;
    FDescricaoContaDepreciacaoAcumuladaVO: TContabilContaVO;
    FDescricaoContaDespesaDepreciacaoVO: TContabilContaVO;
    FDescricaoHistoricoVO: TContabilHistoricoVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_EMPRESA','Id Empresa',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('CODIGO','Codigo',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Codigo: String  read FCODIGO write FCODIGO;
    [TColumn('NOME','Nome',400,[ldGrid, ldLookup, ldCombobox], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;

    [TColumn('CONTA_ATIVO_IMOBILIZADO','Conta Ativo Imobilizado',240,[ldGrid, ldLookup, ldCombobox], False)]
    property ContaAtivoImobilizado: String  read FCONTA_ATIVO_IMOBILIZADO write FCONTA_ATIVO_IMOBILIZADO;
    [TColumn('CONTABIL_CONTA.DESCRICAO.ATIVO_IMOBILIZADO', 'Descrição Conta Ativo Imobilizado', 250, [ldGrid, ldLookup, ldComboBox], True, 'CONTABIL_CONTA', 'CONTA_ATIVO_IMOBILIZADO', 'CLASSIFICACAO')]
    property DescricaoContaAtivoImobilizado: String read FDescricaoContaAtivoImobilizado write FDescricaoContaAtivoImobilizado;

    [TColumn('CONTA_DEPRECIACAO_ACUMULADA','Conta Depreciacao Acumulada',240,[ldGrid, ldLookup, ldCombobox], False)]
    property ContaDepreciacaoAcumulada: String  read FCONTA_DEPRECIACAO_ACUMULADA write FCONTA_DEPRECIACAO_ACUMULADA;
    [TColumn('CONTABIL_CONTA.DESCRICAO.DEPRECIACAO_ACUMULADA', 'Descrição Conta Depreciação Acumulada', 250, [ldGrid, ldLookup, ldComboBox], True, 'CONTABIL_CONTA', 'CONTA_DEPRECIACAO_ACUMULADA', 'CLASSIFICACAO')]
    property DescricaoContaDepreciacaoAcumulada: String read FDescricaoContaDepreciacaoAcumulada write FDescricaoContaDepreciacaoAcumulada;

    [TColumn('CONTA_DESPESA_DEPRECIACAO','Conta Despesa Depreciacao',240,[ldGrid, ldLookup, ldCombobox], False)]
    property ContaDespesaDepreciacao: String  read FCONTA_DESPESA_DEPRECIACAO write FCONTA_DESPESA_DEPRECIACAO;
    [TColumn('CONTABIL_CONTA.DESCRICAO.DESPESA_DEPRECIACAO', 'Descrição Conta Despesa Depreciação', 250, [ldGrid, ldLookup, ldComboBox], True, 'CONTABIL_CONTA', 'CONTA_DESPESA_DEPRECIACAO', 'CLASSIFICACAO')]
    property DescricaoContaDespesaDepreciacao: String read FDescricaoContaDespesaDepreciacao write FDescricaoContaDespesaDepreciacao;

    [TColumn('CODIGO_HISTORICO','Codigo Historico',240,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoHistorico: Integer  read FCODIGO_HISTORICO write FCODIGO_HISTORICO;
    [TColumn('CONTABIL_HISTORICO.DESCRICAO', 'Descrição Histórico', 250, [ldGrid, ldLookup, ldComboBox], True, 'CONTABIL_HISTORICO', 'CODIGO_HISTORICO', 'ID')]
    property DescricaoHistorico: String read FDescricaoHistorico write FDescricaoHistorico;

    [TAssociation(False, 'CLASSIFICACAO', 'CONTA_ATIVO_IMOBILIZADO', 'CONTABIL_CONTA')]
    property DescricaoContaAtivoImobilizadoVO: TContabilContaVO read FDescricaoContaAtivoImobilizadoVO write FDescricaoContaAtivoImobilizadoVO;

    [TAssociation(False, 'CLASSIFICACAO', 'CONTA_DEPRECIACAO_ACUMULADA', 'CONTABIL_CONTA')]
    property DescricaoContaDepreciacaoAcumuladaVO: TContabilContaVO read FDescricaoContaDepreciacaoAcumuladaVO write FDescricaoContaDepreciacaoAcumuladaVO;

    [TAssociation(False, 'CLASSIFICACAO', 'CONTA_DESPESA_DEPRECIACAO', 'CONTABIL_CONTA')]
    property DescricaoContaDespesaDepreciacaoVO: TContabilContaVO read FDescricaoContaDespesaDepreciacaoVO write FDescricaoContaDespesaDepreciacaoVO;

    [TAssociation(False, 'ID', 'CODIGO_HISTORICO', 'CONTABIL_HISTORICO')]
    property DescricaoHistoricoVO: TContabilHistoricoVO read FDescricaoHistoricoVO write FDescricaoHistoricoVO;
  end;

implementation

destructor TPatrimGrupoBemVO.Destroy;
begin
  if Assigned(FDescricaoContaAtivoImobilizadoVO) then
    FDescricaoContaAtivoImobilizadoVO.Free;
  if Assigned(FDescricaoContaDepreciacaoAcumuladaVO) then
    FDescricaoContaDepreciacaoAcumuladaVO.Free;
  if Assigned(FDescricaoContaDespesaDepreciacaoVO) then
    FDescricaoContaDespesaDepreciacaoVO.Free;
  if Assigned(FDescricaoHistoricoVO) then
    FDescricaoHistoricoVO.Free;
  inherited;
end;

function TPatrimGrupoBemVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    if Assigned(Self.DescricaoContaAtivoImobilizadoVO) then
      Self.DescricaoContaAtivoImobilizado := Self.DescricaoContaAtivoImobilizadoVO.Descricao;
    if Assigned(Self.DescricaoContaDepreciacaoAcumuladaVO) then
      Self.DescricaoContaDepreciacaoAcumulada := Self.DescricaoContaDepreciacaoAcumuladaVO.Descricao;
    if Assigned(Self.DescricaoContaDespesaDepreciacaoVO) then
      Self.DescricaoContaDespesaDepreciacao := Self.DescricaoContaDespesaDepreciacaoVO.Descricao;
    if Assigned(Self.FDescricaoHistoricoVO) then
      Self.DescricaoHistorico := Self.FDescricaoHistoricoVO.Descricao;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
