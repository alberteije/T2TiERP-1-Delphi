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
  Provider, DBClient, DB, SqlExpr, DBCtrls,Generics.Collections;

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
    CDSDetalheX: TStringField;
    CDSDetalheMESCLA_PRODUTO: TStringField;
    CDSDetalheID_DAV_CABECALHO: TIntegerField;
    CDSDetalheGTIN_PRODUTO: TStringField;
    CDSDetalheNOME_PRODUTO: TStringField;
    CDSDetalheUNIDADE_PRODUTO: TStringField;
    CDSMestreNUMERO_DAV: TStringField;
    CDSDetalheTOTALIZADOR_PARCIAL: TStringField;
    CDSDetalheCANCELADO: TStringField;
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure GridMestreKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSMestreAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridMestreDblClick(Sender: TObject);
    procedure GridDetalheDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure selecionaDavCabelho;
    procedure selecionaDavDetalhes(p_marcar : Boolean);
  end;

var
  FMesclaDAV: TFMesclaDAV;

implementation

uses
  UCaixa,DAVController, DAVDetalheVO, UDataModule, Biblioteca, DavCabecalhoVO,
  Constantes;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

{$R *.dfm}

procedure TFMesclaDAV.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFMesclaDAV.CDSMestreAfterScroll(DataSet: TDataSet);
begin
  EditDestinatario.Text := CDSMestre.FieldByName('NOME_DESTINATARIO').AsString;
  EditCPFCNPJ.Text := CDSMestre.FieldByName('CPF_CNPJ_DESTINATARIO').AsString;
end;

procedure TFMesclaDAV.Confirma;
var
  ListaDAVCabecalho: TObjectList<TDAVCabecalhoVO>;
  ListaDAVDetalhe: TObjectList<TDAVDetalheVO>;
  DAVCabecalho: TDAVCabecalhoVO;
  DAVDetalhe: TDAVDetalheVO;
  ValorNovoDav: Extended;
