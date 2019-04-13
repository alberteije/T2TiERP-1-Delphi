{ *******************************************************************************
  Title: T2Ti ERP
  Description:  VO  relacionado à tabela [PRODUTO]

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
  t2ti.com@gmail.com</p>

  @author Albert Eije (t2ti.com@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit ProdutoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, UnidadeProdutoVO, ProdutoSubGrupoVO, AlmoxarifadoVO, TributGrupoTributarioVO,
  ProdutoMarcaVO, TributIcmsCustomCabVO;

type
  [TEntity]
  [TTable('PRODUTO')]

  TProdutoVO = class(TJsonVO)
  private
    FID: Integer;
    FGTIN: String;
    FNOME: String;
    FID_UNIDADE_PRODUTO: Integer;
    FID_ALMOXARIFADO: Integer;
    FID_GRUPO_TRIBUTARIO: Integer;
    FID_TRIBUT_ICMS_CUSTOM_CAB: Integer;
    FID_MARCA_PRODUTO: Integer;
    FID_SUB_GRUPO: Integer;
    FCODIGO_INTERNO: String;
    FNCM: String;
    FDESCRICAO: String;
    FDESCRICAO_PDV: String;
    FVALOR_COMPRA: Extended;
    FVALOR_VENDA: Extended;
    FPRECO_VENDA_MINIMO: Extended;
    FPRECO_SUGERIDO: Extended;
    FCUSTO_MEDIO_LIQUIDO: Extended;
    FPRECO_LUCRO_ZERO: Extended;
    FPRECO_LUCRO_MINIMO: Extended;
    FPRECO_LUCRO_MAXIMO: Extended;
    FMARKUP: Extended;
    FQUANTIDADE_ESTOQUE: Extended;
    FQUANTIDADE_ESTOQUE_ANTERIOR: Extended;
    FESTOQUE_MINIMO: Extended;
    FESTOQUE_MAXIMO: Extended;
    FESTOQUE_IDEAL: Extended;
    FEXCLUIDO: String;
    FINATIVO: String;
    FDATA_CADASTRO: TDateTime;
    FFOTO_PRODUTO: String;
    FEX_TIPI: String;
    FCODIGO_LST: String;
    FCLASSE_ABC: String;
    FIAT: String;
    FIPPT: String;
    FTIPO_ITEM_SPED: String;
    FPESO: Extended;
    FPORCENTO_COMISSAO: Extended;
    FPONTO_PEDIDO: Extended;
    FLOTE_ECONOMICO_COMPRA: Extended;
    FALIQUOTA_ICMS_PAF: Extended;
    FALIQUOTA_ISSQN_PAF: Extended;
    FTOTALIZADOR_PARCIAL: String;
    FCODIGO_BALANCA: Integer;
    FDATA_ALTERACAO: TDateTime;
    FVALIDADE: TDateTime;
    FTIPO: String;

    FTributIcmsCustomCabDescricao: String;
    FUnidadeProdutoSigla: String;
    FAlmoxarifadoNome: String;
    FTributGrupoTributarioDescricao: String;
    FProdutoMarcaNome: String;
    FProdutoSubGrupoNome: String;
    FProdutoGrupoNome: String;

    FImagem: String;
    FTipoImagem: String;

    FTributIcmsCustomCabVO: TTributIcmsCustomCabVO;
    FUnidadeProdutoVO: TUnidadeProdutoVO;
    FAlmoxarifadoVO: TAlmoxarifadoVO;
    FGrupoTributarioVO: TTributGrupoTributarioVO;
    FProdutoMarcaVO: TProdutoMarcaVO;
    FProdutoSubGrupoVO: TProdutoSubGrupoVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer read FID write FID;
    [TColumn('GTIN', 'Gtin', 112, [ldGrid, ldLookup, ldComboBox], False)]
    property Gtin: String read FGTIN write FGTIN;
    [TColumn('NOME', 'Nome', 450, [ldGrid, ldLookup], False)]
    property Nome: String read FNOME write FNOME;

    [TColumn('ID_UNIDADE_PRODUTO', 'Id Unidade', 70, [], False)]
    property IdUnidade: Integer read FID_UNIDADE_PRODUTO write FID_UNIDADE_PRODUTO;
    [TColumn('UNIDADE_PRODUTO.SIGLA', 'Unidade', 150, [ldGrid, ldLookup], True, 'UNIDADE_PRODUTO', 'ID_UNIDADE_PRODUTO', 'ID')]
    property UnidadeProdutoSigla: String read FUnidadeProdutoSigla write FUnidadeProdutoSigla;

    [TColumn('ID_ALMOXARIFADO', 'Id Almoxarifado', 80, [], False)]
    property IdAlmoxarifado: Integer read FID_ALMOXARIFADO write FID_ALMOXARIFADO;
    [TColumn('ALMOXARIFADO.NOME', 'Almoxarifado', 150, [ldGrid, ldLookup], True, 'ALMOXARIFADO', 'ID_ALMOXARIFADO', 'ID')]
    property AlmoxarifadoNome: String read FAlmoxarifadoNome write FAlmoxarifadoNome;

    [TColumn('ID_GRUPO_TRIBUTARIO', 'Id Grupo Tributário', 120, [ldLookup], False)]
    property IdGrupoTributario: Integer read FID_GRUPO_TRIBUTARIO write FID_GRUPO_TRIBUTARIO;
    [TColumn('TRIBUT_GRUPO_TRIBUTARIO.DESCRICAO', 'Grupo Tributário', 150, [ldGrid, ldLookup], True, 'TRIBUT_GRUPO_TRIBUTARIO', 'ID_GRUPO_TRIBUTARIO', 'ID')]
    property TributGrupoTributarioDescricao: String read FTributGrupoTributarioDescricao write FTributGrupoTributarioDescricao;

    [TColumn('ID_TRIBUT_ICMS_CUSTOM_CAB', 'Id Icms Customizado', 120, [ldLookup], False)]
    property IdIcmsCustomizado: Integer read FID_TRIBUT_ICMS_CUSTOM_CAB write FID_TRIBUT_ICMS_CUSTOM_CAB;
    [TColumn('TRIBUT_ICMS_CUSTOM_CAB.DESCRICAO', 'Icms Customizado', 150, [ldGrid, ldLookup], True, 'TRIBUT_ICMS_CUSTOM_CAB', 'ID_TRIBUT_ICMS_CUSTOM_CAB', 'ID')]
    property TributIcmsCustomCabDescricao: String read FTributIcmsCustomCabDescricao write FTributIcmsCustomCabDescricao;

    [TColumn('ID_MARCA_PRODUTO', 'Id Marca', 70, [], False)]
    property IdProdutoMarca: Integer read FID_MARCA_PRODUTO write FID_MARCA_PRODUTO;
    [TColumn('MARCA_PRODUTO.NOME', 'Marca', 150, [ldGrid, ldLookup], True, 'MARCA_PRODUTO', 'ID_MARCA_PRODUTO', 'ID')]
    property ProdutoMarcaNome: String read FProdutoMarcaNome write FProdutoMarcaNome;

    [TColumn('ID_SUB_GRUPO', 'Id Subgrupo', 70, [], False)]
    property IdSubGrupo: Integer read FID_SUB_GRUPO write FID_SUB_GRUPO;
    [TColumn('PRODUTO_GRUPO.NOME', 'Grupo', 150, [ldGrid, ldLookup, ldComboBox], True, 'PRODUTO_SUB_GRUPO.PRODUTO_GRUPO', 'ID_SUB_GRUPO.ID_GRUPO', 'ID')]
    property ProdutoGrupoNome: String read FProdutoGrupoNome write FProdutoGrupoNome;
    [TColumn('PRODUTO_SUB_GRUPO.NOME', 'Subgrupo', 150, [ldGrid, ldLookup, ldComboBox], True, 'PRODUTO_SUB_GRUPO', 'ID_SUB_GRUPO', 'ID')]
    property ProdutoSubGrupoNome: String read FProdutoSubGrupoNome write FProdutoSubGrupoNome;

    [TColumn('CODIGO_INTERNO', 'Código Interno', 450, [ldGrid, ldLookup, ldComboBox], False)]
    property CodigoInterno: String read FCODIGO_INTERNO write FCODIGO_INTERNO;
    [TColumn('NCM', 'Ncm', 64, [ldGrid, ldLookup, ldComboBox], False)]
    property Ncm: String read FNCM write FNCM;
    [TColumn('DESCRICAO', 'Descrição', 450, [ldGrid, ldLookup, ldComboBox], False)]
    property Descricao: String read FDESCRICAO write FDESCRICAO;
    [TColumn('DESCRICAO_PDV', 'Descrição Pdv', 240, [ldGrid, ldLookup], False)]
    property DescricaoPdv: String read FDESCRICAO_PDV write FDESCRICAO_PDV;
    [TColumn('VALOR_COMPRA', 'Valor Compra', 168, [ldGrid, ldLookup], False)]
    property ValorCompra: Extended read FVALOR_COMPRA write FVALOR_COMPRA;
    [TColumn('VALOR_VENDA', 'Valor Venda', 168, [ldGrid, ldLookup], False)]
    [TFormatter('0.0000')]
    property ValorVenda: Extended read FVALOR_VENDA write FVALOR_VENDA;
    [TColumn('PRECO_VENDA_MINIMO', 'Preço Venda Mínimo', 168, [ldGrid, ldLookup], False)]
    property PrecoVendaMinimo: Extended read FPRECO_VENDA_MINIMO write FPRECO_VENDA_MINIMO;
    [TColumn('PRECO_SUGERIDO', 'Preço Sugerido', 168, [ldGrid, ldLookup], False)]
    property PrecoSugerido: Extended read FPRECO_SUGERIDO write FPRECO_SUGERIDO;
    [TColumn('CUSTO_MEDIO_LIQUIDO', 'Custo Médio Líquido', 168, [ldGrid, ldLookup], False)]
    property CustoMedioLiquido: Extended read FCUSTO_MEDIO_LIQUIDO write FCUSTO_MEDIO_LIQUIDO;
    [TColumn('PRECO_LUCRO_ZERO', 'Preço Lucro Zero', 168, [ldGrid, ldLookup], False)]
    property PrecoLucroZero: Extended read FPRECO_LUCRO_ZERO write FPRECO_LUCRO_ZERO;
    [TColumn('PRECO_LUCRO_MINIMO', 'Preço Lucro Mínimo', 168, [ldGrid, ldLookup], False)]
    property PrecoLucroMinimo: Extended read FPRECO_LUCRO_MINIMO write FPRECO_LUCRO_MINIMO;
    [TColumn('PRECO_LUCRO_MAXIMO', 'Preço Lucro Máximo', 168, [ldGrid, ldLookup], False)]
    property PrecoLucroMaximo: Extended read FPRECO_LUCRO_MAXIMO write FPRECO_LUCRO_MAXIMO;
    [TColumn('MARKUP', 'Markup', 168, [ldGrid, ldLookup], False)]
    property Markup: Extended read FMARKUP write FMARKUP;
    [TColumn('QUANTIDADE_ESTOQUE', 'Qtde Estoque', 168, [ldGrid, ldLookup], False)]
    property QuantidadeEstoque: Extended read FQUANTIDADE_ESTOQUE write FQUANTIDADE_ESTOQUE;
    [TColumn('QUANTIDADE_ESTOQUE_ANTERIOR', 'Qtde Estoque Anterior', 168, [ldGrid, ldLookup], False)]
    property QuantidadeEstoqueAnterior: Extended read FQUANTIDADE_ESTOQUE_ANTERIOR write FQUANTIDADE_ESTOQUE_ANTERIOR;
    [TColumn('ESTOQUE_MINIMO', 'Estoque Mínimo', 168, [ldGrid, ldLookup], False)]
    property EstoqueMinimo: Extended read FESTOQUE_MINIMO write FESTOQUE_MINIMO;
    [TColumn('ESTOQUE_MAXIMO', 'Estoque Máximo', 168, [ldGrid, ldLookup], False)]
    property EstoqueMaximo: Extended read FESTOQUE_MAXIMO write FESTOQUE_MAXIMO;
    [TColumn('ESTOQUE_IDEAL', 'Estoque Ideal', 168, [ldGrid, ldLookup], False)]
    property EstoqueIdeal: Extended read FESTOQUE_IDEAL write FESTOQUE_IDEAL;
    [TColumn('EXCLUIDO', 'Excluido', 8, [], False)]
    property Excluido: String read FEXCLUIDO write FEXCLUIDO;
    [TColumn('INATIVO', 'Inativo', 50, [ldGrid, ldLookup], False)]
    property Inativo: String read FINATIVO write FINATIVO;
    [TColumn('DATA_CADASTRO', 'Data Cadastro', 80, [ldGrid, ldLookup, ldComboBox], False)]
    property DataCadastro: TDateTime read FDATA_CADASTRO write FDATA_CADASTRO;
    [TColumn('FOTO_PRODUTO', 'Foto Produto', 450, [ldGrid, ldLookup], False)]
    property FotoProduto: String read FFOTO_PRODUTO write FFOTO_PRODUTO;
    [TColumn('EX_TIPI', 'Ex Tipi', 50, [ldGrid, ldLookup], False)]
    property ExTipi: String read FEX_TIPI write FEX_TIPI;
    [TColumn('CODIGO_LST', 'Código Lst', 80, [ldGrid, ldLookup], False)]
    property CodigoLst: String read FCODIGO_LST write FCODIGO_LST;
    [TColumn('CLASSE_ABC', 'Classe ABC', 80, [ldGrid, ldLookup], False)]
    property ClasseAbc: String read FCLASSE_ABC write FCLASSE_ABC;
    [TColumn('IAT', 'Iat', 50, [ldGrid, ldLookup], False)]
    property Iat: String read FIAT write FIAT;
    [TColumn('IPPT', 'Ippt', 50, [ldGrid, ldLookup], False)]
    property Ippt: String read FIPPT write FIPPT;
    [TColumn('TIPO_ITEM_SPED', 'Tipo Item Sped', 100, [ldGrid, ldLookup], False)]
    property TipoItemSped: String read FTIPO_ITEM_SPED write FTIPO_ITEM_SPED;
    [TColumn('PESO', 'Peso', 168, [ldGrid, ldLookup], False)]
    property Peso: Extended read FPESO write FPESO;
    [TColumn('PORCENTO_COMISSAO', 'Porcento Comissão', 168, [ldGrid, ldLookup], False)]
    property PorcentoComissao: Extended read FPORCENTO_COMISSAO write FPORCENTO_COMISSAO;
    [TColumn('PONTO_PEDIDO', 'Ponto Pedido', 168, [ldGrid, ldLookup], False)]
    property PontoPedido: Extended read FPONTO_PEDIDO write FPONTO_PEDIDO;
    [TColumn('LOTE_ECONOMICO_COMPRA', 'Lote Econômico Compra', 168, [ldGrid, ldLookup], False)]
    property LoteEconomicoCompra: Extended read FLOTE_ECONOMICO_COMPRA write FLOTE_ECONOMICO_COMPRA;
    [TColumn('ALIQUOTA_ICMS_PAF', 'Alíquota ICMS PAF', 168, [ldGrid, ldLookup], False)]
    property AliquotaIcmsPaf: Extended read FALIQUOTA_ICMS_PAF write FALIQUOTA_ICMS_PAF;
    [TColumn('ALIQUOTA_ISSQN_PAF', 'Alíquota ISS PAF', 168, [ldGrid, ldLookup], False)]
    property AliquotaIssqnPaf: Extended read FALIQUOTA_ISSQN_PAF write FALIQUOTA_ISSQN_PAF;
    [TColumn('TOTALIZADOR_PARCIAL', 'Totalizador Parcial', 100, [ldGrid, ldLookup], False)]
    property TotalizadorParcial: String read FTOTALIZADOR_PARCIAL write FTOTALIZADOR_PARCIAL;
    [TColumn('CODIGO_BALANCA', 'Código Balança', 100, [ldGrid, ldLookup], False)]
    property CodigoBalanca: Integer read FCODIGO_BALANCA write FCODIGO_BALANCA;
    [TColumn('DATA_ALTERACAO', 'Data Alteração', 80, [ldGrid, ldLookup], False)]
    property DataAlteracao: TDateTime read FDATA_ALTERACAO write FDATA_ALTERACAO;
    [TColumn('TIPO', 'Tipo', 100, [ldGrid, ldLookup], False)]
    property Tipo: String read FTIPO write FTIPO;

    [TColumn('IMAGEM', 'Imagem', 80, [], True)]
    property Imagem: String read FImagem write FImagem;
    [TColumn('TIPO_IMAGEM', 'Tipo Imagem', 80, [], True)]
    property TipoImagem: String read FTipoImagem write FTipoImagem;

    [TAssociation(False, 'ID', 'ID_UNIDADE_PRODUTO')]
    property UnidadeProdutoVO: TUnidadeProdutoVO read FUnidadeProdutoVO write FUnidadeProdutoVO;

    [TAssociation(True, 'ID', 'ID_SUB_GRUPO')]
    property ProdutoSubGrupoVO: TProdutoSubGrupoVO read FProdutoSubGrupoVO write FProdutoSubGrupoVO;

    [TAssociation(False, 'ID', 'ID_ALMOXARIFADO')]
    property AlmoxarifadoVO: TAlmoxarifadoVO read FAlmoxarifadoVO write FAlmoxarifadoVO;

    [TAssociation(False, 'ID', 'ID_GRUPO_TRIBUTARIO')]
    property GrupoTributarioVO: TTributGrupoTributarioVO read FGrupoTributarioVO write FGrupoTributarioVO;

    [TAssociation(False, 'ID', 'ID_TRIBUT_ICMS_CUSTOM_CAB')]
    property TributIcmsCustomCabVO: TTributIcmsCustomCabVO read FTributIcmsCustomCabVO write FTributIcmsCustomCabVO;

    [TAssociation(False, 'ID', 'ID_MARCA_PRODUTO')]
    property ProdutoMarcaVO: TProdutoMarcaVO read FProdutoMarcaVO write FProdutoMarcaVO;

  end;

implementation

destructor TProdutoVO.Destroy;
begin
  if Assigned(FUnidadeProdutoVO) then
    FUnidadeProdutoVO.Free;
  if Assigned(FProdutoSubGrupoVO) then
    FProdutoSubGrupoVO.Free;
  if Assigned(FAlmoxarifadoVO) then
    FAlmoxarifadoVO.Free;
  if Assigned(FGrupoTributarioVO) then
    FGrupoTributarioVO.Free;
  if Assigned(FTributIcmsCustomCabVO) then
    FTributIcmsCustomCabVO.Free;
  if Assigned(FProdutoMarcaVO) then
    FProdutoMarcaVO.Free;
  inherited;
end;

function TProdutoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.UnidadeProdutoVO) then
      Self.UnidadeProdutoSigla := Self.UnidadeProdutoVO.Sigla;
    if Assigned(Self.ProdutoSubGrupoVO) then
    begin
      Self.ProdutoSubGrupoNome := Self.ProdutoSubGrupoVO.Nome;
      Self.ProdutoGrupoNome := Self.ProdutoSubGrupoVO.ProdutoGrupoVO.Nome;
    end;
    if Assigned(Self.AlmoxarifadoVO) then
      Self.AlmoxarifadoNome := Self.AlmoxarifadoVO.Nome;
    if Assigned(Self.GrupoTributarioVO) then
      Self.TributGrupoTributarioDescricao := Self.GrupoTributarioVO.Descricao;
    if Assigned(Self.TributIcmsCustomCabVO) then
      Self.TributIcmsCustomCabDescricao := Self.TributIcmsCustomCabVO.Descricao;
    if Assigned(Self.ProdutoMarcaVO) then
      Self.ProdutoMarcaNome := Self.ProdutoMarcaVO.Nome;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
