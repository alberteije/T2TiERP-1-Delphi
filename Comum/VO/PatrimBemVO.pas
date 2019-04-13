{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [PATRIM_BEM] 
                                                                                
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
unit PatrimBemVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ColaboradorPessoaVO, SetorVO, FornecedorPessoaVO, PatrimGrupoBemVO,
  PatrimTipoAquisicaoBemVO, PatrimEstadoConservacaoVO, PatrimDocumentoBemVO,
  PatrimDepreciacaoBemVO, PatrimMovimentacaoBemVO;

type
  [TEntity]
  [TTable('PATRIM_BEM')]
  TPatrimBemVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PATRIM_TIPO_AQUISICAO_BEM: Integer;
    FID_PATRIM_ESTADO_CONSERVACAO: Integer;
    FID_PATRIM_GRUPO_BEM: Integer;
    FID_SETOR: Integer;
    FID_FORNECEDOR: Integer;
    FID_COLABORADOR: Integer;
    FNUMERO_NB: String;
    FNOME: String;
    FDESCRICAO: String;
    FNUMERO_SERIE: String;
    FDATA_AQUISICAO: TDateTime;
    FDATA_ACEITE: TDateTime;
    FDATA_CADASTRO: TDateTime;
    FDATA_CONTABILIZADO: TDateTime;
    FDATA_VISTORIA: TDateTime;
    FDATA_MARCACAO: TDateTime;
    FDATA_BAIXA: TDateTime;
    FVENCIMENTO_GARANTIA: TDateTime;
    FNUMERO_NOTA_FISCAL: String;
    FCHAVE_NFE: String;
    FVALOR_ORIGINAL: Extended;
    FVALOR_COMPRA: Extended;
    FVALOR_ATUALIZADO: Extended;
    FVALOR_BAIXA: Extended;
    FDEPRECIA: String;
    FMETODO_DEPRECIACAO: String;
    FINICIO_DEPRECIACAO: TDateTime;
    FULTIMA_DEPRECIACAO: TDateTime;
    FTIPO_DEPRECIACAO: String;
    FTAXA_ANUAL_DEPRECIACAO: Extended;
    FTAXA_MENSAL_DEPRECIACAO: Extended;
    FTAXA_DEPRECIACAO_ACELERADA: Extended;
    FTAXA_DEPRECIACAO_INCENTIVADA: Extended;
    FFUNCAO: String;

    FSetorNome: String;
    FColaboradorPessoaNome: String;
    FFornecedorPessoaNome: String;
    FPatrimGrupoBemNome: String;
    FPatrimTipoAquisicaoBemNome: String;
    FPatrimEstadoConservacaoNome: String;

    FSetorVO: TSetorVO;
    FColaboradorVO: TColaboradorVO;
    FFornecedorVO: TFornecedorVO;
    FPatrimGrupoBemVO: TPatrimGrupoBemVO;
    FPatrimTipoAquisicaoBemVO: TPatrimTipoAquisicaoBemVO;
    FPatrimEstadoConservacaoVO: TPatrimEstadoConservacaoVO;

    FListaPatrimDocumentoBemVO: TObjectList<TPatrimDocumentoBemVO>;
    FListaPatrimDepreciacaoBemVO: TObjectList<TPatrimDepreciacaoBemVO>;
    FListaPatrimMovimentacaoBemVO: TObjectList<TPatrimMovimentacaoBemVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_PATRIM_TIPO_AQUISICAO_BEM','Id Tipo Aquisição',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPatrimTipoAquisicaoBem: Integer  read FID_PATRIM_TIPO_AQUISICAO_BEM write FID_PATRIM_TIPO_AQUISICAO_BEM;
    [TColumn('PATRIM_TIPO_AQUISICAO_BEM.NOME', 'Tipo Aquisição', 150, [ldGrid, ldLookup, ldComboBox], True, 'PATRIM_TIPO_AQUISICAO_BEM', 'ID_PATRIM_TIPO_AQUISICAO_BEM', 'ID')]
    property PatrimTipoAquisicaoBemNome: String read FPatrimTipoAquisicaoBemNome write FPatrimTipoAquisicaoBemNome;

    [TColumn('ID_PATRIM_ESTADO_CONSERVACAO','Id Estado Conservacao',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPatrimEstadoConservacao: Integer  read FID_PATRIM_ESTADO_CONSERVACAO write FID_PATRIM_ESTADO_CONSERVACAO;
    [TColumn('PATRIM_ESTADO_CONSERVACAO.NOME', 'Estado Conservacao', 150, [ldGrid, ldLookup, ldComboBox], True, 'PATRIM_ESTADO_CONSERVACAO', 'ID_PATRIM_ESTADO_CONSERVACAO', 'ID')]
    property PatrimEstadoConservacaoNome: String read FPatrimEstadoConservacaoNome write FPatrimEstadoConservacaoNome;

    [TColumn('ID_PATRIM_GRUPO_BEM','Id Grupo',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPatrimGrupoBem: Integer  read FID_PATRIM_GRUPO_BEM write FID_PATRIM_GRUPO_BEM;
    [TColumn('PATRIM_GRUPO_BEM.NOME', 'Grupo', 150, [ldGrid, ldLookup, ldComboBox], True, 'PATRIM_GRUPO_BEM', 'ID_PATRIM_GRUPO_BEM', 'ID')]
    property PatrimGrupoBemNome: String read FPatrimGrupoBemNome write FPatrimGrupoBemNome;

    [TColumn('ID_SETOR','Id Setor',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdSetor: Integer  read FID_SETOR write FID_SETOR;
    [TColumn('SETOR.NOME', 'Setor', 250, [ldGrid, ldLookup, ldComboBox], True, 'SETOR', 'ID_SETOR', 'ID')]
    property SetorNome: String read FSetorNome write FSetorNome;

    [TColumn('ID_FORNECEDOR','Id Fornecedor',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFornecedor: Integer  read FID_FORNECEDOR write FID_FORNECEDOR;
    [TColumn('FORNECEDOR.PESSOA.NOME', 'Fornecedor', 250, [ldGrid, ldLookup, ldComboBox], True, 'FORNECEDOR', 'ID_FORNECEDOR', 'ID')]
    property FornecedorPessoaNome: String read FFornecedorPessoaNome write FFornecedorPessoaNome;

    [TColumn('ID_COLABORADOR','Id Colaborador',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADOR.PESSOA.NOME', 'Colaborador', 250, [ldGrid, ldLookup, ldComboBox], True, 'COLABORADOR.PESSOA', 'ID_COLABORADOR', 'ID')]
    property ColaboradorPessoaNome: String read FColaboradorPessoaNome write FColaboradorPessoaNome;

    [TColumn('NUMERO_NB','Numero Nb',160,[ldGrid, ldLookup, ldCombobox], False)]
    property NumeroNb: String  read FNUMERO_NB write FNUMERO_NB;
    [TColumn('NOME','Nome',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('NUMERO_SERIE','Numero Serie',400,[ldGrid, ldLookup, ldCombobox], False)]
    property NumeroSerie: String  read FNUMERO_SERIE write FNUMERO_SERIE;
    [TColumn('DATA_AQUISICAO','Data Aquisicao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataAquisicao: TDateTime  read FDATA_AQUISICAO write FDATA_AQUISICAO;
    [TColumn('DATA_ACEITE','Data Aceite',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataAceite: TDateTime  read FDATA_ACEITE write FDATA_ACEITE;
    [TColumn('DATA_CADASTRO','Data Cadastro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataCadastro: TDateTime  read FDATA_CADASTRO write FDATA_CADASTRO;
    [TColumn('DATA_CONTABILIZADO','Data Contabilizado',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataContabilizado: TDateTime  read FDATA_CONTABILIZADO write FDATA_CONTABILIZADO;
    [TColumn('DATA_VISTORIA','Data Vistoria',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataVistoria: TDateTime  read FDATA_VISTORIA write FDATA_VISTORIA;
    [TColumn('DATA_MARCACAO','Data Marcacao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataMarcacao: TDateTime  read FDATA_MARCACAO write FDATA_MARCACAO;
    [TColumn('DATA_BAIXA','Data Baixa',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataBaixa: TDateTime  read FDATA_BAIXA write FDATA_BAIXA;
    [TColumn('VENCIMENTO_GARANTIA','Vencimento Garantia',80,[ldGrid, ldLookup, ldCombobox], False)]
    property VencimentoGarantia: TDateTime  read FVENCIMENTO_GARANTIA write FVENCIMENTO_GARANTIA;
    [TColumn('NUMERO_NOTA_FISCAL','Numero Nota Fiscal',400,[ldGrid, ldLookup, ldCombobox], False)]
    property NumeroNotaFiscal: String  read FNUMERO_NOTA_FISCAL write FNUMERO_NOTA_FISCAL;
    [TColumn('CHAVE_NFE','Chave Nfe',352,[ldGrid, ldLookup, ldCombobox], False)]
    property ChaveNfe: String  read FCHAVE_NFE write FCHAVE_NFE;
    [TColumn('VALOR_ORIGINAL','Valor Original',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorOriginal: Extended  read FVALOR_ORIGINAL write FVALOR_ORIGINAL;
    [TColumn('VALOR_COMPRA','Valor Compra',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorCompra: Extended  read FVALOR_COMPRA write FVALOR_COMPRA;
    [TColumn('VALOR_ATUALIZADO','Valor Atualizado',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorAtualizado: Extended  read FVALOR_ATUALIZADO write FVALOR_ATUALIZADO;
    [TColumn('VALOR_BAIXA','Valor Baixa',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorBaixa: Extended  read FVALOR_BAIXA write FVALOR_BAIXA;
    [TColumn('DEPRECIA','Deprecia',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Deprecia: String  read FDEPRECIA write FDEPRECIA;
    [TColumn('METODO_DEPRECIACAO','Metodo Depreciacao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property MetodoDepreciacao: String  read FMETODO_DEPRECIACAO write FMETODO_DEPRECIACAO;
    [TColumn('INICIO_DEPRECIACAO','Inicio Depreciacao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property InicioDepreciacao: TDateTime  read FINICIO_DEPRECIACAO write FINICIO_DEPRECIACAO;
    [TColumn('ULTIMA_DEPRECIACAO','Ultima Depreciacao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property UltimaDepreciacao: TDateTime  read FULTIMA_DEPRECIACAO write FULTIMA_DEPRECIACAO;
    [TColumn('TIPO_DEPRECIACAO','Tipo Depreciacao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property TipoDepreciacao: String  read FTIPO_DEPRECIACAO write FTIPO_DEPRECIACAO;
    [TColumn('TAXA_ANUAL_DEPRECIACAO','Taxa Anual Depreciacao',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaAnualDepreciacao: Extended  read FTAXA_ANUAL_DEPRECIACAO write FTAXA_ANUAL_DEPRECIACAO;
    [TColumn('TAXA_MENSAL_DEPRECIACAO','Taxa Mensal Depreciacao',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaMensalDepreciacao: Extended  read FTAXA_MENSAL_DEPRECIACAO write FTAXA_MENSAL_DEPRECIACAO;
    [TColumn('TAXA_DEPRECIACAO_ACELERADA','Taxa Depreciacao Acelerada',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaDepreciacaoAcelerada: Extended  read FTAXA_DEPRECIACAO_ACELERADA write FTAXA_DEPRECIACAO_ACELERADA;
    [TColumn('TAXA_DEPRECIACAO_INCENTIVADA','Taxa Depreciacao Incentivada',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaDepreciacaoIncentivada: Extended  read FTAXA_DEPRECIACAO_INCENTIVADA write FTAXA_DEPRECIACAO_INCENTIVADA;
    [TColumn('FUNCAO','Funcao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Funcao: String  read FFUNCAO write FFUNCAO;

    [TAssociation(False, 'ID', 'ID_SETOR', 'SETOR')]
    property SetorVO: TSetorVO read FSetorVO write FSetorVO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR', 'COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TAssociation(True, 'ID', 'ID_FORNECEDOR', 'FORNECEDOR')]
    property FornecedorVO: TFornecedorVO read FFornecedorVO write FFornecedorVO;

    [TAssociation(True, 'ID', 'ID_PATRIM_GRUPO_BEM', 'PATRIM_GRUPO_BEM')]
    property PatrimGrupoBemVO: TPatrimGrupoBemVO read FPatrimGrupoBemVO write FPatrimGrupoBemVO;

    [TAssociation(True, 'ID', 'ID_PATRIM_TIPO_AQUISICAO_BEM', 'PATRIM_TIPO_AQUISICAO_BEM')]
    property PatrimTipoAquisicaoBemVO: TPatrimTipoAquisicaoBemVO read FPatrimTipoAquisicaoBemVO write FPatrimTipoAquisicaoBemVO;

    [TAssociation(True, 'ID', 'ID_PATRIM_ESTADO_CONSERVACAO', 'PATRIM_ESTADO_CONSERVACAO')]
    property PatrimEstadoConservacaoVO: TPatrimEstadoConservacaoVO read FPatrimEstadoConservacaoVO write FPatrimEstadoConservacaoVO;

    [TManyValuedAssociation(False,'ID_PATRIM_BEM','ID')]
    property ListaPatrimDocumentoBemVO: TObjectList<TPatrimDocumentoBemVO> read FListaPatrimDocumentoBemVO write FListaPatrimDocumentoBemVO;

    [TManyValuedAssociation(False,'ID_PATRIM_BEM','ID')]
    property ListaPatrimDepreciacaoBemVO: TObjectList<TPatrimDepreciacaoBemVO> read FListaPatrimDepreciacaoBemVO write FListaPatrimDepreciacaoBemVO;

    [TManyValuedAssociation(True,'ID_PATRIM_BEM','ID')]
    property ListaPatrimMovimentacaoBemVO: TObjectList<TPatrimMovimentacaoBemVO> read FListaPatrimMovimentacaoBemVO write FListaPatrimMovimentacaoBemVO;
  end;

implementation

constructor TPatrimBemVO.Create;
begin
  inherited;
  ListaPatrimDocumentoBemVO := TObjectList<TPatrimDocumentoBemVO>.Create;
  ListaPatrimDepreciacaoBemVO := TObjectList<TPatrimDepreciacaoBemVO>.Create;
  ListaPatrimMovimentacaoBemVO := TObjectList<TPatrimMovimentacaoBemVO>.Create;
end;

constructor TPatrimBemVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Documento
    Deserializa.RegisterReverter(TPatrimBemVO, 'FListaPatrimDocumentoBemVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TPatrimBemVO(Data).FListaPatrimDocumentoBemVO) then
        TPatrimBemVO(Data).FListaPatrimDocumentoBemVO := TObjectList<TPatrimDocumentoBemVO>.Create;

      for Obj in Args do
      begin
        TPatrimBemVO(Data).FListaPatrimDocumentoBemVO.Add(TPatrimDocumentoBemVO(Obj));
      end
    end);

    //Depreciação
    Deserializa.RegisterReverter(TPatrimBemVO, 'FListaPatrimDepreciacaoBemVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TPatrimBemVO(Data).FListaPatrimDepreciacaoBemVO) then
        TPatrimBemVO(Data).FListaPatrimDepreciacaoBemVO := TObjectList<TPatrimDepreciacaoBemVO>.Create;

      for Obj in Args do
      begin
        TPatrimBemVO(Data).FListaPatrimDepreciacaoBemVO.Add(TPatrimDepreciacaoBemVO(Obj));
      end
    end);

    //Movimentação
    Deserializa.RegisterReverter(TPatrimBemVO, 'FListaPatrimMovimentacaoBemVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TPatrimBemVO(Data).FListaPatrimMovimentacaoBemVO) then
        TPatrimBemVO(Data).FListaPatrimMovimentacaoBemVO := TObjectList<TPatrimMovimentacaoBemVO>.Create;

      for Obj in Args do
      begin
        TPatrimBemVO(Data).FListaPatrimMovimentacaoBemVO.Add(TPatrimMovimentacaoBemVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TPatrimBemVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TPatrimBemVO.Destroy;
begin
  ListaPatrimDocumentoBemVO.Free;
  ListaPatrimDepreciacaoBemVO.Free;
  ListaPatrimMovimentacaoBemVO.Free;

  if Assigned(FSetorVO) then
    FSetorVO.Free;
  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;
  if Assigned(FFornecedorVO) then
    FFornecedorVO.Free;
  if Assigned(FPatrimGrupoBemVO) then
    FPatrimGrupoBemVO.Free;
  if Assigned(FPatrimTipoAquisicaoBemVO) then
    FPatrimTipoAquisicaoBemVO.Free;
  if Assigned(FPatrimEstadoConservacaoVO) then
    FPatrimEstadoConservacaoVO.Free;

  inherited;
end;

function TPatrimBemVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Documento
    Serializa.RegisterConverter(TPatrimBemVO, 'FListaPatrimDocumentoBemVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TPatrimBemVO(Data).FListaPatrimDocumentoBemVO) then
        begin
          SetLength(Result, TPatrimBemVO(Data).FListaPatrimDocumentoBemVO.Count);
          for I := 0 to TPatrimBemVO(Data).FListaPatrimDocumentoBemVO.Count - 1 do
          begin
            Result[I] := TPatrimBemVO(Data).FListaPatrimDocumentoBemVO.Items[I];
          end;
        end;
      end);

    //Depreciação
    Serializa.RegisterConverter(TPatrimBemVO, 'FListaPatrimDepreciacaoBemVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TPatrimBemVO(Data).FListaPatrimDepreciacaoBemVO) then
        begin
          SetLength(Result, TPatrimBemVO(Data).FListaPatrimDepreciacaoBemVO.Count);
          for I := 0 to TPatrimBemVO(Data).FListaPatrimDepreciacaoBemVO.Count - 1 do
          begin
            Result[I] := TPatrimBemVO(Data).FListaPatrimDepreciacaoBemVO.Items[I];
          end;
        end;
      end);

    //Movimentação
    Serializa.RegisterConverter(TPatrimBemVO, 'FListaPatrimMovimentacaoBemVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TPatrimBemVO(Data).FListaPatrimMovimentacaoBemVO) then
        begin
          SetLength(Result, TPatrimBemVO(Data).FListaPatrimMovimentacaoBemVO.Count);
          for I := 0 to TPatrimBemVO(Data).FListaPatrimMovimentacaoBemVO.Count - 1 do
          begin
            Result[I] := TPatrimBemVO(Data).FListaPatrimMovimentacaoBemVO.Items[I];
          end;
      end;
      end);

     // Campos Transientes
     if Assigned(Self.SetorVO) then
       Self.SetorNome := Self.SetorVO.Nome;
     if Assigned(Self.ColaboradorVO) then
       Self.ColaboradorPessoaNome := Self.ColaboradorVO.PessoaVO.Nome;
     if Assigned(Self.FornecedorVO) then
       Self.FornecedorPessoaNome := Self.FornecedorVO.PessoaVO.Nome;
     if Assigned(Self.PatrimGrupoBemVO) then
       Self.PatrimGrupoBemNome := Self.PatrimGrupoBemVO.Nome;
     if Assigned(Self.PatrimTipoAquisicaoBemVO) then
       Self.PatrimTipoAquisicaoBemNome := Self.PatrimTipoAquisicaoBemVO.Nome;
     if Assigned(Self.PatrimEstadoConservacaoVO) then
       Self.PatrimEstadoConservacaoNome := Self.PatrimEstadoConservacaoVO.Nome;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
