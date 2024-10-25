{*******************************************************************************
Title: T2Ti ERP
Description: Gerador

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
Ultima modifica��o: 06/04/2012 Fernando L�cio Oliveira.
*******************************************************************************}

unit DelphiReverse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, WideStrings, Buttons, StdCtrls, DB, SqlExpr, ExtCtrls,
  ComCtrls, FMTBcd, MidasLib, DBClient, Menus, DBCtrls, DBXMsSQL, DBXInterbase,
  DBXOracle, DBXFirebird, DBXMySql, FileCtrl, JvExStdCtrls, JvListBox,
  JvDriveCtrls, JvCombobox, Mask, JvExMask, JvToolEdit, JvComponentBase,
  JvEnterTab, IniFiles, SWSystem;

type
  TFGera = class(TForm)
    Panel1: TPanel;
    memo: TMemo;
    Panel2: TPanel;
    botaoGerar: TButton;
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
    Label6: TLabel;
    OpenDialog1: TOpenDialog;
    FindDialog1: TFindDialog;
    editDiretorioVO: TJvDirectoryEdit;
    JvEnterAsTab1: TJvEnterAsTab;
    BotaoGerarTodos: TButton;
    cbxOpcao: TComboBox;
    EditAutor: TLabeledEdit;
    EditEmailAutor: TLabeledEdit;
    Label7: TLabel;
    editBancoDados: TJvFilenameEdit;
    botaoConectar: TBitBtn;
    Label2: TLabel;
    Label8: TLabel;
    editDiretorioControllerCliente: TJvDirectoryEdit;
    editDiretorioControllerServidor: TJvDirectoryEdit;
    BotaoGerarConjunto: TButton;
    Panel4: TPanel;
    EditBusca: TLabeledEdit;
    procedure botaoConectarClick(Sender: TObject);
    procedure listaTabelasClick(Sender: TObject);
    procedure botaoGerarClick(Sender: TObject);
    procedure botaoSairClick(Sender: TObject);
    procedure botaoLimparMemoClick(Sender: TObject);
    procedure BotaoGerarTodosClick(Sender: TObject);
    procedure cbxOpcaoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BotaoGerarConjuntoClick(Sender: TObject);
    procedure EditBuscaChange(Sender: TObject);


  private
    ListaCampos: TStringList;
    ListaPropriedades: TStringList;
    ListaSets: TStringList;
    ListaProcedureSet: TStringList;

    function TrataNomeTabela: String;
    function NomeTabelaMaiusculo: String;
    function TrataNomeProperty(NomeCampo: String): String;
    function TrataNomeDisplay(NomeCampo: String): String;

    function GetUserFromWindows: String;

    procedure AdicionaLicenca;
    procedure GetPropriedades;
    procedure GetPropriedadesController;
    procedure CriarClasseVO;
    procedure CriarClasseCliente;
    procedure CriarClasseServidor;
    procedure ConfigurePropertyListVO(Classe, Campo, Tamanho, Tipo, GetSet: String);
    procedure ConfigurePropertyListController(Classe, Campo, Tipo, GetSet: String);
    procedure Conectar(Driver: String; Conn: TSQLConnection; Server, Database, User, Pass: String);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGera: TFGera;
  NomeClasse: String;
  TabelaVO, NomeTabela: String;
  Diretorio : TJvDirectoryEdit;

implementation

{$R *.dfm}

procedure TFGera.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(gsAppPath+'DelphiReverse.ini');
  try
    with Ini do
    begin
      WriteString('Autor','Autor',EditAutor.Text);
      WriteString('Autor','Email',EditEmailAutor.Text);
      WriteString('Banco','Banco',EditBancoDados.Text);
      WriteString('VO', 'VO',EditDiretorioVO.Text);
      WriteString('ControllerCliente','ControllerCliente',EditDiretorioControllerCliente.Text);
      WriteString('ControllerServidor','ControllerServidor',EditDiretorioControllerServidor.Text);
    end;
  finally
    Ini.Free;
  end;
end;

procedure TFGera.FormCreate(Sender: TObject);
begin
  cbxOpcaoChange(self);
  BotaoGerar.Enabled := False;
  BotaoGerarTodos.Enabled := False;
  BotaoGerarConjunto.Enabled := False;

end;

