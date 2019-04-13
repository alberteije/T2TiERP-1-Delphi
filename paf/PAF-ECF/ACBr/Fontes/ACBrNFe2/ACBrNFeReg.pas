{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 09/03/2009: Dulcemar P.Zilli
|*  - Incluido IPI e II
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeReg;

interface

uses
  SysUtils, Classes, ACBrNFe, pcnConversao,
  {$IFDEF VisualCLX} QDialogs {$ELSE} Dialogs, FileCtrl {$ENDIF},
  {$IFDEF FPC}
     LResources, LazarusPackageIntf, PropEdits, componenteditors
  {$ELSE}
    {$IFNDEF COMPILER6_UP}
       DsgnIntf
    {$ELSE}
       DesignIntf,
       DesignEditors
    {$ENDIF}
  {$ENDIF} ;


type
  { Editor de Proriedades de Componente para mostrar o AboutACBr }
  TACBrAboutDialogProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  THRWEBSERVICEUFProperty = class( TStringProperty )
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc) ; override;
  end;

  { Editor de Proriedades de Componente para chamar OpenDialog }
  TACBrNFeDirProperty = class( TStringProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;


procedure Register;

implementation

uses ACBrNFeConfiguracoes;

{$IFNDEF FPC}
   {$R ACBrNFe.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrNFe]);

  RegisterPropertyEditor(TypeInfo(TACBrNFeAboutInfo), nil, 'AboutACBrNFe',
     TACBrAboutDialogProperty);

  RegisterPropertyEditor(TypeInfo(TCertificadosConf), TConfiguracoes, 'Certificados',
    TClassProperty);

  RegisterPropertyEditor(TypeInfo(TConfiguracoes), TACBrNFe, 'Configuracoes',
    TClassProperty);

  RegisterPropertyEditor(TypeInfo(TWebServicesConf), TConfiguracoes, 'WebServices',
    TClassProperty);

  RegisterPropertyEditor(TypeInfo(String), TWebServicesConf, 'UF',
     THRWEBSERVICEUFProperty);

  RegisterPropertyEditor(TypeInfo(TGeralConf), TConfiguracoes, 'Geral',
    TClassProperty);

  RegisterPropertyEditor(TypeInfo(String), TGeralConf, 'PathSalvar',
     TACBrNFeDirProperty);

  RegisterPropertyEditor(TypeInfo(TArquivosConf), TConfiguracoes, 'Arquivos',
    TClassProperty);

  RegisterPropertyEditor(TypeInfo(String), TArquivosConf, 'PathNFe',
     TACBrNFeDirProperty);

  RegisterPropertyEditor(TypeInfo(String), TArquivosConf, 'PathCan',
     TACBrNFeDirProperty);

  RegisterPropertyEditor(TypeInfo(String), TArquivosConf, 'PathInu',
     TACBrNFeDirProperty);

  RegisterPropertyEditor(TypeInfo(String), TArquivosConf, 'PathDPEC',
     TACBrNFeDirProperty);

end;

{ TACBrAboutDialogProperty }
procedure TACBrAboutDialogProperty.Edit;
begin
  ACBrAboutDialog ;
end;

function TACBrAboutDialogProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TACBrAboutDialogProperty.GetValue: string;
begin
  Result := 'Versão: ' + ACBRNFE_VERSAO ;
end;

{ THRWEBSERVICEUFProperty }

function THRWEBSERVICEUFProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paAutoUpdate];
end;

procedure THRWEBSERVICEUFProperty.GetValues(Proc: TGetStrProc);
var
 i : integer;
begin
  inherited;
  for i:= 0 to High(NFeUF) do
    Proc(NFeUF[i]);
end;

{ TACBrNFeDirProperty }

procedure TACBrNFeDirProperty.Edit;
Var
{$IFNDEF VisualCLX} Dir : String ; {$ELSE} Dir : WideString ; {$ENDIF}
begin
  {$IFNDEF VisualCLX}
  Dir := GetValue ;
  if SelectDirectory(Dir,[],0) then
     SetValue( Dir ) ;
  {$ELSE}
  Dir := '' ;
  if SelectDirectory('Selecione o Diretório','',Dir) then
     SetValue( Dir ) ;
  {$ENDIF}
end;

function TACBrNFeDirProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

initialization
{$IFDEF FPC}
//   {$i acbrnfepcn_lcl.lrs}
{$ENDIF}

end.
