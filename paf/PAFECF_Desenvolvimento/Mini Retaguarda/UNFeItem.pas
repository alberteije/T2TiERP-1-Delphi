unit UNFeItem;

interface

uses SysUtils;

type

 TNFeItem = class
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

procedure TNFeItem.AtualizaNFeItem(Id: integer);
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
                     '       i.id as ID_Imposto,'+
                     '       i.cfop,'+
                     '       i.aliquota_icms,'+
                     '       i.reducao_base_calculo'+
                     '  from produto p,'+
                     '       imposto_icms i,'+
                     '       unidade_produto u'+
                     ' where p.id_imposto_icms = i.id'+
                     '   and p.id_unidade_produto = u.id';

      ResultSet := TT2TiORM.Consultar(ConsultaSQL, 'P.ID = '+IntToStr(Id),0);

      ResultSet.Next;

      if ResultSet['ID'].AsInt32 > 0 then
      begin
        Id_Produto := ResultSet['Id'].AsInt32;
        CodBarras  := ResultSet['gtin'].AsString;
        Unidade    := ResultSet['Unidade'].AsString;
        Descricao  := ResultSet['Nome'].AsString;
        NCM        := ResultSet['NCM'].AsString;
        ValorItem  := ResultSet['Valor_venda'].AsDouble;
        Aliquota   := ResultSet['Aliquota_icms'].AsDouble;
        ReducaoBaseCalculo := ResultSet['Reducao_Base_calculo'].AsDouble;
      end;
    finally
      ResultSet.Free;
    end;

end;

end.