begin
  if Application.MessageBox('Tem certeza que deseja mesclar os DAV selecionados?', 'Mesclar DAV', Mb_YesNo + Mb_IconQuestion) = IdYes then
  begin
    if (Trim(EditDestinatario.Text) = '') Then
    begin
      Application.MessageBox('Preencha o Nome do Destinatário!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      EditDestinatario.SetFocus;
      Exit;
    end;
    if (not ValidaCPF(EditCPFCNPJ.Text)) and (not ValidaCNPJ(EditCPFCNPJ.Text)) then
    begin
      Application.MessageBox('Documento Inválido! Favor Corrigir', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      EditCPFCNPJ.SetFocus;
      Exit;
    end;
    ValorNovoDav := 0;

    FCaixa.labelMensagens.Caption := 'Aguarde. Mesclando DAV!';
    ListaDAVCabecalho := TObjectList<TDAVCabecalhoVO>.Create;
    ListaDAVDetalhe := TObjectList<TDAVDetalheVO>.Create;

    CDSMestre.DisableControls;
    CDSMestre.First;
    while not CDSMestre.Eof do
    begin
      if CDSMestre.FieldByName('X').AsString = 'X' then
      begin
        DAVCabecalho := TDAVCabecalhoVO.Create;
        DAVCabecalho.Id := CDSMestre.FieldByName('ID').AsInteger;
        DAVCabecalho.NomeDestinatario := EditDestinatario.Text;
        DAVCabecalho.CpfCnpjDestinatario := EditCPFCNPJ.Text;
        DAVCabecalho.Valor := CDSMestre.FieldByName('VALOR').AsFloat;
        ListaDAVCabecalho.Add(DAVCabecalho);

        CDSDetalhe.Close;
        CDSDetalhe.Open;
        CDSDetalhe.First;
        while not CDSDetalhe.Eof do
        begin
          if CDSDetalhe.FieldByName('MESCLA_PRODUTO').AsString = 'S' then
          begin
            DAVDetalhe := TDAVDetalheVO.Create;
            DAVDetalhe.IdDavCabecalho := DAVCabecalho.Id;
            DAVDetalhe.Id := CDSDetalhe.FieldByName('ID').AsInteger;
            DAVDetalhe.IdProduto := CDSDetalhe.FieldByName('ID_PRODUTO').AsInteger;
            DAVDetalhe.GtinProduto := CDSDetalhe.FieldByName('GTIN_PRODUTO').AsString;
            DAVDetalhe.NomeProduto := CDSDetalhe.FieldByName('NOME_PRODUTO').AsString;
            DAVDetalhe.TotalizadorParcial := CDSDetalhe.FieldByName('TOTALIZADOR_PARCIAL').AsString;
            DAVDetalhe.UnidadeProduto := CDSDetalhe.FieldByName('UNIDADE_PRODUTO').AsString;
            DAVDetalhe.Cancelado := CDSDetalhe.FieldByName('CANCELADO').AsString;
            DAVDetalhe.Quantidade := CDSDetalhe.FieldByName('QUANTIDADE').AsFloat;
            DAVDetalhe.ValorUnitario := CDSDetalhe.FieldByName('VALOR_UNITARIO').AsFloat;
            DAVDetalhe.ValorTotal := CDSDetalhe.FieldByName('VALOR_TOTAL').AsFloat;
            if DAVDetalhe.Cancelado = 'N' then
              ValorNovoDav := TruncaValor(ValorNovoDav + DAVDetalhe.ValorTotal, Constantes.TConstantes.DECIMAIS_VALOR);
            ListaDAVDetalhe.Add(DAVDetalhe);
          end;
          CDSDetalhe.Next;
        end;
      end;

      CDSMestre.Next;
    end;

    CDSMestre.EnableControls;

    if ListaDAVDetalhe.Count < 1 then
       Application.MessageBox('Nenhum ítem selecionado!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
    else
       begin
        TDAVController.MesclaDAV(ListaDAVCabecalho, ListaDAVDetalhe, ValorNovoDav);
        FCaixa.labelMensagens.Caption := 'Venda em andamento.';
        Close;
       end;

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
  QMestre.SQLConnection     := FDataModule.ConexaoBalcao;
  QDetalhe.SQLConnection    := FDataModule.ConexaoBalcao;
  QMestre.ParamByName('SITUACAO').AsString := 'P';
  CDSDetalhe.MasterSource   := DSMestre;
  CDSDetalhe.MasterFields   := 'ID';
  CDSDetalhe.IndexFieldNames:= 'ID_DAV_CABECALHO';
  CDSMestre.Active  := True;
  CDSDetalhe.Active := True;
end;

procedure TFMesclaDAV.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 123 then
    Confirma;
end;

procedure TFMesclaDAV.GridDetalheDblClick(Sender: TObject);
var
  bookMark : TBookMark;
begin
   try
     bookMark := CDSDetalhe.GetBookmark;
     cdsDetalhe.DisableControls;
    if not CDSDetalhe.IsEmpty then
    begin
      try
        try
          try
            ConsultaSQL :=  'update DAV_DETALHE set ' +
                            'MESCLA_PRODUTO = :pMesclaProduto '+
                            ' where ID = :pId';

            Query := TSQLQuery.Create(nil);
            Query.SQLConnection := FDataModule.ConexaoBalcao;
            Query.sql.Text := ConsultaSQL;
            Query.ParamByName('pId').AsInteger := CDSDetalhe.FieldByName('ID').AsInteger;
            CDSDetalhe.Edit;
            if CDSDetalhe.FieldByName('X').AsString = '' then
            begin
              CDSDetalhe.FieldByName('X').AsString := 'X';
              CDSDetalhe.FieldByName('MESCLA_PRODUTO').AsAnsiString :=  'S';
              Query.ParamByName('pMesclaProduto').AsString := 'S';
            end
            else
            begin
              CDSDetalhe.FieldByName('X').AsString := '';
              CDSDetalhe.FieldByName('MESCLA_PRODUTO').AsAnsiString :=  'N';
              Query.ParamByName('pMesclaProduto').AsString := 'N';
            end;
            CDSDetalhe.Post;
            Query.ExecSQL();
          except
          end;
        finally
          Query.Free;
        end;
   //   end//if CDSMestre.FieldByName('X').AsString = '' then
   //   else
   //     Application.MessageBox('Não Existe Detalhes Para Selecionar!', 'Informação do sistema',MB_OK +MB_ICONERROR);
      finally
          selecionaDavCabelho;
      end;
    End;
    finally
       cdsDetalhe.GotoBookmark(bookMark);
       cdsDetalhe.enableControls;
       cdsDetalhe.FreeBookmark(bookMark);
    end;

end;

procedure TFMesclaDAV.GridDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_SPACE then
  begin
    if CDSMestre.FieldByName('X').AsString = '' then
    begin
      Application.MessageBox('É Necessário Marcar o Dav Para Poder Selecionar Seus Ítens!', 'Informação do sistema',MB_OK +MB_ICONERROR);
    end
    else
    Begin
    if not CDSDetalhe.IsEmpty then
    begin
        try
          try
            ConsultaSQL :=  'update DAV_DETALHE set ' +
                            'MESCLA_PRODUTO = :pMesclaProduto '+
                            ' where ID = :pId';

            Query := TSQLQuery.Create(nil);
            Query.SQLConnection := FDataModule.ConexaoBalcao;
            Query.sql.Text := ConsultaSQL;
            Query.ParamByName('pId').AsInteger := CDSDetalhe.FieldByName('ID').AsInteger;
            CDSDetalhe.Edit;
            if CDSDetalhe.FieldByName('X').AsString = '' then
            begin
              CDSDetalhe.FieldByName('X').AsString := 'X';
              CDSDetalhe.FieldByName('MESCLA_PRODUTO').AsAnsiString :=  'S';
              Query.ParamByName('pMesclaProduto').AsString := 'S';
            end
            else
            begin
              CDSDetalhe.FieldByName('X').AsString := '';
              CDSDetalhe.FieldByName('MESCLA_PRODUTO').AsAnsiString :=  'N';
              Query.ParamByName('pMesclaProduto').AsString := 'N';
            end;
            CDSDetalhe.Post;
            Query.ExecSQL();
          except
          end;
        finally
          Query.Free;
        end;
      end//if CDSMestre.FieldByName('X').AsString = '' then
      else
        Application.MessageBox('Não Existe Detalhes Para Selecionar!', 'Informação do sistema',MB_OK +MB_ICONERROR);
    end;
  end;//if key = VK_SPACE then
end;

procedure TFMesclaDAV.GridMestreDblClick(Sender: TObject);
begin
     CDSMestre.Edit;
    if CDSMestre.FieldByName('X').AsString = '' then
       begin
          CDSMestre.FieldByName('X').AsString := 'X';
          selecionaDavDetalhes(true);
       end
    else
       begin
          CDSMestre.FieldByName('X').AsString := '';
          selecionaDavDetalhes(false);
       end;
    CDSMestre.Post;

end;

procedure TFMesclaDAV.GridMestreKeyDown(Sender: TObject; var Key: Word;   Shift: TShiftState);
begin
  if key = VK_SPACE then
  begin
    CDSMestre.Edit;
    if CDSMestre.FieldByName('X').AsString = '' then
       begin
          CDSMestre.FieldByName('X').AsString := 'X';
          cdsDetalhe.DisableControls;
          selecionaDavDetalhes(true);
          cdsDetalhe.EnableControls;
       end
    else
       begin
          CDSMestre.FieldByName('X').AsString := '';
           cdsDetalhe.DisableControls;
           selecionaDavDetalhes(false);
           cdsDetalhe.EnableControls;
       end;
    CDSMestre.Post;
  end;
end;

procedure TFMesclaDAV.selecionaDavCabelho;
var
 v_bool : boolean;
begin
     v_bool := false;
     CDSMestre.Edit;
        cdsDetalhe.DisableControls;
        CDSDetalhe.First;
        while not CDSDetalhe.eof do
           begin
              if CDSDetalhe.FieldByName('X').AsString = 'X' then
                 begin
                    v_bool := true;
                    break;
                 end;
              CDSDetalhe.Next;
           end;
        cdsDetalhe.enableControls;
        if v_bool then
           CDSMestre.FieldByName('X').AsString := 'X'
        else
           CDSMestre.FieldByName('X').AsString := '';

    CDSMestre.Post;

end;

procedure TFMesclaDAV.selecionaDavDetalhes(p_marcar : Boolean);
begin
          CDSDetalhe.first;
          while not CDSDetalhe.Eof do
             begin
                  CDSDetalhe.Edit;
                  if p_marcar then
                  begin
                    CDSDetalhe.FieldByName('X').AsString := 'X';
                    CDSDetalhe.FieldByName('MESCLA_PRODUTO').AsAnsiString :=  'S';
                  //
                  end
                  else
                  begin
                    CDSDetalhe.FieldByName('X').AsString := '';
                    CDSDetalhe.FieldByName('MESCLA_PRODUTO').AsAnsiString :=  'N';
                   // Query.ParamByName('pMesclaProduto').AsString := 'N';
                  end;
                  CDSDetalhe.Post;


              CDSDetalhe.Next;
              End;

           try
             try
                 CDSDetalhe.First;
                 Query := TSQLQuery.Create(nil);
                 while not cdsDetalhe.eof do
                    begin
                        ConsultaSQL :=  'update DAV_DETALHE set ' +
                                          'MESCLA_PRODUTO = :pMesclaProduto '+
                                          ' where ID = :pId';


                        Query.SQLConnection := FDataModule.ConexaoBalcao;
                        Query.sql.Text := ConsultaSQL;
                        Query.ParamByName('pId').AsInteger := CDSDetalhe.FieldByName('ID').AsInteger;
                        Query.ParamByName('pMesclaProduto').AsString := CDSDetalhe.FieldByName('MESCLA_PRODUTO').AsAnsiString;
                        Query.ExecSQL();
                        CDSDetalhe.Next;
                    end

                except
                end;
           finally
              Query.Free;
           end;

end;

end.
