////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar CTe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da CTe          //
//                                                                            //
//        site: www.projetocooperar.org/CTe                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_CTe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordenação: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//      Versão: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licença: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa é software livre; você pode redistribuí-lo    //
//              e/ou modificá-lo sob os termos da Licença Pública Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              versão 2 da Licença como (a seu critério) qualquer versão     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa é distribuído na expectativa de ser útil,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia implícita de  //
//              COMERCIALIZAÇÃO ou de ADEQUAÇÃO A QUALQUER PROPÓSITO EM       //
//              PARTICULAR. Consulte a Licença Pública Geral GNU para obter   //
//              mais detalhes. Você deve ter recebido uma cópia da Licença    //
//              Pública Geral GNU junto com este programa; se não, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licença oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licença  não  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  CTe", não  podendo o mesmo ser    //
//              utilizado sem previa autorização.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manutenção deste cabeçalho junto ao código     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{$I ACBr.inc}

unit pcteCTeR;

interface uses

  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnLeitor, pcteCTe;

type

  TCTeR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FCTe: TCTe;
    FSchema: TpcnSchema;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property CTe: TCTe read FCTe write FCTe;
    property schema: TpcnSchema read Fschema write Fschema;
  end;

  ////////////////////////////////////////////////////////////////////////////////

implementation

{ TCTeR }

constructor TCTeR.Create(AOwner: TCTe);
begin
  FLeitor := TLeitor.Create;
  FCTe := AOwner;
end;

destructor TCTeR.Destroy;
begin
  FLeitor.Free;
  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////

function TCTeR.LerXml: boolean;
var
  ok: boolean;
  i, j, i01, i02, i03: integer;
  sCST: String;
