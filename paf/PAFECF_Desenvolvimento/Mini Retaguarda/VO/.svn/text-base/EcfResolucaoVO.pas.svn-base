{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [EcfResolucao]
                                                                                
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
                                                                                
@author  Marcos Leite
@version 1.0
*******************************************************************************}
unit EcfResolucaoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('ECF_RESOLUCAO')]
  TEcfResolucaoVO = class
  private
    FID: Integer;
    FNOME_CAIXA: String;
    FID_GERADO_CAIXA: Integer;
    FID_EMPRESA: Integer;
    FRESOLUCAO_TELA: String;
    FLARGURA: Integer;
    FALTURA: Integer;
    FIMAGEM_TELA: String;
    FIMAGEM_MENU: String;
    FIMAGEM_SUBMENU: String;
    FHOTTRACK_COLOR: String;
    FITEM_STYLE_FONT_NAME: String;
    FITEM_STYLE_FONT_COLOR: String;
    FITEM_SEL_STYLE_COLOR: String;
    FLABEL_TOTAL_GERAL_FONT_COLOR: String;
    FITEM_STYLE_FONT_STYLE: String;
    FEDITS_COLOR: String;
    FEDITS_FONT_COLOR: String;
    FEDITS_DISABLED_COLOR: String;
    FEDITS_FONT_NAME: String;
    FEDITS_FONT_STYLE: String;
    FDATA_SINCRONIZACAO: String;
    FHORA_SINCRONIZACAO: String;

  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('NOME_CAIXA','Nome Caixa',ldGridLookup ,False)]
    property NomeCaixa: String  read FNOME_CAIXA write FNOME_CAIXA;
    [TColumn('ID_GERADO_CAIXA','Id Gerado Caixa',ldGridLookup ,False)]
    property IdGeradoCaixa: Integer  read FID_GERADO_CAIXA write FID_GERADO_CAIXA;
    [TColumn('ID_EMPRESA','Id Empresa',ldGridLookup ,False)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('RESOLUCAO_TELA','Resolucao Tela',ldGridLookup ,False)]
    property ResolucaoTela: String  read FRESOLUCAO_TELA write FRESOLUCAO_TELA;
    [TColumn('LARGURA','Largura',ldGridLookup ,False)]
    property Largura: Integer  read FLARGURA write FLARGURA;
    [TColumn('ALTURA','Altura',ldGridLookup ,False)]
    property Altura: Integer  read FALTURA write FALTURA;
    [TColumn('IMAGEM_TELA','Imagem Tela',ldGridLookup ,False)]
    property ImagemTela: String  read FIMAGEM_TELA write FIMAGEM_TELA;
    [TColumn('IMAGEM_MENU','Imagem Menu',ldGridLookup ,False)]
    property ImagemMenu: String  read FIMAGEM_MENU write FIMAGEM_MENU;
    [TColumn('IMAGEM_SUBMENU','Imagem Submenu',ldGridLookup ,False)]
    property ImagemSubmenu: String  read FIMAGEM_SUBMENU write FIMAGEM_SUBMENU;
    [TColumn('HOTTRACK_COLOR','Hottrack Color',ldGridLookup ,False)]
    property HottrackColor: String  read FHOTTRACK_COLOR write FHOTTRACK_COLOR;
    [TColumn('ITEM_STYLE_FONT_NAME','Item Style Font Name',ldGridLookup ,False)]
    property ItemStyleFontName: String  read FITEM_STYLE_FONT_NAME write FITEM_STYLE_FONT_NAME;
    [TColumn('ITEM_STYLE_FONT_COLOR','Item Style Font Color',ldGridLookup ,False)]
    property ItemStyleFontColor: String  read FITEM_STYLE_FONT_COLOR write FITEM_STYLE_FONT_COLOR;
    [TColumn('ITEM_SEL_STYLE_COLOR','Item Sel Style Color',ldGridLookup ,False)]
    property ItemSelStyleColor: String  read FITEM_SEL_STYLE_COLOR write FITEM_SEL_STYLE_COLOR;
    [TColumn('LABEL_TOTAL_GERAL_FONT_COLOR','Label Total Geral Font Color',ldGridLookup ,False)]
    property LabelTotalGeralFontColor: String  read FLABEL_TOTAL_GERAL_FONT_COLOR write FLABEL_TOTAL_GERAL_FONT_COLOR;
    [TColumn('ITEM_STYLE_FONT_STYLE','Item Style Font Style',ldGridLookup ,False)]
    property ItemStyleFontStyle: String  read FITEM_STYLE_FONT_STYLE write FITEM_STYLE_FONT_STYLE;
    [TColumn('EDITS_COLOR','Edits Color',ldGridLookup ,False)]
    property EditsColor: String  read FEDITS_COLOR write FEDITS_COLOR;
    [TColumn('EDITS_FONT_COLOR','Edits Font Color',ldGridLookup ,False)]
    property EditsFontColor: String  read FEDITS_FONT_COLOR write FEDITS_FONT_COLOR;
    [TColumn('EDITS_DISABLED_COLOR','Edits Disabled Color',ldGridLookup ,False)]
    property EditsDisabledColor: String  read FEDITS_DISABLED_COLOR write FEDITS_DISABLED_COLOR;
    [TColumn('EDITS_FONT_NAME','Edits Font Name',ldGridLookup ,False)]
    property EditsFontName: String  read FEDITS_FONT_NAME write FEDITS_FONT_NAME;
    [TColumn('EDITS_FONT_STYLE','Edits Font Style',ldGridLookup ,False)]
    property EditsFontStyle: String  read FEDITS_FONT_STYLE write FEDITS_FONT_STYLE;
    [TColumn('DATA_SINCRONIZACAO','Data Sincronizacao',ldGridLookup ,False)]
    property DataSincronizacao: String  read FDATA_SINCRONIZACAO write FDATA_SINCRONIZACAO;
    [TColumn('HORA_SINCRONIZACAO','Hora Sincronizacao',ldGridLookup ,False)]
    property HoraSincronizacao: String  read FHORA_SINCRONIZACAO write FHORA_SINCRONIZACAO;

  end;

implementation



end.
