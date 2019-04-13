unit UDestinatarioUtil;

interface

type
  TNFeDestinatarioUtil = class
  private
    FNOME: string;
    FDOCUMENTO: string;
    FINSCRICAO_ESTADUAL: string;
    FTELEFONE: string;
    FLOGRADOURO: string;
    FBAIRRO: string;
    FUF: string;
    FCIDADE_CODIGO_IBGE: integer;
    FCIDADE: string;

  published
  public
    property Nome: string read FNOME write FNOME;
    property Documento: string read FDOCUMENTO write FDOCUMENTO;
    property IncricaoEstadual: string read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;
    property Telefone: string read FTELEFONE write FTELEFONE;
    property Logradouro: string read FLOGRADOURO write FLOGRADOURO;
    property Bairro: string read FBAIRRO write FBAIRRO;
    property CidadeCodigoIBGE: integer read FCIDADE_CODIGO_IBGE write FCIDADE_CODIGO_IBGE;
    property Cidade: string read FCIDADE write FCIDADE;
    property Uf: string read FUF write FUF;

    procedure AtualizaDestinatario(ID: integer);
  end;

implementation

uses T2TiORM, DBXCommon, SysUtils;

{ TNFeDestinatarioUtil }

procedure TNFeDestinatarioUtil.AtualizaDestinatario(ID: integer);
var
  ResultSet : TDBXReader;
  ConsultaSQL: string;
begin
    try

      ConsultaSQL := 'select p.id,'+
                     '       p.nome,'+
                     //'       p.fantasia,'+
                     '       p.cpf_cnpj,'+
                     '       p.inscricao_estadual,'+
                     '       p.inscricao_municipal,'+
                     '       p.fone1'+
                     '  from pessoa p';

      ResultSet := TT2TiORM.Consultar(ConsultaSQL, 'P.ID = '+IntToStr(Id),0);

      ResultSet.Next;

      if ResultSet['ID'].AsInt32 > 0 then
      begin
        Nome             := ResultSet['Nome'].AsString;
        Documento        := ResultSet['cpf_cnpj'].AsString;
        IncricaoEstadual := ResultSet['Unidade'].AsString;
        Telefone         := ResultSet['Fone1'].AsString;
      end;
    finally
      ResultSet.Free;
    end;


end;

end.