begin

  I := 0;
  I := RetornarPosEx('Id=', Leitor.Arquivo, I + 6);
  if I = 0 then
    raise Exception.Create('Não encontrei inicio do URI: Id=');

  I := RetornarPosEx('"', Leitor.Arquivo, I + 2);
  if I = 0 then
    raise Exception.Create('Não encontrei inicio do URI: aspas inicial');

  J := RetornarPosEx('"', Leitor.Arquivo, I + 1);
  if J = 0 then
    raise Exception.Create('Não encontrei inicio do URI: aspas final');

  // CTe.infCTe.ID := copy(Leitor.Arquivo, I + 4, J - I - 4);
  CTe.infCTe.ID := copy(Leitor.Arquivo, I + 1, J - I -1);

  (* Grupo da TAG <ide> *******************************************************)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    (*B02*)CTe.Ide.cUF      := Leitor.rCampo(tcInt, 'cUF');
    (*B03*)CTe.Ide.cCT      := Leitor.rCampo(tcStr, 'cCT');
    (*B04*)CTe.Ide.CFOP     := Leitor.rCampo(tcStr, 'CFOP');
    (*B05*)CTe.Ide.natOp    := Leitor.rCampo(tcStr, 'natOp');
    (*B06*)CTe.Ide.forPag   := StrTotpforPag(ok, Leitor.rCampo(tcStr, 'forPag'));
    (*B07*)CTe.Ide.modelo   := Leitor.rCampo(tcStr, 'mod');
    (*B08*)CTe.Ide.serie    := Leitor.rCampo(tcInt, 'serie');
    (*B09*)CTe.Ide.nCT      := Leitor.rCampo(tcInt, 'nCT');
    (*B10*)CTe.Ide.dhEmi    := Leitor.rCampo(tcDatHor, 'dhEmi');
    (*B11*)CTe.Ide.tpImp    := StrToTpImp(ok, Leitor.rCampo(tcStr, 'tpImp'));
    (*B12*)CTe.Ide.tpEmis   := StrToTpEmis(ok, Leitor.rCampo(tcStr, 'tpEmis'));
    (*B13*)CTe.Ide.cDV      := Leitor.rCampo(tcInt, 'cDV');
    (*B14*)CTe.Ide.tpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
    (*B15*)CTe.Ide.tpCTe    := StrTotpCTe(ok, Leitor.rCampo(tcStr, 'tpCTe'));
    (*B15a*)CTe.Ide.procEmi := StrToprocEmi(ok, Leitor.rCampo(tcStr, 'procEmi'));
    (*B15b*)CTe.Ide.verProc := Leitor.rCampo(tcStr, 'verProc');
    (*B15c*)CTe.Ide.refCTE  := Leitor.rCampo(tcStr, 'refCTE');
  {$IFDEF PL_103}
    (*B16*)CTe.Ide.cMunEmi  := Leitor.rCampo(tcInt, 'cMunEmi');
    (*B17*)CTe.Ide.xMunEmi  := Leitor.rCampo(tcStr, 'xMunEmi');
    (*B18*)CTe.Ide.UFEmi    := Leitor.rCampo(tcStr, 'UFEmi');
  {$ENDIF}
  {$IFDEF PL_104}
    (*B16*)CTe.Ide.cMunEnv  := Leitor.rCampo(tcInt, 'cMunEnv');
    (*B17*)CTe.Ide.xMunEnv  := Leitor.rCampo(tcStr, 'xMunEnv');
    (*B18*)CTe.Ide.UFEnv    := Leitor.rCampo(tcStr, 'UFEnv');
  {$ENDIF}
    (*B19*)CTe.Ide.modal    := StrToTpModal(ok, Leitor.rCampo(tcStr, 'modal'));
    (*B20*)CTe.Ide.tpServ   := StrToTpServ(ok, Leitor.rCampo(tcStr, 'tpServ'));
    (*B21*)CTe.Ide.cMunIni  := Leitor.rCampo(tcInt, 'cMunIni');
    (*B22*)CTe.Ide.xMunIni  := Leitor.rCampo(tcStr, 'xMunIni');
    (*B23*)CTe.Ide.UFIni    := Leitor.rCampo(tcStr, 'UFIni');
    (*B24*)CTe.Ide.cMunFim  := Leitor.rCampo(tcInt, 'cMunFim');
    (*B25*)CTe.Ide.xMunFim  := Leitor.rCampo(tcStr, 'xMunFim');
    (*B26*)CTe.Ide.UFFim    := Leitor.rCampo(tcStr, 'UFFim');
    (*B27*)CTe.Ide.retira   := StrToTpRetira(ok, Leitor.rCampo(tcStr, 'retira'));

    (*B27a*)CTe.Ide.xdetretira := Leitor.rCampo(tcStr, 'xdetretira');
  {$IFDEF PL_104}
    (*#57*)CTe.Ide.dhCont := Leitor.rCampo(tcDatHor, 'dhCont');
    (*#58*)CTe.Ide.xJust  := Leitor.rCampo(tcStr, 'xJust');
  {$ENDIF}
  end;

  (* Grupo da TAG <ide><toma03> ***********************************************)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    if Leitor.rExtrai(2, 'toma03') <> '' then
    begin
      (*B29*)CTe.Ide.Toma03.Toma := StrToTpTomador(ok, Leitor.rCampo(tcStr, 'toma'));
    end;
  end;

  (* Grupo da TAG <ide><toma4> ************************************************)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    if Leitor.rExtrai(2, 'toma4') <> '' then
    begin
      (*B29*)CTe.Ide.Toma4.toma    := StrToTpTomador(ok, Leitor.rCampo(tcStr, 'toma'));
      (*B31*)CTe.Ide.Toma4.CNPJCPF := Leitor.rCampoCNPJCPF;
      (*B33*)CTe.Ide.Toma4.IE      := Leitor.rCampo(tcStr, 'IE');
      (*B34*)CTe.Ide.Toma4.xNome   := Leitor.rCampo(tcStr, 'xNome');
      (*B35*)CTe.Ide.Toma4.xFant   := Leitor.rCampo(tcStr, 'xFant');
  {$IFDEF PL_104}
      (*#56*)CTe.Ide.Toma4.email   := Leitor.rCampo(tcStr, 'email');
  {$ENDIF}

       if Leitor.rExtrai(3, 'enderToma') <> '' then
       begin
         (*B37*)CTe.Ide.Toma4.EnderToma.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
         (*B37*)CTe.Ide.Toma4.EnderToma.xNum    := Leitor.rCampo(tcStr, 'nro');
         (*B37*)CTe.Ide.Toma4.EnderToma.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
         (*B37*)CTe.Ide.Toma4.EnderToma.xBairro := Leitor.rCampo(tcStr, 'xBairro');
         (*B37*)CTe.Ide.Toma4.EnderToma.cMun    := Leitor.rCampo(tcInt, 'cMun');
         (*B37*)CTe.Ide.Toma4.EnderToma.xMun    := Leitor.rCampo(tcStr, 'xMun');
         (*B37*)CTe.Ide.Toma4.EnderToma.CEP     := Leitor.rCampo(tcInt, 'CEP');
         (*B37*)CTe.Ide.Toma4.EnderToma.UF      := Leitor.rCampo(tcStr, 'UF');
         (*B37*)CTe.Ide.Toma4.EnderToma.cPais   := Leitor.rCampo(tcInt, 'cPais');
         (*B37*)CTe.Ide.Toma4.EnderToma.xPais   := Leitor.rCampo(tcStr, 'xPais');
       end;
    end;
  end;

  (* Grupo da TAG <compl> *****************************************************)
  if Leitor.rExtrai(1, 'compl') <> '' then
  begin
    CTe.Compl.xCaracAd  := Leitor.rCampo(tcstr,'xCaracAd');
    CTe.Compl.xCaracSer := Leitor.rCampo(tcstr,'xCaracSer');
    CTe.Compl.xEmi      := Leitor.rCampo(tcstr,'xEmi');
    CTe.Compl.origCalc  := Leitor.rCampo(tcstr,'origCalc');
    CTe.Compl.destCalc  := Leitor.rCampo(tcstr,'destCalc');
    CTe.Compl.xObs      := Leitor.rCampo(tcstr,'xObs');

    if Leitor.rExtrai(2, 'fluxo') <> '' then
    begin
      CTe.Compl.fluxo.xOrig := Leitor.rCampo(tcstr,'xOrig');
      CTe.Compl.fluxo.xDest := Leitor.rCampo(tcstr,'xDest');
      CTe.Compl.fluxo.xRota := Leitor.rCampo(tcstr,'xRota');

      i01 := 0;
      while Leitor.rExtrai(3, 'pass', '', i01 + 1) <> '' do
      begin
        CTe.Compl.fluxo.pass.Add;
        CTe.Compl.fluxo.pass[i01].xPass := Leitor.rCampo(tcStr, 'xPass');
        inc(i01);
      end;
    end;

    if Leitor.rExtrai(2, 'Entrega') <> '' then
    begin
      if Leitor.rExtrai(3, 'semData') <> '' then
      begin
        CTe.Compl.Entrega.semData.tpPer := StrToTpDataPeriodo(ok, Leitor.rCampo(tcStr, 'tpPer'));
      end;

      if Leitor.rExtrai(3, 'comData') <> '' then
      begin
        CTe.Compl.Entrega.comData.tpPer := StrToTpDataPeriodo(ok, Leitor.rCampo(tcStr, 'tpPer'));
        CTe.Compl.Entrega.comData.dProg := Leitor.rCampo(tcDat, 'dProg');
      end;

      if Leitor.rExtrai(3, 'noPeriodo') <> '' then
      begin
        CTe.Compl.Entrega.noPeriodo.tpPer := StrToTpDataPeriodo(ok, Leitor.rCampo(tcStr, 'tpPer'));
        CTe.Compl.Entrega.noPeriodo.dIni  := Leitor.rCampo(tcDat, 'dIni');
        CTe.Compl.Entrega.noPeriodo.dFim  := Leitor.rCampo(tcDat, 'dFim');
      end;

      if Leitor.rExtrai(3, 'semHora') <> '' then
      begin
        CTe.Compl.Entrega.semHora.tpHor := StrToTpHorarioIntervalo(ok, Leitor.rCampo(tcStr, 'tpHor'));
      end;

      if Leitor.rExtrai(3, 'comHora') <> '' then
      begin
        CTe.Compl.Entrega.comHora.tpHor := StrToTpHorarioIntervalo(ok, Leitor.rCampo(tcStr, 'tpHor'));
        CTe.Compl.Entrega.comHora.hProg := StrToTime(Leitor.rCampo(tcStr, 'hProg'));
      end;

      if Leitor.rExtrai(3, 'noInter') <> '' then
      begin
        CTe.Compl.Entrega.noInter.tpHor := StrToTpHorarioIntervalo(ok, Leitor.rCampo(tcStr, 'tpHor'));
        CTe.Compl.Entrega.noInter.hIni  := StrToTime(Leitor.rCampo(tcStr, 'hIni'));
        CTe.Compl.Entrega.noInter.hFim  := StrToTime(Leitor.rCampo(tcStr, 'hFim'));
      end;
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'ObsCont', '', i01 + 1) <> '' do
    begin
      I := 0;
      I := RetornarPosEx('ObsCont xCampo=', Leitor.Arquivo, I + 1);
      J := RetornarPosEx('"', Leitor.Arquivo, I + 16);
      CTe.Compl.ObsCont.Add;
//      CTe.Compl.ObsCont[i01].xCampo := copy(Leitor.Arquivo, I + 16, J - (I + 16) - 1);
      // Alterado por Italo em 29/08/2011 conforme erro apontado por Doni Delphi
      CTe.Compl.ObsCont[i01].xCampo := copy(Leitor.Arquivo, I + 16, J - (I + 16));
      CTe.Compl.ObsCont[i01].xTexto := Leitor.rCampo(tcstr,'xTexto');
      inc(i01);
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'ObsFisco', '', i01 + 1) <> '' do
    begin
      I := 0;
      I := RetornarPosEx('ObsFisco xCampo=', Leitor.Arquivo, I + 1);
      J := RetornarPosEx('"', Leitor.Arquivo, I + 17);
      CTe.Compl.ObsFisco.Add;
//      CTe.Compl.ObsFisco[i01].xCampo := copy(Leitor.Arquivo, I + 17, J - (I + 17) - 1);
      // Alterado por Italo em 29/08/2011 conforme erro apontado por Doni Delphi
      CTe.Compl.ObsFisco[i01].xCampo := copy(Leitor.Arquivo, I + 17, J - (I + 17));
      CTe.Compl.ObsFisco[i01].xTexto := Leitor.rCampo(tcstr,'xTexto');
      inc(i01);
    end;
  end;

  (* Grupo da TAG <emit> ******************************************************)
  if Leitor.rExtrai(1, 'emit') <> '' then
  begin
    CTe.emit.CNPJ  := Leitor.rCampo(tcStr,'CNPJ');
    CTe.emit.IE    := Leitor.rCampo(tcStr, 'IE');
    CTe.emit.xNome := Leitor.rCampo(tcStr, 'xNome');
    CTe.emit.xFant := Leitor.rCampo(tcStr, 'xFant');

    if Leitor.rExtrai(2, 'enderEmit') <> '' then
    begin
      CTe.emit.enderemit.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.emit.enderemit.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.emit.enderemit.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.emit.enderemit.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.emit.enderemit.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.emit.enderemit.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.emit.enderemit.CEP     := Leitor.rCampo(tcInt, 'CEP');
      CTe.emit.enderemit.UF      := Leitor.rCampo(tcStr, 'UF');
  {$IFDEF PL_103}
      CTe.emit.enderemit.cPais   := Leitor.rCampo(tcInt, 'cPais');
      CTe.emit.enderemit.xPais   := Leitor.rCampo(tcStr, 'xPais');
  {$ENDIF}
      CTe.emit.enderemit.fone    := Leitor.rCampo(tcStr, 'fone');
    end;
  end;

  (* Grupo da TAG <rem> *******************************************************)
  if Leitor.rExtrai(1, 'rem') <> '' then
  begin
    CTe.Rem.CNPJCPF := Leitor.rCampoCNPJCPF;
    CTe.Rem.IE      := Leitor.rCampo(tcStr, 'IE');
    CTe.Rem.xNome   := Leitor.rCampo(tcStr, 'xNome');
    CTe.Rem.xFant   := Leitor.rCampo(tcStr, 'xFant');
    CTe.Rem.fone    := Leitor.rCampo(tcStr, 'fone');
  {$IFDEF PL_104}
    CTe.Rem.email   := Leitor.rCampo(tcStr, 'email');
  {$ENDIF}

    if Leitor.rExtrai(2, 'enderReme') <> '' then
    begin
      CTe.Rem.enderReme.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.Rem.enderReme.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.Rem.enderReme.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.Rem.enderReme.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.Rem.enderReme.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.Rem.enderReme.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.Rem.enderReme.CEP     := Leitor.rCampo(tcInt, 'CEP');
      CTe.Rem.enderReme.UF      := Leitor.rCampo(tcStr, 'UF');
      CTe.Rem.enderReme.cPais   := Leitor.rCampo(tcInt, 'cPais');
      CTe.Rem.enderReme.xPais   := Leitor.rCampo(tcStr, 'xPais');
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'infNF', '', i01 + 1) <> '' do
    begin
      CTe.Rem.InfNF.Add;
      CTe.Rem.InfNF[i01].nRoma := Leitor.rCampo(tcStr, 'nRoma');
      CTe.Rem.InfNF[i01].nPed  := Leitor.rCampo(tcStr, 'nPed');
  {$IFDEF PL_104}
      CTe.Rem.InfNF[i01].Modelo := StrToModeloNF(Ok, Leitor.rCampo(tcStr, 'mod'));
  {$ENDIF}
      CTe.Rem.InfNF[i01].serie := Leitor.rCampo(tcStr, 'serie');
      CTe.Rem.InfNF[i01].nDoc  := Leitor.rCampo(tcEsp, 'nDoc');
      CTe.Rem.InfNF[i01].dEmi  := Leitor.rCampo(tcDat, 'dEmi');
      CTe.Rem.InfNF[i01].vBC   := Leitor.rCampo(tcDe2, 'vBC');
      CTe.Rem.InfNF[i01].vICMS := Leitor.rCampo(tcDe2, 'vICMS');
      CTe.Rem.InfNF[i01].vBCST := Leitor.rCampo(tcDe2, 'vBCST');
      CTe.Rem.InfNF[i01].vST   := Leitor.rCampo(tcDe2, 'vST');
      CTe.Rem.InfNF[i01].vProd := Leitor.rCampo(tcDe2, 'vProd');
      CTe.Rem.InfNF[i01].vNF   := Leitor.rCampo(tcDe2, 'vNF');
      CTe.Rem.InfNF[i01].nCFOP := Leitor.rCampo(tcInt, 'nCFOP');
      CTe.Rem.InfNF[i01].nPeso := Leitor.rCampo(tcDe3, 'nPeso');
      CTe.Rem.InfNF[i01].PIN   := Leitor.rCampo(tcStr, 'PIN');

      if Leitor.rExtrai(3, 'locRet') <> '' then
      begin
        CTe.Rem.InfNF[i01].locRet.CNPJCPF := Leitor.rCampoCNPJCPF;
        CTe.Rem.InfNF[i01].locRet.xNome   := Leitor.rCampo(tcStr, 'xNome');
        CTe.Rem.InfNF[i01].locRet.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
        CTe.Rem.InfNF[i01].locRet.Nro     := Leitor.rCampo(tcStr, 'nro');
        CTe.Rem.InfNF[i01].locRet.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
        CTe.Rem.InfNF[i01].locRet.xBairro := Leitor.rCampo(tcStr, 'xBairro');
        CTe.Rem.InfNF[i01].locRet.cMun    := Leitor.rCampo(tcInt, 'cMun');
        CTe.Rem.InfNF[i01].locRet.xMun    := Leitor.rCampo(tcStr, 'xMun');
        CTe.Rem.InfNF[i01].locRet.UF      := Leitor.rCampo(tcStr, 'UF');
      end;
      inc(i01);
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'infNFe', '', i01 + 1) <> '' do
    begin
      CTe.Rem.InfNFE.Add;
      CTe.Rem.InfNFE[i01].chave := Leitor.rCampo(tcStr, 'chave');
      CTe.Rem.InfNFE[i01].PIN   := Leitor.rCampo(tcStr, 'PIN');
      inc(i01);
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'infOutros', '', i01 + 1) <> '' do
    begin
      CTe.Rem.InfOutros.Add;
      CTe.Rem.InfOutros[i01].tpDoc      := StrToTpDocumento(ok, Leitor.rCampo(tcStr, 'tpDoc'));
      CTe.Rem.InfOutros[i01].descOutros := Leitor.rCampo(tcStr, 'descOutros');
      CTe.Rem.InfOutros[i01].nDoc       := Leitor.rCampo(tcStr, 'nDoc');
      CTe.Rem.InfOutros[i01].dEmi       := Leitor.rCampo(tcDat, 'dEmi');
      CTe.Rem.InfOutros[i01].vDocFisc   := Leitor.rCampo(tcDe2, 'vDocFisc');
      inc(i01);
    end;
  end;

  (* Grupo da TAG <exped> *****************************************************)
  if Leitor.rExtrai(1, 'exped') <> '' then
  begin
    CTe.Exped.CNPJCPF := Leitor.rCampoCNPJCPF;
    CTe.Exped.IE      := Leitor.rCampo(tcStr, 'IE');
    CTe.Exped.xNome   := Leitor.rCampo(tcStr, 'xNome');
    CTe.Exped.fone    := Leitor.rCampo(tcStr, 'fone');
  {$IFDEF PL_104}
    CTe.Exped.email   := Leitor.rCampo(tcStr, 'email');
  {$ENDIF}

    if Leitor.rExtrai(2, 'enderExped') <> '' then
    begin
      CTe.Exped.EnderExped.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.Exped.EnderExped.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.Exped.EnderExped.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.Exped.EnderExped.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.Exped.EnderExped.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.Exped.EnderExped.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.Exped.EnderExped.CEP     := Leitor.rCampo(tcInt, 'CEP');
      CTe.Exped.EnderExped.UF      := Leitor.rCampo(tcStr, 'UF');
      CTe.Exped.EnderExped.cPais   := Leitor.rCampo(tcInt, 'cPais');
      CTe.Exped.EnderExped.xPais   := Leitor.rCampo(tcStr, 'xPais');
    end;
  end;

  (* Grupo da TAG <receb> *****************************************************)
  if Leitor.rExtrai(1, 'receb') <> '' then
  begin
    CTe.receb.CNPJCPF := Leitor.rCampoCNPJCPF;
    CTe.receb.IE      := Leitor.rCampo(tcStr, 'IE');
    CTe.receb.xNome   := Leitor.rCampo(tcStr, 'xNome');
    CTe.receb.fone    := Leitor.rCampo(tcStr, 'fone');
  {$IFDEF PL_104}
    CTe.receb.email   := Leitor.rCampo(tcStr, 'email');
  {$ENDIF}

    if Leitor.rExtrai(2, 'enderReceb') <> '' then
    begin
      CTe.receb.Enderreceb.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.receb.Enderreceb.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.receb.Enderreceb.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.receb.Enderreceb.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.receb.Enderreceb.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.receb.Enderreceb.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.receb.Enderreceb.CEP     := Leitor.rCampo(tcInt, 'CEP');
      CTe.receb.Enderreceb.UF      := Leitor.rCampo(tcStr, 'UF');
      CTe.receb.Enderreceb.cPais   := Leitor.rCampo(tcInt, 'cPais');
      CTe.receb.Enderreceb.xPais   := Leitor.rCampo(tcStr, 'xPais');
    end;
  end;

  (* Grupo da TAG <dest> ******************************************************)
  if Leitor.rExtrai(1, 'dest') <> '' then
  begin
    CTe.Dest.CNPJCPF := Leitor.rCampoCNPJCPF;
    CTe.Dest.IE      := Leitor.rCampo(tcStr, 'IE');
    CTe.Dest.xNome   := Leitor.rCampo(tcStr, 'xNome');
    CTe.Dest.fone    := Leitor.rCampo(tcStr, 'fone');
  {$IFDEF PL_104}
    CTe.Dest.email   := Leitor.rCampo(tcStr, 'email');
  {$ENDIF}

    if Leitor.rExtrai(2, 'enderDest') <> '' then
    begin
      CTe.Dest.EnderDest.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.Dest.EnderDest.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.Dest.EnderDest.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.Dest.EnderDest.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.Dest.EnderDest.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.Dest.EnderDest.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.Dest.EnderDest.CEP     := Leitor.rCampo(tcInt, 'CEP');
      CTe.Dest.EnderDest.UF      := Leitor.rCampo(tcStr, 'UF');
      CTe.Dest.EnderDest.cPais   := Leitor.rCampo(tcInt, 'cPais');
      CTe.Dest.EnderDest.xPais   := Leitor.rCampo(tcStr, 'xPais');
    end;

    if Leitor.rExtrai(2, 'locEnt') <> '' then
    begin
      CTe.Dest.locEnt.CNPJCPF := Leitor.rCampoCNPJCPF;
      CTe.Dest.locEnt.xNome   := Leitor.rCampo(tcStr, 'xNome');
      CTe.Dest.locEnt.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.Dest.locEnt.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.Dest.locEnt.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.Dest.locEnt.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.Dest.locEnt.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.Dest.locEnt.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.Dest.locEnt.UF      := Leitor.rCampo(tcStr, 'UF');
    end;
  end;

  (* Grupo da TAG <vPrest> ****************************************************)
  if Leitor.rExtrai(1, 'vPrest') <> '' then
  begin
    CTe.vPrest.vTPrest := Leitor.rCampo(tcDe2,'vTPrest');
    CTe.vPrest.vRec    := Leitor.rCampo(tcDe2,'vRec');

    i01 := 0;
    while Leitor.rExtrai(2, 'Comp', '', i01 + 1) <> '' do
    begin
      CTe.vPrest.Comp.Add;
      CTe.vPrest.Comp[i01].xNome := Leitor.rCampo(tcStr, 'xNome');
      CTe.vPrest.Comp[i01].vComp := Leitor.rCampo(tcDe2, 'vComp');
      inc(i01);
    end;
  end;

  (* Grupo da TAG <imp> *******************************************************)
  if Leitor.rExtrai(1, 'imp') <> '' then
  begin
    if Leitor.rExtrai(2, 'ICMS') <> '' then
    begin
    {$IFDEF PL_103}
      if Leitor.rExtrai(3, 'CST00') <> '' then
    {$ENDIF}
    {$IFDEF PL_104}
      if Leitor.rExtrai(3, 'ICMS00') <> '' then
    {$ENDIF}
      begin
        if Leitor.rCampo(tcStr,'CST')='00'
        then begin
          CTe.Imp.ICMS.SituTrib    := cst00;
          CTe.Imp.ICMS.CST00.CST   := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.CST00.vBC   := Leitor.rCampo(tcDe2,'vBC');
          CTe.Imp.ICMS.CST00.pICMS := Leitor.rCampo(tcDe2,'pICMS');
          CTe.Imp.ICMS.CST00.vICMS := Leitor.rCampo(tcDe2,'vICMS');
        end;
      end;

    {$IFDEF PL_103}
      if Leitor.rExtrai(3, 'CST20') <> '' then
    {$ENDIF}
    {$IFDEF PL_104}
      if Leitor.rExtrai(3, 'ICMS20') <> '' then
    {$ENDIF}
      begin
        if Leitor.rCampo(tcStr,'CST')='20'
        then begin
          CTe.Imp.ICMS.SituTrib     := cst20;
          CTe.Imp.ICMS.CST20.CST    := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.CST20.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
          CTe.Imp.ICMS.CST20.vBC    := Leitor.rCampo(tcDe2,'vBC');
          CTe.Imp.ICMS.CST20.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
          CTe.Imp.ICMS.CST20.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
        end;
      end;

    {$IFDEF PL_103}
      if Leitor.rExtrai(3, 'CST45') <> '' then
    {$ENDIF}
    {$IFDEF PL_104}
      if Leitor.rExtrai(3, 'ICMS45') <> '' then
    {$ENDIF}
      begin
        sCST:=Leitor.rCampo(tcStr,'CST');
        if (sCST='40') or (sCST='41') or (sCST='51')
        then begin
          if sCST='40' then CTe.Imp.ICMS.SituTrib  := cst40;
          if sCST='41' then CTe.Imp.ICMS.SituTrib  := cst41;
          if sCST='51' then CTe.Imp.ICMS.SituTrib  := cst51;
          CTe.Imp.ICMS.CST45.CST := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
        end;
      end;

    {$IFDEF PL_104}
      if Leitor.rExtrai(3, 'ICMS60') <> '' then
      begin
        if Leitor.rCampo(tcStr,'CST')='60'
        then begin
          CTe.Imp.ICMS.SituTrib         := cst60;
          CTe.Imp.ICMS.CST60.CST        := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.CST60.vBCSTRet   := Leitor.rCampo(tcDe2,'vBCSTRet');
          CTe.Imp.ICMS.CST60.vICMSSTRet := Leitor.rCampo(tcDe2,'vICMSSTRet');
          CTe.Imp.ICMS.CST60.pICMSSTRet := Leitor.rCampo(tcDe2,'pICMSSTRet');
          CTe.Imp.ICMS.CST60.vCred      := Leitor.rCampo(tcDe2,'vCred');
        end;
      end;
    {$ENDIF}

      if Leitor.rExtrai(3, 'CST80') <> '' then
      begin
        if Leitor.rCampo(tcStr,'CST')='90'
        then begin
          // Responsabilidade do recolhimento do ICMS atribuído ao tomador ou 3o por ST
          CTe.Imp.ICMS.SituTrib    := cst80;
          CTe.Imp.ICMS.CST80.CST   := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.CST80.vBC   := Leitor.rCampo(tcDe2,'vBC');
          CTe.Imp.ICMS.CST80.pICMS := Leitor.rCampo(tcDe2,'pICMS');
          CTe.Imp.ICMS.CST80.vICMS := Leitor.rCampo(tcDe2,'vICMS');
          CTe.Imp.ICMS.CST80.vCred := Leitor.rCampo(tcDe2,'vCred');
        end;
      end;

      if Leitor.rExtrai(3, 'CST81') <> '' then
      begin
        if Leitor.rCampo(tcStr,'CST')='90'
        then begin
          // ICMS devido à Outra UF
          CTe.Imp.ICMS.SituTrib     := cst81;
          CTe.Imp.ICMS.CST81.CST    := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.CST81.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
          CTe.Imp.ICMS.CST81.vBC    := Leitor.rCampo(tcDe2,'vBC');
          CTe.Imp.ICMS.CST81.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
          CTe.Imp.ICMS.CST81.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
        end;
      end;

    {$IFDEF PL_103}
      if Leitor.rExtrai(3, 'CST90') <> '' then
    {$ENDIF}
    {$IFDEF PL_104}
      if Leitor.rExtrai(3, 'ICMS90') <> '' then
    {$ENDIF}
      begin
        if Leitor.rCampo(tcStr,'CST')='90'
        then begin
          CTe.Imp.ICMS.SituTrib     := cst90;
          CTe.Imp.ICMS.CST90.CST    := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.CST90.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
          CTe.Imp.ICMS.CST90.vBC    := Leitor.rCampo(tcDe2,'vBC');
          CTe.Imp.ICMS.CST90.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
          CTe.Imp.ICMS.CST90.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
          CTe.Imp.ICMS.CST90.vCred  := Leitor.rCampo(tcDe2,'vCred');
        end;
      end;

      if Leitor.rExtrai(3, 'ICMSOutraUF') <> '' then
      begin
        if Leitor.rCampo(tcStr,'CST')='90'
        then begin
          // ICMS devido à UF de origem da prestação, quando diferente da UF do emitente
          CTe.Imp.ICMS.SituTrib                  := cstICMSOutraUF;
          CTe.Imp.ICMS.ICMSOutraUF.CST           := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.ICMSOutraUF.pRedBCOutraUF := Leitor.rCampo(tcDe2,'pRedBCOutraUF');
          CTe.Imp.ICMS.ICMSOutraUF.vBCOutraUF    := Leitor.rCampo(tcDe2,'vBCOutraUF');
          CTe.Imp.ICMS.ICMSOutraUF.pICMSOutraUF  := Leitor.rCampo(tcDe2,'pICMSOutraUF');
          CTe.Imp.ICMS.ICMSOutraUF.vICMSOutraUF  := Leitor.rCampo(tcDe2,'vICMSOutraUF');
        end;
      end;

      if Leitor.rExtrai(3, 'ICMSSN') <> '' then
      begin
       // ICMS Simples Nacional
       CTe.Imp.ICMS.SituTrib     := cstICMSSN;
       CTe.Imp.ICMS.ICMSSN.indSN := Leitor.rCampo(tcInt,'indSN');
      end;

    end;
  end;

  (* Grupo da TAG <infCTeNorm> ************************************************)
  if Leitor.rExtrai(1, 'infCTeNorm') <> '' then
  begin
    if Leitor.rExtrai(2, 'infCarga') <> ''
    then begin
  {$IFDEF PL_103}
      CTe.InfCarga.vMerc   := Leitor.rCampo(tcDe2,'vMerc');
  {$ENDIF}
  {$IFDEF PL_104}
      CTe.InfCarga.vCarga   := Leitor.rCampo(tcDe2,'vCarga');
  {$ENDIF}
      CTe.InfCarga.proPred := Leitor.rCampo(tcStr,'proPred');
      CTe.InfCarga.xOutCat := Leitor.rCampo(tcStr,'xOutCat');
    end;

    i01 := 0;
    while Leitor.rExtrai(3, 'infQ', '', i01 + 1) <> '' do
    begin
      CTe.InfCarga.infQ.Add;
      CTe.InfCarga.infQ[i01].cUnid  := Leitor.rCampo(tcStr, 'cUnid');
      CTe.InfCarga.infQ[i01].tpMed  := Leitor.rCampo(tcStr, 'tpMed');
      CTe.InfCarga.infQ[i01].qCarga := Leitor.rCampo(tcDe4, 'qCarga');
      inc(i01);
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'contQt', '', i01 + 1) <> '' do
    begin
      CTe.infCTeNorm.contQt.Add;
      CTe.infCTeNorm.contQt[i01].nCont := Leitor.rCampo(tcInt, 'nCont');

      i02 := 0;
      while Leitor.rExtrai(3, 'lacContQt', '', i02 + 1) <> '' do
      begin
        CTe.infCTeNorm.contQt[i01].lacContQt.Add;
        CTe.infCTeNorm.contQt[i01].lacContQt[i02].nLacre := Leitor.rCampo(tcStr, 'nLacre');
        inc(i02);
      end;

      CTe.infCTeNorm.contQt[i01].dPrev := Leitor.rCampo(tcDat, 'dPrev');
      inc(i01);
    end;

    if Leitor.rExtrai(2, 'docAnt') <> ''
    then begin
      i01 := 0;
      while Leitor.rExtrai(3, 'emiDocAnt', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.emiDocAnt.Add;
        CTe.infCTeNorm.emiDocAnt[i01].CNPJCPF := Leitor.rCampoCNPJCPF;
        CTe.infCTeNorm.emiDocAnt[i01].IE      := Leitor.rCampo(tcStr, 'IE');
        CTe.infCTeNorm.emiDocAnt[i01].UF      := Leitor.rCampo(tcStr, 'UF');
        CTe.infCTeNorm.emiDocAnt[i01].xNome   := Leitor.rCampo(tcStr, 'xNome');

        i02 := 0;
        while Leitor.rExtrai(4, 'idDocAnt', '', i02 + 1) <> '' do
        begin
          CTe.infCTeNorm.emiDocAnt[i01].idDocAnt.Add;

          i03 := 0;
          while Leitor.rExtrai(5, 'idDocAntPap', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.emiDocAnt[i01].idDocAnt[i02].idDocAntPap.Add;
            CTe.infCTeNorm.emiDocAnt[i01].idDocAnt[i02].idDocAntPap[i03].tpDoc  := StrToTpDocumentoAnterior(ok, Leitor.rCampo(tcStr, 'tpDoc'));
            CTe.infCTeNorm.emiDocAnt[i01].idDocAnt[i02].idDocAntPap[i03].serie  := Leitor.rCampo(tcStr, 'serie');
            CTe.infCTeNorm.emiDocAnt[i01].idDocAnt[i02].idDocAntPap[i03].subser := Leitor.rCampo(tcStr, 'subser');
            CTe.infCTeNorm.emiDocAnt[i01].idDocAnt[i02].idDocAntPap[i03].nDoc   := Leitor.rCampo(tcInt, 'nDoc');
            CTe.infCTeNorm.emiDocAnt[i01].idDocAnt[i02].idDocAntPap[i03].dEmi   := Leitor.rCampo(tcDat, 'dEmi');
            inc(i03);
          end;

          i03 := 0;
          while Leitor.rExtrai(5, 'idDocAntEle', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.emiDocAnt[i01].idDocAnt[i02].idDocAntEle.Add;
            CTe.infCTeNorm.emiDocAnt[i01].idDocAnt[i02].idDocAntEle[i03].chave := Leitor.rCampo(tcStr, 'chave');
            inc(i03);
          end;
          inc(i02);
        end;
        inc(i01);
      end;
      //
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'seg', '', i01 + 1) <> '' do
    begin
      CTe.infSeg.Add;
      CTe.InfSeg[i01].respSeg := StrToTpRspSeguro(ok, Leitor.rCampo(tcStr, 'respSeg'));
      CTe.InfSeg[i01].xSeg    := Leitor.rCampo(tcStr, 'xSeg');
      CTe.InfSeg[i01].nApol   := Leitor.rCampo(tcStr, 'nApol');
      CTe.InfSeg[i01].nAver   := Leitor.rCampo(tcStr, 'nAver');
  {$IFDEF PL_103}
      CTe.InfSeg[i01].vMerc   := Leitor.rCampo(tcDe3, 'vMerc');
  {$ENDIF}
  {$IFDEF PL_104}
      CTe.InfSeg[i01].vCarga   := Leitor.rCampo(tcDe3, 'vCarga');
  {$ENDIF}
      inc(i01);
    end;

    if Leitor.rExtrai(2, 'rodo') <> '' then
    begin
      CTe.Rodo.RNTRC := Leitor.rCampo(tcStr,'RNTRC');
      CTe.Rodo.dPrev := Leitor.rCampo(tcDat,'dPrev');
      CTe.Rodo.lota  := StrToTpLotacao(ok, Leitor.rCampo(tcStr,'lota'));

  {$IFDEF PL_103}
      if Leitor.rExtrai(3, 'CTRB') <> '' then
      begin
        CTe.Rodo.CTRB.serie := Leitor.rCampo(tcInt,'serie');
        CTe.Rodo.CTRB.nCTRB := Leitor.rCampo(tcInt,'nCTRB');
      end;
  {$ENDIF}
  {$IFDEF PL_104}
      CTe.Rodo.CIOT  := Leitor.rCampo(tcInt, 'CIOT');
  {$ENDIF}

      i01 := 0;
      while Leitor.rExtrai(3, 'occ', '', i01 + 1) <> '' do
      begin
        CTe.Rodo.Occ.Add;
        CTe.Rodo.Occ[i01].serie := Leitor.rCampo(tcStr, 'serie');
        CTe.Rodo.Occ[i01].nOcc  := Leitor.rCampo(tcInt, 'nOcc');
        CTe.Rodo.Occ[i01].dEmi  := Leitor.rCampo(tcDat, 'dEmi');

        if Leitor.rExtrai(4, 'emiOcc') <> '' then
        begin
          CTe.Rodo.Occ[i01].EmiOCC.CNPJ := Leitor.rCampo(tcStr, 'CNPJ');
          CTe.Rodo.Occ[i01].EmiOCC.cInt := Leitor.rCampo(tcStr, 'cInt');
          CTe.Rodo.Occ[i01].EmiOCC.IE   := Leitor.rCampo(tcStr, 'IE');
          CTe.Rodo.Occ[i01].EmiOCC.UF   := Leitor.rCampo(tcStr, 'UF');
          CTe.Rodo.Occ[i01].EmiOCC.fone := Leitor.rCampo(tcStr, 'fone');
        end;
        inc(i01);
      end;

      if Leitor.rExtrai(3, 'valePed') <> '' then
      begin
  {$IFDEF PL_103}
        CTe.Rodo.valePed.nroRE     := Leitor.rCampo(tcStr, 'nroRE');
        CTe.Rodo.valePed.vTValePed := Leitor.rCampo(tcDe2, 'vTValePed');
        CTe.Rodo.valePed.respPg    := StrToRspPagPedagio(ok, Leitor.rCampo(tcStr, 'respPg'));

        i01 := 0;
        while Leitor.rExtrai(4, 'disp', '', i01 + 1) <> '' do
        begin
          CTe.Rodo.valePed.disp.Add;
          CTe.Rodo.valePed.disp[i01].tpDisp := StrToTpDispositivo(ok, Leitor.rCampo(tcStr, 'tpDisp'));
          CTe.Rodo.valePed.disp[i01].xEmp   := Leitor.rCampo(tcStr, 'xEmp');
          CTe.Rodo.valePed.disp[i01].dVig   := Leitor.rCampo(tcDat, 'dVig');
          CTe.Rodo.valePed.disp[i01].nDisp  := Leitor.rCampo(tcStr, 'nDisp');
          CTe.Rodo.valePed.disp[i01].nCompC := Leitor.rCampo(tcStr, 'nCompC');
          inc(i01);
        end;
  {$ENDIF}
  {$IFDEF PL_104}
        CTe.Rodo.valePed.CNPJForn := Leitor.rCampo(tcStr, 'CNPJForn');
        CTe.Rodo.valePed.nCompra  := Leitor.rCampo(tcStr, 'nCompra');
        CTe.Rodo.valePed.CNPJPg   := Leitor.rCampo(tcStr, 'CNPJPg');
  {$ENDIF}
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'veic', '', i01 + 1) <> '' do
      begin
        CTe.Rodo.veic.Add;
        CTe.Rodo.veic[i01].cInt    := Leitor.rCampo(tcStr, 'cInt');
        CTe.Rodo.veic[i01].RENAVAM := Leitor.rCampo(tcStr, 'RENAVAM');
        CTe.Rodo.veic[i01].placa   := Leitor.rCampo(tcStr, 'placa');
        CTe.Rodo.veic[i01].tara    := Leitor.rCampo(tcInt, 'tara');
        CTe.Rodo.veic[i01].capKG   := Leitor.rCampo(tcInt, 'capKG');
        CTe.Rodo.veic[i01].capM3   := Leitor.rCampo(tcInt, 'capM3');
        CTe.Rodo.veic[i01].tpProp  := StrToTpPropriedade(ok, Leitor.rCampo(tcStr, 'tpProp'));
        CTe.Rodo.veic[i01].tpVeic  := StrToTpVeiculo(ok, Leitor.rCampo(tcStr, 'tpVeic'));
        CTe.Rodo.veic[i01].tpRod   := StrToTpRodado(ok, Leitor.rCampo(tcStr, 'tpRod'));
        CTe.Rodo.veic[i01].tpCar   := StrToTpCarroceria(ok, Leitor.rCampo(tcStr, 'tpCar'));
        CTe.Rodo.veic[i01].UF      := Leitor.rCampo(tcStr, 'UF');

        if Leitor.rExtrai(4, 'prop') <> '' then
        begin
          CTe.Rodo.veic[i01].Prop.CNPJCPF := Leitor.rCampoCNPJCPF;
          CTe.Rodo.veic[i01].Prop.RNTRC   := Leitor.rCampo(tcStr, 'RNTRC');
          CTe.Rodo.veic[i01].Prop.xNome   := Leitor.rCampo(tcStr, 'xNome');
          CTe.Rodo.veic[i01].Prop.IE      := Leitor.rCampo(tcStr, 'IE');
          CTe.Rodo.veic[i01].Prop.UF      := Leitor.rCampo(tcStr, 'UF');
          CTe.Rodo.veic[i01].Prop.tpProp  := StrToTpProp(ok, Leitor.rCampo(tcStr, 'tpProp'));
        end;
        inc(i01);
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'lacRodo', '', i01 + 1) <> '' do
      begin
        CTe.Rodo.Lacres.Add;
        CTe.Rodo.Lacres[i01].nLacre := Leitor.rCampo(tcStr, 'nLacre');
        inc(i01);
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'moto', '', i01 + 1) <> '' do
      begin
        CTe.Rodo.moto.Add;
        CTe.Rodo.moto[i01].xNome := Leitor.rCampo(tcStr, 'xNome');
        CTe.Rodo.moto[i01].CPF   := Leitor.rCampo(tcStr, 'CPF');
        inc(i01);
      end;

    end; // fim das informações do modal Rodoviário

    if Leitor.rExtrai(2, 'aereo') <> '' then
    begin
      CTe.Aereo.nMinu   := Leitor.rCampo(tcInt,'nMinu');
      CTe.Aereo.nOCA    := Leitor.rCampo(tcStr,'nOCA');
      CTe.Aereo.dPrev   := Leitor.rCampo(tcDat,'dPrev');
      CTe.Aereo.xLAgEmi := Leitor.rCampo(tcStr,'xLAgEmi');
      CTe.Aereo.cIATA   := Leitor.rCampo(tcStr,'cIATA');

      if Leitor.rExtrai(3, 'tarifa') <> '' then
      begin
  {$IFDEF PL_103}
        CTe.Aereo.tarifa.trecho := Leitor.rCampo(tcStr,'trecho');
  {$ENDIF}
        CTe.Aereo.tarifa.CL     := Leitor.rCampo(tcStr,'CL');
        CTe.Aereo.tarifa.cTar   := Leitor.rCampo(tcStr,'cTar');
        CTe.Aereo.tarifa.vTar   := Leitor.rCampo(tcDe2,'vTar');
      end;

    end; // fim das informações do modal Aéreo

    if Leitor.rExtrai(2, 'aquav') <> '' then
    begin
      CTe.Aquav.vPrest   := Leitor.rCampo(tcDe2,'vPrest');
      CTe.Aquav.vAFRMM   := Leitor.rCampo(tcDe2,'vAFRMM');
      CTe.Aquav.nBooking := Leitor.rCampo(tcStr,'nBooking');
      CTe.Aquav.nCtrl    := Leitor.rCampo(tcStr,'nCtrl');
      CTe.Aquav.xNavio   := Leitor.rCampo(tcStr,'xNavio');
      CTe.Aquav.nViag    := Leitor.rCampo(tcStr,'nViag');
      CTe.Aquav.direc    := StrToTpDirecao(ok, Leitor.rCampo(tcStr, 'direc'));
      CTe.Aquav.prtEmb   := Leitor.rCampo(tcStr,'prtEmb');
      CTe.Aquav.prtTrans := Leitor.rCampo(tcStr,'prtTrans');
      CTe.Aquav.prtDest  := Leitor.rCampo(tcStr,'prtDest');
      CTe.Aquav.tpNav    := StrToTpNavegacao(ok, Leitor.rCampo(tcStr, 'tpNav'));
      CTe.Aquav.irin     := Leitor.rCampo(tcStr,'irin');

