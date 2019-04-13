{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [EcfPosicaoComponentes]
                                                                                
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
unit EcfPosicaoComponentesVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('ECF_POSICAO_COMPONENTES')]
  TEcfPosicaoComponentesVO = class
  private
    FID: Integer;
    FNOME_CAIXA: String;
    FID_GERADO_CAIXA: Integer;
    FID_EMPRESA: Integer;
    FNOME: String;
    FALTURA: Integer;
    FLARGURA: Integer;
    FTOPO: Integer;
    FESQUERDA: Integer;
    FTAMANHO_FONTE: Integer;
    FTEXTO: String;
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
    [TColumn('NOME','Nome',ldGridLookup ,False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('ALTURA','Altura',ldGridLookup ,False)]
    property Altura: Integer  read FALTURA write FALTURA;
    [TColumn('LARGURA','Largura',ldGridLookup ,False)]
    property Largura: Integer  read FLARGURA write FLARGURA;
    [TColumn('TOPO','Topo',ldGridLookup ,False)]
    property Topo: Integer  read FTOPO write FTOPO;
    [TColumn('ESQUERDA','Esquerda',ldGridLookup ,False)]
    property Esquerda: Integer  read FESQUERDA write FESQUERDA;
    [TColumn('TAMANHO_FONTE','Tamanho Fonte',ldGridLookup ,False)]
    property TamanhoFonte: Integer  read FTAMANHO_FONTE write FTAMANHO_FONTE;
    [TColumn('TEXTO','Texto',ldGridLookup ,False)]
    property Texto: String  read FTEXTO write FTEXTO;
    [TColumn('DATA_SINCRONIZACAO','Data Sincronizacao',ldGridLookup ,False)]
    property DataSincronizacao: String  read FDATA_SINCRONIZACAO write FDATA_SINCRONIZACAO;
    [TColumn('HORA_SINCRONIZACAO','Hora Sincronizacao',ldGridLookup ,False)]
    property HoraSincronizacao: String  read FHORA_SINCRONIZACAO write FHORA_SINCRONIZACAO;

  end;

implementation



end.
