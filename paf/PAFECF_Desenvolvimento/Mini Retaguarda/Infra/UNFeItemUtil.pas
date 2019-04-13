unit UNFeItemUtil;

interface

uses SysUtils;

type

 TNFeItemUtil = class
  private
    FId_Produto: integer;
    FDescricao: string;
    FID: integer;
    FNCM: string;
    FAliquota: Double;
    FUnidade: string;
    FValorItem: Double;
    FCodBarras: string;
    FReducaoBaseCalculo: Double;

  published

  public
    property Id: integer read FID write FID;
    property Id_Produto: integer read FId_Produto write FId_Produto;
    property Unidade: string read FUnidade write FUnidade;
    property CodBarras: string read FCodBarras write FCodBarras;
    property Descricao: string read FDescricao write FDescricao;
    property NCM: string read FNCM write FNCM;
    property ValorItem: Double read FValorItem write FValorItem;
    property Aliquota: Double read FAliquota write FAliquota;
    property ReducaoBaseCalculo: Double read FReducaoBaseCalculo write FReducaoBaseCalculo;

    procedure AtualizaNFeItem(Id: integer);
 end;

implementation

uses
  DBXCommon, T2TiORM;

{ TNFeItem }

procedure TNFeItemUtil.AtualizaNFeItem(Id: integer);
var
  ResultSet : TDBXReader;
  ConsultaSQL: string;
begin
    try

      ConsultaSQL := 'select p.id,'+
                     '       p.id_unidade_produto,'+
                     '       u.nome as Unidade,'+
                     '       p.gtin,'+
                     '       p.codigo_interno,'+
                     '       p.nome,'+
                     '       p.valor_venda,'+
                     '       p.ncm,'+
                     '       p.Taxa_ICMS,'+
                     '       0 as reducao_base_calculo'+     // verificar onde obter esta informação para o item
                     '  from produto p,'+
                     '       unidade_produto u'+
                     ' where p.id_unidade_produto = u.id';

      ResultSet := TT2TiORM.Consultar(ConsultaSQL, 'P.ID = '+IntToStr(Id),0);

      ResultSet.Next;

      if ResultSet['ID'].AsInt32 > 0 then
      begin
        Id_Produto := ResultSet.Value['Id'].AsInt32;
        CodBarras  := ResultSet.Value['gtin'].AsString;
        Unidade    := ResultSet.Value['Unidade'].AsString;
        Descricao  := ResultSet.Value['Nome'].AsString;
        NCM        := ResultSet.Value['NCM'].AsString;
        ValorItem  := ResultSet.Value['Valor_venda'].AsDouble;
        Aliquota   := ResultSet.Value['Taxa_icms'].AsDouble;
        ReducaoBaseCalculo := ResultSet.Value['Reducao_Base_calculo'].AsDouble;
      end;
    finally
      ResultSet.Free;
    end;

end;

end.