{$IFDEF PL_104}
      i01 := 0;
      while Leitor.rExtrai(3, 'balsa', '', i01 + 1) <> '' do
      begin
        CTe.Aquav.balsa.Add;
        CTe.Aquav.balsa[i01].xBalsa := Leitor.rCampo(tcStr, 'xBalsa');
        inc(i01);
      end;
{$ENDIF}

      i01 := 0;
      while Leitor.rExtrai(3, 'lacre', '', i01 + 1) <> '' do
      begin
        CTe.Aquav.Lacre.Add;
        CTe.Aquav.Lacre[i01].nLacre := Leitor.rCampo(tcStr, 'nLacre');
        inc(i01);
      end;

    end; // fim das informações do modal Aquaviário

    if Leitor.rExtrai(2, 'ferrov') <> '' then
    begin
      CTe.Ferrov.tpTraf := StrToTpTrafego(ok, Leitor.rCampo(tcStr, 'tpTraf'));
{$IFDEF PL_104}
      if Leitor.rExtrai(3, 'trafMut') <> '' then
      begin
        CTe.Ferrov.trafMut.respFat := StrToTrafegoMutuo(ok, Leitor.rCampo(tcStr, 'respFat'));
        CTe.Ferrov.trafMut.ferrEmi := StrToTrafegoMutuo(ok, Leitor.rCampo(tcStr, 'ferrEmi'));
      end;
{$ENDIF}
      CTe.Ferrov.fluxo  := Leitor.rCampo(tcStr,'fluxo');
      CTe.Ferrov.idTrem := Leitor.rCampo(tcStr,'idTrem');
      CTe.Ferrov.vFrete := Leitor.rCampo(tcDe2,'vFrete');
{$IFDEF PL_103}
      if Leitor.rExtrai(3, 'ferroSub') <> '' then
      begin
        CTe.Ferrov.ferroSub.CNPJ  := Leitor.rCampo(tcStr,'CNPJ');
        CTe.Ferrov.ferroSub.cInt  := Leitor.rCampo(tcStr,'cInt');
        CTe.Ferrov.ferroSub.IE    := Leitor.rCampo(tcStr,'IE');
        CTe.Ferrov.ferroSub.xNome := Leitor.rCampo(tcStr,'xNome');
        if Leitor.rExtrai(4, 'enderFerro') <> '' then
        begin
          CTe.Ferrov.ferroSub.EnderFerro.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
          CTe.Ferrov.ferroSub.EnderFerro.nro     := Leitor.rCampo(tcStr, 'nro');
          CTe.Ferrov.ferroSub.EnderFerro.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
          CTe.Ferrov.ferroSub.EnderFerro.xBairro := Leitor.rCampo(tcStr, 'xBairro');
          CTe.Ferrov.ferroSub.EnderFerro.cMun    := Leitor.rCampo(tcInt, 'cMun');
          CTe.Ferrov.ferroSub.EnderFerro.xMun    := Leitor.rCampo(tcStr, 'xMun');
          CTe.Ferrov.ferroSub.EnderFerro.CEP     := Leitor.rCampo(tcInt, 'CEP');
          CTe.Ferrov.ferroSub.EnderFerro.UF      := Leitor.rCampo(tcStr, 'UF');
        end;
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'DCL', '', i01 + 1) <> '' do
      begin
        CTe.Ferrov.DCL.Add;
        CTe.Ferrov.DCL[i01].serie   := Leitor.rCampo(tcStr, 'serie');
        CTe.Ferrov.DCL[i01].nDCL    := Leitor.rCampo(tcStr, 'nDCL');
        CTe.Ferrov.DCL[i01].dEmi    := Leitor.rCampo(tcDat, 'dEmi');
        CTe.Ferrov.DCL[i01].qVag    := Leitor.rCampo(tcInt, 'qVag');
        CTe.Ferrov.DCL[i01].pCalc   := Leitor.rCampo(tcDe2, 'pCalc');
        CTe.Ferrov.DCL[i01].vTar    := Leitor.rCampo(tcDe2, 'vTar');
        CTe.Ferrov.DCL[i01].vFrete  := Leitor.rCampo(tcDe2, 'vFrete');
        CTe.Ferrov.DCL[i01].vSAcess := Leitor.rCampo(tcDe2, 'vSAcess');
        CTe.Ferrov.DCL[i01].vTServ  := Leitor.rCampo(tcDe2, 'vTServ');
        CTe.Ferrov.DCL[i01].idTrem  := Leitor.rCampo(tcStr, 'idTrem');

        i02 := 0;
        while Leitor.rExtrai(4, 'detVagDCL', '', i02 + 1) <> '' do
        begin
          CTe.Ferrov.DCL[i01].detVagDCL.Add;
          CTe.Ferrov.DCL[i01].detVagDCL[i02].nVag   := Leitor.rCampo(tcInt, 'nVag');
          CTe.Ferrov.DCL[i01].detVagDCL[i02].cap    := Leitor.rCampo(tcDe2, 'cap');
          CTe.Ferrov.DCL[i01].detVagDCL[i02].tpVag  := Leitor.rCampo(tcStr, 'tpVag');
          CTe.Ferrov.DCL[i01].detVagDCL[i02].pesoR  := Leitor.rCampo(tcDe2, 'pesoR');
          CTe.Ferrov.DCL[i01].detVagDCL[i02].pesoBC := Leitor.rCampo(tcDe2, 'pesoBC');

          i03 := 0;
          while Leitor.rExtrai(5, 'lacDetVagDCL', '', i03 + 1) <> '' do
          begin
            CTe.Ferrov.DCL[i01].detVagDCL[i02].lacDetVagDCL.Add;
            CTe.Ferrov.DCL[i01].detVagDCL[i02].lacDetVagDCL[i03].nLacre := Leitor.rCampo(tcStr, 'nLacre');
            inc(i03);
          end;

          i03 := 0;
          while Leitor.rExtrai(5, 'contDCL', '', i03 + 1) <> '' do
          begin
            CTe.Ferrov.DCL[i01].detVagDCL[i02].contDCL.Add;
            CTe.Ferrov.DCL[i01].detVagDCL[i02].contDCL[i03].nCont := Leitor.rCampo(tcStr, 'nCont');
            CTe.Ferrov.DCL[i01].detVagDCL[i02].contDCL[i03].dPrev := Leitor.rCampo(tcDat, 'dPrev');
            inc(i03);
          end;
          inc(i02);
        end;

        inc(i01);
      end;
{$ENDIF}

