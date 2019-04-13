{*******************************************************************************
Title: T2Ti ERP
Description: Mescla dois ou mais DAVs.

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
unit UMesclaDAV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, FMTBcd,
  Provider, DBClient, DB, SqlExpr, Math, DBCtrls,Generics.Collections;

type
  TFMesclaDAV = class(TForm)
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
    CDSDetalheID_ECF_DAV: TIntegerField;
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
    Bevel2: TBevel;
    Label2: TLabel;
    EditDestinatario: TEdit;
    Label3: TLabel;
    EditCPFCNPJ: TEdit;
    CDSMestreVALOR: TFMTBCDField;
    CDSDetalheQUANTIDADE: TFMTBCDField;
    CDSDetalheVALOR_UNITARIO: TFMTBCDField;
    CDSDetalheVALOR_TOTAL: TFMTBCDField;
    CDSMestreDATA_EMISSAO: TDateField;
    CDSMestreHORA_EMISSAO: TStringField;
    CDSMestreHASH_TRIPA: TStringField;
    procedure confirma;
    procedure FormActivate(Sender: TObject);
    procedure GridMestreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSMestreAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMesclaDAV: TFMesclaDAV;

implementation

Uses
UCaixa,DAVController,DAVVO,DAVDetalheVO;

{$R *.dfm}

procedure TFMesclaDAV.botaoConfirmaClick(Sender: TObject);
begin
  confirma;
end;

procedure TFMesclaDAV.CDSMestreAfterScroll(DataSet: TDataSet);
begin
  EditDestinatario.Text := CDSMestre.FieldByName('NOME_DESTINATARIO').AsString;
  EditCPFCNPJ.Text := CDSMestre.FieldByName('CPF_CNPJ_DESTINATARIO').AsString;
end;

procedure TFMesclaDAV.confirma;
var
  ListaDAVCabecalho: TObjectList<TDAVVO>;
  ListaDAVDetalhe: TObjectList<TDAVDetalheVO>;
  DAVCabecalho: TDAVVO;
  DAVDetalhe: TDAVDetalheVO;
begin
  if Application.MessageBox('Tem certeza que deseja mesclar os DAV selecionados?', 'Mesclar DAV', Mb_YesNo + Mb_IconQuestion) = IdYes then
  begin
    if (EditDestinatario.Text <> '') and (EditCPFCNPJ.Text <> '') then
    begin
      FCaixa.labelMensagens.Caption := 'Aguarde. Mesclando DAV!';
      ListaDAVCabecalho := TObjectList<TDAVVO>.Create;
      ListaDAVDetalhe := TObjectList<TDAVDetalheVO>.Create;

      CDSMestre.DisableControls;
      CDSMestre.First;
      while not CDSMestre.Eof do
      begin
        if CDSMestre.FieldByName('X').AsString = 'X' then
        begin
          DAVCabecalho := TDAVVO.Create;
          DAVCabecalho.Id := CDSMestre.FieldByName('ID').AsInteger;
          DAVCabecalho.NomeDestinatario := EditDestinatario.Text;
          DAVCabecalho.CpfCnpjDestinatario := EditCPFCNPJ.Text;
          ListaDAVCabecalho.Add(DAVCabecalho);

          QDetalhe.Active := False;
          QDetalhe.SQL.Clear;
          QDetalhe.SQL.Add('SELECT * FROM ECF_DAV_DETALHE WHERE ID_ECF_DAV='+QuotedStr(CDSMestre.FieldByName('ID').AsString));
          QDetalhe.Active := True;

          QDetalhe.First;
          while not QDetalhe.Eof do
          begin
            DAVDetalhe := TDAVDetalheVO.Create;
            DAVDetalhe.IdDAV := QDetalhe.FieldByName('ID_ECF_DAV').AsInteger;
            DAVDetalhe.IdProduto := QDetalhe.FieldByName('ID_PRODUTO').AsInteger;
            DAVDetalhe.Quantidade := QDetalhe.FieldByName('QUANTIDADE').AsFloat;
            DAVDetalhe.ValorUnitario := QDetalhe.FieldByName('VALOR_UNITARIO').AsFloat;
            DAVDetalhe.ValorTotal := QDetalhe.FieldByName('VALOR_TOTAL').AsFloat;
            ListaDAVDetalhe.Add(DAVDetalhe);
            QDetalhe.Next;
          end;
        end;
        CDSMestre.Next;
      end;
      TDAVController.MesclaDAV(ListaDAVCabecalho,ListaDAVDetalhe);
      FCaixa.labelMensagens.Caption := 'Venda em andamento.';
      FCaixa.FechaMenuOperacoes;
      Close;
    end
    else
      Application.MessageBox('Nome e CPF/CNPJ do destinatário são obrigatórios.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TFMesclaDAV.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  GridMestre.SetFocus;
end;

procedure TFMesclaDAV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFMesclaDAV.FormCreate(Sender: TObject);
begin
  CDSMestre.Active := True;
  CDSDetalhe.Active := True;
end;

procedure TFMesclaDAV.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 123 then
    confirma;
end;

procedure TFMesclaDAV.GridMestreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_SPACE then
  begin
    CDSMestre.Edit;
    if CDSMestre.FieldByName('X').AsString = '' then
      CDSMestre.FieldByName('X').AsString := 'X'
    else
      CDSMestre.FieldByName('X').AsString := '';
    CDSMestre.Post;
  end;
end;

end.
