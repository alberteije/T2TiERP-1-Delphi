{*******************************************************************************
Title: T2Ti ERP
Description: VO do movimento.

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
unit MovimentoVO;

interface

type
  TMovimentoVO = class
  private
    FID: Integer;
    FID_ECF_EMPRESA: Integer;
    FID_ECF_TURNO: Integer;
    FID_ECF_IMPRESSORA: Integer;
    FID_ECF_OPERADOR: Integer;
    FID_ECF_CAIXA: Integer;
    FID_GERENTE_SUPERVISOR: Integer;
    FDATA_ABERTURA: String;
    FHORA_ABERTURA: String;
    FDATA_FECHAMENTO: String;
    FHORA_FECHAMENTO: String;
    FTOTAL_SUPRIMENTO: Extended;
    FTOTAL_SANGRIA: Extended;
    FTOTAL_NAO_FISCAL: Extended;
    FTOTAL_VENDA: Extended;
    FTOTAL_DESCONTO: Extended;
    FTOTAL_ACRESCIMO: Extended;
    FTOTAL_FINAL: Extended;
    FTOTAL_RECEBIDO: Extended;
    FTOTAL_TROCO: Extended;
    FTOTAL_CANCELADO: Extended;
    FSTATUS_MOVIMENTO: String;
    FSINCRONIZADO: String;

    FIdentificacaoImpressora: String;
    FDescricaoTurno: String;
    FLoginOperador: String;
    FNomeCaixa: String;

  published

    property Id: Integer read FID write FID;
    property IdEmpresa: Integer read FID_ECF_EMPRESA write FID_ECF_EMPRESA;
    property IdTurno: Integer read FID_ECF_TURNO write FID_ECF_TURNO;
    property IdImpressora: Integer read FID_ECF_IMPRESSORA write FID_ECF_IMPRESSORA;
    property IdOperador: Integer read FID_ECF_OPERADOR write FID_ECF_OPERADOR;
    property IdCaixa: Integer read FID_ECF_CAIXA write FID_ECF_CAIXA;
    property IdGerenteSupervisor: Integer read FID_GERENTE_SUPERVISOR write FID_GERENTE_SUPERVISOR;
    property DataAbertura: String read FDATA_ABERTURA write FDATA_ABERTURA;
    property HoraAbertura: String read FHORA_ABERTURA write FHORA_ABERTURA;
    property DataFechamento: String read FDATA_FECHAMENTO write FDATA_FECHAMENTO;
    property HoraFechamento: String read FHORA_FECHAMENTO write FHORA_FECHAMENTO;
    property TotalSuprimento: Extended read FTOTAL_SUPRIMENTO write FTOTAL_SUPRIMENTO;
    property TotalSangria: Extended read FTOTAL_SANGRIA write FTOTAL_SANGRIA;
    property TotalNaoFiscal: Extended read FTOTAL_NAO_FISCAL write FTOTAL_NAO_FISCAL;
    property TotalVenda: Extended read FTOTAL_VENDA write FTOTAL_VENDA;
    property TotalDesconto: Extended read FTOTAL_DESCONTO write FTOTAL_DESCONTO;
    property TotalAcrescimo: Extended read FTOTAL_ACRESCIMO write FTOTAL_ACRESCIMO;
    property TotalFinal: Extended read FTOTAL_FINAL write FTOTAL_FINAL;
    property TotalRecebido: Extended read FTOTAL_RECEBIDO write FTOTAL_RECEBIDO;
    property TotalTroco: Extended read FTOTAL_TROCO write FTOTAL_TROCO;
    property TotalCancelado: Extended read FTOTAL_CANCELADO write FTOTAL_CANCELADO;
    property Status: String read FSTATUS_MOVIMENTO write FSTATUS_MOVIMENTO;
    property Sincronizado: String read FSINCRONIZADO write FSINCRONIZADO;

    property IdentificacaoImpressora: String read FIdentificacaoImpressora write FIdentificacaoImpressora;
    property DescricaoTurno: String read FDescricaoTurno write FDescricaoTurno;
    property LoginOperador: String read FLoginOperador write FLoginOperador;
    property NomeCaixa: String read FNomeCaixa write FNomeCaixa;

end;

implementation

end.