{$IFDEF PL_104}
      if Leitor.rExtrai(3, 'ferroEnv') <> '' then
      begin
        CTe.Ferrov.ferroEnv.CNPJ  := Leitor.rCampo(tcStr,'CNPJ');
        CTe.Ferrov.ferroEnv.cInt  := Leitor.rCampo(tcStr,'cInt');
        CTe.Ferrov.ferroEnv.IE    := Leitor.rCampo(tcStr,'IE');
        CTe.Ferrov.ferroEnv.xNome := Leitor.rCampo(tcStr,'xNome');
        if Leitor.rExtrai(4, 'enderFerro') <> '' then
        begin
          CTe.Ferrov.ferroEnv.EnderFerro.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
          CTe.Ferrov.ferroEnv.EnderFerro.nro     := Leitor.rCampo(tcStr, 'nro');
          CTe.Ferrov.ferroEnv.EnderFerro.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
          CTe.Ferrov.ferroEnv.EnderFerro.xBairro := Leitor.rCampo(tcStr, 'xBairro');
          CTe.Ferrov.ferroEnv.EnderFerro.cMun    := Leitor.rCampo(tcInt, 'cMun');
          CTe.Ferrov.ferroEnv.EnderFerro.xMun    := Leitor.rCampo(tcStr, 'xMun');
          CTe.Ferrov.ferroEnv.EnderFerro.CEP     := Leitor.rCampo(tcInt, 'CEP');
          CTe.Ferrov.ferroEnv.EnderFerro.UF      := Leitor.rCampo(tcStr, 'UF');
        end;
      end;
{$ENDIF}

      i01 := 0;
      while Leitor.rExtrai(3, 'detVag', '', i01 + 1) <> '' do
      begin
        CTe.Ferrov.detVag.Add;
        CTe.Ferrov.detVag[i01].nVag   := Leitor.rCampo(tcInt, 'nVag');
        CTe.Ferrov.detVag[i01].cap    := Leitor.rCampo(tcDe2, 'cap');
        CTe.Ferrov.detVag[i01].tpVag  := Leitor.rCampo(tcStr, 'tpVag');
        CTe.Ferrov.detVag[i01].pesoR  := Leitor.rCampo(tcDe2, 'pesoR');
        CTe.Ferrov.detVag[i01].pesoBC := Leitor.rCampo(tcDe2, 'pesoBC');

        i02 := 0;
        while Leitor.rExtrai(4, 'lacDetVag', '', i02 + 1) <> '' do
        begin
          CTe.Ferrov.detVag[i01].lacDetVag.Add;
          CTe.Ferrov.detVag[i01].lacdetVag[i02].nLacre := Leitor.rCampo(tcStr, 'nLacre');

          inc(i02);
        end;

        i02 := 0;
        while Leitor.rExtrai(4, 'contVag', '', i02 + 1) <> '' do
        begin
          CTe.Ferrov.detVag[i01].contVag.Add;
          CTe.Ferrov.detVag[i01].contVag[i02].nCont := Leitor.rCampo(tcStr, 'nCont');
          CTe.Ferrov.detVag[i01].contVag[i02].dPrev := Leitor.rCampo(tcDat, 'dPrev');
          inc(i02);
        end;

        inc(i01);
      end;
    end; // fim das informações do modal Ferroviário

    if Leitor.rExtrai(2, 'duto') <> '' then
    begin
      CTe.duto.vTar := Leitor.rCampo(tcDe6, 'vTar');
{$IFDEF PL_104}
      CTe.duto.dIni := Leitor.rCampo(tcDat, 'dIni');
      CTe.duto.dFim := Leitor.rCampo(tcDat, 'dFim');
{$ENDIF}
    end; // fim das informações do modal Dutoviário

    i01 := 0;
    while Leitor.rExtrai(2, 'peri', '', i01 + 1) <> '' do
    begin
      CTe.peri.Add;
      CTe.peri[i01].nONU        := Leitor.rCampo(tcStr, 'nONU');
      CTe.peri[i01].xNomeAE     := Leitor.rCampo(tcStr, 'xNomeAE');
      CTe.peri[i01].xClaRisco   := Leitor.rCampo(tcStr, 'xClaRisco');
      CTe.peri[i01].grEmb       := Leitor.rCampo(tcStr, 'grEmb');
      CTe.peri[i01].qTotProd    := Leitor.rCampo(tcStr, 'qTotProd');
      CTe.peri[i01].qVolTipo    := Leitor.rCampo(tcStr, 'qVolTipo');
      CTe.peri[i01].pontoFulgor := Leitor.rCampo(tcStr, 'pontoFulgor');
      inc(i01);
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'veicNovos', '', i01 + 1) <> '' do
    begin
      CTe.veicNovos.Add;
      CTe.veicNovos[i01].chassi := Leitor.rCampo(tcStr, 'chassi');
      CTe.veicNovos[i01].cCor   := Leitor.rCampo(tcStr, 'cCor');
      CTe.veicNovos[i01].xCor   := Leitor.rCampo(tcStr, 'xCor');
      CTe.veicNovos[i01].cMod   := Leitor.rCampo(tcStr, 'cMod');
      CTe.veicNovos[i01].vUnit  := Leitor.rCampo(tcDe2, 'vUnit');
      CTe.veicNovos[i01].vFrete := Leitor.rCampo(tcDe2, 'vFrete');
      inc(i01);
    end;

    if Leitor.rExtrai(2, 'infCteSub') <> '' then
    begin
     CTe.infCTeSub.chCte := Leitor.rCampo(tcStr, 'chCte');
     if Leitor.rExtrai(3, 'tomaICMS') <> '' then
      begin
       CTe.infCTeSub.tomaICMS.refNFe := Leitor.rCampo(tcStr, 'refNFe');
       if Leitor.rExtrai(4, 'refNF') <> '' then
        begin
         CTe.infCTeSub.tomaICMS.refNF.CNPJ     := Leitor.rCampo(tcStr, 'CNPJ');
         CTe.infCTeSub.tomaICMS.refNF.modelo   := Leitor.rCampo(tcStr, 'mod');
         CTe.infCTeSub.tomaICMS.refNF.serie    := Leitor.rCampo(tcInt, 'serie');
         CTe.infCTeSub.tomaICMS.refNF.subserie := Leitor.rCampo(tcInt, 'subserie');
         CTe.infCTeSub.tomaICMS.refNF.nro      := Leitor.rCampo(tcInt, 'nro');
         CTe.infCTeSub.tomaICMS.refNF.valor    := Leitor.rCampo(tcDe2, 'valor');
         CTe.infCTeSub.tomaICMS.refNF.dEmi     := Leitor.rCampo(tcDat, 'dEmi');
        end;
       CTe.infCTeSub.tomaICMS.refCte := Leitor.rCampo(tcStr, 'refCte');
      end;
     if Leitor.rExtrai(3, 'tomaNaoICMS') <> '' then
      begin
       CTe.infCTeSub.tomaNaoICMS.refCteAnu := Leitor.rCampo(tcStr, 'refCteAnu');
      end;
    end;
  end;

  (* Grupo da TAG <infCteComp> ************************************************)
  i01 := 0;
  while Leitor.rExtrai(1, 'infCteComp', '', i01 + 1) <> '' do
  begin
    CTe.InfCTeComp.Add;
    CTe.InfCTeComp[i01].Chave := Leitor.rCampo(tcStr, 'chave');

    if Leitor.rExtrai(2, 'vPresComp') <> ''
    then begin
      CTe.infCTeComp[i01].vPresComp.vTPrest := Leitor.rCampo(tcDe2,'vTPrest');

      i02 := 0;
      while Leitor.rExtrai(3, 'compComp', '', i02 + 1) <> '' do
      begin
        CTe.InfCTeComp[i01].vPresComp.compComp.Add;
        CTe.InfCTeComp[i01].vPresComp.compComp[i02].xNome := Leitor.rCampo(tcStr, 'xNome');
        CTe.InfCTeComp[i01].vPresComp.compComp[i02].vComp := Leitor.rCampo(tcDe2, 'vComp');
        inc(i02);
      end;
    end;

    if Leitor.rExtrai(2, 'impComp') <> '' then
    begin
      if Leitor.rExtrai(3, 'ICMSComp') <> '' then
      begin
{$IFDEF PL_103}
        if Leitor.rExtrai(4, 'CST00') <> '' then
{$ENDIF}
{$IFDEF PL_104}
        if Leitor.rExtrai(4, 'ICMS00') <> '' then
{$ENDIF}
        begin
          if Leitor.rCampo(tcStr,'CST')='00'
          then begin
            CTe.InfCTeComp[i01].impComp.ICMSComp.SituTrib    := cst00;
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST00.CST   := Leitor.rCampo(tcStr,'CST');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST00.vBC   := Leitor.rCampo(tcDe2,'vBC');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST00.pICMS := Leitor.rCampo(tcDe2,'pICMS');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST00.vICMS := Leitor.rCampo(tcDe2,'vICMS');
          end;
        end;

