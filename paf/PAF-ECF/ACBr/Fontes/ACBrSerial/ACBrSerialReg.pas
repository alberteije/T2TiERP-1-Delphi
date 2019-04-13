{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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
|* 27/05/2004: Primeira Versao
|*    Daniel Simoes de Almeida
|*    Criaçao de um arquivo unico para registro dos Componentes
******************************************************************************}

{$I ACBr.inc}
unit ACBrSerialReg;

interface
Uses Classes ,
    {$IFDEF VisualCLX}
      QDialogs
    {$ELSE}
      Dialogs
      {$IFNDEF FPC}
        {$WARN UNIT_PLATFORM OFF}, FileCtrl {$WARN UNIT_PLATFORM ON}
      {$ENDIF}
    {$ENDIF},
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
  { Editor de Proriedades de Componente de ACBrGAV -> StrComando }
  TACBrGAVStrComandoProperty = class( TStringProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc) ; override;
  end;

  { Editor de Componente do ECF para Mostrar TestarDialog }
  TACBrECFEditor = class( TComponentEditor )
  public
    procedure Edit; override;
  end;

  { Editor de Proriedades de Componente para chamar OpenDialog }
  TACBrFileNameProperty = class( TStringProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  { Editor de Proriedades de Componente para chamar OpenDialog }
  TACBrDirProperty = class( TStringProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure Register;

implementation
Uses ACBrUtil,  
     ACBrECF, ACBrGAV, ACBrCHQ, ACBrLCB, ACBrDIS, ACBrTER, ACBrBAL, ACBrETQ,
     ACBrRFD,
     SysUtils;

{$IFNDEF FPC}
   {$R ACBrSerial.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrECF, TACBrRFD, TACBrGAV, TACBrCHQ,
     TACBrLCB, TACBrDIS, TACBrTER, TACBrBAL, TACBrETQ]);

  { Registrando os Editores de Propriedade }
  RegisterPropertyEditor(TypeInfo(String), TACBrGAV, 'StrComando',
     TACBrGAVStrComandoProperty);
  RegisterPropertyEditor(TypeInfo(String), TACBrCHQ, 'ArquivoBancosINI',
     TACBrFileNameProperty);
  RegisterPropertyEditor(TypeInfo(String), TACBrRFD, 'DirBase',
     TACBrDirProperty);

  {$IFNDEF COMPILER6_UP}
  RegisterPropertyEditor(TypeInfo(TACBrDevice), TACBrECF, 'Device',
    TClassProperty);
  RegisterPropertyEditor(TypeInfo(TACBrDevice), TACBrGAV, 'Device',
    TClassProperty);
  RegisterPropertyEditor(TypeInfo(TACBrDevice), TACBrCHQ, 'Device',
    TClassProperty);
  RegisterPropertyEditor(TypeInfo(TACBrDevice), TACBrLCB, 'Device',
    TClassProperty);
  RegisterPropertyEditor(TypeInfo(TACBrDevice), TACBrDIS, 'Device',
    TClassProperty);
  RegisterPropertyEditor(TypeInfo(TACBrDevice), TACBrBAL, 'Device',
    TClassProperty);
  RegisterPropertyEditor(TypeInfo(TACBrDevice), TACBrTER, 'Device',
    TClassProperty);
  RegisterPropertyEditor(TypeInfo(TACBrDevice), TACBrETQ, 'Device',
    TClassProperty);
  {$ENDIF}

  { Registrando os Editores de Componente }
  RegisterComponentEditor(TACBrECF, TACBrECFEditor);
end;


{ TACBrECFEditor }

procedure TACBrECFEditor.Edit;
begin
  with Component as TACBrECF do
     TestarDialog ;
end;

{ TACBrGAVStrComandoProperty }

procedure TACBrGAVStrComandoProperty.Edit;
begin
  inherited;

end;

function TACBrGAVStrComandoProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TACBrGAVStrComandoProperty.GetValues(Proc: TGetStrProc);
begin
  Proc('#027,v,#140 | Bematech') ;
  Proc('#254 | Daruma') ;
  Proc('#027,p,0,#050,#200 | Mecaf') ;
  Proc('#027,p,#000,#050,#200 | Schalter') ;
  Proc('#027,#112,#048,#050 | Zantus') ;
end;


{ TACBrFileNameProperty }

procedure TACBrFileNameProperty.Edit;
var Dlg : TOpenDialog ;
begin
  Dlg := TOpenDialog.Create( nil );
  try
     Dlg.FileName   := GetValue ;
     Dlg.InitialDir := ExtractFilePath( GetValue ) ;
     Dlg.Filter     := 'Arquivos INI|*.ini' ;

     if Dlg.Execute then
        SetValue( Dlg.FileName );
  finally
     Dlg.Free ;
  end ;
end;

function TACBrFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{ TACBrDirProperty }

procedure TACBrDirProperty.Edit;
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

function TACBrDirProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{$ifdef FPC}
initialization
   {$i ACBrSerial.lrs}
{$endif}

end.
