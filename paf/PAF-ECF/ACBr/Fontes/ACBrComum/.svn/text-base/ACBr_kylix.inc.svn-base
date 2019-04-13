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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Alexandre Rocha Lima e Marcondes -  arlm@users.sourceforge.net               }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 06/04/2005: Primeira Versao
|*    Alexandre Rocha Lima e Marcondes
|*    Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{-----------------------------------------------------------------------------
 *** Extraido de kylix.inc  - Project JEDI Code Library (JCL) ***
 ---------------------------------------------------------------------------- }

//
// Este código é incompatível com o FPC e foi excluído do ACBr.inc  por esta razão
//
// O Kylix 3/C++, por alguma razão, avalia comparações com CompilerVersion como falsas,
// se a constante a ser comparada é um valor de ponto flutuante - estranho.
// O sinal de "+" previne o Kylix/Delphi de regsitrar uma warning sobre comparações
// entre valores com e sem sinal.
//
    {$IF not Declared(CompilerVersion)}
      {$DEFINE KYLIX1}
      {$DEFINE COMPILER6}
      {$DEFINE DELPHICOMPILER6}
      {$DEFINE RTL140_UP}
    {$ELSEIF Declared(CompilerVersion) and (CompilerVersion > +14)}
      {$DEFINE KYLIX2}
      {$DEFINE COMPILER6}
      {$DEFINE DELPHICOMPILER6}
      {$DEFINE RTL142_UP}
    {$ELSEIF Declared(CompilerVersion) and (CompilerVersion < +15)}
      {$DEFINE KYLIX3}
      {$DEFINE COMPILER6}
      {$IFNDEF BCB}
        {$DEFINE DELPHICOMPILER6}
      {$ENDIF}
      {$DEFINE RTL145_UP}
    {$ELSE}
      Adicione uma nova versão de Kylix aqui
    {$IFEND}