{$IFDEF PL_103}
        if Leitor.rExtrai(4, 'CST20') <> '' then
{$ENDIF}
{$IFDEF PL_104}
        if Leitor.rExtrai(4, 'ICMS20') <> '' then
{$ENDIF}
        begin
          if Leitor.rCampo(tcStr,'CST')='20'
          then begin
            CTe.InfCTeComp[i01].impComp.ICMSComp.SituTrib     := cst20;
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST20.CST    := Leitor.rCampo(tcStr,'CST');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST20.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST20.vBC    := Leitor.rCampo(tcDe2,'vBC');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST20.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST20.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
          end;
        end;

{$IFDEF PL_103}
        if Leitor.rExtrai(4, 'CST45') <> '' then
{$ENDIF}
{$IFDEF PL_104}
        if Leitor.rExtrai(4, 'ICMS45') <> '' then
{$ENDIF}
        begin
          if (Leitor.rCampo(tcStr,'CST')='40') or
             (Leitor.rCampo(tcStr,'CST')='41') or
             (Leitor.rCampo(tcStr,'CST')='51')
          then begin
            CTe.InfCTeComp[i01].impComp.ICMSComp.SituTrib  := Leitor.rCampo(tcStr,'CST');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST45.CST := Leitor.rCampo(tcStr,'CST');
          end;
        end;

    {$IFDEF PL_104}
        if Leitor.rExtrai(4, 'ICMS60') <> '' then
        begin
          if Leitor.rCampo(tcStr,'CST')='60'
          then begin
            CTe.InfCTeComp[i01].impComp.ICMSComp.SituTrib         := cst60;
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST60.CST        := Leitor.rCampo(tcStr,'CST');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST60.vBCSTRet   := Leitor.rCampo(tcDe2,'vBCSTRet');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST60.vICMSSTRet := Leitor.rCampo(tcDe2,'vICMSSTRet');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST60.pICMSSTRet := Leitor.rCampo(tcDe2,'pICMSSTRet');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST60.vCred      := Leitor.rCampo(tcDe2,'vCred');
          end;
        end;
    {$ENDIF}

        if Leitor.rExtrai(4, 'CST80') <> '' then
        begin
          if Leitor.rCampo(tcStr,'CST')='90'
          then begin
            // Responsabilidade do recolhimento do ICMS atribuído ao tomador ou 3o por ST
            CTe.InfCTeComp[i01].impComp.ICMSComp.SituTrib    := cst80;
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST80.CST   := Leitor.rCampo(tcStr,'CST');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST80.vBC   := Leitor.rCampo(tcDe2,'vBC');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST80.pICMS := Leitor.rCampo(tcDe2,'pICMS');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST80.vICMS := Leitor.rCampo(tcDe2,'vICMS');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST80.vCred := Leitor.rCampo(tcDe2,'vCred');
          end;
        end;

        if Leitor.rExtrai(4, 'CST81') <> '' then
        begin
          if Leitor.rCampo(tcStr,'CST')='90'
          then begin
            // ICMS devido à Outra UF
            CTe.InfCTeComp[i01].impComp.ICMSComp.SituTrib     := cst81;
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST81.CST    := Leitor.rCampo(tcStr,'CST');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST81.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST81.vBC    := Leitor.rCampo(tcDe2,'vBC');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST81.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST81.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
          end;
        end;

