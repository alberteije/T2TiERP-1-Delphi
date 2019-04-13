object FDataModuleNFe: TFDataModuleNFe
  OldCreateOrder = False
  Left = 427
  Top = 97
  Height = 641
  Width = 912
  object CDSVolumes: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_TRANSPORTE'
        DataType = ftInteger
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ESPECIE'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'MARCA'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'NUMERACAO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'PESO_LIQUIDO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'PESO_BRUTO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 356
    Top = 19
    Data = {
      1F0100009619E0BD0200000018000000080000000000030000001F0102494404
      000100000000001149445F4E46455F5452414E53504F52544504000100000000
      000A5155414E5449444144450C0012000000020008444543494D414C53020002
      0006000557494454480200020014000745535045434945010049000000010005
      5749445448020002003C00054D41524341010049000000010005574944544802
      0002003C00094E554D45524143414F0100490000000100055749445448020002
      003C000C5045534F5F4C49515549444F0C0012000000020008444543494D414C
      530200020006000557494454480200020014000A5045534F5F425255544F0C00
      12000000020008444543494D414C530200020006000557494454480200020014
      000000}
    object CDSVolumesID: TIntegerField
      FieldName = 'ID'
    end
    object CDSVolumesID_NFE_TRANSPORTE: TIntegerField
      FieldName = 'ID_NFE_TRANSPORTE'
    end
    object CDSVolumesQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSVolumesESPECIE: TStringField
      FieldName = 'ESPECIE'
      Size = 60
    end
    object CDSVolumesMARCA: TStringField
      FieldName = 'MARCA'
      Size = 60
    end
    object CDSVolumesNUMERACAO: TStringField
      FieldName = 'NUMERACAO'
      Size = 60
    end
    object CDSVolumesPESO_LIQUIDO: TFMTBCDField
      FieldName = 'PESO_LIQUIDO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSVolumesPESO_BRUTO: TFMTBCDField
      FieldName = 'PESO_BRUTO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
  end
  object DSVolumes: TDataSource
    DataSet = CDSVolumes
    Left = 356
    Top = 67
  end
  object CDSNfReferenciada: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_CABECALHO'
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_UF'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'ANO_MES'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'CNPJ'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'MODELO'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'SERIE'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'NUMERO_NF'
        DataType = ftString
        Size = 9
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 356
    Top = 131
    Data = {
      E40000009619E0BD010000001800000008000000000003000000E40002494404
      000100000000001049445F4E46455F4341424543414C484F0400010000000000
      09434F4449474F5F554601004900000001000557494454480200020002000741
      4E4F5F4D4553010049000000010005574944544802000200040004434E504A01
      00490000000100055749445448020002000E00064D4F44454C4F010049000000
      0100055749445448020002000200055345524945010049000000010005574944
      5448020002000300094E554D45524F5F4E460100490000000100055749445448
      0200020009000000}
    object CDSNfReferenciadaID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfReferenciadaID_NFE_CABECALHO: TIntegerField
      FieldName = 'ID_NFE_CABECALHO'
    end
    object CDSNfReferenciadaCODIGO_UF: TStringField
      FieldName = 'CODIGO_UF'
      Size = 2
    end
    object CDSNfReferenciadaANO_MES: TStringField
      FieldName = 'ANO_MES'
      Size = 4
    end
    object CDSNfReferenciadaCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 14
    end
    object CDSNfReferenciadaMODELO: TStringField
      FieldName = 'MODELO'
      Size = 2
    end
    object CDSNfReferenciadaSERIE: TStringField
      FieldName = 'SERIE'
      Size = 3
    end
    object CDSNfReferenciadaNUMERO_NF: TStringField
      FieldName = 'NUMERO_NF'
      Size = 9
    end
  end
  object DSNfReferenciada: TDataSource
    DataSet = CDSNfReferenciada
    Left = 356
    Top = 179
  end
  object CDSCteReferenciado: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_CABECALHO'
        DataType = ftInteger
      end
      item
        Name = 'CHAVE_ACESSO'
        DataType = ftString
        Size = 44
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 212
    Top = 131
    Data = {
      5F0000009619E0BD0100000018000000030000000000030000005F0002494404
      000100000000001049445F4E46455F4341424543414C484F0400010000000000
      0C43484156455F41434553534F0100490000000100055749445448020002002C
      000000}
    object CDSCteReferenciadoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSCteReferenciadoID_NFE_CABECALHO: TIntegerField
      FieldName = 'ID_NFE_CABECALHO'
    end
    object CDSCteReferenciadoCHAVE_ACESSO: TStringField
      FieldName = 'CHAVE_ACESSO'
      Size = 44
    end
  end
  object DSCteReferenciado: TDataSource
    DataSet = CDSCteReferenciado
    Left = 212
    Top = 179
  end
  object CDSNfRuralReferenciada: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_CABECALHO'
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_UF'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'ANO_MES'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'CNPJ'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'CPF'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'INSCRICAO_ESTADUAL'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'MODELO'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'SERIE'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'NUMERO_NF'
        DataType = ftString
        Size = 9
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 212
    Top = 19
    Data = {
      230100009619E0BD01000000180000000A000000000003000000230102494404
      000100000000001049445F4E46455F4341424543414C484F0400010000000000
      09434F4449474F5F554601004900000001000557494454480200020002000741
      4E4F5F4D4553010049000000010005574944544802000200040004434E504A01
      00490000000100055749445448020002000E0003435046010049000000010005
      5749445448020002000B0012494E5343524943414F5F455354414455414C0100
      490000000100055749445448020002000E00064D4F44454C4F01004900000001
      0005574944544802000200020005534552494501004900000001000557494454
      48020002000300094E554D45524F5F4E46010049000000010005574944544802
      00020009000000}
    object CDSNfRuralReferenciadaID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfRuralReferenciadaID_NFE_CABECALHO: TIntegerField
      FieldName = 'ID_NFE_CABECALHO'
    end
    object CDSNfRuralReferenciadaCODIGO_UF: TStringField
      FieldName = 'CODIGO_UF'
      Size = 2
    end
    object CDSNfRuralReferenciadaANO_MES: TStringField
      FieldName = 'ANO_MES'
      Size = 4
    end
    object CDSNfRuralReferenciadaCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 14
    end
    object CDSNfRuralReferenciadaCPF: TStringField
      FieldName = 'CPF'
      Size = 11
    end
    object CDSNfRuralReferenciadaINSCRICAO_ESTADUAL: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Size = 14
    end
    object CDSNfRuralReferenciadaMODELO: TStringField
      FieldName = 'MODELO'
      Size = 2
    end
    object CDSNfRuralReferenciadaSERIE: TStringField
      FieldName = 'SERIE'
      Size = 3
    end
    object CDSNfRuralReferenciadaNUMERO_NF: TStringField
      FieldName = 'NUMERO_NF'
      Size = 9
    end
  end
  object DSNfRuralReferenciada: TDataSource
    DataSet = CDSNfRuralReferenciada
    Left = 212
    Top = 67
  end
  object CDSCupomReferenciado: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_CABECALHO'
        DataType = ftInteger
      end
      item
        Name = 'MODELO_DOCUMENTO_FISCAL'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'NUMERO_ORDEM_ECF'
        DataType = ftInteger
      end
      item
        Name = 'COO'
        DataType = ftInteger
      end
      item
        Name = 'DATA_EMISSAO_CUPOM'
        DataType = ftDate
      end
      item
        Name = 'NUMERO_CAIXA'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO_SERIE_ECF'
        DataType = ftString
        Size = 21
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 68
    Top = 251
    Data = {
      E40000009619E0BD010000001800000008000000000003000000E40002494404
      000100000000001049445F4E46455F4341424543414C484F0400010000000000
      174D4F44454C4F5F444F43554D454E544F5F46495343414C0100490000000100
      055749445448020002000200104E554D45524F5F4F5244454D5F454346040001
      000000000003434F4F040001000000000012444154415F454D495353414F5F43
      55504F4D04000600000000000C4E554D45524F5F434149584104000100000000
      00104E554D45524F5F53455249455F4543460100490000000100055749445448
      0200020015000000}
    object CDSCupomReferenciadoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSCupomReferenciadoID_NFE_CABECALHO: TIntegerField
      FieldName = 'ID_NFE_CABECALHO'
    end
    object CDSCupomReferenciadoMODELO_DOCUMENTO_FISCAL: TStringField
      FieldName = 'MODELO_DOCUMENTO_FISCAL'
      Size = 2
    end
    object CDSCupomReferenciadoNUMERO_ORDEM_ECF: TIntegerField
      FieldName = 'NUMERO_ORDEM_ECF'
    end
    object CDSCupomReferenciadoCOO: TIntegerField
      FieldName = 'COO'
    end
    object CDSCupomReferenciadoDATA_EMISSAO_CUPOM: TDateField
      FieldName = 'DATA_EMISSAO_CUPOM'
      EditMask = '##/##/####'
    end
    object CDSCupomReferenciadoNUMERO_CAIXA: TIntegerField
      FieldName = 'NUMERO_CAIXA'
    end
    object CDSCupomReferenciadoNUMERO_SERIE_ECF: TStringField
      FieldName = 'NUMERO_SERIE_ECF'
      Size = 21
    end
  end
  object DSCupomReferenciado: TDataSource
    DataSet = CDSCupomReferenciado
    Left = 68
    Top = 299
  end
  object CDSDuplicata: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_CABECALHO'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'DATA_VENCIMENTO'
        DataType = ftDate
      end
      item
        Name = 'VALOR'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 212
    Top = 251
    Data = {
      9A0000009619E0BD0200000018000000050000000000030000009A0002494404
      000100000000001049445F4E46455F4341424543414C484F0400010000000000
      064E554D45524F0100490000000100055749445448020002003C000F44415441
      5F56454E43494D454E544F04000600000000000556414C4F520C001200000002
      0008444543494D414C530200020006000557494454480200020014000000}
    object CDSDuplicataID: TIntegerField
      FieldName = 'ID'
    end
    object CDSDuplicataID_NFE_CABECALHO: TIntegerField
      FieldName = 'ID_NFE_CABECALHO'
    end
    object CDSDuplicataNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 60
    end
    object CDSDuplicataDATA_VENCIMENTO: TDateField
      FieldName = 'DATA_VENCIMENTO'
    end
    object CDSDuplicataVALOR: TFMTBCDField
      FieldName = 'VALOR'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
  end
  object DSDuplicata: TDataSource
    DataSet = CDSDuplicata
    Left = 212
    Top = 299
  end
  object CDSNfeReferenciada: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_CABECALHO'
        DataType = ftInteger
      end
      item
        Name = 'CHAVE_ACESSO'
        DataType = ftString
        Size = 44
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 68
    Top = 131
    Data = {
      5F0000009619E0BD0100000018000000030000000000030000005F0002494404
      000100000000001049445F4E46455F4341424543414C484F0400010000000000
      0C43484156455F41434553534F0100490000000100055749445448020002002C
      000000}
    object CDSNfeReferenciadaID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeReferenciadaID_NFE_CABECALHO: TIntegerField
      FieldName = 'ID_NFE_CABECALHO'
    end
    object CDSNfeReferenciadaCHAVE_ACESSO: TStringField
      FieldName = 'CHAVE_ACESSO'
      Size = 44
    end
  end
  object DSNfeReferenciada: TDataSource
    DataSet = CDSNfeReferenciada
    Left = 68
    Top = 179
  end
  object CDSNfeDetalhe: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_PRODUTO'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_CABECALHO'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO_ITEM'
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_PRODUTO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'GTIN'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'NOME_PRODUTO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'NCM'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'EX_TIPI'
        DataType = ftInteger
      end
      item
        Name = 'CFOP'
        DataType = ftInteger
      end
      item
        Name = 'UNIDADE_COMERCIAL'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'QUANTIDADE_COMERCIAL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_UNITARIO_COMERCIAL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_BRUTO_PRODUTO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'GTIN_UNIDADE_TRIBUTAVEL'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'UNIDADE_TRIBUTAVEL'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'QUANTIDADE_TRIBUTAVEL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_UNITARIO_TRIBUTAVEL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_FRETE'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_SEGURO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_DESCONTO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_OUTRAS_DESPESAS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ENTRA_TOTAL'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'VALOR_SUBTOTAL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_TOTAL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'INFORMACOES_ADICIONAIS'
        DataType = ftString
        Size = 3000
      end
      item
        Name = 'CODIGO_LACRE_PRODUTO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CODIGO_LOTE_PRODUTO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CADASTRADO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PERSISTE'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 68
    Top = 19
    Data = {
      940400009619E0BD02000000180000001E000000000003000000940402494404
      000100000000000A49445F50524F4455544F04000100000000001049445F4E46
      455F4341424543414C484F04000100000000000B4E554D45524F5F4954454D04
      000100000000000E434F4449474F5F50524F4455544F01004900000001000557
      49445448020002003C00044754494E0100490000000100055749445448020002
      000E000C4E4F4D455F50524F4455544F01004900000001000557494454480200
      02006400034E434D01004900000001000557494454480200020008000745585F
      5449504904000100000000000443464F50040001000000000011554E49444144
      455F434F4D45524349414C010049000000010005574944544802000200060014
      5155414E5449444144455F434F4D45524349414C0C0012000000020008444543
      494D414C530200020006000557494454480200020014001856414C4F525F554E
      49544152494F5F434F4D45524349414C0C0012000000020008444543494D414C
      530200020006000557494454480200020014001356414C4F525F425255544F5F
      50524F4455544F0C0012000000020008444543494D414C530200020006000557
      49445448020002001400174754494E5F554E49444144455F5452494255544156
      454C0100490000000100055749445448020002000E0012554E49444144455F54
      52494255544156454C0100490000000100055749445448020002000600155155
      414E5449444144455F5452494255544156454C0C001200000002000844454349
      4D414C530200020006000557494454480200020014001956414C4F525F554E49
      544152494F5F5452494255544156454C0C0012000000020008444543494D414C
      530200020006000557494454480200020014000B56414C4F525F46524554450C
      0012000000020008444543494D414C5302000200060005574944544802000200
      14000C56414C4F525F53454755524F0C0012000000020008444543494D414C53
      0200020006000557494454480200020014000E56414C4F525F444553434F4E54
      4F0C0012000000020008444543494D414C530200020006000557494454480200
      020014001556414C4F525F4F55545241535F44455350455341530C0012000000
      020008444543494D414C530200020006000557494454480200020014000B454E
      5452415F544F54414C01004900000001000557494454480200020001000E5641
      4C4F525F535542544F54414C0C0012000000020008444543494D414C53020002
      0006000557494454480200020014000B56414C4F525F544F54414C0C00120000
      00020008444543494D414C530200020006000557494454480200020014001649
      4E464F524D41434F45535F41444943494F4E4149530200490000000100055749
      44544802000200B80B14434F4449474F5F4C414352455F50524F4455544F0100
      49000000010005574944544802000200320013434F4449474F5F4C4F54455F50
      524F4455544F01004900000001000557494454480200020032000A4341444153
      545241444F010049000000010005574944544802000200010008504552534953
      544501004900000001000557494454480200020001000000}
    object CDSNfeDetalheID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeDetalheID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
    end
    object CDSNfeDetalheID_NFE_CABECALHO: TIntegerField
      FieldName = 'ID_NFE_CABECALHO'
    end
    object CDSNfeDetalheNUMERO_ITEM: TIntegerField
      FieldName = 'NUMERO_ITEM'
    end
    object CDSNfeDetalheCODIGO_PRODUTO: TStringField
      FieldName = 'CODIGO_PRODUTO'
      Size = 60
    end
    object CDSNfeDetalheGTIN: TStringField
      FieldName = 'GTIN'
      Size = 14
    end
    object CDSNfeDetalheNOME_PRODUTO: TStringField
      FieldName = 'NOME_PRODUTO'
      Size = 100
    end
    object CDSNfeDetalheNCM: TStringField
      FieldName = 'NCM'
      Size = 8
    end
    object CDSNfeDetalheEX_TIPI: TIntegerField
      FieldName = 'EX_TIPI'
    end
    object CDSNfeDetalheCFOP: TIntegerField
      FieldName = 'CFOP'
    end
    object CDSNfeDetalheUNIDADE_COMERCIAL: TStringField
      FieldName = 'UNIDADE_COMERCIAL'
      Size = 6
    end
    object CDSNfeDetalheQUANTIDADE_COMERCIAL: TFMTBCDField
      FieldName = 'QUANTIDADE_COMERCIAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheVALOR_UNITARIO_COMERCIAL: TFMTBCDField
      FieldName = 'VALOR_UNITARIO_COMERCIAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheVALOR_BRUTO_PRODUTO: TFMTBCDField
      FieldName = 'VALOR_BRUTO_PRODUTO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheGTIN_UNIDADE_TRIBUTAVEL: TStringField
      FieldName = 'GTIN_UNIDADE_TRIBUTAVEL'
      Size = 14
    end
    object CDSNfeDetalheUNIDADE_TRIBUTAVEL: TStringField
      FieldName = 'UNIDADE_TRIBUTAVEL'
      Size = 6
    end
    object CDSNfeDetalheQUANTIDADE_TRIBUTAVEL: TFMTBCDField
      FieldName = 'QUANTIDADE_TRIBUTAVEL'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheVALOR_UNITARIO_TRIBUTAVEL: TFMTBCDField
      FieldName = 'VALOR_UNITARIO_TRIBUTAVEL'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheVALOR_FRETE: TFMTBCDField
      FieldName = 'VALOR_FRETE'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheVALOR_SEGURO: TFMTBCDField
      FieldName = 'VALOR_SEGURO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheVALOR_DESCONTO: TFMTBCDField
      FieldName = 'VALOR_DESCONTO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheVALOR_OUTRAS_DESPESAS: TFMTBCDField
      FieldName = 'VALOR_OUTRAS_DESPESAS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheENTRA_TOTAL: TStringField
      FieldName = 'ENTRA_TOTAL'
      Size = 1
    end
    object CDSNfeDetalheVALOR_SUBTOTAL: TFMTBCDField
      FieldName = 'VALOR_SUBTOTAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheCODIGO_LACRE_PRODUTO: TStringField
      FieldName = 'CODIGO_LACRE_PRODUTO'
      Size = 50
    end
    object CDSNfeDetalheCODIGO_LOTE_PRODUTO: TStringField
      FieldName = 'CODIGO_LOTE_PRODUTO'
      Size = 50
    end
    object CDSNfeDetalheCADASTRADO: TStringField
      FieldName = 'CADASTRADO'
      Size = 1
    end
    object CDSNfeDetalheINFORMACOES_ADICIONAIS: TStringField
      FieldName = 'INFORMACOES_ADICIONAIS'
      Size = 3000
    end
    object CDSNfeDetalhePERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
  end
  object DSNfeDetalhe: TDataSource
    DataSet = CDSNfeDetalhe
    Left = 68
    Top = 67
  end
  object CDSReboque: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_TRANSPORTE'
        DataType = ftInteger
      end
      item
        Name = 'PLACA'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'UF'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'RNTC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'VAGAO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BALSA'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 356
    Top = 251
    Data = {
      BD0000009619E0BD010000001800000007000000000003000000BD0002494404
      000100000000001149445F4E46455F5452414E53504F52544504000100000000
      0005504C41434101004900000001000557494454480200020008000255460100
      49002000010005574944544802000200020004524E5443010049000000010005
      574944544802000200140005564147414F010049000000010005574944544802
      00020014000542414C5341010049000000010005574944544802000200140000
      00}
    object CDSReboqueID: TIntegerField
      FieldName = 'ID'
    end
    object CDSReboqueID_NFE_TRANSPORTE: TIntegerField
      FieldName = 'ID_NFE_TRANSPORTE'
    end
    object CDSReboquePLACA: TStringField
      FieldName = 'PLACA'
      Size = 8
    end
    object CDSReboqueUF: TStringField
      FieldName = 'UF'
      FixedChar = True
      Size = 2
    end
    object CDSReboqueRNTC: TStringField
      FieldName = 'RNTC'
    end
    object CDSReboqueVAGAO: TStringField
      FieldName = 'VAGAO'
    end
    object CDSReboqueBALSA: TStringField
      FieldName = 'BALSA'
    end
  end
  object DSReboque: TDataSource
    DataSet = CDSReboque
    Left = 356
    Top = 299
  end
  object CDSNfeImpostoCofins: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'CST_COFINS'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'QUANTIDADE_VENDIDA'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'BASE_CALCULO_COFINS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_COFINS_PERCENTUAL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_COFINS_REAIS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_COFINS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 492
    Top = 19
    Data = {
      6F0100009619E0BD0200000018000000080000000000030000006F0102494404
      000100000000000E49445F4E46455F444554414C484504000100000000000A43
      53545F434F46494E530100490000000100055749445448020002000200125155
      414E5449444144455F56454E444944410C0012000000020008444543494D414C
      5302000200060005574944544802000200140013424153455F43414C43554C4F
      5F434F46494E530C0012000000020008444543494D414C530200020006000557
      494454480200020014001A414C4951554F54415F434F46494E535F5045524345
      4E5455414C0C0012000000020008444543494D414C5302000200060005574944
      544802000200140015414C4951554F54415F434F46494E535F52454149530C00
      12000000020008444543494D414C530200020006000557494454480200020014
      000C56414C4F525F434F46494E530C0012000000020008444543494D414C5302
      00020006000557494454480200020014000000}
    object CDSNfeImpostoCofinsID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeImpostoCofinsID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeImpostoCofinsCST_COFINS: TStringField
      FieldName = 'CST_COFINS'
      Size = 2
    end
    object CDSNfeImpostoCofinsQUANTIDADE_VENDIDA: TFMTBCDField
      FieldName = 'QUANTIDADE_VENDIDA'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoCofinsBASE_CALCULO_COFINS: TFMTBCDField
      FieldName = 'BASE_CALCULO_COFINS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoCofinsALIQUOTA_COFINS_PERCENTUAL: TFMTBCDField
      FieldName = 'ALIQUOTA_COFINS_PERCENTUAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoCofinsALIQUOTA_COFINS_REAIS: TFMTBCDField
      FieldName = 'ALIQUOTA_COFINS_REAIS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoCofinsVALOR_COFINS: TFMTBCDField
      FieldName = 'VALOR_COFINS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
  end
  object DSNfeImpostoCofins: TDataSource
    DataSet = CDSNfeImpostoCofins
    Left = 492
    Top = 67
  end
  object CDSNfeImpostoIcms: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'ORIGEM_MERCADORIA'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CST_ICMS'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CSOSN'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'MODALIDADE_BC_ICMS'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'TAXA_REDUCAO_BC_ICMS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'BASE_CALCULO_ICMS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_ICMS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_ICMS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'MOTIVO_DESONERACAO_ICMS'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'MODALIDADE_BC_ICMS_ST'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PERCENTUAL_MVA_ICMS_ST'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'PERCENTUAL_REDUCAO_BC_ICMS_ST'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_BASE_CALCULO_ICMS_ST'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_ICMS_ST'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_ICMS_ST'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_BC_ICMS_ST_RETIDO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_ICMS_ST_RETIDO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_BC_ICMS_ST_DESTINO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_ICMS_ST_DESTINO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_CREDITO_ICMS_SN'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_CREDITO_ICMS_SN'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'PERCENTUAL_BC_OPERACAO_PROPRIA'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'UF_ST'
        DataType = ftString
        Size = 2
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 492
    Top = 131
    Data = {
      B90400009619E0BD020000001800000019000000000003000000B90402494404
      000100000000000E49445F4E46455F444554414C48450400010000000000114F
      524947454D5F4D45524341444F52494101004900000001000557494454480200
      02000100084353545F49434D5301004900000001000557494454480200020002
      000543534F534E0100490000000100055749445448020002000300124D4F4441
      4C49444144455F42435F49434D53010049000000010005574944544802000200
      010014544158415F5245445543414F5F42435F49434D530C0012000000020008
      444543494D414C5302000200060005574944544802000200140011424153455F
      43414C43554C4F5F49434D530C0012000000020008444543494D414C53020002
      0006000557494454480200020014000D414C4951554F54415F49434D530C0012
      000000020008444543494D414C53020002000600055749445448020002001400
      0A56414C4F525F49434D530C0012000000020008444543494D414C5302000200
      0600055749445448020002001400174D4F5449564F5F4445534F4E4552414341
      4F5F49434D530100490000000100055749445448020002000100154D4F44414C
      49444144455F42435F49434D535F535401004900000001000557494454480200
      020001001650455243454E5455414C5F4D56415F49434D535F53540C00120000
      00020008444543494D414C530200020006000557494454480200020014001D50
      455243454E5455414C5F5245445543414F5F42435F49434D535F53540C001200
      0000020008444543494D414C530200020006000557494454480200020014001A
      56414C4F525F424153455F43414C43554C4F5F49434D535F53540C0012000000
      020008444543494D414C5302000200060005574944544802000200140010414C
      4951554F54415F49434D535F53540C0012000000020008444543494D414C5302
      00020006000557494454480200020014000D56414C4F525F49434D535F53540C
      0012000000020008444543494D414C5302000200060005574944544802000200
      14001756414C4F525F42435F49434D535F53545F52455449444F0C0012000000
      020008444543494D414C53020002000600055749445448020002001400145641
      4C4F525F49434D535F53545F52455449444F0C0012000000020008444543494D
      414C530200020006000557494454480200020014001856414C4F525F42435F49
      434D535F53545F44455354494E4F0C0012000000020008444543494D414C5302
      00020006000557494454480200020014001556414C4F525F49434D535F53545F
      44455354494E4F0C0012000000020008444543494D414C530200020006000557
      4944544802000200140018414C4951554F54415F4352454449544F5F49434D53
      5F534E0C0012000000020008444543494D414C53020002000600055749445448
      0200020014001556414C4F525F4352454449544F5F49434D535F534E0C001200
      0000020008444543494D414C530200020006000557494454480200020014001E
      50455243454E5455414C5F42435F4F5045524143414F5F50524F505249410C00
      12000000020008444543494D414C530200020006000557494454480200020014
      000555465F535401004900000001000557494454480200020002000000}
    object CDSNfeImpostoIcmsID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeImpostoIcmsID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeImpostoIcmsORIGEM_MERCADORIA: TStringField
      FieldName = 'ORIGEM_MERCADORIA'
      FixedChar = True
      Size = 1
    end
    object CDSNfeImpostoIcmsCST_ICMS: TStringField
      FieldName = 'CST_ICMS'
      FixedChar = True
      Size = 2
    end
    object CDSNfeImpostoIcmsCSOSN: TStringField
      FieldName = 'CSOSN'
      FixedChar = True
      Size = 3
    end
    object CDSNfeImpostoIcmsMODALIDADE_BC_ICMS: TStringField
      FieldName = 'MODALIDADE_BC_ICMS'
      FixedChar = True
      Size = 1
    end
    object CDSNfeImpostoIcmsTAXA_REDUCAO_BC_ICMS: TFMTBCDField
      FieldName = 'TAXA_REDUCAO_BC_ICMS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsBASE_CALCULO_ICMS: TFMTBCDField
      FieldName = 'BASE_CALCULO_ICMS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsALIQUOTA_ICMS: TFMTBCDField
      FieldName = 'ALIQUOTA_ICMS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsVALOR_ICMS: TFMTBCDField
      FieldName = 'VALOR_ICMS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsMOTIVO_DESONERACAO_ICMS: TStringField
      FieldName = 'MOTIVO_DESONERACAO_ICMS'
      FixedChar = True
      Size = 1
    end
    object CDSNfeImpostoIcmsMODALIDADE_BC_ICMS_ST: TStringField
      FieldName = 'MODALIDADE_BC_ICMS_ST'
      FixedChar = True
      Size = 1
    end
    object CDSNfeImpostoIcmsPERCENTUAL_MVA_ICMS_ST: TFMTBCDField
      FieldName = 'PERCENTUAL_MVA_ICMS_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsPERCENTUAL_REDUCAO_BC_ICMS_ST: TFMTBCDField
      FieldName = 'PERCENTUAL_REDUCAO_BC_ICMS_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsVALOR_BASE_CALCULO_ICMS_ST: TFMTBCDField
      FieldName = 'VALOR_BASE_CALCULO_ICMS_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsALIQUOTA_ICMS_ST: TFMTBCDField
      FieldName = 'ALIQUOTA_ICMS_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsVALOR_ICMS_ST: TFMTBCDField
      FieldName = 'VALOR_ICMS_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsVALOR_BC_ICMS_ST_RETIDO: TFMTBCDField
      FieldName = 'VALOR_BC_ICMS_ST_RETIDO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsVALOR_ICMS_ST_RETIDO: TFMTBCDField
      FieldName = 'VALOR_ICMS_ST_RETIDO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsVALOR_BC_ICMS_ST_DESTINO: TFMTBCDField
      FieldName = 'VALOR_BC_ICMS_ST_DESTINO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsVALOR_ICMS_ST_DESTINO: TFMTBCDField
      FieldName = 'VALOR_ICMS_ST_DESTINO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsALIQUOTA_CREDITO_ICMS_SN: TFMTBCDField
      FieldName = 'ALIQUOTA_CREDITO_ICMS_SN'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsVALOR_CREDITO_ICMS_SN: TFMTBCDField
      FieldName = 'VALOR_CREDITO_ICMS_SN'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsPERCENTUAL_BC_OPERACAO_PROPRIA: TFMTBCDField
      FieldName = 'PERCENTUAL_BC_OPERACAO_PROPRIA'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIcmsUF_ST: TStringField
      FieldName = 'UF_ST'
      FixedChar = True
      Size = 2
    end
  end
  object DSNfeImpostoIcms: TDataSource
    DataSet = CDSNfeImpostoIcms
    Left = 492
    Top = 179
  end
  object CDSNfeImpostoImportacao: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'VALOR_BC_II'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_DESPESAS_ADUANEIRAS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_IMPOSTO_IMPORTACAO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_IOF'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 492
    Top = 251
    Data = {
      110100009619E0BD020000001800000006000000000003000000110102494404
      000100000000000E49445F4E46455F444554414C484504000100000000000B56
      414C4F525F42435F49490C0012000000020008444543494D414C530200020006
      000557494454480200020014001956414C4F525F44455350455341535F414455
      414E45495241530C0012000000020008444543494D414C530200020006000557
      494454480200020014001856414C4F525F494D504F53544F5F494D504F525441
      43414F0C0012000000020008444543494D414C53020002000600055749445448
      0200020014000956414C4F525F494F460C0012000000020008444543494D414C
      530200020006000557494454480200020014000000}
    object CDSNfeImpostoImportacaoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeImpostoImportacaoID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeImpostoImportacaoVALOR_BC_II: TFMTBCDField
      FieldName = 'VALOR_BC_II'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoImportacaoVALOR_DESPESAS_ADUANEIRAS: TFMTBCDField
      FieldName = 'VALOR_DESPESAS_ADUANEIRAS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoImportacaoVALOR_IMPOSTO_IMPORTACAO: TFMTBCDField
      FieldName = 'VALOR_IMPOSTO_IMPORTACAO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoImportacaoVALOR_IOF: TFMTBCDField
      FieldName = 'VALOR_IOF'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
  end
  object DSNfeImpostoImportacao: TDataSource
    DataSet = CDSNfeImpostoImportacao
    Left = 492
    Top = 299
  end
  object CDSNfeImpostoIpi: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'ENQUADRAMENTO_IPI'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'CNPJ_PRODUTOR'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'CODIGO_SELO_IPI'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'QUANTIDADE_SELO_IPI'
        DataType = ftInteger
      end
      item
        Name = 'ENQUADRAMENTO_LEGAL_IPI'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'CST_IPI'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'VALOR_BASE_CALCULO_IPI'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_IPI'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'QUANTIDADE_UNIDADE_TRIBUTAVEL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_UNIDADE_TRIBUTAVEL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_IPI'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 636
    Top = 19
    Data = {
      200200009619E0BD02000000180000000D000000000003000000200202494404
      000100000000000E49445F4E46455F444554414C484504000100000000001145
      4E5155414452414D454E544F5F49504901004900000001000557494454480200
      020005000D434E504A5F50524F4455544F520100490000000100055749445448
      020002000E000F434F4449474F5F53454C4F5F49504901004900000001000557
      49445448020002003C00135155414E5449444144455F53454C4F5F4950490400
      01000000000017454E5155414452414D454E544F5F4C4547414C5F4950490100
      490020000100055749445448020002000300074353545F495049010049002000
      01000557494454480200020002001656414C4F525F424153455F43414C43554C
      4F5F4950490C0012000000020008444543494D414C5302000200060005574944
      54480200020014000C414C4951554F54415F4950490C00120000000200084445
      43494D414C530200020006000557494454480200020014001D5155414E544944
      4144455F554E49444144455F5452494255544156454C0C001200000002000844
      4543494D414C530200020006000557494454480200020014001856414C4F525F
      554E49444144455F5452494255544156454C0C0012000000020008444543494D
      414C530200020006000557494454480200020014000956414C4F525F4950490C
      0012000000020008444543494D414C5302000200060005574944544802000200
      14000000}
    object CDSNfeImpostoIpiID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeImpostoIpiID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeImpostoIpiENQUADRAMENTO_IPI: TStringField
      FieldName = 'ENQUADRAMENTO_IPI'
      Size = 5
    end
    object CDSNfeImpostoIpiCNPJ_PRODUTOR: TStringField
      FieldName = 'CNPJ_PRODUTOR'
      Size = 14
    end
    object CDSNfeImpostoIpiCODIGO_SELO_IPI: TStringField
      FieldName = 'CODIGO_SELO_IPI'
      Size = 60
    end
    object CDSNfeImpostoIpiQUANTIDADE_SELO_IPI: TIntegerField
      FieldName = 'QUANTIDADE_SELO_IPI'
    end
    object CDSNfeImpostoIpiENQUADRAMENTO_LEGAL_IPI: TStringField
      FieldName = 'ENQUADRAMENTO_LEGAL_IPI'
      FixedChar = True
      Size = 3
    end
    object CDSNfeImpostoIpiCST_IPI: TStringField
      FieldName = 'CST_IPI'
      FixedChar = True
      Size = 2
    end
    object CDSNfeImpostoIpiVALOR_BASE_CALCULO_IPI: TFMTBCDField
      FieldName = 'VALOR_BASE_CALCULO_IPI'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIpiALIQUOTA_IPI: TFMTBCDField
      FieldName = 'ALIQUOTA_IPI'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIpiQUANTIDADE_UNIDADE_TRIBUTAVEL: TFMTBCDField
      FieldName = 'QUANTIDADE_UNIDADE_TRIBUTAVEL'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIpiVALOR_UNIDADE_TRIBUTAVEL: TFMTBCDField
      FieldName = 'VALOR_UNIDADE_TRIBUTAVEL'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIpiVALOR_IPI: TFMTBCDField
      FieldName = 'VALOR_IPI'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
  end
  object DSNfeImpostoIpi: TDataSource
    DataSet = CDSNfeImpostoIpi
    Left = 636
    Top = 67
  end
  object CDSNfeImpostoIssqn: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'BASE_CALCULO_ISSQN'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_ISSQN'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_ISSQN'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'MUNICIPIO_ISSQN'
        DataType = ftInteger
      end
      item
        Name = 'ITEM_LISTA_SERVICOS'
        DataType = ftInteger
      end
      item
        Name = 'TRIBUTACAO_ISSQN'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 636
    Top = 131
    Data = {
      2C0100009619E0BD0200000018000000080000000000030000002C0102494404
      000100000000000E49445F4E46455F444554414C484504000100000000001242
      4153455F43414C43554C4F5F495353514E0C0012000000020008444543494D41
      4C530200020006000557494454480200020014000E414C4951554F54415F4953
      53514E0C0012000000020008444543494D414C53020002000600055749445448
      0200020014000B56414C4F525F495353514E0C0012000000020008444543494D
      414C530200020006000557494454480200020014000F4D554E49434950494F5F
      495353514E0400010000000000134954454D5F4C495354415F5345525649434F
      530400010000000000105452494255544143414F5F495353514E010049002000
      01000557494454480200020001000000}
    object CDSNfeImpostoIssqnID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeImpostoIssqnID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeImpostoIssqnBASE_CALCULO_ISSQN: TFMTBCDField
      FieldName = 'BASE_CALCULO_ISSQN'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIssqnALIQUOTA_ISSQN: TFMTBCDField
      FieldName = 'ALIQUOTA_ISSQN'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIssqnVALOR_ISSQN: TFMTBCDField
      FieldName = 'VALOR_ISSQN'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoIssqnMUNICIPIO_ISSQN: TIntegerField
      FieldName = 'MUNICIPIO_ISSQN'
    end
    object CDSNfeImpostoIssqnITEM_LISTA_SERVICOS: TIntegerField
      FieldName = 'ITEM_LISTA_SERVICOS'
    end
    object CDSNfeImpostoIssqnTRIBUTACAO_ISSQN: TStringField
      FieldName = 'TRIBUTACAO_ISSQN'
      FixedChar = True
      Size = 1
    end
  end
  object DSNfeImpostoIssqn: TDataSource
    DataSet = CDSNfeImpostoIssqn
    Left = 636
    Top = 179
  end
  object CDSNfeImpostoPis: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'CST_PIS'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'QUANTIDADE_VENDIDA'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_BASE_CALCULO_PIS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_PIS_PERCENTUAL'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_PIS_REAIS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_PIS'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 636
    Top = 251
    Data = {
      660100009619E0BD020000001800000008000000000003000000660102494404
      000100000000000E49445F4E46455F444554414C484504000100000000000743
      53545F5049530100490020000100055749445448020002000200125155414E54
      49444144455F56454E444944410C0012000000020008444543494D414C530200
      020006000557494454480200020014001656414C4F525F424153455F43414C43
      554C4F5F5049530C0012000000020008444543494D414C530200020006000557
      4944544802000200140017414C4951554F54415F5049535F50455243454E5455
      414C0C0012000000020008444543494D414C5302000200060005574944544802
      000200140012414C4951554F54415F5049535F52454149530C00120000000200
      08444543494D414C530200020006000557494454480200020014000956414C4F
      525F5049530C0012000000020008444543494D414C5302000200060005574944
      54480200020014000000}
    object CDSNfeImpostoPisID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeImpostoPisID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeImpostoPisCST_PIS: TStringField
      FieldName = 'CST_PIS'
      FixedChar = True
      Size = 2
    end
    object CDSNfeImpostoPisQUANTIDADE_VENDIDA: TFMTBCDField
      FieldName = 'QUANTIDADE_VENDIDA'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoPisVALOR_BASE_CALCULO_PIS: TFMTBCDField
      FieldName = 'VALOR_BASE_CALCULO_PIS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoPisALIQUOTA_PIS_PERCENTUAL: TFMTBCDField
      FieldName = 'ALIQUOTA_PIS_PERCENTUAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoPisALIQUOTA_PIS_REAIS: TFMTBCDField
      FieldName = 'ALIQUOTA_PIS_REAIS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImpostoPisVALOR_PIS: TFMTBCDField
      FieldName = 'VALOR_PIS'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
  end
  object DSNfeImpostoPis: TDataSource
    DataSet = CDSNfeImpostoPis
    Left = 636
    Top = 299
  end
  object CDSNfeDeclaracaoImportacao: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO_DOCUMENTO'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'DATA_REGISTRO'
        DataType = ftDate
      end
      item
        Name = 'LOCAL_DESEMBARACO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'UF_DESEMBARACO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'DATA_DESEMBARACO'
        DataType = ftDate
      end
      item
        Name = 'CODIGO_EXPORTADOR'
        DataType = ftString
        Size = 60
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 68
    Top = 371
    Data = {
      FF0000009619E0BD010000001800000008000000000003000000FF0002494404
      000100000000000E49445F4E46455F444554414C48450400010000000000104E
      554D45524F5F444F43554D454E544F0100490000000100055749445448020002
      000C000D444154415F524547495354524F0400060000000000114C4F43414C5F
      444553454D42415241434F0100490000000100055749445448020002003C000E
      55465F444553454D42415241434F010049002000010005574944544802000200
      020010444154415F444553454D42415241434F040006000000000011434F4449
      474F5F4558504F525441444F520100490000000100055749445448020002003C
      000000}
    object CDSNfeDeclaracaoImportacaoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeDeclaracaoImportacaoID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeDeclaracaoImportacaoNUMERO_DOCUMENTO: TStringField
      FieldName = 'NUMERO_DOCUMENTO'
      Size = 12
    end
    object CDSNfeDeclaracaoImportacaoDATA_REGISTRO: TDateField
      FieldName = 'DATA_REGISTRO'
      EditMask = '##/##/####'
    end
    object CDSNfeDeclaracaoImportacaoLOCAL_DESEMBARACO: TStringField
      FieldName = 'LOCAL_DESEMBARACO'
      Size = 60
    end
    object CDSNfeDeclaracaoImportacaoUF_DESEMBARACO: TStringField
      FieldName = 'UF_DESEMBARACO'
      FixedChar = True
      Size = 2
    end
    object CDSNfeDeclaracaoImportacaoDATA_DESEMBARACO: TDateField
      FieldName = 'DATA_DESEMBARACO'
      EditMask = '##/##/####'
    end
    object CDSNfeDeclaracaoImportacaoCODIGO_EXPORTADOR: TStringField
      FieldName = 'CODIGO_EXPORTADOR'
      Size = 60
    end
  end
  object DSNfeDeclaracaoImportacao: TDataSource
    DataSet = CDSNfeDeclaracaoImportacao
    Left = 68
    Top = 419
  end
  object CDSNfeImportacaoDetalhe: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DECLARACAO_IMPORTACAO'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO_ADICAO'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO_SEQUENCIAL'
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_FABRICANTE_ESTRANGEIRO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'VALOR_DESCONTO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'NUMERO_PEDIDO_COMPRA'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ITEM_PEDIDO_COMPRA'
        DataType = ftInteger
      end>
    IndexDefs = <>
    MasterSource = DSNfeDeclaracaoImportacao
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 68
    Top = 491
    Data = {
      220100009619E0BD020000001800000008000000000003000000220102494404
      000100000000001C49445F4E46455F4445434C41524143414F5F494D504F5254
      4143414F04000100000000000D4E554D45524F5F41444943414F040001000000
      0000114E554D45524F5F53455155454E4349414C04000100000000001D434F44
      49474F5F464142524943414E54455F45535452414E474549524F010049000000
      0100055749445448020002003C000E56414C4F525F444553434F4E544F0C0012
      000000020008444543494D414C53020002000600055749445448020002001400
      144E554D45524F5F50454449444F5F434F4D5052410100490000000100055749
      445448020002000F00124954454D5F50454449444F5F434F4D50524104000100
      000000000000}
    object CDSNfeImportacaoDetalheID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeImportacaoDetalheID_NFE_DECLARACAO_IMPORTACAO: TIntegerField
      FieldName = 'ID_NFE_DECLARACAO_IMPORTACAO'
    end
    object CDSNfeImportacaoDetalheNUMERO_ADICAO: TIntegerField
      FieldName = 'NUMERO_ADICAO'
    end
    object CDSNfeImportacaoDetalheNUMERO_SEQUENCIAL: TIntegerField
      FieldName = 'NUMERO_SEQUENCIAL'
    end
    object CDSNfeImportacaoDetalheCODIGO_FABRICANTE_ESTRANGEIRO: TStringField
      FieldName = 'CODIGO_FABRICANTE_ESTRANGEIRO'
      Size = 60
    end
    object CDSNfeImportacaoDetalheVALOR_DESCONTO: TFMTBCDField
      FieldName = 'VALOR_DESCONTO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeImportacaoDetalheNUMERO_PEDIDO_COMPRA: TStringField
      FieldName = 'NUMERO_PEDIDO_COMPRA'
      Size = 15
    end
    object CDSNfeImportacaoDetalheITEM_PEDIDO_COMPRA: TIntegerField
      FieldName = 'ITEM_PEDIDO_COMPRA'
    end
  end
  object DSNfeImportacaoDetalhe: TDataSource
    DataSet = CDSNfeImportacaoDetalhe
    Left = 68
    Top = 539
  end
  object CDSNfeDetalheVeiculo: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'TIPO_OPERACAO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CHASSI'
        DataType = ftString
        Size = 17
      end
      item
        Name = 'COR'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'DESCRICAO_COR'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'POTENCIA_MOTOR'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'CILINDRADAS'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'PESO_LIQUIDO'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'PESO_BRUTO'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'NUMERO_SERIE'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'TIPO_COMBUSTIVEL'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'NUMERO_MOTOR'
        DataType = ftString
        Size = 21
      end
      item
        Name = 'CAPACIDADE_MAXIMA_TRACAO'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'DISTANCIA_EIXOS'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'ANO_MODELO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 4
      end
      item
        Name = 'ANO_FABRICACAO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 4
      end
      item
        Name = 'TIPO_PINTURA'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'TIPO_VEICULO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'ESPECIE_VEICULO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CONDICAO_VIN'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CONDICAO_VEICULO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CODIGO_MARCA_MODELO'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'CODIGO_COR'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'LOTACAO'
        DataType = ftInteger
      end
      item
        Name = 'RESTRICAO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 212
    Top = 371
    Data = {
      510300009619E0BD01000000180000001A000000000003000000510302494404
      000100000000000E49445F4E46455F444554414C484504000100000000000D54
      49504F5F4F5045524143414F0100490020000100055749445448020002000100
      06434841535349010049000000010005574944544802000200110003434F5201
      004900000001000557494454480200020004000D44455343524943414F5F434F
      5201004900000001000557494454480200020028000E504F54454E4349415F4D
      4F544F5201004900000001000557494454480200020004000B43494C494E4452
      4144415301004900000001000557494454480200020004000C5045534F5F4C49
      515549444F01004900000001000557494454480200020009000A5045534F5F42
      5255544F01004900000001000557494454480200020009000C4E554D45524F5F
      53455249450100490000000100055749445448020002000900105449504F5F43
      4F4D425553544956454C01004900200001000557494454480200020002000C4E
      554D45524F5F4D4F544F52010049000000010005574944544802000200150018
      434150414349444144455F4D4158494D415F54524143414F0100490000000100
      0557494454480200020009000F44495354414E4349415F4549584F5301004900
      000001000557494454480200020004000A414E4F5F4D4F44454C4F0100490020
      0001000557494454480200020004000E414E4F5F4641425249434143414F0100
      4900200001000557494454480200020004000C5449504F5F50494E5455524101
      004900200001000557494454480200020001000C5449504F5F56454943554C4F
      01004900200001000557494454480200020002000F455350454349455F564549
      43554C4F01004900200001000557494454480200020001000C434F4E44494341
      4F5F56494E010049002000010005574944544802000200010010434F4E444943
      414F5F56454943554C4F01004900200001000557494454480200020001001343
      4F4449474F5F4D415243415F4D4F44454C4F0100490000000100055749445448
      0200020006000A434F4449474F5F434F52010049002000010005574944544802
      0002000200074C4F544143414F04000100000000000952455354524943414F01
      004900200001000557494454480200020001000000}
    object CDSNfeDetalheVeiculoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeDetalheVeiculoID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeDetalheVeiculoTIPO_OPERACAO: TStringField
      FieldName = 'TIPO_OPERACAO'
      FixedChar = True
      Size = 1
    end
    object CDSNfeDetalheVeiculoCHASSI: TStringField
      FieldName = 'CHASSI'
      Size = 17
    end
    object CDSNfeDetalheVeiculoCOR: TStringField
      FieldName = 'COR'
      Size = 4
    end
    object CDSNfeDetalheVeiculoDESCRICAO_COR: TStringField
      FieldName = 'DESCRICAO_COR'
      Size = 40
    end
    object CDSNfeDetalheVeiculoPOTENCIA_MOTOR: TStringField
      FieldName = 'POTENCIA_MOTOR'
      Size = 4
    end
    object CDSNfeDetalheVeiculoCILINDRADAS: TStringField
      FieldName = 'CILINDRADAS'
      Size = 4
    end
    object CDSNfeDetalheVeiculoPESO_LIQUIDO: TStringField
      FieldName = 'PESO_LIQUIDO'
      Size = 9
    end
    object CDSNfeDetalheVeiculoPESO_BRUTO: TStringField
      FieldName = 'PESO_BRUTO'
      Size = 9
    end
    object CDSNfeDetalheVeiculoNUMERO_SERIE: TStringField
      FieldName = 'NUMERO_SERIE'
      Size = 9
    end
    object CDSNfeDetalheVeiculoTIPO_COMBUSTIVEL: TStringField
      FieldName = 'TIPO_COMBUSTIVEL'
      FixedChar = True
      Size = 2
    end
    object CDSNfeDetalheVeiculoNUMERO_MOTOR: TStringField
      FieldName = 'NUMERO_MOTOR'
      Size = 21
    end
    object CDSNfeDetalheVeiculoCAPACIDADE_MAXIMA_TRACAO: TStringField
      FieldName = 'CAPACIDADE_MAXIMA_TRACAO'
      Size = 9
    end
    object CDSNfeDetalheVeiculoDISTANCIA_EIXOS: TStringField
      FieldName = 'DISTANCIA_EIXOS'
      Size = 4
    end
    object CDSNfeDetalheVeiculoANO_MODELO: TStringField
      FieldName = 'ANO_MODELO'
      FixedChar = True
      Size = 4
    end
    object CDSNfeDetalheVeiculoANO_FABRICACAO: TStringField
      FieldName = 'ANO_FABRICACAO'
      FixedChar = True
      Size = 4
    end
    object CDSNfeDetalheVeiculoTIPO_PINTURA: TStringField
      FieldName = 'TIPO_PINTURA'
      FixedChar = True
      Size = 1
    end
    object CDSNfeDetalheVeiculoTIPO_VEICULO: TStringField
      FieldName = 'TIPO_VEICULO'
      FixedChar = True
      Size = 2
    end
    object CDSNfeDetalheVeiculoESPECIE_VEICULO: TStringField
      FieldName = 'ESPECIE_VEICULO'
      FixedChar = True
      Size = 1
    end
    object CDSNfeDetalheVeiculoCONDICAO_VIN: TStringField
      FieldName = 'CONDICAO_VIN'
      FixedChar = True
      Size = 1
    end
    object CDSNfeDetalheVeiculoCONDICAO_VEICULO: TStringField
      FieldName = 'CONDICAO_VEICULO'
      FixedChar = True
      Size = 1
    end
    object CDSNfeDetalheVeiculoCODIGO_MARCA_MODELO: TStringField
      FieldName = 'CODIGO_MARCA_MODELO'
      Size = 6
    end
    object CDSNfeDetalheVeiculoCODIGO_COR: TStringField
      FieldName = 'CODIGO_COR'
      FixedChar = True
      Size = 2
    end
    object CDSNfeDetalheVeiculoLOTACAO: TIntegerField
      FieldName = 'LOTACAO'
    end
    object CDSNfeDetalheVeiculoRESTRICAO: TStringField
      FieldName = 'RESTRICAO'
      FixedChar = True
      Size = 1
    end
  end
  object DSNfeDetalheVeiculo: TDataSource
    DataSet = CDSNfeDetalheVeiculo
    Left = 212
    Top = 419
  end
  object CDSNfeDetalheArmamento: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'TIPO_ARMA'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMERO_SERIE_ARMA'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'NUMERO_SERIE_CANO'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 250
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 212
    Top = 491
    Data = {
      C40000009619E0BD010000001800000006000000000003000000C40002494404
      000100000000000E49445F4E46455F444554414C484504000100000000000954
      49504F5F41524D410100490020000100055749445448020002000100114E554D
      45524F5F53455249455F41524D41010049000000010005574944544802000200
      0900114E554D45524F5F53455249455F43414E4F010049000000010005574944
      54480200020009000944455343524943414F0100490000000100055749445448
      02000200FA000000}
    object CDSNfeDetalheArmamentoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeDetalheArmamentoID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeDetalheArmamentoTIPO_ARMA: TStringField
      FieldName = 'TIPO_ARMA'
      FixedChar = True
      Size = 1
    end
    object CDSNfeDetalheArmamentoNUMERO_SERIE_ARMA: TStringField
      FieldName = 'NUMERO_SERIE_ARMA'
      Size = 9
    end
    object CDSNfeDetalheArmamentoNUMERO_SERIE_CANO: TStringField
      FieldName = 'NUMERO_SERIE_CANO'
      Size = 9
    end
    object CDSNfeDetalheArmamentoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 250
    end
  end
  object DSNfeDetalheArmamento: TDataSource
    DataSet = CDSNfeDetalheArmamento
    Left = 212
    Top = 539
  end
  object CDSNfeDetalheCombustivel: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_ANP'
        DataType = ftInteger
      end
      item
        Name = 'CODIF'
        DataType = ftString
        Size = 21
      end
      item
        Name = 'QUANTIDADE_TEMP_AMBIENTE'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'UF_CONSUMO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'BASE_CALCULO_CIDE'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_CIDE'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_CIDE'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 356
    Top = 371
    Data = {
      580100009619E0BD020000001800000009000000000003000000580102494404
      000100000000000E49445F4E46455F444554414C484504000100000000000A43
      4F4449474F5F414E50040001000000000005434F444946010049000000010005
      5749445448020002001500185155414E5449444144455F54454D505F414D4249
      454E54450C0012000000020008444543494D414C530200020006000557494454
      480200020014000A55465F434F4E53554D4F0100490020000100055749445448
      02000200020011424153455F43414C43554C4F5F434944450C00120000000200
      08444543494D414C530200020006000557494454480200020014000D414C4951
      554F54415F434944450C0012000000020008444543494D414C53020002000600
      0557494454480200020014000A56414C4F525F434944450C0012000000020008
      444543494D414C530200020006000557494454480200020014000000}
    object CDSNfeDetalheCombustivelID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeDetalheCombustivelID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeDetalheCombustivelCODIGO_ANP: TIntegerField
      FieldName = 'CODIGO_ANP'
    end
    object CDSNfeDetalheCombustivelCODIF: TStringField
      FieldName = 'CODIF'
      Size = 21
    end
    object CDSNfeDetalheCombustivelQUANTIDADE_TEMP_AMBIENTE: TFMTBCDField
      FieldName = 'QUANTIDADE_TEMP_AMBIENTE'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheCombustivelUF_CONSUMO: TStringField
      FieldName = 'UF_CONSUMO'
      FixedChar = True
      Size = 2
    end
    object CDSNfeDetalheCombustivelBASE_CALCULO_CIDE: TFMTBCDField
      FieldName = 'BASE_CALCULO_CIDE'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheCombustivelALIQUOTA_CIDE: TFMTBCDField
      FieldName = 'ALIQUOTA_CIDE'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheCombustivelVALOR_CIDE: TFMTBCDField
      FieldName = 'VALOR_CIDE'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
  end
  object DSNfeDetalheCombustivel: TDataSource
    DataSet = CDSNfeDetalheCombustivel
    Left = 356
    Top = 419
  end
  object CDSNfeDetalheMedicamento: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_DETALHE'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO_LOTE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'QUANTIDADE_LOTE'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'DATA_FABRICACAO'
        DataType = ftDate
      end
      item
        Name = 'DATA_VALIDADE'
        DataType = ftDate
      end
      item
        Name = 'PRECO_MAXIMO_CONSUMIDOR'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_DETALHE'
    MasterFields = 'ID'
    MasterSource = DSNfeDetalhe
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 356
    Top = 491
    Data = {
      F80000009619E0BD020000001800000007000000000003000000F80002494404
      000100000000000E49445F4E46455F444554414C484504000100000000000B4E
      554D45524F5F4C4F544501004900000001000557494454480200020014000F51
      55414E5449444144455F4C4F54450C0012000000020008444543494D414C5302
      00020006000557494454480200020014000F444154415F464142524943414341
      4F04000600000000000D444154415F56414C4944414445040006000000000017
      505245434F5F4D4158494D4F5F434F4E53554D49444F520C0012000000020008
      444543494D414C530200020006000557494454480200020014000000}
    object CDSNfeDetalheMedicamentoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSNfeDetalheMedicamentoID_NFE_DETALHE: TIntegerField
      FieldName = 'ID_NFE_DETALHE'
    end
    object CDSNfeDetalheMedicamentoNUMERO_LOTE: TStringField
      FieldName = 'NUMERO_LOTE'
    end
    object CDSNfeDetalheMedicamentoQUANTIDADE_LOTE: TFMTBCDField
      FieldName = 'QUANTIDADE_LOTE'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSNfeDetalheMedicamentoDATA_FABRICACAO: TDateField
      FieldName = 'DATA_FABRICACAO'
      EditMask = '##/##/####'
    end
    object CDSNfeDetalheMedicamentoDATA_VALIDADE: TDateField
      FieldName = 'DATA_VALIDADE'
      EditMask = '##/##/####'
    end
    object CDSNfeDetalheMedicamentoPRECO_MAXIMO_CONSUMIDOR: TFMTBCDField
      FieldName = 'PRECO_MAXIMO_CONSUMIDOR'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
  end
  object DSNfeDetalheMedicamento: TDataSource
    DataSet = CDSNfeDetalheMedicamento
    Left = 356
    Top = 539
  end
  object CDSVolumesLacres: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_NFE_TRANSPORTE_VOLUME'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO'
        DataType = ftString
        Size = 60
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_NFE_TRANSPORTE_VOLUME'
    MasterFields = 'ID'
    MasterSource = DSVolumes
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 492
    Top = 371
    Data = {
      610000009619E0BD010000001800000003000000000003000000610002494404
      000100000000001849445F4E46455F5452414E53504F5254455F564F4C554D45
      0400010000000000064E554D45524F0100490000000100055749445448020002
      003C000000}
    object CDSVolumesLacresID: TIntegerField
      FieldName = 'ID'
    end
    object CDSVolumesLacresID_NFE_TRANSPORTE_VOLUME: TIntegerField
      FieldName = 'ID_NFE_TRANSPORTE_VOLUME'
    end
    object CDSVolumesLacresNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 60
    end
  end
  object DSVolumesLacres: TDataSource
    DataSet = CDSVolumesLacres
    Left = 492
    Top = 419
  end
  object CDSNfeNumero: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'SERIE'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'NUMERO'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 492
    Top = 491
  end
  object DSNfeNumero: TDataSource
    DataSet = CDSNfeNumero
    Left = 492
    Top = 539
  end
end