procedure TFGera.FormShow(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(gsAppPath+'DelphiReverse.ini');
  try
    with Ini do
    begin
      if not SectionExists('Autor') then
      begin
        WriteString('Autor','Autor',GetUserFromWindows);
        WriteString('Autor','Email','seuemail@email.com');
        WriteString('Banco','Banco','caminho do banco');
        WriteString('VO', 'VO','Caminho do VO');
        WriteString('ControllerCliente','ControllerCliente','Caminho Controller Cliente');
        WriteString('ControllerServidor','ControllerServidor','Caminho Controller Servidor');
      end;

      EditAutor.Text := ReadString('Autor','Autor','');
      EditEmailAutor.Text := ReadString('Autor','Email','');
      EditBancoDados.Text := ReadString('Banco','Banco','');
      EditDiretorioVO.Text := ReadString('VO','VO','');
      EditDiretorioControllerCliente.Text := ReadString('ControllerCliente','ControllerCliente','');
      EditDiretorioControllerServidor.Text := ReadString('ControllerServidor','ControllerServidor','');
    end;
  finally
    Ini.Free;
  end;
end;

procedure TFGera.Conectar(Driver: String; Conn: TSQLConnection; Server, Database, User, Pass: String);
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

procedure TFGera.botaoConectarClick(Sender: TObject);
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
  if List.Count>0 then
    BotaoGerarTodos.Enabled := True;

  EditBusca.SetFocus;
  List.Free;
end;

procedure TFGera.listaTabelasClick(Sender: TObject);
begin
  Entidade.SQLConnection.GetFieldNames(listaTabelas.Items.Strings[listaTabelas.itemindex],listaCampo.Items);
  if ListaCampo.Count > 0 then
  BotaoGerar.Enabled := True;
  BotaoGerarConjunto.Enabled := BotaoGerar.Enabled;
end;

procedure TFGera.botaoGerarClick(Sender: TObject);
begin
  memo.Clear;
  if listaTabelas.itemindex > -1 then
  begin
     try
       Entidade.Active := false;
       Entidade.CommandText:= 'Select * From '+ listaTabelas.Items.Strings[listaTabelas.itemindex] +' where 0=1';
       Entidade.Active := true;

       NomeTabela := TrataNomeTabela;
       TabelaVO   := NomeTabela + 'VO';
       NomeClasse := NomeTabela + 'Controller';
       case (cbxOpcao.ItemIndex) of
          0:
          begin
            NomeClasse := TabelaVO;
            GetPropriedades;
            CriarClasseVO;
            Diretorio := EditDiretorioVO;
          end;
          1:
          begin
            CriarClasseCliente;
            Diretorio := EditDiretorioControllerCliente;
            end;
          else
          begin
            GetPropriedades;
            CriarClasseServidor;
            Diretorio := EditDiretorioControllerServidor;
          end;
       end;
       memo.Lines.SaveToFile(Diretorio.Directory + '\' + NomeClasse+'.pas');
     finally
       if (cbxOpcao.ItemIndex  = 0) or (cbxOpcao.ItemIndex  = 2) then
       begin
         ListaPropriedades.free;
         ListaCampos.free;
         ListaSets.free;
         ListaProcedureSet.free;
       end;
     end;
  end;
end;

procedure TFGera.botaoLimparMemoClick(Sender: TObject);
begin
  memo.Clear;
end;

procedure TFGera.botaoSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFGera.cbxOpcaoChange(Sender: TObject);
begin
   case (cbxOpcao.ItemIndex) of
     0:  botaoGerar.Caption :=  'Gerar VO';
     1:  botaoGerar.Caption :=  'Controller (Cliente)';
   else
     botaoGerar.Caption :=  'Controller (Servidor)';
   end
end;

procedure TFGera.BotaoGerarConjuntoClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to 3  do
  begin
    case I of
     1 :
      begin
         Diretorio := EditDiretorioVO;
         cbxOpcao.ItemIndex := 0;
      end;

     2 :
      begin
        Diretorio := EditDiretorioControllerCliente;
        cbxOpcao.ItemIndex := 1;
      end;

     3 :
      begin
        Diretorio := EditDiretorioControllerServidor;
        cbxOpcao.ItemIndex := 2;
      end;
    end;
    botaoGerar.Click;
    Application.ProcessMessages;
  end;
  Memo.Clear;
  memo.Lines.Add('');
  memo.Lines.Add('VO Gerado no Diret�rio :');
  memo.Lines.Add(' '+EditDiretorioVO.Text);
  memo.Lines.Add('*************************************************');
  memo.Lines.Add('ControllerCliente Gerado no Diret�rio :');
  memo.Lines.Add(' '+ EditDiretorioControllerCliente.Text);
  memo.Lines.Add('*************************************************');
  memo.Lines.Add('ControllerServidor Gerado no Diret�rio :');
  memo.Lines.Add(' '+EditDiretorioControllerServidor.Text);
end;

procedure TFGera.BotaoGerarTodosClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to listaTabelas.Count - 1 do
  begin
    listaTabelas.ItemIndex := I;
    BotaoGerarTodos.Caption := listaTabelas.Items.Strings[listaTabelas.itemindex];
    botaoGerar.Click;
    Application.ProcessMessages;
  end;
  BotaoGerarTodos.Caption := 'Gerar Todos';
end;

procedure TFGera.GetPropriedades;
var
  I: Integer;
  GetSet, Campo, Classe, Tamanho: String;
begin
  ListaCampos := TStringList.Create;
  ListaPropriedades := TStringList.Create;
  ListaSets := TStringList.Create;
  ListaProcedureSet := TStringList.Create;
  for I := 0 to Entidade.FieldList.Count - 1 do
  begin
    GetSet := ' read F' + Entidade.FieldList.Fields[I].FieldName + ' write F' + Entidade.FieldList.Fields[I].FieldName + ';';
    Campo := Entidade.FieldList.Fields[I].FieldName;

    // Calcular tamanho do campo (tam.campo * 8)
    Tamanho := IntToStr((Entidade.FieldList.Fields[I].DisplayWidth * 8));

    // o tamanho passar de 450 ent�o vamos deixar 450px
    if (StrToInt(Tamanho) > 450) then
      Tamanho := '450';

    // se o campo for do tipo memo fixamos em 450px
    if Entidade.FieldByName(Campo).DataType in [ftMemo] then
      Tamanho := '450';

    Classe := 'T' + listaTabelas.Items.Strings[listaTabelas.itemindex];

    if Entidade.FieldByName(Campo).DataType in [ftString, ftMemo] then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'String', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'String', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType = ftBoolean then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'Boolean', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'Boolean', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType in [ftSmallint, ftInteger, ftWord] then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'Integer', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'Integer', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType in [ftFloat, ftCurrency, ftBCD] then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'Extended', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'Extended', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType in [ftTime] then
    begin
      if cbxOpcao.itemindex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'String', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'String', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType in [ftDate, ftDateTime, ftTimeStamp] then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'TDateTime', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'TDateTime', GetSet);
    end
    else if Entidade.FieldByName(Campo).DataType in [ftExtended, ftBCD, ftFMTBcd] then
    begin
      if cbxOpcao.ItemIndex = 0 then
        ConfigurePropertyListVO(Classe, Campo, Tamanho, 'Extended', GetSet)
      else
        ConfigurePropertyListController(Classe, Campo, 'Extended', GetSet);
    end;
  end;
end;

procedure TFGera.GetPropriedadesController;
var
  I: Integer;
  GetSet, Campo, Classe: String;
begin
  ListaCampos := TStringList.Create;
  ListaPropriedades := TStringList.Create;
  ListaSets := TStringList.Create;
  ListaProcedureSet := TStringList.Create;
  for I := 0 to Entidade.FieldList.Count - 1 do
  begin
    GetSet := ' read F' + Entidade.FieldList.Fields[I].FieldName + ' write F' + Entidade.FieldList.Fields[I].FieldName + ';';
    Campo := Entidade.FieldList.Fields[I].FieldName;
    Classe := 'T' + listaTabelas.Items.Strings[listaTabelas.itemindex];

    if Entidade.FieldByName(Campo).DataType in [ftString, ftMemo] then
      ConfigurePropertyListController(Classe, Campo, 'String', GetSet)
    else if Entidade.FieldByName(Campo).DataType = ftBoolean then
      ConfigurePropertyListController(Classe, Campo, 'Boolean', GetSet)
    else if Entidade.FieldByName(Campo).DataType in [ftSmallint, ftInteger, ftWord] then
      ConfigurePropertyListController(Classe, Campo, 'Integer', GetSet)
    else if Entidade.FieldByName(Campo).DataType in [ftFloat, ftCurrency, ftBCD] then
      ConfigurePropertyListController(Classe, Campo, 'Currency', GetSet)
    else if Entidade.FieldByName(Campo).DataType in [ftTime] then
      ConfigurePropertyListController(Classe, Campo, 'String', GetSet)
    else if Entidade.FieldByName(Campo).DataType in [ftDate, ftDateTime, ftTimeStamp] then
      ConfigurePropertyListController(Classe, Campo, 'TDateTime', GetSet)
    else
      ConfigurePropertyListController(Classe, Campo, 'Double', GetSet);
  end;
end;

function TFGera.GetUserFromWindows: String;
var
  Buffer: PWideChar;
  Size: dword;
begin
  Size := 256;
  Buffer := '';

  if GetUserName(Buffer, Size) then
    Result := Buffer
  else
    Result := 'Desconhecido';
end;

procedure TFGera.ConfigurePropertyListVO(Classe, Campo, Tamanho, Tipo, GetSet : String);
begin
  if Campo = 'ID' then
  begin
    ListaPropriedades.add('    [TId(' + QuotedStr(Campo) + ')]');
    ListaPropriedades.add('    [TGeneratedValue(sAuto)]');
    ListaPropriedades.add('    [TFormatter(ftZerosAEsquerda, taCenter)]');
  end
  else
  begin
    ListaPropriedades.add('    [TColumn(' + QuotedStr(Campo) + ',' + QuotedStr(TrataNomeDisplay(Campo)) + ',' + Tamanho + ',' + '[ldGrid, ldLookup, ldCombobox], False)]');

    if Tipo = 'String' then
    begin
      if (Campo = 'FONE') or (Campo = 'TELEFONE') or (Campo = 'FAX') or (Campo = 'CELULAR') then
        ListaPropriedades.add('    [TFormatter(ftTelefone, taLeftJustify)]')
      else if (Campo = 'CEP') then
        ListaPropriedades.add('    [TFormatter(ftCep, taLeftJustify)]')
      else if (Campo = 'CNPJ') then
        ListaPropriedades.add('    [TFormatter(ftCnpj, taLeftJustify)]')
      else if (Campo = 'CPF') then
        ListaPropriedades.add('    [TFormatter(ftCpf, taLeftJustify)]');
    end
    else if Tipo = 'Integer' then
      ListaPropriedades.add('    [TFormatter(ftZerosAEsquerda, taCenter)]')
    else if Tipo = 'Currency' then
      ListaPropriedades.add('    [TFormatter(ftFloatComSeparador, taRightJustify)]')
    else if Tipo = 'Extended' then
      ListaPropriedades.add('    [TFormatter(ftFloatComSeparador, taRightJustify)]')
    else if Tipo = 'Double' then
      ListaPropriedades.add('    [TFormatter(ftFloatComSeparador, taRightJustify)]');
  end;
  ListaPropriedades.add('    property ' + TrataNomeProperty(Campo) + ': ' + Tipo + ' ' + GetSet);
  ListaCampos.add('    F' + Campo + ': ' + Tipo + ';')
end;

procedure TFGera.ConfigurePropertyListController(Classe, Campo, Tipo, GetSet: String);
begin
  if Tipo = 'String' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsString;')
  else if Tipo = 'Boolean' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsBoolean;')
  else if Tipo = 'Integer' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsInt32;')
  else if Tipo = 'Currency' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsCurrency;')
  else if Tipo = 'Double' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsDouble;')
  else if Tipo = 'Date' then
    ListaCampos.add('        obj' + NomeTabela + '.' + TrataNomeProperty(Campo) + ':= resultSet.Value[' + QuotedStr(Campo) + '].AsDate;')
end;

// -------------------------------------------------------------------------------------------------
// VOS
// -------------------------------------------------------------------------------------------------

procedure TFGera.CriarClasseVO;
begin
  AdicionaLicenca;

  NomeTabela := TrataNomeTabela + 'VO';

  memo.Lines.Add('unit ' + NomeTabela + ';');
  memo.Lines.Add('');

  memo.Lines.Add('interface');
  memo.Lines.Add('');

  memo.Lines.Add('uses');
  memo.Lines.Add('  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;');
  memo.Lines.Add('');

  memo.Lines.Add('type');
  memo.Lines.Add('  [TEntity]');
  memo.Lines.Add('  [TTable(' + QuotedStr(NomeTabelaMaiusculo) + ')]');
  memo.Lines.Add('  T' + NomeTabela + ' = class(TJsonVO)');
  memo.Lines.Add('  private');
  memo.Lines.Add(ListaCampos.Text);
  memo.Lines.Add('  public ');
  memo.Lines.Add(ListaPropriedades.Text);
  memo.Lines.Add('  end;');
  memo.Lines.Add('');

  memo.Lines.Add('implementation');
  memo.Lines.Add('');
  memo.Lines.Add('');
  memo.Lines.Add('');
  memo.Lines.Add('end.');
end;

procedure TFGera.EditBuscaChange(Sender: TObject);
begin
  ListaTabelas.Perform(LB_SELECTSTRING,0,LongInt(PChar(EditBusca.Text)));
end;

procedure TFGera.CriarClasseCliente;
begin
  AdicionaLicenca;

  memo.Lines.Add('unit ' + NomeClasse + ';');
  memo.Lines.Add('');

  memo.Lines.Add('interface');
  memo.Lines.Add('');

  memo.Lines.Add('uses');
  memo.Lines.Add('  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB,');
  memo.Lines.Add('  Windows, Forms, Controller, Rtti, Atributos, ' + TabelaVO + ';');
  memo.Lines.Add('');
  memo.Lines.Add('');

  memo.Lines.Add('type');
  memo.Lines.Add('  T' + NomeClasse + ' = class(TController)');
  memo.Lines.Add('  private');
  memo.Lines.Add('    class var FDataSet: TClientDataSet;');
  memo.Lines.Add('  public');
  memo.Lines.Add('    class procedure Consulta(pFiltro: String; pPagina: Integer);');
  memo.Lines.Add('    class function Insere(p' + NomeTabela + ': T' + TabelaVO + '): Boolean;');
  memo.Lines.Add('    class function Altera(p' + NomeTabela + ', p'+NomeTabela+'Old: T' + TabelaVO + '): Boolean;');
  memo.Lines.Add('    class function Exclui(pId: Integer): Boolean;');
  memo.Lines.Add('');
  memo.Lines.Add('    class function GetDataSet: TClientDataSet; override;');
  memo.Lines.Add('    class procedure SetDataSet(pDataSet: TClientDataSet); override;');
  memo.Lines.Add('');
  memo.Lines.Add('    class function MethodCtx: String; override;');
  memo.Lines.Add('  end;');
  memo.Lines.Add('');

  memo.Lines.Add('implementation');
  memo.Lines.Add('');

  memo.Lines.Add('uses UDataModule, Conversor;');
  memo.Lines.Add('');

  memo.Lines.Add('class procedure T' + NomeClasse + '.Consulta(pFiltro: String; pPagina: Integer);');
  memo.Lines.Add('var');
  memo.Lines.Add('  StreamResposta: TStringStream;');
  memo.Lines.Add('begin');
  memo.Lines.Add('  try');
  memo.Lines.Add('    StreamResposta := TStringStream.Create;');
  memo.Lines.Add('    try');
  memo.Lines.Add('      Get([pFiltro, IntToStr(pPagina)], StreamResposta);');
  memo.Lines.Add('      PopulaGrid<T' + TabelaVO + '>(StreamResposta);');
  memo.Lines.Add('    finally');
  memo.Lines.Add('      StreamResposta.Free;');
  memo.Lines.Add('    end;');
  memo.Lines.Add('  except');
  memo.Lines.Add('    on E: Exception do');
  memo.Lines.Add('      Application.MessageBox(PChar(' + QuotedStr('Ocorreu um erro durante a consulta. Informe a mensagem ao Administrador do sistema.') + ' + #13 + #13 + E.Message)' + ', ' + QuotedStr('Erro do sistema') + ', MB_OK + MB_ICONERROR);');
  memo.Lines.Add('  end;');
  memo.Lines.Add('end;');
  memo.Lines.Add('');

  memo.Lines.Add('class function T' + NomeClasse + '.Insere(p' + NomeTabela + ': T' + TabelaVO + '): Boolean;');
  memo.Lines.Add('var');
  memo.Lines.Add('  DataStream: TStringStream;');
  memo.Lines.Add('  StreamResposta: TStringStream;');
  memo.Lines.Add('  jRegistro: TJSONArray;');
  memo.Lines.Add('begin');
  memo.Lines.Add('  Result := False;');
  memo.Lines.Add('  try');
  memo.Lines.Add('    StreamResposta := TStringStream.Create;');
  memo.Lines.Add('    try');
  memo.Lines.Add('      DataStream := TStringStream.Create(p' + NomeTabela + '.ToJSONString);');
  memo.Lines.Add('      try');
  memo.Lines.Add('        Put([], DataStream, StreamResposta);');
  memo.Lines.Add('      finally');
  memo.Lines.Add('        DataStream.Free;');
  memo.Lines.Add('      end;');
  memo.Lines.Add('');
  memo.Lines.Add('      jRegistro := TConversor.JSONArrayStreamToJSONArray(StreamResposta);');
  memo.Lines.Add('      try');
  memo.Lines.Add('        if jRegistro.Size > 0 then');
  memo.Lines.Add('        begin');
  memo.Lines.Add('          Result := True;');
  memo.Lines.Add('          PopulaGrid<T' + TabelaVO + '>(StreamResposta);');
  memo.Lines.Add('        end;');
  memo.Lines.Add('      finally');
  memo.Lines.Add('        jRegistro.Free;');
  memo.Lines.Add('      end;');
  memo.Lines.Add('    finally');
  memo.Lines.Add('      StreamResposta.Free;');
  memo.Lines.Add('    end;');
  memo.Lines.Add('  except');
  memo.Lines.Add('    on E: Exception do');
  memo.Lines.Add('      Application.MessageBox(PChar(' + QuotedStr('Ocorreu um erro na inclus�o do registro. Informe a mensagem ao Administrador do sistema.') + ' + #13 + #13 + E.Message)' + ', ' + QuotedStr('Erro do sistema') + ', MB_OK + MB_ICONERROR);');
  memo.Lines.Add('  end;');
  memo.Lines.Add('end;');
  memo.Lines.Add('');

  memo.Lines.Add('class function T' + NomeClasse + '.Altera(p' + NomeTabela + ', p'+NomeTabela+'Old: T' + TabelaVO + '): Boolean;');

  memo.Lines.Add('var');
  memo.Lines.Add('  DataStream: TStringStream;');
  memo.Lines.Add('  StreamResposta: TStringStream;');
  memo.Lines.Add('  ObjetosJson: TJSONArray;');
  memo.Lines.Add('begin');
  memo.Lines.Add('  try');
  memo.Lines.Add('    StreamResposta := TStringStream.Create;');
  memo.Lines.Add('    ObjetosJson := TJSONArray.Create;');
  memo.Lines.Add('    ObjetosJson.AddElement(p' + NomeTabela + '.ToJSON);');
  memo.Lines.Add('    ObjetosJson.AddElement(p' + NomeTabela + 'Old.ToJSON);');
  memo.Lines.Add('    try');
  memo.Lines.Add('      DataStream := TStringStream.Create(ObjetosJson.ToString);');
  memo.Lines.Add('      try');
  memo.Lines.Add('        Post([], DataStream, StreamResposta);');
  memo.Lines.Add('      finally');
  memo.Lines.Add('        DataStream.Free;');
  memo.Lines.Add('        ObjetosJson.Free;');
  memo.Lines.Add('      end;');
  memo.Lines.Add('      Result := TConversor.JSONObjectStreamToBoolean(StreamResposta);');
  memo.Lines.Add('    finally');
  memo.Lines.Add('      StreamResposta.Free;');
  memo.Lines.Add('    end;');
  memo.Lines.Add('  except');
  memo.Lines.Add('    on E: Exception do');
  memo.Lines.Add('      Application.MessageBox(PChar(' + QuotedStr('Ocorreu um erro na altera��o do registro. Informe a mensagem ao Administrador do sistema.') + ' + #13 + #13 + E.Message)' + ', ' + QuotedStr('Erro do sistema') + ', MB_OK + MB_ICONERROR);');
  memo.Lines.Add('  end;');
  memo.Lines.Add('end;');
  memo.Lines.Add('');

  memo.Lines.Add('class function T' + NomeClasse + '.Exclui(pId: Integer): Boolean;');
  memo.Lines.Add('begin');
  memo.Lines.Add('  try');
  memo.Lines.Add('    Result := TConversor.JSONPairStrToBoolean(Delete([IntToStr(pId)]));');
  memo.Lines.Add('  except');
  memo.Lines.Add('    on E: Exception do');
  memo.Lines.Add('      Application.MessageBox(PChar(' + QuotedStr('Ocorreu um erro na exclus�o do registro. Informe a mensagem ao Administrador do sistema.') + ' + #13 + #13 + E.Message)' + ', ' + QuotedStr('Erro do sistema') + ', MB_OK + MB_ICONERROR);');
  memo.Lines.Add('  end;');
  memo.Lines.Add('end;');
  memo.Lines.Add('');

  memo.Lines.Add('class function T' + NomeClasse + '.GetDataSet: TClientDataSet;');
  memo.Lines.Add('begin');
  memo.Lines.Add('  Result := FDataSet;');
  memo.Lines.Add('end;');
  memo.Lines.Add('');

  memo.Lines.Add('class procedure T' + NomeClasse + '.SetDataSet(pDataSet: TClientDataSet);');
  memo.Lines.Add('begin');
  memo.Lines.Add('  FDataSet := pDataSet;');
  memo.Lines.Add('end;');
  memo.Lines.Add('');

  memo.Lines.Add('class function T' + NomeClasse + '.MethodCtx: String;');
  memo.Lines.Add('begin');
  memo.Lines.Add('  Result := ' + QuotedStr(NomeTabela) + ';');
  memo.Lines.Add('end;');
  memo.Lines.Add('');

  memo.Lines.Add('end.');
end;

procedure TFGera.CriarClasseServidor;
begin
  AdicionaLicenca;
  memo.Lines.add('unit ' + NomeClasse + ';');
  memo.Lines.add('');

  memo.Lines.add('interface');
  memo.Lines.add('');

  memo.Lines.add('uses');
  memo.Lines.add('  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;');
  memo.Lines.add('');

  memo.Lines.add('type');
  memo.Lines.add('  T' + NomeClasse + ' = class(TController)');
  memo.Lines.add('  protected');
  memo.Lines.add('  public');
  memo.Lines.add('    //consultar');
  memo.Lines.add('    function ' + NomeTabela + '(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;');
  memo.Lines.add('    //inserir');
  memo.Lines.add('    function Accept' + NomeTabela + '(pSessao: String; pObjeto: TJSONValue): TJSONArray;');
  memo.Lines.add('    //alterar');
  memo.Lines.add('    function Update' + NomeTabela + '(pSessao: String; pObjeto: TJSONValue): TJSONArray;');
  memo.Lines.add('    //excluir');
  memo.Lines.add('    function Cancel' + NomeTabela + '(pSessao: String; pId: Integer): TJSONArray;');
  memo.Lines.add('  end;');
  memo.Lines.add('');

  memo.Lines.add('implementation');
  memo.Lines.add('');

  memo.Lines.add('uses');
  memo.Lines.add('  ' + TabelaVO + ', T2TiORM, SA;');
  memo.Lines.add('');
  memo.Lines.add('{ T' + NomeClasse + ' }');
  memo.Lines.add('');

  memo.Lines.add('var');
  memo.Lines.add('  obj' + NomeTabela + ': T' + TabelaVO + ';');
  memo.Lines.add('  Resultado: Boolean;');
  memo.Lines.add('');

  memo.Lines.add('function T' + NomeClasse + '.' + NomeTabela + '(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;');
  memo.Lines.add('begin');
  memo.Lines.add('  Result := TJSONArray.Create;');
  memo.Lines.add('  try');
  memo.Lines.add('    if Pos(' + QuotedStr('ID=') + ', pFiltro) > 0 then');
  memo.Lines.add('      Result := TT2TiORM.Consultar<T' + TabelaVO + '>(pFiltro, pPagina, True)');
  memo.Lines.add('    else');
  memo.Lines.add('      Result := TT2TiORM.Consultar<T' + TabelaVO + '>(pFiltro, pPagina, False);');
  memo.Lines.add('  except');
  memo.Lines.add('    on E: Exception do');
  memo.Lines.add('    begin');
  memo.Lines.add('      Result.AddElement(TJSOnString.Create(' + QuotedStr('ERRO') + '));');
  memo.Lines.add('      Result.AddElement(TJSOnString.Create(E.Message));');
  memo.Lines.add('    end;');
  memo.Lines.add('  end;');
  memo.Lines.add('');
  memo.Lines.add('  FSA.MemoResposta.Lines.Clear;');
  memo.Lines.add('  FSA.MemoResposta.Lines.Add(result.ToString);');
  memo.Lines.add('end;');
  memo.Lines.add('');

  memo.Lines.add('function T' + NomeClasse + '.Accept' + NomeTabela + '(pSessao: String; pObjeto: TJSONValue): TJSONArray;');
  memo.Lines.add('var');
  memo.Lines.add('  UltimoID:Integer;');
  memo.Lines.add('begin');
  memo.Lines.add('  obj' + NomeTabela + ' := T' + TabelaVO + '.Create(pObjeto);');
  memo.Lines.add('  Result := TJSONArray.Create;');
  memo.Lines.add('  try');
  memo.Lines.add('    try');
  memo.Lines.add('      UltimoID := TT2TiORM.Inserir(obj' + NomeTabela + ');');
  memo.Lines.add('      Result := ' + NomeTabela + '(pSessao, ' + QuotedStr('ID = ') + ' + IntToStr(UltimoID), 0);');
  memo.Lines.add('    except');
  memo.Lines.add('      on E: Exception do');
  memo.Lines.add('      begin');
  memo.Lines.add('        Result.AddElement(TJSOnString.Create(' + QuotedStr('ERRO') + '));');
  memo.Lines.add('        Result.AddElement(TJSOnString.Create(E.Message));');
  memo.Lines.add('      end;');
  memo.Lines.add('    end;');
  memo.Lines.add('  finally');
  memo.Lines.add('    obj' + NomeTabela + '.Free;');
  memo.Lines.add('  end;');
  memo.Lines.add('end;');
  memo.Lines.add('');

  memo.Lines.add('function T' + NomeClasse + '.Update' + NomeTabela + '(pSessao: String; pObjeto: TJSONValue): TJSONArray;');
  memo.Lines.add('var');
  memo.Lines.add('  obj'+ NomeTabela +'Old: T'+ TabelaVO+';');
  memo.Lines.add('begin');
  memo.Lines.add(' //Objeto Novo');
  memo.Lines.add('  obj' + NomeTabela + ' := T' + TabelaVO + '.Create((pObjeto as TJSONArray).Get(0));');
  memo.Lines.add('  //Objeto Antigo');
  memo.Lines.add('  obj' + NomeTabela + 'Old := T' + TabelaVO + '.Create((pObjeto as TJSONArray).Get(1));');
  memo.Lines.add('  Result := TJSONArray.Create;');
  memo.Lines.add('  try');
  memo.Lines.add('    try');
  memo.Lines.add('      Resultado := TT2TiORM.Alterar(obj' + NomeTabela + ', obj' + NomeTabela + 'Old);');
  memo.Lines.add('    except');
  memo.Lines.add('      on E: Exception do');
  memo.Lines.add('      begin');
  memo.Lines.add('        Result.AddElement(TJSOnString.Create(' + QuotedStr('ERRO') + '));');
  memo.Lines.add('        Result.AddElement(TJSOnString.Create(E.Message));');
  memo.Lines.add('      end;');
  memo.Lines.add('    end;');
  memo.Lines.add('  finally');
  memo.Lines.add('    if Resultado then');
  memo.Lines.add('    begin');
  memo.Lines.add('      Result.AddElement(TJSONTrue.Create);');
  memo.Lines.add('    end;');
  memo.Lines.add('    obj' + NomeTabela + '.Free;');
  memo.Lines.add('  end;');
  memo.Lines.add('end;');
  memo.Lines.add('');

  memo.Lines.add('function T' + NomeClasse + '.Cancel' + NomeTabela + '(pSessao: String; pId: Integer): TJSONArray;');
  memo.Lines.add('begin');
  memo.Lines.add('  obj' + NomeTabela + ' := T' + TabelaVO + '.Create;');
  memo.Lines.add('  Result := TJSONArray.Create;');
  memo.Lines.add('  try');
  memo.Lines.add('    obj' + NomeTabela + '.Id := pId;');
  memo.Lines.add('    try');
  memo.Lines.add('      Resultado := TT2TiORM.Excluir(obj' + NomeTabela + ');');
  memo.Lines.add('    except');
  memo.Lines.add('      on E: Exception do');
  memo.Lines.add('      begin');
  memo.Lines.add('        Result.AddElement(TJSOnString.Create(' + QuotedStr('ERRO') + '));');
  memo.Lines.add('        Result.AddElement(TJSOnString.Create(E.Message));');
  memo.Lines.add('      end;');
  memo.Lines.add('    end;');
  memo.Lines.add('  finally');
  memo.Lines.add('    if Resultado then');
  memo.Lines.add('    begin');
  memo.Lines.add('      Result.AddElement(TJSONTrue.Create);');
  memo.Lines.add('    end;');
  memo.Lines.add('    obj' + NomeTabela + '.Free;');
  memo.Lines.add('  end;');
  memo.Lines.add('end;');
  memo.Lines.add('');
  memo.Lines.add('end.');
end;

function TFGera.TrataNomeTabela: String;
var
  NomeTabela: String;
  I: Integer;
begin
  NomeTabela := listaTabelas.Items.Strings[listaTabelas.itemindex];
  NomeTabela := UpperCase(Copy(NomeTabela, 1, 1)) + LowerCase(Copy(NomeTabela, 2, length(NomeTabela) - 1));

  for I := 1 to length(NomeTabela) do
  begin
    if Copy(NomeTabela, I, 1) = '_' then
    begin
      Delete(NomeTabela, I, 1);
      NomeTabela := Copy(NomeTabela, 1, I - 1) + UpperCase(Copy(NomeTabela, I, 1)) + LowerCase(Copy(NomeTabela, I + 1, length(NomeTabela) - 1));
    end;
  end;

  Result := NomeTabela;
end;

function TFGera.NomeTabelaMaiusculo: String;
var
  NomeTabela: String;
begin
  NomeTabela := UpperCase(listaTabelas.Items.Strings[listaTabelas.itemindex]);
  Result := NomeTabela;
end;

function TFGera.TrataNomeProperty(NomeCampo: String): String;
var
  I: Integer;
begin
  NomeCampo := UpperCase(Copy(NomeCampo, 1, 1)) + LowerCase
    (Copy(NomeCampo, 2, length(NomeCampo) - 1));

  for I := 1 to length(NomeCampo) do
  begin
    if copy(NomeCampo,I,1) = '_' then
    begin
      Delete(NomeCampo,I,1);
      NomeCampo := Copy(NomeCampo,1,I-1) + UpperCase(Copy(NomeCampo,I,1)) + LowerCase(Copy(NomeCampo,I+1,length(NomeCampo)-1));
    end;
  end;

  Result := NomeCampo;
end;

function TFGera.TrataNomeDisplay(NomeCampo: String): String;
var
  I: Integer;
begin
  NomeCampo := UpperCase(Copy(NomeCampo,1,1)) + LowerCase(Copy(NomeCampo,2,length(NomeCampo)-1));
  for I := 1 to length(NomeCampo) do
  begin
    if copy(NomeCampo,I,1) = '_' then
    begin
      Delete(NomeCampo,I,1);
      Insert(' ',NomeCampo,I);
      NomeCampo := Copy(NomeCampo,1,I) + UpperCase(Copy(NomeCampo,I+1,1)) + (Copy(NomeCampo,I+2,length(NomeCampo)-1));
    end;
  end;
  result := NomeCampo;
end;

procedure TFGera.AdicionaLicenca;
var
  loOpcao: String;
begin
  case (cbxOpcao.ItemIndex) of
    0:  loOpcao:=  ' VO ';
    1:  loOpcao := 'Controller do lado Cliente';
    2:  loOpcao := 'Controller do lado Servidor';
  end;

  memo.Lines.Add('{*******************************************************************************');
  memo.Lines.Add('Title: T2Ti ERP                                                                 ');
  memo.Lines.Add('Description: ' + loOpcao + ' relacionado � tabela [' + NomeTabelaMaiusculo + '] ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('The MIT License                                                                 ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('Copyright: Copyright (C) 2010 T2Ti.COM                                          ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('Permission is hereby granted, free of charge, to any person                     ');
  memo.Lines.Add('obtaining a copy of this software and associated documentation                  ');
  memo.Lines.Add('files (the "Software"), to deal in the Software without                         ');
  memo.Lines.Add('restriction, including without limitation the rights to use,                    ');
  memo.Lines.Add('copy, modify, merge, publish, distribute, sublicense, and/or sell               ');
  memo.Lines.Add('copies of the Software, and to permit persons to whom the                       ');
  memo.Lines.Add('Software is furnished to do so, subject to the following                        ');
  memo.Lines.Add('conditions:                                                                     ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('The above copyright notice and this permission notice shall be                  ');
  memo.Lines.Add('included in all copies or substantial portions of the Software.                 ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 ');
  memo.Lines.Add('EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 ');
  memo.Lines.Add('OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        ');
  memo.Lines.Add('NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     ');
  memo.Lines.Add('HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    ');
  memo.Lines.Add('WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    ');
  memo.Lines.Add('FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   ');
  memo.Lines.Add('OTHER DEALINGS IN THE SOFTWARE.                                                 ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('       The author may be contacted at:                                          ');
  memo.Lines.Add('           t2ti.com@gmail.com                                                   ');
  memo.Lines.Add('                                                                                ');
  memo.Lines.Add('@author ' + EditAutor.Text + ' (' + EditEmailAutor.Text + ')                    ');
  memo.Lines.Add('@version 1.0                                                                    ');
  memo.Lines.Add('*******************************************************************************}');
end;

end.