{$IFDEF PL_103}
        if Leitor.rExtrai(4, 'CST90') <> '' then
{$ENDIF}
{$IFDEF PL_104}
        if Leitor.rExtrai(4, 'ICMS90') <> '' then
{$ENDIF}
        begin
          if Leitor.rCampo(tcStr,'CST')='90'
          then begin
            CTe.InfCTeComp[i01].impComp.ICMSComp.SituTrib     := cst90;
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST90.CST    := Leitor.rCampo(tcStr,'CST');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST90.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST90.vBC    := Leitor.rCampo(tcDe2,'vBC');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST90.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST90.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
            CTe.InfCTeComp[i01].impComp.ICMSComp.CST90.vCred  := Leitor.rCampo(tcDe2,'vCred');
          end;
        end;
      end;
    end;

    inc(i01);
  end;

  (* Grupo da TAG <infCteAnu> ************************************************)
  if Leitor.rExtrai(1, 'infCteAnu') <> '' then
  begin
    CTe.InfCTeAnuEnt.chCTe := Leitor.rCampo(tcStr,'chCte');
    CTe.InfCTeAnuEnt.dEmi  := Leitor.rCampo(tcDat,'dEmi');
  end;

  (* Grupo da TAG <signature> *************************************************)

  Leitor.Grupo := Leitor.Arquivo;

  CTe.signature.URI             := Leitor.rAtributo('Reference URI=');
  CTe.signature.DigestValue     := Leitor.rCampo(tcStr, 'DigestValue');
  CTe.signature.SignatureValue  := Leitor.rCampo(tcStr, 'SignatureValue');
  CTe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');

  (* Grupo da TAG <protCTe> ****************************************************)
  if Leitor.rExtrai(1, 'protCTe') <> '' then
  begin
    CTe.procCTe.tpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
    CTe.procCTe.verAplic := Leitor.rCampo(tcStr, 'verAplic');
    CTe.procCTe.chCTe    := Leitor.rCampo(tcStr, 'chCTe');
    CTe.procCTe.dhRecbto := Leitor.rCampo(tcDatHor, 'dhRecbto');
    CTe.procCTe.nProt    := Leitor.rCampo(tcStr, 'nProt');
    CTe.procCTe.digVal   := Leitor.rCampo(tcStr, 'digVal');
    CTe.procCTe.cStat    := Leitor.rCampo(tcInt, 'cStat');
    CTe.procCTe.xMotivo  := Leitor.rCampo(tcStr, 'xMotivo');
  end;

  Result := true;
end;

end.

