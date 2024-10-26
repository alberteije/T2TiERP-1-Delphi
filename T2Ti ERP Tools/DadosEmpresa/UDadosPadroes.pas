{*******************************************************************************
Title: T2Ti ERP
Description: T2Ti Tools - Dados Padr�es Empresa

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
@version 1.1
*******************************************************************************}

unit UDadosPadroes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, WideStrings, Buttons, StdCtrls, DB, SqlExpr, ExtCtrls,
  ComCtrls, FMTBcd, MidasLib, DBClient, Menus, DBCtrls, DBXMsSQL, DBXInterbase,
  DBXOracle, DBXFirebird, DBXMySql, FileCtrl, JvExStdCtrls, JvListBox,
  JvDriveCtrls, JvCombobox, Mask, JvExMask, JvToolEdit, JvComponentBase,
  JvEnterTab, IniFiles, SWSystem, Grids, DBGrids, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid;

type
  TFDadosPadroes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    editHost: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    editSenha: TEdit;
    editUsuario: TEdit;
    Panel3: TPanel;
    listaCampo: TListBox;
    listaTabelas: TListBox;
    StatusBar1: TStatusBar;
    Entidade: TSQLDataSet;
    comboConexao: TComboBox;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    DataSetEntidade: TClientDataSet;
    DataSetEntidadecampo: TStringField;
    DataSetEntidadeimplamentacao: TStringField;
    DataSource1: TDataSource;
    INTERBASE: TSQLConnection;
    Oracle: TSQLConnection;
    SQL: TSQLConnection;
    CONN: TSQLConnection;
    MySQL: TSQLConnection;
    Label5: TLabel;
    botaoSair: TButton;
    botaoLimparMemo: TButton;
    OpenDialog1: TOpenDialog;
    FindDialog1: TFindDialog;
    JvEnterAsTab1: TJvEnterAsTab;
    Label7: TLabel;
    editBancoDados: TJvFilenameEdit;
    Panel4: TPanel;
    EditBusca: TLabeledEdit;
    botaoConectar: TBitBtn;
    GridDadosPadroes: TJvDBUltimGrid;
    CDSDadosPadroes: TClientDataSet;
    DSDadosPadroes: TDataSource;
    CDSDadosPadroesID: TAutoIncField;
    CDSDadosPadroesTABELA: TStringField;
    Button1: TButton;
    CDSDadosPadroesCAMPO1: TStringField;
    CDSDadosPadroesVALOR1: TStringField;
    CDSDadosPadroesCAMPO2: TStringField;
    CDSDadosPadroesVALOR2: TStringField;
    Button2: TButton;
    procedure botaoConectarClick(Sender: TObject);
    procedure listaTabelasClick(Sender: TObject);
    procedure botaoSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EditBuscaChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);


  private
    ListaCampos: TStringList;
    ListaPropriedades: TStringList;
    ListaSets: TStringList;
    ListaProcedureSet: TStringList;

    procedure Conectar(Driver: String; Conn: TSQLConnection; Server, Database, User, Pass: String);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDadosPadroes: TFDadosPadroes;
  NomeClasse: String;
  TabelaVO, NomeTabela: String;
  Diretorio : TJvDirectoryEdit;

implementation

{$R *.dfm}

procedure TFDadosPadroes.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(gsAppPath+'DadosPadroes.ini');
  try
    with Ini do
    begin
      WriteString('Banco','Banco',EditBancoDados.Text);
    end;
  finally
    Ini.Free;
  end;
end;

