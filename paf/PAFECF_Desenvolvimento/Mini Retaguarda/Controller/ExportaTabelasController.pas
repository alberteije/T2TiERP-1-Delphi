{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da Exportação das  tabelas para o PDV

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

unit ExportaTabelasController;

interface

uses   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, Buttons,DB, Generics.Collections, ComCtrls,
   UnidadeProdutoController, UDataModule, ContasPagarReceberVO, Rtti, TypInfo, Atributos, SWSystem,
  ContasParcelasVO, LancamentoReceberController, ParcelaPagamentoController,
  Biblioteca, BancoController, CfopController, PessoaController,
  SituacaoPessoaController, ProdutoController, EmpresaController,
  ContadorController, EcfTurnoController, CargaFuncionarioController,
  UsuarioController, FichaTecnicaController, EcfResolucaoController,
  EcfImpressoraController, EcfConfiguracaoController,
  EcfPosicaoComponentesController, ProdutoPromocaoController, ProdutoVO, UMenu, UPDVCarga;

    procedure ExportaUnidadeProduto;
    procedure ExportaProduto(TipoExporta:integer);
    procedure ExportaSituacaoCliente;
    procedure ExportaCliente;
    procedure ExportaBanco;
    procedure ExportaCFOP;
    procedure ExportaEmpresa;
    procedure ExportaContador;
    procedure ExportaTurno;
    procedure ExportaFuncionario;
    procedure ExportaOperador;
    procedure ExportaFichaTecnica;
    procedure ExportaProdutoPromocao;
    procedure ExportaResolucao;
    procedure ExportaImpressora;
    procedure ExportaConfiguracao;
    procedure ExportaPosicaoComponentes;

    procedure GravaLogExportacao(Erro: string);

    var
       Filtro: String;
       Pagina: Integer;

implementation


procedure ExportaSituacaoCliente;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSSituacaoPessoa.Close;
      FDataModule.CDSSituacaoPessoa.FieldDefs.Clear;
      FDataModule.CDSSituacaoPessoa.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSSituacaoPessoa.FieldDefs.add('NOME', ftString, 30);
      FDataModule.CDSSituacaoPessoa.FieldDefs.add('DESCRICAO', ftMemo);
      FDataModule.CDSSituacaoPessoa.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TSituacaoPessoaController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSSituacaoPessoa.First;
      while not FDataModule.CDSSituacaoPessoa.Eof do
        begin
          Write(ExportaPDV,'SITUACAO_CLI|'+
                        VerificaNULL(FDataModule.CDSSituacaoPessoa.FieldByName('ID').AsString,0)+'|'+          //ID         INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSSituacaoPessoa.FieldByName('NOME').AsString,1)+'|'+        //NOME       VARCHAR(20),
                        VerificaNULL(FDataModule.CDSSituacaoPessoa.FieldByName('DESCRICAO').AsString,1)+'|');  //DESCRICAO  VARCHAR(250)
          Writeln(ExportaPDV);

          FDataModule.CDSSituacaoPessoa.Next;
        end;

    except
       GravaLogExportacao('SITUACAO_CLI|'+
                           FDataModule.CDSSituacaoPessoa.FieldByName('ID').AsString+'|'+
                           FDataModule.CDSSituacaoPessoa.FieldByName('NOME').AsString+'|'+
                           FDataModule.CDSSituacaoPessoa.FieldByName('DESCRICAO').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;



procedure ExportaTurno;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSTurno.Close;
      FDataModule.CDSTurno.FieldDefs.Clear;
      FDataModule.CDSTurno.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSTurno.FieldDefs.add('DESCRICAO', ftString, 10);
      FDataModule.CDSTurno.FieldDefs.add('HORA_INICIO', ftString, 8);
      FDataModule.CDSTurno.FieldDefs.add('HORA_FIM', ftString, 8);
      FDataModule.CDSTurno.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TEcfTurnoController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSTurno.First;
      while not FDataModule.CDSTurno.Eof do
        begin
          Write(ExportaPDV,'TURNO|'+
                        VerificaNULL(FDataModule.CDSTurno.FieldByName('ID').AsString,0)+'|'+                      //ID           INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSTurno.FieldByName('DESCRICAO').AsString,1)+'|'+    //DESCRICAO    VARCHAR(10),
                        VerificaNULL(FDataModule.CDSTurno.FieldByName('HORA_INICIO').AsString,1)+'|'+  //HORA_INICIO  VARCHAR(8),
                        VerificaNULL(FDataModule.CDSTurno.FieldByName('HORA_FIM').AsString,1)+'|');    //HORA_FIM     VARCHAR(8)
          Writeln(ExportaPDV);

          FDataModule.CDSTurno.Next;
        end;
    except
       GravaLogExportacao('TURNO|'+
                        FDataModule.CDSTurno.FieldByName('ID').AsString+'|'+
                        FDataModule.CDSTurno.FieldByName('DESCRICAO').AsString+'|'+
                        FDataModule.CDSTurno.FieldByName('HORA_INICIO').AsString+'|'+
                        FDataModule.CDSTurno.FieldByName('HORA_FIM').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaBanco;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSBanco.Close;
      FDataModule.CDSBanco.FieldDefs.Clear;
      FDataModule.CDSBanco.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSBanco.FieldDefs.add('CODIGO', ftString, 10);
      FDataModule.CDSBanco.FieldDefs.add('NOME', ftString, 100);
      FDataModule.CDSBanco.FieldDefs.add('URL', ftString, 250);
      FDataModule.CDSBanco.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TBancoController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSBanco.First;
      while not FDataModule.CDSBanco.Eof do
        begin
          Write(ExportaPDV,'BANCO|'+
                        VerificaNULL(FDataModule.CDSBanco.FieldByName('ID').AsString,0)+'|'+      //ID      INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSBanco.FieldByName('CODIGO').AsString,1)+'|'+  //CODIGO  VARCHAR(10),
                        VerificaNULL(FDataModule.CDSBanco.FieldByName('NOME').AsString,1)+'|'+    //NOME    VARCHAR(100),
                        VerificaNULL(FDataModule.CDSBanco.FieldByName('URL').AsString,1)+'|');    //URL     VARCHAR(250)

          Writeln(ExportaPDV);

          FDataModule.CDSBanco.Next;
        end;
    except
       GravaLogExportacao('BANCO|'+
                        FDataModule.CDSBanco.FieldByName('ID').AsString+'|'+
                        FDataModule.CDSBanco.FieldByName('CODIGO').AsString+'|'+
                        FDataModule.CDSBanco.FieldByName('NOME').AsString+'|'+
                        FDataModule.CDSBanco.FieldByName('URL').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaCFOP;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSCfop.Close;
      FDataModule.CDSCfop.FieldDefs.Clear;
      FDataModule.CDSCfop.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSCfop.FieldDefs.add('CFOP', ftInteger);
      FDataModule.CDSCfop.FieldDefs.add('DESCRICAO', ftMemo);
      FDataModule.CDSCfop.FieldDefs.add('APLICACAO', ftMemo);
      FDataModule.CDSCfop.FieldDefs.add('MOVIMENTA_ESTOQUE', ftString, 1);
      FDataModule.CDSCfop.FieldDefs.add('MOVIMENTA_FINANCEIRO', ftString, 1);
      FDataModule.CDSCfop.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TCfopController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSCfop.First;
      while not FDataModule.CDSCfop.Eof do
        begin
          Write(ExportaPDV,'CFOP|'+
                        VerificaNULL(FDataModule.CDSCfop.FieldByName('ID').AsString,0)+'|'+                      //ID         INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSCfop.FieldByName('CFOP').AsString,0)+'|'+                    //CFOP       INTEGER,
                        VerificaNULL(copy(FDataModule.CDSCfop.FieldByName('DESCRICAO').AsString,1,250),1)+'|'+   //DESCRICAO  VARCHAR(250),
                        VerificaNULL(copy(FDataModule.CDSCfop.FieldByName('APLICACAO').AsString,1,250),1)+'|');  //APLICACAO  VARCHAR(250)
                        //QuotedStr(FDataModule.CDSCfop.FieldByName('MOVIMENTA_ESTOQUE').AsString)+'|'+     //Nao tem no Banco do Paf-Ecf
                        //QuotedStr(FDataModule.CDSCfop.FieldByName('MOVIMENTA_FINANCEIRO').AsString)+'|'); //Nao tem no Banco do Paf-Ecf

          Writeln(ExportaPDV);

          FDataModule.CDSCfop.Next;
        end;
    except
       GravaLogExportacao('CFOP|'+
                        FDataModule.CDSCfop.FieldByName('ID').AsString+'|'+
                        FDataModule.CDSCfop.FieldByName('CFOP').AsString+'|'+
                        FDataModule.CDSCfop.FieldByName('DESCRICAO').AsString+'|'+
                        FDataModule.CDSCfop.FieldByName('APLICACAO').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaCliente;
var
  ExportaPDV: TextFile;
  datavazia :string;
begin
  datavazia:= '1000-01-01';
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSPessoa.Close;
      FDataModule.CDSPessoa.FieldDefs.Clear;
      FDataModule.CDSPessoa.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSPessoa.FieldDefs.add('ID_SITUACAO_CLIENTE', ftInteger);
      FDataModule.CDSPessoa.FieldDefs.add('NOME', ftString,150);
      FDataModule.CDSPessoa.FieldDefs.add('FANTASIA', ftString,150);
      FDataModule.CDSPessoa.FieldDefs.add('EMAIL', ftString,250);
      FDataModule.CDSPessoa.FieldDefs.add('CPF_CNPJ', ftString,14);
      FDataModule.CDSPessoa.FieldDefs.add('RG', ftString,20);
      FDataModule.CDSPessoa.FieldDefs.add('ORGAO_RG', ftString,20);
      FDataModule.CDSPessoa.FieldDefs.add('DATA_EMISSAO_RG', ftString,10);
      FDataModule.CDSPessoa.FieldDefs.add('SEXO', ftString,1);
      FDataModule.CDSPessoa.FieldDefs.add('INSCRICAO_ESTADUAL', ftString,30);
      FDataModule.CDSPessoa.FieldDefs.add('INSCRICAO_MUNICIPAL', ftString,30);
      //    FDataModule.CDSPessoa.FieldDefs.add('DESDE', ftString,10);
      FDataModule.CDSPessoa.FieldDefs.add('TIPO_PESSOA', ftString,1);
      //    FDataModule.CDSPessoa.FieldDefs.add('EXCLUIDO', ftString,1);
      FDataModule.CDSPessoa.FieldDefs.add('DATA_CADASTRO', ftString,10);
      FDataModule.CDSPessoa.FieldDefs.add('LOGRADOURO', ftString,250);
      FDataModule.CDSPessoa.FieldDefs.add('NUMERO', ftString,6);
      FDataModule.CDSPessoa.FieldDefs.add('COMPLEMENTO', ftString,50);
      FDataModule.CDSPessoa.FieldDefs.add('CEP', ftString,8);
      FDataModule.CDSPessoa.FieldDefs.add('BAIRRO', ftString,100);
      FDataModule.CDSPessoa.FieldDefs.add('CIDADE', ftString,100);
      FDataModule.CDSPessoa.FieldDefs.add('UF', ftString,2);
      FDataModule.CDSPessoa.FieldDefs.add('FONE1', ftString,10);
      FDataModule.CDSPessoa.FieldDefs.add('FONE2', ftString,10);
      FDataModule.CDSPessoa.FieldDefs.add('CELULAR', ftString,10);
      FDataModule.CDSPessoa.FieldDefs.add('CONTATO', ftString,50);
      FDataModule.CDSPessoa.FieldDefs.add('CODIGO_IBGE_CIDADE', ftInteger);
      FDataModule.CDSPessoa.FieldDefs.add('CODIGO_IBGE_UF', ftInteger);



      FDataModule.CDSPessoa.CreateDataSet;

      Pagina := 0;
      Filtro := ' P.ID > 0 ';

      TPessoaController.ConsultaCARGA(trim(Filtro), Pagina, False); //Criei uma Class ConsultaCARGA na PessoaController para trazer o endereco ass.: Marcos Leite
      FDataModule.CDSPessoa.First;
      while not FDataModule.CDSPessoa.Eof do
        begin
          Write(ExportaPDV,'CLIENTE|'+
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('ID').AsString,0)+'|'+                                       //    ID                   INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('ID_SITUACAO_CLIENTE').AsString,0)+'|'+                      //    ID_SITUACAO_CLIENTE  INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('NOME').AsString,1)+'|'+                          //    NOME                 VARCHAR(150),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('FANTASIA').AsString,1)+'|'+                      //    FANTASIA             VARCHAR(150),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('EMAIL').AsString,1)+'|'+                         //    EMAIL                VARCHAR(250),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('CPF_CNPJ').AsString,1)+'|'+                      //    CPF_CNPJ             VARCHAR(14),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('RG').AsString,1)+'|'+                            //    RG                   VARCHAR(20),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('ORGAO_RG').AsString,1)+'|'+                      //    ORGAO_RG             VARCHAR(20),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('DATA_EMISSAO_RG').AsString,1)+'|'+               //    DATA_EMISSAO_RG      DATE,
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('SEXO').AsString,1)+'|'+                          //    SEXO                 CHAR(1),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('INSCRICAO_ESTADUAL').AsString,1)+'|'+            //    INSCRICAO_ESTADUAL   VARCHAR(30),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('INSCRICAO_MUNICIPAL').AsString,1)+'|'+           //    INSCRICAO_MUNICIPAL  VARCHAR(30),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('TIPO_PESSOA').AsString,1)+'|'+                   //    TIPO_PESSOA          CHAR(1),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('DATA_CADASTRO').AsString,1)+'|'+                 //    DATA_CADASTRO        DATE,
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('LOGRADOURO').AsString,1)+'|'+                    //    LOGRADOURO           VARCHAR(250),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('NUMERO').AsString,1)+'|'+                        //    NUMERO               VARCHAR(6),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('COMPLEMENTO').AsString,1)+'|'+                   //    COMPLEMENTO          VARCHAR(50),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('CEP').AsString,1)+'|'+                           //    CEP                  VARCHAR(8),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('BAIRRO').AsString,1)+'|'+                        //    BAIRRO               VARCHAR(100),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('CIDADE').AsString,1)+'|'+                        //    CIDADE               VARCHAR(100),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('UF').AsString,1)+'|'+                            //    UF                   CHAR(2),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('FONE1').AsString,1)+'|'+                         //    FONE1                VARCHAR(10),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('FONE2').AsString,1)+'|'+                         //    FONE2                VARCHAR(10),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('CELULAR').AsString,1)+'|'+                       //    CELULAR              VARCHAR(10),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('CONTATO').AsString,1)+'|'+                       //    CONTATO              VARCHAR(50),
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('CODIGO_IBGE_CIDADE').AsString,0)+'|'+            //    CODIGO_IBGE_CIDADE   INTEGER,
                        VerificaNULL(FDataModule.CDSPessoa.FieldByName('CODIGO_IBGE_UF').AsString,0)+'|');               //    CODIGO_IBGE_UF       INTEGER
          Writeln(ExportaPDV);
          FDataModule.CDSPessoa.Next;
        end;
    except
       GravaLogExportacao('CLIENTE|'+
                           FDataModule.CDSPessoa.FieldByName('ID').AsString+'|'+
                           FDataModule.CDSPessoa.FieldByName('ID_SITUACAO_CLIENTE').AsString+'|'+
                           FDataModule.CDSPessoa.FieldByName('NOME').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaConfiguracao;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSConfiguracao.Close;
      FDataModule.CDSConfiguracao.FieldDefs.Clear;
      FDataModule.CDSConfiguracao.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('NOME_CAIXA', ftString, 30 );
      FDataModule.CDSConfiguracao.FieldDefs.add('ID_GERADO_CAIXA', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('ID_EMPRESA', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('ID_ECF_IMPRESSORA', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('ID_ECF_RESOLUCAO', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('ID_ECF_CAIXA', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('ID_ECF_EMPRESA', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('MENSAGEM_CUPOM', ftString, 250);
      FDataModule.CDSConfiguracao.FieldDefs.add('PORTA_ECF', ftString, 10);
      FDataModule.CDSConfiguracao.FieldDefs.add('IP_SERVIDOR', ftString, 15);
      FDataModule.CDSConfiguracao.FieldDefs.add('IP_SITEF', ftString, 15);
      FDataModule.CDSConfiguracao.FieldDefs.add('TIPO_TEF', ftString, 2);
      FDataModule.CDSConfiguracao.FieldDefs.add('TITULO_TELA_CAIXA', ftString, 100);
      FDataModule.CDSConfiguracao.FieldDefs.add('CAMINHO_IMAGENS_PRODUTOS', ftString, 250);
      FDataModule.CDSConfiguracao.FieldDefs.add('CAMINHO_IMAGENS_MARKETING', ftString, 250);
      FDataModule.CDSConfiguracao.FieldDefs.add('CAMINHO_IMAGENS_LAYOUT', ftString, 250);
      FDataModule.CDSConfiguracao.FieldDefs.add('COR_JANELAS_INTERNAS', ftString, 20);
      FDataModule.CDSConfiguracao.FieldDefs.add('MARKETING_ATIVO', ftString, 1);
      FDataModule.CDSConfiguracao.FieldDefs.add('CFOP_ECF', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('CFOP_NF2', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('TIMEOUT_ECF', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('INTERVALO_ECF', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('DESCRICAO_SUPRIMENTO', ftString, 20);
      FDataModule.CDSConfiguracao.FieldDefs.add('DESCRICAO_SANGRIA', ftString, 20);
      FDataModule.CDSConfiguracao.FieldDefs.add('TEF_TIPO_GP', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('TEF_TEMPO_ESPERA', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('TEF_ESPERA_STS', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('TEF_NUMERO_VIAS', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('DECIMAIS_QUANTIDADE', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('DECIMAIS_VALOR', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('BITS_POR_SEGUNDO', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('QTDE_MAXIMA_CARTOES', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('PESQUISA_PARTE', ftString, 1);
      FDataModule.CDSConfiguracao.FieldDefs.add('CONFIGURACAO_BALANCA', ftString, 100);
      FDataModule.CDSConfiguracao.FieldDefs.add('PARAMETROS_DIVERSOS', ftString, 250);
      FDataModule.CDSConfiguracao.FieldDefs.add('ULTIMA_EXCLUSAO', ftInteger);
      FDataModule.CDSConfiguracao.FieldDefs.add('LAUDO', ftString, 10);
      FDataModule.CDSConfiguracao.FieldDefs.add('INDICE_GERENCIAL', ftString, 100);
      FDataModule.CDSConfiguracao.FieldDefs.add('DATA_ATUALIZACAO_ESTOQUE', ftString, 10);
      FDataModule.CDSConfiguracao.FieldDefs.add('DATA_SINCRONIZACAO', ftString, 10);
      FDataModule.CDSConfiguracao.FieldDefs.add('HORA_SINCRONIZACAO', ftString, 8);
      FDataModule.CDSConfiguracao.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TEcfConfiguracaoController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSConfiguracao.First;
      while not FDataModule.CDSConfiguracao.Eof do
        begin
          Write(ExportaPDV,'CONFIGURACAO|'+
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('ID').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                            //ID                         INTEGER NOT NULL,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('ID_ECF_IMPRESSORA').AsString,0),'|','[#]',[rfReplaceAll])+'|'+             //ID_ECF_IMPRESSORA          INTEGER NOT NULL,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('ID_ECF_RESOLUCAO').AsString,0),'|','[#]',[rfReplaceAll])+'|'+              //ID_ECF_RESOLUCAO           INTEGER NOT NULL,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('ID_ECF_CAIXA').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                  //ID_ECF_CAIXA               INTEGER NOT NULL,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('ID_ECF_EMPRESA').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                //ID_ECF_EMPRESA             INTEGER NOT NULL,
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('MENSAGEM_CUPOM').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+              //MENSAGEM_CUPOM             VARCHAR(250),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('PORTA_ECF').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                   //PORTA_ECF                  CHAR(10),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('IP_SERVIDOR').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                 //IP_SERVIDOR                VARCHAR(15),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('IP_SITEF').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                    //IP_SITEF                   VARCHAR(15),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('TIPO_TEF').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                    //TIPO_TEF                   CHAR(2),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('TITULO_TELA_CAIXA').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+           //TITULO_TELA_CAIXA          VARCHAR(100),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('CAMINHO_IMAGENS_PRODUTOS').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+    //CAMINHO_IMAGENS_PRODUTOS   VARCHAR(250),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('CAMINHO_IMAGENS_MARKETING').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+   //CAMINHO_IMAGENS_MARKETING  VARCHAR(250),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('CAMINHO_IMAGENS_LAYOUT').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+      //CAMINHO_IMAGENS_LAYOUT     VARCHAR(250),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('COR_JANELAS_INTERNAS').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+        //COR_JANELAS_INTERNAS       VARCHAR(20),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('MARKETING_ATIVO').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+             //MARKETING_ATIVO            CHAR(1),
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('CFOP_ECF').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                      //CFOP_ECF                   INTEGER,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('CFOP_NF2').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                      //CFOP_NF2                   INTEGER,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('TIMEOUT_ECF').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                   //TIMEOUT_ECF                INTEGER,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('INTERVALO_ECF').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                 //INTERVALO_ECF              INTEGER,
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('DESCRICAO_SUPRIMENTO').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+        //DESCRICAO_SUPRIMENTO       VARCHAR(20),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('DESCRICAO_SANGRIA').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+           //DESCRICAO_SANGRIA          VARCHAR(20),
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('TEF_TIPO_GP').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                   //TEF_TIPO_GP                INTEGER,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('TEF_TEMPO_ESPERA').AsString,0),'|','[#]',[rfReplaceAll])+'|'+              //TEF_TEMPO_ESPERA           INTEGER,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('TEF_ESPERA_STS').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                //TEF_ESPERA_STS             INTEGER,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('TEF_NUMERO_VIAS').AsString,0),'|','[#]',[rfReplaceAll])+'|'+               //TEF_NUMERO_VIAS            INTEGER,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('DECIMAIS_QUANTIDADE').AsString,0),'|','[#]',[rfReplaceAll])+'|'+           //DECIMAIS_QUANTIDADE        INTEGER,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('DECIMAIS_VALOR').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                //DECIMAIS_VALOR             INTEGER,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('BITS_POR_SEGUNDO').AsString,0),'|','[#]',[rfReplaceAll])+'|'+              //BITS_POR_SEGUNDO           INTEGER,
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('QTDE_MAXIMA_CARTOES').AsString,0),'|','[#]',[rfReplaceAll])+'|'+           //QTDE_MAXIMA_CARTOES        INTEGER,
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('PESQUISA_PARTE').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+              //PESQUISA_PARTE             CHAR(1),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('CONFIGURACAO_BALANCA').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+        //CONFIGURACAO_BALANCA       VARCHAR(100),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('PARAMETROS_DIVERSOS').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+         //PARAMETROS_DIVERSOS        VARCHAR(250),
                        StringReplace(VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('ULTIMA_EXCLUSAO').AsString,0),'|','[#]',[rfReplaceAll])+'|'+               //ULTIMA_EXCLUSAO            INTEGER,
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('LAUDO').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                       //LAUDO                      VARCHAR(10),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('INDICE_GERENCIAL').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+            //INDICE_GERENCIAL           VARCHAR(100),
                        StringReplace((VerificaNULL(FDataModule.CDSConfiguracao.FieldByName('DATA_ATUALIZACAO_ESTOQUE').AsString,1)),'|','[#]',[rfReplaceAll])+'|');   //DATA_ATUALIZACAO_ESTOQUE   VARCHAR(100),
                        //SINCRONIZADO               CHAR(1)                                                                                                           //SINCRONIZADO               CHAR(1)
          Writeln(ExportaPDV);

          FDataModule.CDSConfiguracao.Next;
        end;
    except
       GravaLogExportacao('CONFIGURACAO|'+
                        FDataModule.CDSConfiguracao.FieldByName('ID').AsString+'|'+
                        FDataModule.CDSConfiguracao.FieldByName('NOME_CAIXA').AsString+'|'+
                        FDataModule.CDSConfiguracao.FieldByName('ID_GERADO_CAIXA').AsString+'|'+
                        IntToStr(FDataModule.EmpresaID)+'|');//To pegando do conexao.ini mas este fiquei na duvida? ass.: Marcos Leite
    end;
  finally
     CloseFile(ExportaPDV);
  end;
end;

procedure ExportaContador;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSContador.Close;
      FDataModule.CDScontador.FieldDefs.Clear;
      FDataModule.CDScontador.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSContador.FieldDefs.add('CPF', ftString, 11);
      FDataModule.CDSContador.FieldDefs.add('CNPJ', ftString, 14);
      FDataModule.CDSContador.FieldDefs.add('NOME', ftString, 100);
      FDataModule.CDSContador.FieldDefs.add('INSCRICAO_CRC', ftString, 15);
      FDataModule.CDSContador.FieldDefs.add('FONE', ftString, 10);
      FDataModule.CDSContador.FieldDefs.add('FAX', ftString, 10);
      FDataModule.CDSContador.FieldDefs.add('LOGRADOURO', ftString, 100);
      FDataModule.CDSContador.FieldDefs.add('NUMERO', ftInteger);
      FDataModule.CDSContador.FieldDefs.add('COMPLEMENTO', ftString, 100);
      FDataModule.CDSContador.FieldDefs.add('BAIRRO', ftString, 30);
      FDataModule.CDSContador.FieldDefs.add('CEP', ftString, 8);
      FDataModule.CDSContador.FieldDefs.add('CODIGO_MUNICIPIO', ftInteger);
      FDataModule.CDSContador.FieldDefs.add('UF', ftString, 2);
      FDataModule.CDSContador.FieldDefs.add('EMAIL', ftString, 250);
      FDataModule.CDScontador.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TContadorController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDScontador.First;
      while not FDataModule.CDScontador.Eof do
        begin
          Write(ExportaPDV,'CONTADOR|'+
                        VerificaNULL(FDataModule.CDScontador.FieldByName('ID').AsString,0)+'|'+                //ID                INTEGER NOT NULL,
                        IntToStr(FDataModule.EmpresaID)+'|'+ // to pegando do conexao.ini como havia dito ass.: Marcos Leite
                        VerificaNULL(FDataModule.CDSContador.FieldByName('CPF').AsString,1)+'|'+               //CPF               VARCHAR(11),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('CNPJ').AsString,1)+'|'+              //CNPJ              VARCHAR(14),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('NOME').AsString,1)+'|'+              //NOME              VARCHAR(100),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('INSCRICAO_CRC').AsString,1)+'|'+     //INSCRICAO_CRC     VARCHAR(15),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('FONE').AsString,1)+'|'+              //FONE              VARCHAR(15),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('FAX').AsString,1)+'|'+               //FAX               VARCHAR(15),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('LOGRADOURO').AsString,1)+'|'+        //LOGRADOURO        VARCHAR(100),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('NUMERO').AsString,1)+'|'+            //NUMERO            INTEGER,
                        VerificaNULL(FDataModule.CDSContador.FieldByName('COMPLEMENTO').AsString,1)+'|'+       //COMPLEMENTO       VARCHAR(100),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('BAIRRO').AsString,1)+'|'+            //BAIRRO            VARCHAR(30),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('CEP').AsString,1)+'|'+               //CEP               VARCHAR(8),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('CODIGO_MUNICIPIO').AsString,0)+'|'+  //CODIGO_MUNICIPIO  INTEGER,
                        VerificaNULL(FDataModule.CDSContador.FieldByName('UF').AsString,1)+'|'+                //UF                CHAR(2),
                        VerificaNULL(FDataModule.CDSContador.FieldByName('EMAIL').AsString,1)+'|');            //EMAIL             VARCHAR(250)

          Writeln(ExportaPDV);

          FDataModule.CDScontador.Next;
        end;
    except
       GravaLogExportacao('CONTADOR|'+
                        FDataModule.CDScontador.FieldByName('ID').AsString+'|'+
                        IntToStr(FDataModule.EmpresaID)+'|'+ // to pegando do conexao.ini como havia dito
                        FDataModule.CDSContador.FieldByName('CPF').AsString+'|'+
                        FDataModule.CDSContador.FieldByName('CNPJ').AsString+'|'+
                        FDataModule.CDSContador.FieldByName('NOME').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaEmpresa;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSEmpresa.Close;
      FDataModule.CDSEmpresa.FieldDefs.Clear;
      FDataModule.CDSEmpresa.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSEmpresa.FieldDefs.add('RAZAO_SOCIAL', ftString, 150);
      FDataModule.CDSEmpresa.FieldDefs.add('NOME_FANTASIA', ftString, 150);
      FDataModule.CDSEmpresa.FieldDefs.add('CNPJ', ftString, 14);
      FDataModule.CDSEmpresa.FieldDefs.add('INSCRICAO_ESTADUAL', ftString, 30);
      FDataModule.CDSEmpresa.FieldDefs.add('INSCRICAO_ESTADUAL_ST', ftString, 30);
      FDataModule.CDSEmpresa.FieldDefs.add('INSCRICAO_MUNICIPAL', ftString, 30);
      FDataModule.CDSEmpresa.FieldDefs.add('INSCRICAO_JUNTA_COMERCIAL', ftString, 30);
      FDataModule.CDSEmpresa.FieldDefs.add('DATA_INSC_JUNTA_COMERCIAL', ftString, 10);
      FDataModule.CDSEmpresa.FieldDefs.add('DATA_CADASTRO', ftString, 10);
      FDataModule.CDSEmpresa.FieldDefs.add('DATA_INICIO_ATIVIDADES', ftString, 10);
      FDataModule.CDSEmpresa.FieldDefs.add('SUFRAMA', ftString, 9);
      FDataModule.CDSEmpresa.FieldDefs.add('EMAIL', ftString, 250);
      FDataModule.CDSEmpresa.FieldDefs.add('IMAGEM_LOGOTIPO', ftMemo);
      FDataModule.CDSEmpresa.FieldDefs.add('CRT', ftString, 1);
      FDataModule.CDSEmpresa.FieldDefs.add('TIPO_REGIME', ftString, 1);
      FDataModule.CDSEmpresa.FieldDefs.add('ALIQUOTA_PIS', ftFloat);
      FDataModule.CDSEmpresa.FieldDefs.add('ALIQUOTA_COFINS', ftFloat);
      FDataModule.CDSEmpresa.FieldDefs.add('LOGRADOURO', ftString, 250);
      FDataModule.CDSEmpresa.FieldDefs.add('NUMERO', ftString, 6);
      FDataModule.CDSEmpresa.FieldDefs.add('COMPLEMENTO', ftString, 100);
      FDataModule.CDSEmpresa.FieldDefs.add('CEP', ftString, 8);
      FDataModule.CDSEmpresa.FieldDefs.add('BAIRRO', ftString, 100);
      FDataModule.CDSEmpresa.FieldDefs.add('CIDADE', ftString, 100);
      FDataModule.CDSEmpresa.FieldDefs.add('UF', ftString, 2);
      FDataModule.CDSEmpresa.FieldDefs.add('FONE', ftString, 10);
      FDataModule.CDSEmpresa.FieldDefs.add('FAX', ftString, 10);
      FDataModule.CDSEmpresa.FieldDefs.add('CONTATO', ftString, 50);
      FDataModule.CDSEmpresa.FieldDefs.add('CODIGO_IBGE_CIDADE', ftInteger);
      FDataModule.CDSEmpresa.FieldDefs.add('CODIGO_IBGE_UF', ftInteger);
      FDataModule.CDSEmpresa.FieldDefs.add('DATA_MOVIMENTO', ftString, 10);
      FDataModule.CDSEmpresa.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TEmpresaController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSEmpresa.First;
      while not FDataModule.CDSEmpresa.Eof do
        begin
          Write(ExportaPDV,'EMPRESA|'+
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('ID').AsString,0)+'|'+                          //ID                         INTEGER NOT NULL,
                        IntToStr(FDataModule.EmpresaID)+'|'+ // To pegando do conexao.ini                               //ID_EMPRESA                 INTEGER
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('RAZAO_SOCIAL').AsString,1)+'|'+                //RAZAO_SOCIAL               VARCHAR(150),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('NOME_FANTASIA').AsString,1)+'|'+               //NOME_FANTASIA              VARCHAR(150),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('CNPJ').AsString,1)+'|'+                        //CNPJ                       VARCHAR(14),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('INSCRICAO_ESTADUAL').AsString,1)+'|'+          //INSCRICAO_ESTADUAL         VARCHAR(30),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('INSCRICAO_ESTADUAL_ST').AsString,1)+'|'+       //INSCRICAO_ESTADUAL_ST      VARCHAR(30),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('INSCRICAO_MUNICIPAL').AsString,1)+'|'+         //INSCRICAO_MUNICIPAL        VARCHAR(30),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('INSCRICAO_JUNTA_COMERCIAL').AsString,1)+'|'+   //INSCRICAO_JUNTA_COMERCIAL  VARCHAR(30),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('DATA_INSC_JUNTA_COMERCIAL').AsString,1)+'|'+   //DATA_INSC_JUNTA_COMERCIAL  DATE,
                        QuotedStr('M')+'|'+ //Matriz Filial nao tem no MINI                                                   //MATRIZ_FILIAL              CHAR(1), M - Matriz | F - Filial
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('DATA_CADASTRO').AsString,1)+'|'+               //DATA_CADASTRO              DATE,
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('DATA_INICIO_ATIVIDADES').AsString,1)+'|'+      //DATA_INICIO_ATIVIDADES     DATE,
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('SUFRAMA').AsString,1)+'|'+                     //SUFRAMA                    VARCHAR(9),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('EMAIL').AsString,1)+'|'+                       //EMAIL                      VARCHAR(250),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('IMAGEM_LOGOTIPO').AsString,1)+'|'+             //IMAGEM_LOGOTIPO            VARCHAR(250),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('CRT').AsString,1)+'|'+                         //CRT                        CHAR(1),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('TIPO_REGIME').AsString,1)+'|'+                 //TIPO_REGIME                CHAR(1),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('ALIQUOTA_PIS').AsString,0)+'|'+                //ALIQUOTA_PIS               DECIMAL(18,6),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('ALIQUOTA_COFINS').AsString,0)+'|'+             //ALIQUOTA_COFINS            DECIMAL(18,6),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('LOGRADOURO').AsString,1)+'|'+                  //LOGRADOURO                 VARCHAR(250),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('NUMERO').AsString,1)+'|'+                      //NUMERO                     VARCHAR(6),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('COMPLEMENTO').AsString,1)+'|'+                 //COMPLEMENTO                VARCHAR(100),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('CEP').AsString,1)+'|'+                         //CEP                        VARCHAR(8),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('BAIRRO').AsString,1)+'|'+                      //BAIRRO                     VARCHAR(100),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('CIDADE').AsString,1)+'|'+                      //CIDADE                     VARCHAR(100),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('UF').AsString,1)+'|'+                          //UF                         CHAR(2),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('FONE').AsString,1)+'|'+                        //FONE                       VARCHAR(10),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('FAX').AsString,1)+'|'+                         //FAX                        VARCHAR(10),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('CONTATO').AsString,1)+'|'+                     //CONTATO                    VARCHAR(30),
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('CODIGO_IBGE_CIDADE').AsString,0)+'|'+          //CODIGO_IBGE_CIDADE         INTEGER,
                        VerificaNULL(FDataModule.CDSEmpresa.FieldByName('CODIGO_IBGE_UF').AsString,0)+'|');             //CODIGO_IBGE_UF             INTEGER,
          Writeln(ExportaPDV);
          FDataModule.CDSEmpresa.Next;
        end;
    except
       GravaLogExportacao('EMPRESA|'+
                        FDataModule.CDSEmpresa.FieldByName('ID').AsString+'|'+
                        IntToStr(FDataModule.EmpresaID)+'|'+
                        FDataModule.CDSEmpresa.FieldByName('RAZAO_SOCIAL').AsString+'|'+
                        FDataModule.CDSEmpresa.FieldByName('NOME_FANTASIA').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaFichaTecnica;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSFicha.Close;
      FDataModule.CDSFicha.FieldDefs.Clear;
      FDataModule.CDSFicha.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSFicha.FieldDefs.add('ID_PRODUTO', ftInteger);
      FDataModule.CDSFicha.FieldDefs.add('DESCRICAO', ftString, 50);
      FDataModule.CDSFicha.FieldDefs.add('ID_PRODUTO_FILHO', ftInteger);
      FDataModule.CDSFicha.FieldDefs.add('QUANTIDADE', ftFloat);
      FDataModule.CDSFicha.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TFichaTecnicaController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSFicha.First;
      while not FDataModule.CDSFicha.Eof do
        begin
          Write(ExportaPDV,'FICHA|'+
                        VerificaNULL(FDataModule.CDSFicha.FieldByName('ID').AsString,0)+'|'+                    //ID                INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSFicha.FieldByName('ID_PRODUTO').AsString,0)+'|'+            //ID_PRODUTO        INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSFicha.FieldByName('DESCRICAO').AsString,1)+'|'+             //DESCRICAO         VARCHAR(50),
                        VerificaNULL(FDataModule.CDSFicha.FieldByName('ID_PRODUTO_FILHO').AsString,0)+'|'+      //ID_PRODUTO_FILHO  INTEGER,
                        VerificaNULL(FDataModule.CDSFicha.FieldByName('QUANTIDADE').AsString,0)+'|');           //QUANTIDADE        DECIMAL(18,6)
          Writeln(ExportaPDV);

          FDataModule.CDSFicha.Next;
        end;
    except
       GravaLogExportacao('FICHA|'+
                        FDataModule.CDSFicha.FieldByName('ID').AsString+'|'+
                        FDataModule.CDSFicha.FieldByName('ID_PRODUTO').AsString+'|'+
                        FDataModule.CDSFicha.FieldByName('DESCRICAO').AsString+'|'+
                        FDataModule.CDSFicha.FieldByName('ID_PRODUTO_FILHO').AsString+'|'+
                        FDataModule.CDSFicha.FieldByName('QUANTIDADE').AsString+'|');
    end;
  finally
    CloseFile(ExportaPDV);
  end;

end;

procedure ExportaFuncionario; // Tem que criar uma VIEW no banco vou enviar junto o script ass.: Marcos Leite
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSFuncionario.Close;
      FDataModule.CDSFuncionario.FieldDefs.Clear;
      FDataModule.CDSFuncionario.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSFuncionario.FieldDefs.add('NOME', ftString, 150);
      FDataModule.CDSFuncionario.FieldDefs.add('FONE1', ftString, 10);
      FDataModule.CDSFuncionario.FieldDefs.add('CELULAR', ftString, 10);
      FDataModule.CDSFuncionario.FieldDefs.add('EMAIL', ftString, 250);
      FDataModule.CDSFuncionario.FieldDefs.add('NIVEL_AUTORIZACAO_ECF', ftString, 1);
      FDataModule.CDSFuncionario.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TCargaFuncionarioController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSFuncionario.First;
      while not FDataModule.CDSFuncionario.Eof do
        begin
          Write(ExportaPDV,'FUNCIONARIO|'+
                        VerificaNULL(FDataModule.CDSFuncionario.FieldByName('ID').AsString,0)+'|'+                     //ID                 INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSFuncionario.FieldByName('NOME').AsString,1)+'|'+                   //NOME               VARCHAR(100),
                        VerificaNULL(FDataModule.CDSFuncionario.FieldByName('FONE1').AsString,1)+'|'+                  //TELEFONE           VARCHAR(10),
                        VerificaNULL(FDataModule.CDSFuncionario.FieldByName('CELULAR').AsString,1)+'|'+                //CELULAR            VARCHAR(10),
                        VerificaNULL(FDataModule.CDSFuncionario.FieldByName('EMAIL').AsString,1)+'|'+                  //EMAIL              VARCHAR(250),
                        VerificaNULL('',0)+'|'+   // Comissao a Vista nao tem no banco do MINI porem o PDV solicita                      //COMISSAO_VISTA     DECIMAL(18,6),
                        VerificaNULL('',0)+'|'+   // Comissao a Prazo nao tem no banco do MINI porem o PDV solicita                      //COMISSAO_PRAZO     DECIMAL(18,6),
                        VerificaNULL(FDataModule.CDSFuncionario.FieldByName('NIVEL_AUTORIZACAO_ECF').AsString,1)+'|'); //NIVEL_AUTORIZACAO  CHAR(1)
          Writeln(ExportaPDV);

          FDataModule.CDSFuncionario.Next;
        end;
    except
       GravaLogExportacao('FUNCIONARIO|'+
                        FDataModule.CDSFuncionario.FieldByName('ID').AsString+'|'+
                        FDataModule.CDSFuncionario.FieldByName('NOME').AsString+'|'+
                        FDataModule.CDSFuncionario.FieldByName('FONE1').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaImpressora;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSImpressora.Close;
      FDataModule.CDSImpressora.FieldDefs.Clear;
      FDataModule.CDSImpressora.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSImpressora.FieldDefs.add('NUMERO', ftInteger);
      FDataModule.CDSImpressora.FieldDefs.add('CODIGO', ftString, 10);
      FDataModule.CDSImpressora.FieldDefs.add('SERIE', ftString, 20);
      FDataModule.CDSImpressora.FieldDefs.add('IDENTIFICACAO', ftString, 250);
      FDataModule.CDSImpressora.FieldDefs.add('MC', ftString, 2);
      FDataModule.CDSImpressora.FieldDefs.add('MD', ftString, 2);
      FDataModule.CDSImpressora.FieldDefs.add('VR', ftString, 2);
      FDataModule.CDSImpressora.FieldDefs.add('TIPO', ftString, 7);
      FDataModule.CDSImpressora.FieldDefs.add('MARCA', ftString, 30);
      FDataModule.CDSImpressora.FieldDefs.add('MODELO', ftString, 30);
      FDataModule.CDSImpressora.FieldDefs.add('MODELO_ACBR', ftString, 30);
      FDataModule.CDSImpressora.FieldDefs.add('MODELO_DOCUMENTO_FISCAL', ftString, 2);
      FDataModule.CDSImpressora.FieldDefs.add('VERSAO', ftString, 30);
      FDataModule.CDSImpressora.FieldDefs.add('LE', ftString, 1);
      FDataModule.CDSImpressora.FieldDefs.add('LEF', ftString, 1);
      FDataModule.CDSImpressora.FieldDefs.add('MFD', ftString, 1);
      FDataModule.CDSImpressora.FieldDefs.add('LACRE_NA_MFD', ftString, 1);
      FDataModule.CDSImpressora.FieldDefs.add('DOCTO', ftString, 60);
      FDataModule.CDSImpressora.FieldDefs.add('DATA_INSTALACAO_SB', ftString, 10);
      FDataModule.CDSImpressora.FieldDefs.add('HORA_INSTALACAO_SB', ftString, 8);
      FDataModule.CDSImpressora.FieldDefs.add('NUMERO_ECF', ftString, 3);
      FDataModule.CDSImpressora.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TEcfImpressoraController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSImpressora.First;
      while not FDataModule.CDSImpressora.Eof do
        begin
          Write(ExportaPDV,'IMPRESSORA|'+
                        StringReplace(VerificaNULL(FDataModule.CDSImpressora.FieldByName('ID').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                        //ID                       INTEGER NOT NULL,
                        StringReplace(VerificaNULL(FDataModule.CDSImpressora.FieldByName('NUMERO').AsString,0),'|','[#]',[rfReplaceAll])+'|'+                    //NUMERO                   INTEGER,
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('CODIGO').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                  //CODIGO                   VARCHAR(10),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('SERIE').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                   //SERIE                    VARCHAR(20),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('IDENTIFICACAO').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+           //IDENTIFICACAO            VARCHAR(250),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('MC').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                      //MC                       CHAR(2),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('MD').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                      //MD                       CHAR(2),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('VR').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                      //VR                       CHAR(2),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('TIPO').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                    //TIPO                     VARCHAR(7),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('MARCA').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                   //MARCA                    VARCHAR(30),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('MODELO').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                  //MODELO                   VARCHAR(30),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('MODELO_ACBR').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+             //MODELO_ACBR              VARCHAR(30),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+ //MODELO_DOCUMENTO_FISCAL  CHAR(2),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('VERSAO').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                  //VERSAO                   VARCHAR(30),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('LE').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                      //LE                       CHAR(1),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('LEF').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                     //LEF                      CHAR(1),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('MFD').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                     //MFD                      CHAR(1),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('LACRE_NA_MFD').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+            //LACRE_NA_MFD             CHAR(1),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('DOCTO').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+                   //DOCTO                    VARCHAR(60)
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('DATA_INSTALACAO_SB').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+      //DATA_INSTALACAO_SB       DATE,
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('HORA_INSTALACAO_SB').AsString,1)),'|','[#]',[rfReplaceAll])+'|'+      //HORA_INSTALACAO_SB       VARCHAR(8),
                        StringReplace((VerificaNULL(FDataModule.CDSImpressora.FieldByName('NUMERO_ECF').AsString,1)),'|','[#]',[rfReplaceAll])+'|');             //NUMERO_ECF               VARCHAR(3)
          Writeln(ExportaPDV);

          FDataModule.CDSImpressora.Next;
        end;
    except
       GravaLogExportacao('IMPRESSORA|'+
                        FDataModule.CDSImpressora.FieldByName('ID').AsString+'|'+
                        FDataModule.CDSImpressora.FieldByName('NUMERO').AsString+'|'+
                        FDataModule.CDSImpressora.FieldByName('CODIGO').AsString+'|'+
                        FDataModule.CDSImpressora.FieldByName('SERIE').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaOperador;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSUsuario.Close;
      FDataModule.CDSUsuario.FieldDefs.Clear;
      FDataModule.CDSUsuario.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSUsuario.FieldDefs.add('ID_PAPEL', ftInteger);
      FDataModule.CDSUsuario.FieldDefs.add('ID_COLABORADOR', ftInteger);
      FDataModule.CDSUsuario.FieldDefs.add('NOME', ftString, 150);
      FDataModule.CDSUsuario.FieldDefs.add('LOGIN', ftString, 30);
      FDataModule.CDSUsuario.FieldDefs.add('SENHA', ftString, 30);
      FDataModule.CDSUsuario.FieldDefs.add('DATA_CADASTRO', ftString, 10);
      FDataModule.CDSUsuario.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TUsuarioController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSUsuario.First;
      while not FDataModule.CDSUsuario.Eof do
        begin
          Write(ExportaPDV,'OPERADOR|'+
                        VerificaNULL(FDataModule.CDSUsuario.FieldByName('ID').AsString,0)+'|'+             //ID                  INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSUsuario.FieldByName('ID_COLABORADOR').AsString,0)+'|'+ //ID_ECF_FUNCIONARIO ONDE EU PEGO??                          //ID_ECF_FUNCIONARIO  INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSUsuario.FieldByName('LOGIN').AsString,1)+'|'+          //LOGIN               VARCHAR(20),
                        VerificaNULL(FDataModule.CDSUsuario.FieldByName('SENHA').AsString,1)+'|');         //SENHA               VARCHAR(20)
          Writeln(ExportaPDV);

          FDataModule.CDSUsuario.Next;
        end;
    except
       GravaLogExportacao('OPERADOR|'+
                        FDataModule.CDSUsuario.FieldByName('ID').AsString+'|'+             //ID                  INTEGER NOT NULL,
                        FDataModule.CDSUsuario.FieldByName('ID_COLABORADOR').AsString+'|'+ //ID_ECF_FUNCIONARIO
                        FDataModule.CDSUsuario.FieldByName('LOGIN').AsString+'|'+          //LOGIN               VARCHAR(20),
                        FDataModule.CDSUsuario.FieldByName('SENHA').AsString+'|');         //SENHA               VARCHAR(20)
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaPosicaoComponentes;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSComponentes.Close;
      FDataModule.CDSComponentes.FieldDefs.Clear;
      FDataModule.CDSComponentes.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSComponentes.FieldDefs.add('ID_ECF_RESOLUCAO', ftInteger);
      FDataModule.CDSComponentes.FieldDefs.add('NOME_CAIXA', ftString, 30);
      FDataModule.CDSComponentes.FieldDefs.add('ID_GERADO_CAIXA', ftInteger);
      FDataModule.CDSComponentes.FieldDefs.add('ID_EMPRESA', ftInteger);
      FDataModule.CDSComponentes.FieldDefs.add('NOME', ftString, 100);
      FDataModule.CDSComponentes.FieldDefs.add('ALTURA', ftInteger);
      FDataModule.CDSComponentes.FieldDefs.add('LARGURA', ftInteger);
      FDataModule.CDSComponentes.FieldDefs.add('TOPO', ftInteger);
      FDataModule.CDSComponentes.FieldDefs.add('ESQUERDA', ftInteger);
      FDataModule.CDSComponentes.FieldDefs.add('TAMANHO_FONTE', ftInteger);
      FDataModule.CDSComponentes.FieldDefs.add('TEXTO', ftString, 250);
      FDataModule.CDSComponentes.FieldDefs.add('DATA_SINCRONIZACAO', ftString, 10);
      FDataModule.CDSComponentes.FieldDefs.add('HORA_SINCRONIZACAO', ftString, 8);
      FDataModule.CDSComponentes.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TEcfPosicaoComponentesController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSComponentes.First;
      while not FDataModule.CDSComponentes.Eof do
        begin
          Write(ExportaPDV,'COMPONENTES|'+
                        VerificaNULL(FDataModule.CDSComponentes.FieldByName('ID').AsString,0)+'|'+                //ID                            INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSComponentes.FieldByName('ID_ECF_RESOLUCAO').AsString,0)+'|'+  //ID_ECF_RESOLUCAO  INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSComponentes.FieldByName('NOME').AsString,1)+'|'+              //NOME              VARCHAR(100),
                        VerificaNULL(FDataModule.CDSComponentes.FieldByName('ALTURA').AsString,0)+'|'+            //ALTURA            INTEGER,
                        VerificaNULL(FDataModule.CDSComponentes.FieldByName('LARGURA').AsString,0)+'|'+           //LARGURA           INTEGER,
                        VerificaNULL(FDataModule.CDSComponentes.FieldByName('TOPO').AsString,0)+'|'+              //TOPO              INTEGER,
                        VerificaNULL(FDataModule.CDSComponentes.FieldByName('ESQUERDA').AsString,0)+'|'+          //ESQUERDA          INTEGER,
                        VerificaNULL(FDataModule.CDSComponentes.FieldByName('TAMANHO_FONTE').AsString,0)+'|'+     //TAMANHO_FONTE     INTEGER DEFAULT 0,
                        VerificaNULL(FDataModule.CDSComponentes.FieldByName('TEXTO').AsString,1)+'|');            //TEXTO             VARCHAR(250)
          Writeln(ExportaPDV);

          FDataModule.CDSComponentes.Next;
        end;
    except
       GravaLogExportacao('COMPONENTES|'+
                        FDataModule.CDSComponentes.FieldByName('ID').AsString+'|'+                      //ID                INTEGER NOT NULL,
                        FDataModule.CDSComponentes.FieldByName('ID_ECF_RESOLUCAO').AsString+'|'+        //ID_ECF_RESOLUCAO NAO TEM NO MINI                                      //ID_ECF_RESOLUCAO  INTEGER NOT NULL,
                        FDataModule.CDSComponentes.FieldByName('NOME').AsString+'|'+                    //NOME              VARCHAR(100),
                        FDataModule.CDSComponentes.FieldByName('ALTURA').AsString+'|'+                  //ALTURA            INTEGER,
                        FDataModule.CDSComponentes.FieldByName('LARGURA').AsString+'|'+                 //LARGURA           INTEGER,
                        FDataModule.CDSComponentes.FieldByName('TOPO').AsString+'|'+                    //TOPO              INTEGER,
                        FDataModule.CDSComponentes.FieldByName('ESQUERDA').AsString+'|'+                //ESQUERDA          INTEGER,
                        FDataModule.CDSComponentes.FieldByName('TAMANHO_FONTE').AsString+'|'+           //TAMANHO_FONTE     INTEGER DEFAULT 0,
                        FDataModule.CDSComponentes.FieldByName('TEXTO').AsString+'|');                  //TEXTO             VARCHAR(250)
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaProduto(TipoExporta: integer);
var
  ExportaPDV: TextFile;
  Tripa: String;
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  I: Integer;
begin
  try
    try
      DecimalSeparator := '.';

      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;
      Contexto := TRttiContext.Create;
      Tipo := Contexto.GetType(TProdutoVO);


          FDataModule.CDSProduto.Close;
    FDataModule.CDSProduto.FieldDefs.Clear;
    FDataModule.CDSProduto.IndexDefs.Clear;

    //preenche os nomes dos campos do CDS
    FDataModule.CDSProduto.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
              FDataModule.CDSProduto.FieldDefs.add((Atributo as TColumn).Name, ftString, (Atributo as TColumn).Length)
            else
            if Propriedade.PropertyType.TypeKind in [tkFloat] then
              FDataModule.CDSProduto.FieldDefs.add((Atributo as TColumn).Name, ftFloat)
            else
            if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
              FDataModule.CDSProduto.FieldDefs.add((Atributo as TColumn).Name, ftInteger)
          end;
        end;
      end;
    end;
    FDataModule.CDSProduto.CreateDataSet;



     { FDataModule.CDSProduto.Close;
      FDataModule.CDSProduto.FieldDefs.Clear;
      FDataModule.CDSProduto.FieldDefs.add('ID', ftInteger);                        //  INTEGER NOT NULL,
      FDataModule.CDSProduto.FieldDefs.add('ID_UNIDADE_PRODUTO', ftInteger);        //  INTEGER NOT NULL,
      FDataModule.CDSProduto.FieldDefs.add('GTIN', ftString, 14);                   //  VARCHAR(14),
      FDataModule.CDSProduto.FieldDefs.add('CODIGO_INTERNO', ftString, 20);         //  VARCHAR(20),
      FDataModule.CDSProduto.FieldDefs.add('NOME', ftString, 100);                  //  VARCHAR(100),
      FDataModule.CDSProduto.FieldDefs.add('DESCRICAO', ftString, 250);             //  VARCHAR(250),
      FDataModule.CDSProduto.FieldDefs.add('DESCRICAO_PDV', ftString, 30);          //  VARCHAR(30),
      FDataModule.CDSProduto.FieldDefs.add('VALOR_VENDA', ftFloat);                 //  DECIMAL(18,6),
      FDataModule.CDSProduto.FieldDefs.add('QTD_ESTOQUE', ftFloat);                 //  DECIMAL(18,6),
      FDataModule.CDSProduto.FieldDefs.add('QTD_ESTOQUE_ANTERIOR', ftFloat);        //  DECIMAL(18,6),
      FDataModule.CDSProduto.FieldDefs.add('ESTOQUE_MIN', ftFloat);                 //  DECIMAL(18,6),
      FDataModule.CDSProduto.FieldDefs.add('ESTOQUE_MAX', ftFloat);                 //  DECIMAL(18,6),
      FDataModule.CDSProduto.FieldDefs.add('IAT', ftString, 1);                     //  CHAR(1),
      FDataModule.CDSProduto.FieldDefs.add('IPPT', ftString, 1);                    //  CHAR(1),
      FDataModule.CDSProduto.FieldDefs.add('NCM', ftString, 8);                     //  VARCHAR(8),
      FDataModule.CDSProduto.FieldDefs.add('TIPO_ITEM_SPED', ftString, 2);          //  CHAR(2),
      FDataModule.CDSProduto.FieldDefs.add('DATA_ESTOQUE', ftString, 10);           //  DATE,
      FDataModule.CDSProduto.FieldDefs.add('TAXA_IPI', ftFloat);                    //  DECIMAL(18,6),
      FDataModule.CDSProduto.FieldDefs.add('TAXA_ISSQN', ftFloat);                  //  DECIMAL(18,6),
      FDataModule.CDSProduto.FieldDefs.add('TAXA_PIS', ftFloat);                    //  DECIMAL(18,6),
      FDataModule.CDSProduto.FieldDefs.add('TAXA_COFINS', ftFloat);                 //  DECIMAL(18,6),
      FDataModule.CDSProduto.FieldDefs.add('TAXA_ICMS', ftFloat);                   //  DECIMAL(18,6),
      FDataModule.CDSProduto.FieldDefs.add('CST', ftString, 3);                     //  CHAR(3),
      FDataModule.CDSProduto.FieldDefs.add('CSOSN', ftString, 4);                   //  CHAR(4),
      FDataModule.CDSProduto.FieldDefs.add('TOTALIZADOR_PARCIAL', ftString, 10);    //  VARCHAR(10),
      FDataModule.CDSProduto.FieldDefs.add('ECF_ICMS_ST', ftString, 4);             //  VARCHAR(4),
      FDataModule.CDSProduto.FieldDefs.add('CODIGO_BALANCA', ftInteger);            //  INTEGER,
      FDataModule.CDSProduto.FieldDefs.add('PAF_P_ST', ftString, 1);                //  CHAR(1),
      //    HASH_TRIPA            VARCHAR(32),
      //    HASH_INCREMENTO       INTEGER

      FDataModule.CDSProduto.CreateDataSet;  }


      Pagina := 0;
      Filtro := ' ID > 0 ';

      if TipoExporta = 1 then
        Filtro := ' DATA_ALTERACAO ='+QuotedStr(DataParaTexto(now));

      TProdutoController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSProduto.First;
      while not FDataModule.CDSProduto.Eof do
      begin
        if FileExists(FDataModule.PathExporta) then
          Append(ExportaPDV)
        else
          Rewrite(ExportaPDV);

        Tripa :=  FDataModule.CDSProduto.FieldByName('GTIN').AsString +
                  FDataModule.CDSProduto.FieldByName('DESCRICAO').AsString +
                  FDataModule.CDSProduto.FieldByName('DESCRICAO_PDV').AsString +
                  FormataFloat('Q',FDataModule.CDSProduto.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat) +
                  FDataModule.CDSProduto.FieldByName('DATA_ESTOQUE').AsString +
                  FDataModule.CDSProduto.FieldByName('CST').AsString +
                  FormataFloat('V',FDataModule.CDSProduto.FieldByName('TAXA_ICMS').AsFloat) +
                  FormataFloat('V',FDataModule.CDSProduto.FieldByName('VALOR_VENDA').AsFloat) + '0';

        Write(ExportaPDV,'PRODUTO|'+

        VerificaNULL(FDataModule.CDSProduto.FieldByName('ID').AsString,0)+'|'+                   //  INTEGER NOT NULL,
        VerificaNULL(FDataModule.CDSProduto.FieldByName('ID_UNIDADE_PRODUTO').AsString,0)+'|'+   //  INTEGER NOT NULL,
        VerificaNULL(FDataModule.CDSProduto.FieldByName('GTIN').AsString,2)+'|'+                 //  VARCHAR(14),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('CODIGO_INTERNO').AsString,2)+'|'+       //  VARCHAR(20),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('NOME').AsString,2)+'|'+                 //  VARCHAR(100),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('DESCRICAO').AsString,2)+'|'+            //  VARCHAR(250),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('DESCRICAO_PDV').AsString,2)+'|'+        //  VARCHAR(30),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('VALOR_VENDA').AsString,0)+'|'+          //  DECIMAL(18,6),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('QTD_ESTOQUE').AsString,0)+'|'+          //  DECIMAL(18,6),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('QTD_ESTOQUE_ANTERIOR').AsString,0)+'|'+ //  DECIMAL(18,6),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('ESTOQUE_MIN').AsString,0)+'|'+          //  DECIMAL(18,6),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('ESTOQUE_MAX').AsString,0)+'|'+          //  DECIMAL(18,6),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('IAT').AsString,2)+'|'+                  //  CHAR(1),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('IPPT').AsString,2)+'|'+                 //  CHAR(1),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('NCM').AsString,2)+'|'+                  //  VARCHAR(8),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('TIPO_ITEM_SPED').AsString,2)+'|'+       //  CHAR(2),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('DATA_ESTOQUE').AsString,2)+'|'+         //  DATE,
        VerificaNULL(FDataModule.CDSProduto.FieldByName('TAXA_IPI').AsString,0)+'|'+             //  DECIMAL(18,6),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('TAXA_ISSQN').AsString,0)+'|'+           //  DECIMAL(18,6),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('TAXA_PIS').AsString,0)+'|'+             //  DECIMAL(18,6),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('TAXA_COFINS').AsString,0)+'|'+          //  DECIMAL(18,6),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('TAXA_ICMS').AsString,0)+'|'+            //  DECIMAL(18,6),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('CST').AsString,2)+'|'+                  //  CHAR(3),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('CSOSN').AsString,2)+'|'+                //  CHAR(4),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('TOTALIZADOR_PARCIAL').AsString,2)+'|'+  //  VARCHAR(10),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('ECF_ICMS_ST').AsString,2)+'|'+          //  VARCHAR(4),
        VerificaNULL(FDataModule.CDSProduto.FieldByName('CODIGO_BALANCA').AsString,0)+'|'+       //  INTEGER,
        VerificaNULL(FDataModule.CDSProduto.FieldByName('PAF_P_ST').AsString,2)+'|'+             //  CHAR(1),
        VerificaNULL(MD5String(Tripa), 2)+'|'+                                                   //  VARCHAR(32),
        '-1|');                                                                                  //  INTEGER

        Writeln(ExportaPDV);
        FDataModule.CDSProduto.Next;
        Application.ProcessMessages;



      end;

    except
       GravaLogExportacao('PRODUTO|'+
                           FDataModule.CDSProduto.FieldByName('ID').AsString+'|'+
                           FDataModule.CDSProduto.FieldByName('ID_UNIDADE_PRODUTO').AsString+'|'+
                           FDataModule.CDSProduto.FieldByName('GTIN').AsString+'|'+
                           FDataModule.CDSProduto.FieldByName('NOME').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
     DecimalSeparator := ',';
  end;


end;



procedure ExportaProdutoPromocao;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSPromocao.Close;
      FDataModule.CDSPromocao.FieldDefs.Clear;
      FDataModule.CDSPromocao.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSPromocao.FieldDefs.add('ID_PRODUTO', ftInteger);
      FDataModule.CDSPromocao.FieldDefs.add('DATA_INICIO', ftString, 10);
      FDataModule.CDSPromocao.FieldDefs.add('DATA_FIM', ftString, 10);
      FDataModule.CDSPromocao.FieldDefs.add('QUANTIDADE_EM_PROMOCAO', ftFloat);
      FDataModule.CDSPromocao.FieldDefs.add('QUANTIDADE_MAXIMA_CLIENTE', ftFloat);
      FDataModule.CDSPromocao.FieldDefs.add('VALOR', ftFloat);
      FDataModule.CDSPromocao.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TProdutoPromocaoController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSPromocao.First;
      while not FDataModule.CDSPromocao.Eof do
        begin
          Write(ExportaPDV,'PROMOCAO|'+
                        VerificaNULL(FDataModule.CDSPromocao.FieldByName('ID').AsString,0)+'|'+                        //ID                         INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSPromocao.FieldByName('ID_PRODUTO').AsString,0)+'|'+                //ID_PRODUTO                 INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSPromocao.FieldByName('DATA_INICIO').AsString,1)+'|'+               //DATA_INICIO                DATE,
                        VerificaNULL(FDataModule.CDSPromocao.FieldByName('DATA_FIM').AsString,1)+'|'+                  //DATA_FIM                   DATE,
                        VerificaNULL(FDataModule.CDSPromocao.FieldByName('QUANTIDADE_EM_PROMOCAO').AsString,0)+'|'+    //QUANTIDADE_EM_PROMOCAO     DECIMAL(18,6),
                        VerificaNULL(FDataModule.CDSPromocao.FieldByName('QUANTIDADE_MAXIMA_CLIENTE').AsString,0)+'|'+ //QUANTIDADE_MAXIMA_CLIENTE  DECIMAL(18,6),
                        VerificaNULL(FDataModule.CDSPromocao.FieldByName('VALOR').AsString,0)+'|');                    //VALOR                      DECIMAL(18,6)
          Writeln(ExportaPDV);

          FDataModule.CDSPromocao.Next;
        end;
    except
       GravaLogExportacao('PROMOCAO|'+
                        FDataModule.CDSPromocao.FieldByName('ID').AsString+'|'+
                        FDataModule.CDSPromocao.FieldByName('ID_PRODUTO').AsString+'|'+
                        FDataModule.CDSPromocao.FieldByName('DATA_INICIO').AsString+'|'+
                        FDataModule.CDSPromocao.FieldByName('DATA_FIM').AsString+'|'+
                        FDataModule.CDSPromocao.FieldByName('QUANTIDADE_EM_PROMOCAO').AsString+'|'+
                        FDataModule.CDSPromocao.FieldByName('QUANTIDADE_MAXIMA_CLIENTE').AsString+'|'+
                        FDataModule.CDSPromocao.FieldByName('VALOR').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaResolucao;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSResolucao.Close;
      FDataModule.CDSResolucao.FieldDefs.Clear;
      FDataModule.CDSResolucao.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSResolucao.FieldDefs.add('NOME_CAIXA', ftString, 30);
      FDataModule.CDSResolucao.FieldDefs.add('ID_GERADO_CAIXA', ftInteger);
      FDataModule.CDSResolucao.FieldDefs.add('ID_EMPRESA', ftInteger);
      FDataModule.CDSResolucao.FieldDefs.add('RESOLUCAO_TELA', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('LARGURA', ftInteger);
      FDataModule.CDSResolucao.FieldDefs.add('ALTURA', ftInteger);
      FDataModule.CDSResolucao.FieldDefs.add('IMAGEM_TELA', ftString, 50);
      FDataModule.CDSResolucao.FieldDefs.add('IMAGEM_MENU', ftString, 50);
      FDataModule.CDSResolucao.FieldDefs.add('IMAGEM_SUBMENU', ftString, 50);
      FDataModule.CDSResolucao.FieldDefs.add('HOTTRACK_COLOR', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('ITEM_STYLE_FONT_NAME', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('ITEM_STYLE_FONT_COLOR', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('ITEM_SEL_STYLE_COLOR', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('LABEL_TOTAL_GERAL_FONT_COLOR', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('ITEM_STYLE_FONT_STYLE', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('EDITS_COLOR', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('EDITS_FONT_COLOR', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('EDITS_DISABLED_COLOR', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('EDITS_FONT_NAME', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('EDITS_FONT_STYLE', ftString, 20);
      FDataModule.CDSResolucao.FieldDefs.add('DATA_SINCRONIZACAO', ftString, 10);
      FDataModule.CDSResolucao.FieldDefs.add('HORA_SINCRONIZACAO', ftString, 8);
      FDataModule.CDSResolucao.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TEcfResolucaoController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSResolucao.First;
      while not FDataModule.CDSResolucao.Eof do
        begin
          Write(ExportaPDV,'RESOLUCAO|'+
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('ID').AsString,0)+'|'+                            //ID                            INTEGER NOT NULL,
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('RESOLUCAO_TELA').AsString,1)+'|'+                //RESOLUCAO_TELA                VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('LARGURA').AsString,0)+'|'+                       //LARGURA                       INTEGER,
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('ALTURA').AsString,0)+'|'+                        //ALTURA                        INTEGER,
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('IMAGEM_TELA').AsString,1)+'|'+                   //IMAGEM_TELA                   VARCHAR(50),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('IMAGEM_MENU').AsString,1)+'|'+                   //IMAGEM_TELA                   VARCHAR(50),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('IMAGEM_SUBMENU').AsString,1)+'|'+                //IMAGEM_SUBMENU                VARCHAR(50),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('HOTTRACK_COLOR').AsString,1)+'|'+                //HOTTRACK_COLOR                VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('ITEM_STYLE_FONT_NAME').AsString,1)+'|'+          //ITEM_STYLE_FONT_NAME          VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('ITEM_STYLE_FONT_COLOR').AsString,1)+'|'+         //ITEM_STYLE_FONT_COLOR         VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('ITEM_SEL_STYLE_COLOR').AsString,1)+'|'+          //ITEM_SEL_STYLE_COLOR          VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('LABEL_TOTAL_GERAL_FONT_COLOR').AsString,1)+'|'+  //LABEL_TOTAL_GERAL_FONT_COLOR  VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('ITEM_STYLE_FONT_STYLE').AsString,1)+'|'+         //ITEM_STYLE_FONT_STYLE         VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('EDITS_COLOR').AsString,1)+'|'+                   //EDITS_COLOR                   VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('EDITS_FONT_COLOR').AsString,1)+'|'+              //EDITS_FONT_COLOR              VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('EDITS_DISABLED_COLOR').AsString,1)+'|'+          //EDITS_DISABLED_COLOR          VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('EDITS_FONT_NAME').AsString,1)+'|'+               //EDITS_FONT_NAME               VARCHAR(20),
                        VerificaNULL(FDataModule.CDSResolucao.FieldByName('EDITS_FONT_STYLE').AsString,1)+'|');             //EDITS_FONT_STYLE              VARCHAR(20)
          Writeln(ExportaPDV);

          FDataModule.CDSResolucao.Next;
        end;
    except
       GravaLogExportacao('RESOLUCAO|'+
                        FDataModule.CDSResolucao.FieldByName('ID').AsString+'|'+
                        FDataModule.CDSResolucao.FieldByName('RESOLUCAO_TELA').AsString+'|'+
                        FDataModule.CDSResolucao.FieldByName('LARGURA').AsString+'|'+
                        FDataModule.CDSResolucao.FieldByName('ALTURA').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure ExportaUnidadeProduto;
var
  ExportaPDV: TextFile;
begin
  try
    try
      AssignFile(ExportaPDV,FDataModule.PathExporta);
      Application.ProcessMessages;

      if FileExists(FDataModule.PathExporta) then
        Append(ExportaPDV)
      else
        Rewrite(ExportaPDV);

      FDataModule.CDSUnidadeProduto.Close;
      FDataModule.CDSUnidadeProduto.FieldDefs.Clear;
      FDataModule.CDSUnidadeProduto.FieldDefs.add('ID', ftInteger);
      FDataModule.CDSUnidadeProduto.FieldDefs.add('NOME', ftString, 10);
      FDataModule.CDSUnidadeProduto.FieldDefs.add('DESCRICAO', ftMemo);
      FDataModule.CDSUnidadeProduto.FieldDefs.add('PODE_FRACIONAR', ftString, 1);
      FDataModule.CDSUnidadeProduto.CreateDataSet;

      Pagina := 0;
      Filtro := ' ID > 0 ';

      TUnidadeProdutoController.Consulta(trim(Filtro), Pagina, False);
      FDataModule.CDSUnidadeProduto.First;
      while not FDataModule.CDSUnidadeProduto.Eof do
        begin
          Write(ExportaPDV,'UNIDADE|'+
                        VerificaNULL(FDataModule.CDSUnidadeProduto.FieldByName('ID').AsString,0)+'|'+
                        VerificaNULL(FDataModule.CDSUnidadeProduto.FieldByName('NOME').AsString,1)+'|'+
                        VerificaNULL(FDataModule.CDSUnidadeProduto.FieldByName('DESCRICAO').AsString,1)+'|'+
                        VerificaNULL(FDataModule.CDSUnidadeProduto.FieldByName('PODE_FRACIONAR').AsString,1)+'|');

          Writeln(ExportaPDV);

          FDataModule.CDSUnidadeProduto.Next;
        end;

    except
       GravaLogExportacao('UNIDADE|'+
                           FDataModule.CDSUnidadeProduto.FieldByName('ID').AsString+'|'+
                           FDataModule.CDSUnidadeProduto.FieldByName('NOME').AsString+'|'+
                           FDataModule.CDSUnidadeProduto.FieldByName('DESCRICAO').AsString+'|'+
                           FDataModule.CDSUnidadeProduto.FieldByName('PODE_FRACIONAR').AsString+'|');
    end;
  finally
     CloseFile(ExportaPDV);
  end;

end;

procedure GravaLogExportacao(Erro: string);
begin
  // rotina ainda não implementada
end;

end.
