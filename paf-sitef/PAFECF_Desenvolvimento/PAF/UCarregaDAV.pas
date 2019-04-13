{*******************************************************************************
Title: T2Ti ERP
Description: Carrega DAVs.

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

@author Albert Eije (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit UCarregaDAV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, FMTBcd,
  Provider, DBClient, DB, SqlExpr, DBCtrls,Generics.Collections;

type
  TFCarregaDAV = class(TForm)
    Image1: TImage;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    QMestre: TSQLQuery;
    DSMestre: TDataSource;
    CDSMestre: TClientDataSet;
    DSPMestre: TDataSetProvider;
    DSDetalhe: TDataSource;
    CDSDetalhe: TClientDataSet;
    QDetalhe: TSQLQuery;
    DSPDetalhe: TDataSetProvider;
    CDSDetalheID: TIntegerField;
    CDSDetalheID_PRODUTO: TIntegerField;
    CDSDetalheDESCRICAO_PDV: TStringField;
    CDSMestreID: TIntegerField;
    CDSMestreCCF: TIntegerField;
    CDSMestreCOO: TIntegerField;
    CDSMestreNOME_DESTINATARIO: TStringField;
    CDSMestreCPF_CNPJ_DESTINATARIO: TStringField;
    CDSMestreSITUACAO: TStringField;
    CDSMestreX: TStringField;
    GroupBox2: TGroupBox;
    GridMestre: TJvDBGrid;
    GroupBox1: TGroupBox;
    GridDetalhe: TJvDBGrid;
    CDSMestreVALOR: TFMTBCDField;
    CDSDetalheQUANTIDADE: TFMTBCDField;
    CDSDetalheVALOR_UNITARIO: TFMTBCDField;
    CDSDetalheVALOR_TOTAL: TFMTBCDField;
    CDSMestreDATA_EMISSAO: TDateField;
    CDSMestreHORA_EMISSAO: TStringField;
    CDSDetalheX: TStringField;
    CDSDetalheID_DAV_CABECALHO: TIntegerField;
    CDSDetalheGTIN_PRODUTO: TStringField;
    CDSDetalheNOME_PRODUTO: TStringField;
    CDSDetalheUNIDADE_PRODUTO: TStringField;
    CDSMestreID_PESSOA: TIntegerField;
    CDSMestreID_EMPRESA: TIntegerField;
    CDSMestreNUMERO_DAV: TStringField;
    CDSMestreNUMERO_ECF: TStringField;
    CDSMestreTAXA_ACRESCIMO: TFMTBCDField;
    CDSMestreACRESCIMO: TFMTBCDField;
    CDSMestreTAXA_DESCONTO: TFMTBCDField;
    CDSMestreDESCONTO: TFMTBCDField;
    CDSMestreSUBTOTAL: TFMTBCDField;
    CDSMestreIMPRESSO: TStringField;
    CDSMestreHASH_TRIPA: TStringField;
    CDSMestreHASH_INCREMENTO: TIntegerField;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCarregaDAV: TFCarregaDAV;

implementation

uses
  UCaixa,UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

{$R *.dfm}

procedure TFCarregaDAV.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  GridMestre.SetFocus;
end;

procedure TFCarregaDAV.FormCreate(Sender: TObject);
begin
  QMestre.SQLConnection     := FDataModule.ConexaoBalcao;
  QDetalhe.SQLConnection    := FDataModule.ConexaoBalcao;
  QMestre.ParamByName('SITUACAO').AsString := 'P';
  CDSDetalhe.MasterSource   := DSMestre;
  CDSDetalhe.MasterFields   := 'ID';
  CDSDetalhe.IndexFieldNames:= 'ID_DAV_CABECALHO';
  CDSMestre.Active  := True;
  CDSDetalhe.Active := True;
end;

procedure TFCarregaDAV.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F12 then
    botaoConfirma.Click;
end;

end.
