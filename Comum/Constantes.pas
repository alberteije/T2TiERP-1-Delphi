{ *******************************************************************************
  Title: T2Ti ERP
  Description: Unit para armazenas as constantes do sistema

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
  ******************************************************************************* }
unit Constantes;

interface

const
  // Formatter
  ftCnpj = '##.###.###/####-##;0;_';
  ftCpf = '###.###.###-##;0;_';
  ftCep = '##.###-####;0;_';
  ftTelefone = '(##)####-####;0;_';
  ftInteiroComSeparador = '###,###,###';
  ftInteiroSemSeparador = '#########';
  ftFloatComSeparador = '###,###,##0.00';
  ftFloatSemSeparador = '0.00';
  ftZerosAEsquerda = '000000';
  ftZeroInvisivel = '#';

type

  TConstantes = class
  const
    QUANTIDADE_POR_PAGINA = 50;

    {$WRITEABLECONST ON}
    DECIMAIS_QUANTIDADE: Integer = 2;
    DECIMAIS_VALOR: Integer = 2;
    {$WRITEABLECONST OFF}

    TagBotao: array [Boolean] of Integer = (0, 1);
    TagPopupMenu: array [Boolean] of Integer = (0, 1);

    // Identificadores de Formulários
    IF_TipoDocumento: TGUID = '{FCBC4257-7F43-40CF-B197-00A6DFA1F5A2}';
    IF_Papel: TGUID = '{796A18BD-B68B-4173-8A42-7C2451DA4DA2}';
    IF_Colaborador: TGUID = '{7F011AE6-A3C6-4B24-99CD-6A930720F303}';
    IF_EstadoCivil: TGUID = '{383FDAC1-1FEE-4CD9-91A2-08DB04030BF4}';
    IF_Setor: TGUID = '{89B20112-AD09-40B6-AFA5-9D700A94AB11}';
    IF_SubGrupoProduto: TGUID = '{0B3B66F4-6367-492C-978C-33F848143698}';
    IF_ALMOXARIFADO: TGUID = '{B31F837C-E13E-486F-AC1A-80B3C6DED0E3}';
    IF_NCM: TGUID = '{7809BD3A-0685-4DE9-8D1F-5E8E3FF9F350}';
    IF_AgenciaBanco: TGUID = '{C27956E9-8DC6-481E-8AE3-4B9837A57DF5}';
    IF_Uf: TGUID = '{4FF9477B-6C5A-4CB8-96D2-E3AD80BACF52}';
    IF_Municipio: TGUID = '{C3E7E047-8AE9-48AF-A485-0005614A5063}';
    IF_Cep: TGUID = '{6CCA68FC-02AE-400D-B573-3C14E8257CE0}';
    IF_Cfop: TGUID = '{5F29793E-49F8-47BA-BE93-292B78478608}';
    IF_SituacaoForCli: TGUID = '{2B3C4643-82AB-4603-93D5-869A364C40FB}';
    IF_AtividadeForCli: TGUID = '{7C6FF59E-AB9C-483E-B797-789BF89D3920}';
    IF_Cargo: TGUID = '{485F1D92-E91B-4965-97AC-BCCC9BDBF663}';
    IF_TipoAdmissao: TGUID = '{0B49F15A-EDCF-49AB-96AC-8E5DD88B474A}';
    IF_TipoColaborador: TGUID = '{DD2E392D-0D05-4D01-BD78-8A33E4A44691}';
    IF_NivelFormacao: TGUID = '{C77E3443-329E-4E46-94CC-E73E3492FB1A}';
    IF_SituacaoColaborador: TGUID = '{3000ECA9-2CD9-4088-833F-0818E8E1E7AE}';
    IF_TipoRealcionamento: TGUID = '{5D381500-C211-4732-8DD6-13D4EA9FD4D1}';
    IF_AidfAimdf: TGUID = '{A4EB829A-B49A-487D-9CFE-92770CE32DE8}';
    IF_BaseCreditoPis: TGUID = '{74FA01DB-CBD7-4E50-BE57-84709437023E}';
    IF_Cbo: TGUID = '{E0E40A1E-80B2-4451-8C0A-2C169D9BBF41}';
    IF_BaseCalculoReduzida: TGUID = '{907F3212-EA5B-4784-B288-A0EC6521F439}';
    IF_PlanoConta: TGUID = '{D87CED7C-5440-498C-9A69-FCB03E346A7A}';
    IF_PlanoContaRefSped: TGUID ='{2E5FC933-138E-4C0F-8735-58669E815A5E}';
    IF_ContabilConta: TGUID = '{11943BD6-373B-486A-84A5-A238C1A5BEAB}';
    IF_SalarioMininio: TGUID = '{2683B000-17EF-4D4F-BEC1-ED2BCDAB9216}';
    IF_CodigoGps: TGUID = '{A0AF7F37-AA7C-4448-932A-8DE040C1168A}';
    IF_TipoDesligamento:  TGUID = '{3574EF79-57A3-4505-8357-639CD6C539D5}';
    IF_SefipCodigoMovimentacao: TGUID = '{38205CA6-8C68-4377-9DFF-A8B695791FA4}';
    IF_SefipCodigoRecolhimento: TGUID = '{812A9692-1E82-42A3-907E-EF0E6119D1C6}';
    IF_TipoItemSped: TGUID = '{BF5B8A0A-92B9-423C-A1EC-EF7F605B7761}';
    IF_SpedPis4310Controller: TGUID = '{0FEBC645-7320-4C34-97DD-099C5847E941}';
    IF_SpedPis4313Controller: TGUID = '{7CA4F48D-B5FD-4DB7-B784-C63076F8E236}';
    IF_SpedPis4314Controller: TGUID = '{667FA597-ECBC-4315-A311-A89938DD0C1B}';
    IF_SpedPis4315Controller: TGUID = '{EE139520-F960-47CC-B2B3-CD97F4A4FF38}';
    IF_SpedPis4316Controller: TGUID = '{B19D96AB-70F8-42B1-AF79-F983206614BD}';
    IF_SpedPis439Controller: TGUID  = '{DF7155A9-021E-439A-90C5-77C58AD9E29D}';
    IF_TipoCreditoPis: TGUID = '{B82B9A80-949E-45FE-BD23-959D85845C3B}';
    IF_SituacaoDocumento: TGUID = '{C1D3C046-1793-457C-8923-B7D87A5E30EE}';
    IF_CsosnA: TGUID = '{EBC1C6EE-F5CA-429E-B5FA-FFADE8888D58}';
    IF_CsosnB: TGUID =  '{FFFE9397-E395-4746-BF7E-FCF16558360B}';
    IF_CstCofins: TGUID = '{9D1271F9-43EF-4B79-9737-5623E00CB886}';
    IF_CstIcmsA: TGUID = '{FB523371-C960-43B7-B839-23FD6A2A0CE6}';
    IF_CstIcmsB: TGUID = '{2A48FC18-A877-41AD-BF0D-68751B9439A1}';
    IF_CstIpi: TGUID = '{B139F782-46BB-4C7E-822A-71EC081EA990}';
    IF_CstPis: TGUID = '{8F8EFF88-3AC6-4AC2-B6E3-EA3CAF5E1FF1}';
    IF_Feriados: TGUID = '{A57CB66B-466B-4404-9A92-046AE6A01A3A}';

    // Módulos
    MODULO_SEGURANCA = 'Segurança';
    MODULO_CADASTROS = 'Cadastros';
  	MODULO_GED = 'GED - Gestão Eletrônica de Documentos';
    MODULO_VENDAS = 'Vendas';
    MODULO_CONTRATOS = 'Gestão de Contratos';
    MODULO_NFE = 'Nota Fiscal Eletrônica - NFe';
    MODULO_ESTOQUE = 'Controle de Estoque';
    MODULO_PATRIMONIO = 'Controle Patrimonial';
    MODULO_FINANCEIRO = 'Controle Financeiro';
    MODULO_CONTAS_PAGAR = 'Contas a Pagar';
    MODULO_CONTAS_RECEBER = 'Contas a Receber';
    MODULO_COMPRAS = 'Gestão de Compras';
  	MODULO_FLUXO_CAIXA = 'Fluxo de Caixa';
  	MODULO_ORCAMENTO = 'Controle de Orçamentos';
    MODULO_PONTO_ELETRONICO = 'Ponto Eletrônico';
    MODULO_FOLHA_PAGAMENTO = 'Folha de Pagamento';
    MODULO_CONTABILIDADE = 'Contabilidade';
    MODULO_CONCILIACAO_CONTABIL = 'Conciliação Contábil';
    MODULO_ESCRITA_FISCAL = 'Escrita Fiscal';
    MODULO_SPED = 'Sped Contábil e Fiscal';
    MODULO_ADMINISTRATIVO = 'Administrativo';
    MODULO_SUPORTE = 'Suporte';

  end;

implementation

end.
