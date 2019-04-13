{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:    Alexandre Rocha Lima e Marcondes             }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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

{$I ACBr.inc}

Unit ACBrReg ;

interface
uses Classes, SysUtils, ACBrConsts, ACBrBase,
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

procedure Register ;

implementation

Uses ACBrUtil, ACBrEAD, ACBrAAC ;
{$IFNDEF FPC}
   {$R ACBrComum.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrEAD, TACBrAAC]);

  RegisterPropertyEditor(TypeInfo(TACBrAboutInfo), nil, 'AboutACBr',
     TACBrAboutDialogProperty);
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
  Result := 'http://acbr.sf.net' ;  //ACBrStr( 'Versão: ' + ACBR_VERSAO ) ;
end;

{$IFDEF FPC}
initialization
   {$I ACBrComum.lrs}
{$ENDIF}

end.