procedure TFDadosPadroes.FormShow(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(gsAppPath+'DadosPadroes.ini');
  try
    with Ini do
    begin
      if not SectionExists('Autor') then
      begin
        WriteString('Banco','Banco','caminho do banco');
      end;

      EditBancoDados.Text := ReadString('Banco','Banco','');
    end;
  finally
    Ini.Free;
  end;
end;

procedure TFDadosPadroes.Conectar(Driver: String; Conn: TSQLConnection; Server, Database, User, Pass: String);
begin
  Conn.Connected := false;
  if (Driver = 'MSSQL') then
  begin
    Conn.Params.Values['HostName'] := Server;
    Conn.Params.Values['DataBase'] := Database;
  end
  else if (Driver = 'INTERBASE') then
    Conn.Params.Values['DataBase'] := Server + ':' + Database
  else if (Driver = 'FIREBIRD') then
    Conn.Params.Values['DataBase'] := Server + ':' + Database
  else if (Driver = 'Oracle') then
    Conn.Params.Values['DataBase'] := Database
  else if (Driver = 'MySQL') then
  begin
    Conn.Params.Values['HostName'] := Server;
    Conn.Params.Values['DataBase'] := Database;
  end;
  Conn.Params.Values['User_Name'] := User;
  Conn.Params.Values['Password'] := Pass;
  Conn.Connected := True;
  Entidade.SQLConnection := CONN;
end;

procedure TFDadosPadroes.botaoConectarClick(Sender: TObject);
var
  List: TStringList;
begin
  if comboConexao.text = 'MSSQL' then
    Conectar(comboConexao.text,SQL, editHost.text,EditBancoDados.Text,editUsuario.text, editSenha.text)
  else if comboConexao.text = 'FIREBIRD' then
    Conectar(comboConexao.text, INTERBASE, edithost.text,EditBancoDados.Text,editUsuario.text, editSenha.text)
  else if comboConexao.text = 'INTERBASE' then
    Conectar(comboConexao.text, INTERBASE, edithost.text,EditBancoDados.Text,editUsuario.text, editSenha.text)
  else if comboConexao.text = 'Oracle' then
     Conectar(comboConexao.text, Oracle , edithost.text,EditBancoDados.Text,editUsuario.text, editSenha.text)
  else if comboConexao.text = 'MySQL' then
     Conectar(comboConexao.text, MySQL , edithost.text,EditBancoDados.Text,editUsuario.text, editSenha.text);

  List := TStringList.Create;
  Entidade.SQLConnection.GetTableNames(List, false);
  if listaTabelas.itemindex > -1 then
     if listaTabelas.Items.Strings[listaTabelas.itemindex] <> '' then
      Entidade.SQLConnection.GetFieldNames(listaTabelas.Items.Strings[listaTabelas.itemindex],listaCampo.Items);

  listaTabelas.Items.Assign(List);

  EditBusca.SetFocus;
  List.Free;
end;

procedure TFDadosPadroes.listaTabelasClick(Sender: TObject);
begin
  Entidade.SQLConnection.GetFieldNames(listaTabelas.Items.Strings[listaTabelas.itemindex],listaCampo.Items);
  //
  CDSDadosPadroes.Filtered := False;
  CDSDadosPadroes.Filter := 'TABELA = ' + QuotedStr(listaTabelas.Items.Strings[listaTabelas.itemindex]);
  CDSDadosPadroes.Filtered := True;
end;

procedure TFDadosPadroes.botaoSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFDadosPadroes.EditBuscaChange(Sender: TObject);
begin
  ListaTabelas.Perform(LB_SELECTSTRING,0,LongInt(PChar(EditBusca.Text)));
end;

procedure TFDadosPadroes.Button1Click(Sender: TObject);
begin
  CDSDadosPadroes.Append;
  CDSDadosPadroesTABELA.AsString := listaTabelas.Items.Strings[listaTabelas.itemindex];
  CDSDadosPadroesCAMPO1.AsString := listaCampo.Items.Strings[listaCampo.itemindex];
  GridDadosPadroes.SetFocus;
end;

procedure TFDadosPadroes.Button2Click(Sender: TObject);
begin
  CDSDadosPadroes.Edit;
  CDSDadosPadroesTABELA.AsString := listaTabelas.Items.Strings[listaTabelas.itemindex];
  CDSDadosPadroesCAMPO2.AsString := listaCampo.Items.Strings[listaCampo.itemindex];
  GridDadosPadroes.SetFocus;
end;

end.
