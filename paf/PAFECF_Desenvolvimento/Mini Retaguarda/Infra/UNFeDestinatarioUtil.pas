unit UNFeDestinatarioUtil;

interface

type
  TNFeDestinatarioUtil = class
  private
    FID: Integer;
    FNOME: string;
    FDOCUMENTO: string;
    FINSCRICAO_ESTADUAL: string;
    FTELEFONE: string;
    FLOGRADOURO: string;
    FBAIRRO: string;
    FUF: string;
    FCIDADE_CODIGO_IBGE: integer;
    FCIDADE: string;
    FNUMERO: string;
    FCODIGO_CIDADE_IBGE: integer;
    FCEP: string;
    FCOMLEMENTO: string;
    FCODIGO_UF_IBGE: integer;
    FCOMPLEMENTO: string;


  published
  public
    property ID: Integer read FID write FID;
    property Nome: string read FNOME write FNOME;
    property Documento: string read FDOCUMENTO write FDOCUMENTO;
    property IncricaoEstadual: string read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;
    property Telefone: string read FTELEFONE write FTELEFONE;
    property Logradouro: string read FLOGRADOURO write FLOGRADOURO;
    property Numero: string read FNUMERO write FNUMERO;
    property Complemento: string read FCOMPLEMENTO write FCOMPLEMENTO;
    property Cep: string read FCEP write FCEP;
    property Bairro: string read FBAIRRO write FBAIRRO;
    property Cidade: string read FCIDADE write FCIDADE;
    property Uf: string read FUF write FUF;
    property CodigoCidadeIBGE: integer read FCODIGO_CIDADE_IBGE write FCODIGO_CIDADE_IBGE;
    property CodigoUfIBGE: integer read FCODIGO_UF_IBGE write FCODIGO_UF_IBGE;


    procedure AtualizaDestinatario(ID: integer);
  end;

implementation

uses T2TiORM, DBXCommon, SysUtils;

{ TNFeDestinatarioUtil }

procedure TNFeDestinatarioUtil.AtualizaDestinatario(ID: integer);
var
  ResultSet : TDBXReader;
  //DBXValue: TDBXValue;
  //DBXValueType: TDBXValueType;
  //NomeCampo: string;
  ConsultaSQL: string;
  i: integer;

begin
    try

      ConsultaSQL := 'select p.id,'+
                     '       p.nome,'+
                     '       p.cpf_cnpj,'+
                     '       p.inscricao_estadual,'+
                     '       p.inscricao_municipal,'+
                     '       p.fone1,'+
                     '       e.logradouro,'+
                     '       e.numero,'+
                     '       e.complemento,'+
                     '       e.cep,'+
                     '       e.bairro,'+
                     '       e.cidade,'+
                     '       e.uf,'+
                     '       e.codigo_ibge_Cidade,'+
                     '       e.codigo_ibge_uf'+
                     '  from pessoa p,'+
                     '       pessoa_endereco e'+
                     ' where p.id = e.id_pessoa';


      ResultSet := TT2TiORM.Consultar(ConsultaSQL, 'P.ID = '+IntToStr(Id),0);

      ResultSet.Next;

      if ResultSet['ID'].AsInt32 > 0 then
      begin
        FID               := ResultSet.Value['ID'].AsInt32;
        Nome             := ResultSet.Value['Nome'].asString;
        Documento        := ResultSet.Value['cpf_cnpj'].AsString;
        IncricaoEstadual := ResultSet.Value['Inscricao_Estadual'].AsString;
        Telefone         := ResultSet.Value['Fone1'].AsString;
        Logradouro       := ResultSet.Value['Logradouro'].AsString;
        Numero           := ResultSet.Value['Numero'].AsString;
        Complemento      := ResultSet.Value['Complemento'].AsString;
        Cep              := ResultSet.Value['Cep'].AsString;
        Bairro           := ResultSet.Value['Bairro'].AsString;
        Cidade           := ResultSet.Value['Cidade'].AsString;
        Uf               := ResultSet.Value['Uf'].AsString;
        CodigoCidadeIBGE := ResultSet.Value['Codigo_Ibge_Cidade'].AsInt32;
        CodigoUfIBGE     := ResultSet.Value['Codigo_Ibge_Uf'].AsInt32;
      end;
    finally
      ResultSet.Free;
    end;


end;

end.
