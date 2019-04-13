/*
SQLyog Community Edition- MySQL GUI v7.14 
MySQL - 5.1.30-community : Database - t2tipafecf
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`t2tipafecf` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `t2tipafecf`;

/*Table structure for table `banco` */

CREATE TABLE `banco` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CODIGO` int(10) unsigned DEFAULT NULL,
  `NOME` varchar(100) DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=latin1;

/*Table structure for table `cfop` */

CREATE TABLE `cfop` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CFOP` int(10) unsigned DEFAULT NULL,
  `DESCRICAO` text,
  `APLICACAO` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=542 DEFAULT CHARSET=latin1;

/*Table structure for table `cliente` */

CREATE TABLE `cliente` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_SITUACAO_CLI` int(10) unsigned NOT NULL,
  `NOME` varchar(150) DEFAULT NULL,
  `CPF_CNPJ` varchar(14) DEFAULT NULL,
  `RG` varchar(20) DEFAULT NULL,
  `ORGAO_RG` varchar(10) DEFAULT NULL,
  `INSCRICAO_ESTADUAL` varchar(30) DEFAULT NULL,
  `INSCRICAO_MUNICIPAL` varchar(30) DEFAULT NULL,
  `DESDE` date DEFAULT NULL,
  `TIPO_PESSOA` char(1) DEFAULT NULL,
  `EXCLUIDO` char(1) DEFAULT NULL,
  `DATA_CADASTRO` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_SITUACAO_CLIENTE` (`ID_SITUACAO_CLI`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`ID_SITUACAO_CLI`) REFERENCES `situacao_cli` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3589 DEFAULT CHARSET=latin1;

/*Table structure for table `contato` */

CREATE TABLE `contato` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` int(10) unsigned NOT NULL,
  `NOME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_CLIENTE_CONTATO` (`ID_CLIENTE`),
  CONSTRAINT `contato_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `contato_email` */

CREATE TABLE `contato_email` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CONTATO` int(10) unsigned NOT NULL,
  `ID_TIPO_EMAIL` int(10) unsigned NOT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_TIPO_EMAIL_CONTATO` (`ID_TIPO_EMAIL`),
  KEY `FK_CONTATO_EMAIL` (`ID_CONTATO`),
  CONSTRAINT `contato_email_ibfk_1` FOREIGN KEY (`ID_TIPO_EMAIL`) REFERENCES `tipo_email` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `contato_email_ibfk_2` FOREIGN KEY (`ID_CONTATO`) REFERENCES `contato` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `contato_telefone` */

CREATE TABLE `contato_telefone` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CONTATO` int(10) unsigned NOT NULL,
  `ID_TIPO_TELEFONE` int(10) unsigned NOT NULL,
  `TELEFONE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_TIPO_TELEFONE_CONTATO` (`ID_TIPO_TELEFONE`),
  KEY `FK_CONTATO_TELEFONE` (`ID_CONTATO`),
  CONSTRAINT `contato_telefone_ibfk_1` FOREIGN KEY (`ID_TIPO_TELEFONE`) REFERENCES `tipo_telefone` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `contato_telefone_ibfk_2` FOREIGN KEY (`ID_CONTATO`) REFERENCES `contato` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_caixa` */

CREATE TABLE `ecf_caixa` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOME` varchar(30) DEFAULT NULL,
  `DATA_CADASTRO` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_cheque_cliente` */

CREATE TABLE `ecf_cheque_cliente` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_BANCO` int(10) unsigned NOT NULL,
  `ID_CLIENTE` int(10) unsigned NOT NULL,
  `NUMERO_CHEQUE` int(10) unsigned DEFAULT NULL,
  `DATA_CHEQUE` date DEFAULT NULL,
  `VALOR_CHEQUE` decimal(20,6) DEFAULT NULL,
  `OBSERVACOES` text,
  PRIMARY KEY (`ID`),
  KEY `FK_CLIENTE_CHEQUE` (`ID_CLIENTE`),
  KEY `FK_BANCO_CHEQUE` (`ID_BANCO`),
  CONSTRAINT `ecf_cheque_cliente_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_cheque_cliente_ibfk_2` FOREIGN KEY (`ID_BANCO`) REFERENCES `banco` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_configuracao` */

CREATE TABLE `ecf_configuracao` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_IMPRESSORA` int(10) unsigned NOT NULL,
  `ID_ECF_RESOLUCAO` int(10) unsigned NOT NULL,
  `ID_ECF_CAIXA` int(10) unsigned NOT NULL,
  `ID_ECF_EMPRESA` int(10) unsigned NOT NULL,
  `MENSAGEM_CUPOM` varchar(250) DEFAULT NULL,
  `PORTA_ECF` char(10) DEFAULT NULL,
  `PORTA_PINPAD` char(10) DEFAULT NULL,
  `PORTA_BALANCA` char(10) DEFAULT NULL,
  `IP_SERVIDOR` varchar(15) DEFAULT NULL,
  `IP_SITEF` varchar(15) DEFAULT NULL,
  `TIPO_TEF` char(2) DEFAULT NULL,
  `TITULO_TELA_CAIXA` varchar(100) DEFAULT NULL,
  `CAMINHO_IMAGENS_PRODUTOS` varchar(250) DEFAULT NULL,
  `CAMINHO_IMAGENS_MARKETING` varchar(250) DEFAULT NULL,
  `CAMINHO_IMAGENS_LAYOUT` varchar(250) DEFAULT NULL,
  `COR_JANELAS_INTERNAS` varchar(20) DEFAULT NULL,
  `MARKETING_ATIVO` char(1) DEFAULT NULL,
  `CFOP_ECF` int(10) unsigned DEFAULT NULL,
  `CFOP_NF2` int(10) unsigned DEFAULT NULL,
  `TIMEOUT_ECF` int(10) unsigned DEFAULT NULL,
  `INTERVALO_ECF` int(10) unsigned DEFAULT NULL,
  `DESCRICAO_SUPRIMENTO` varchar(20) DEFAULT NULL,
  `DESCRICAO_SANGRIA` varchar(20) DEFAULT NULL,
  `TEF_TIPO_GP` int(10) unsigned DEFAULT NULL,
  `TEF_TEMPO_ESPERA` int(10) unsigned DEFAULT NULL,
  `TEF_ESPERA_STS` int(10) unsigned DEFAULT NULL,
  `TEF_NUMERO_VIAS` int(10) unsigned DEFAULT NULL,
  `INDICE_GERENCIAL_DAV` int(10) unsigned DEFAULT NULL,
  `DECIMAIS_QUANTIDADE` int(10) unsigned DEFAULT NULL,
  `DECIMAIS_VALOR` int(10) unsigned DEFAULT NULL,
  `SINCRONIZADO` char(1) DEFAULT NULL,
  `BITS_POR_SEGUNDO` int(10) DEFAULT NULL,
  `QTDE_MAXIMA_CARTOES` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_EMPRESA_CONFIGURACAO` (`ID_ECF_EMPRESA`),
  KEY `FK_CAIXA_CONFIGURACAO` (`ID_ECF_CAIXA`),
  KEY `FK_RESOLUCAO_CONFIGURACAO` (`ID_ECF_RESOLUCAO`),
  KEY `FK_IMPRESSORA_CONFIGURACAO` (`ID_ECF_IMPRESSORA`),
  CONSTRAINT `ecf_configuracao_ibfk_1` FOREIGN KEY (`ID_ECF_EMPRESA`) REFERENCES `ecf_empresa` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_configuracao_ibfk_2` FOREIGN KEY (`ID_ECF_CAIXA`) REFERENCES `ecf_caixa` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_configuracao_ibfk_3` FOREIGN KEY (`ID_ECF_RESOLUCAO`) REFERENCES `ecf_resolucao` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_configuracao_ibfk_4` FOREIGN KEY (`ID_ECF_IMPRESSORA`) REFERENCES `ecf_impressora` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_contador` */

CREATE TABLE `ecf_contador` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_EMPRESA` int(10) unsigned NOT NULL,
  `CPF` varchar(11) DEFAULT NULL,
  `CNPJ` varchar(14) DEFAULT NULL,
  `NOME` varchar(100) DEFAULT NULL,
  `INSCRICAO_CRC` varchar(15) DEFAULT NULL,
  `FONE` varchar(15) DEFAULT NULL,
  `FAX` varchar(15) DEFAULT NULL,
  `LOGRADOURO` varchar(100) DEFAULT NULL,
  `NUMERO` int(10) unsigned DEFAULT NULL,
  `COMPLEMENTO` varchar(100) DEFAULT NULL,
  `BAIRRO` varchar(30) DEFAULT NULL,
  `CEP` varchar(8) DEFAULT NULL,
  `CODIGO_MUNICIPIO` int(10) unsigned DEFAULT NULL,
  `UF` char(2) DEFAULT NULL,
  `EMAIL` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_EMPRESA_CONTADOR` (`ID_ECF_EMPRESA`),
  CONSTRAINT `ecf_contador_ibfk_1` FOREIGN KEY (`ID_ECF_EMPRESA`) REFERENCES `ecf_empresa` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_dav_cabecalho` */

CREATE TABLE `ecf_dav_cabecalho` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CCF` int(10) unsigned DEFAULT NULL,
  `COO` int(10) unsigned DEFAULT NULL,
  `NOME_DESTINATARIO` varchar(100) DEFAULT NULL,
  `CPF_CNPJ_DESTINATARIO` varchar(14) DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `HORA_EMISSAO` varchar(8) DEFAULT NULL,
  `SITUACAO` char(1) DEFAULT NULL,
  `VALOR` decimal(20,6) DEFAULT NULL,
  `HASH_TRIPA` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_dav_detalhe` */

CREATE TABLE `ecf_dav_detalhe` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PRODUTO` int(10) unsigned NOT NULL,
  `ID_ECF_DAV` int(10) unsigned NOT NULL,
  `QUANTIDADE` decimal(20,6) DEFAULT NULL,
  `VALOR_UNITARIO` decimal(20,6) DEFAULT NULL,
  `VALOR_TOTAL` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_DAV_CAB_DET` (`ID_ECF_DAV`),
  KEY `FK_PRODUTO_DAV_DET` (`ID_PRODUTO`),
  CONSTRAINT `ecf_dav_detalhe_ibfk_1` FOREIGN KEY (`ID_ECF_DAV`) REFERENCES `ecf_dav_cabecalho` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_dav_detalhe_ibfk_2` FOREIGN KEY (`ID_PRODUTO`) REFERENCES `produto` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_documentos_emitidos` */

CREATE TABLE `ecf_documentos_emitidos` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_MOVIMENTO` int(10) unsigned NOT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `HORA_EMISSAO` varchar(8) DEFAULT NULL,
  `TIPO` char(2) DEFAULT NULL,
  `COO` int(10) unsigned DEFAULT NULL,
  `SINCRONIZADO` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_MOVIMENTO_DOC_EMITIDOS` (`ID_ECF_MOVIMENTO`),
  CONSTRAINT `ecf_documentos_emitidos_ibfk_1` FOREIGN KEY (`ID_ECF_MOVIMENTO`) REFERENCES `ecf_movimento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_empresa` */

CREATE TABLE `ecf_empresa` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_EMPRESA` int(10) unsigned NOT NULL,
  `RAZAO_SOCIAL` varchar(150) DEFAULT NULL,
  `NOME_FANTASIA` varchar(150) DEFAULT NULL,
  `CNPJ` varchar(14) DEFAULT NULL,
  `INSCRICAO_ESTADUAL` varchar(30) DEFAULT NULL,
  `INSCRICAO_MUNICIPAL` varchar(30) DEFAULT NULL,
  `MATRIZ_FILIAL` char(1) DEFAULT NULL,
  `DATA_CADASTRO` date DEFAULT NULL,
  `ENDERECO` varchar(100) DEFAULT NULL,
  `NUMERO` varchar(10) DEFAULT NULL,
  `COMPLEMENTO` varchar(100) DEFAULT NULL,
  `BAIRRO` varchar(50) DEFAULT NULL,
  `CIDADE` varchar(50) DEFAULT NULL,
  `CODIGO_MUNICIPIO_IBGE` int(10) unsigned DEFAULT NULL,
  `UF` char(2) DEFAULT NULL,
  `CEP` varchar(8) DEFAULT NULL,
  `FONE1` varchar(10) DEFAULT NULL,
  `FONE2` varchar(10) DEFAULT NULL,
  `CONTATO` varchar(30) DEFAULT NULL,
  `SUFRAMA` varchar(9) DEFAULT NULL,
  `EMAIL` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_EMPRESA_FILIAL` (`ID_EMPRESA`),
  CONSTRAINT `ecf_empresa_ibfk_1` FOREIGN KEY (`ID_EMPRESA`) REFERENCES `ecf_empresa` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_funcionario` */

CREATE TABLE `ecf_funcionario` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOME` varchar(100) DEFAULT NULL,
  `TELEFONE` varchar(10) DEFAULT NULL,
  `CELULAR` varchar(10) DEFAULT NULL,
  `EMAIL` varchar(250) DEFAULT NULL,
  `COMISSAO_VISTA` decimal(20,6) DEFAULT NULL,
  `COMISSAO_PRAZO` decimal(20,6) DEFAULT NULL,
  `NIVEL_AUTORIZACAO` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_impressora` */

CREATE TABLE `ecf_impressora` (
  `ID` int(10) unsigned NOT NULL,
  `NUMERO` int(10) unsigned DEFAULT NULL,
  `CODIGO` varchar(10) DEFAULT NULL,
  `SERIE` varchar(20) DEFAULT NULL,
  `IDENTIFICACAO` varchar(250) DEFAULT NULL,
  `MC` char(2) DEFAULT NULL,
  `MD` char(2) DEFAULT NULL,
  `VR` char(2) DEFAULT NULL,
  `TIPO` varchar(7) DEFAULT NULL,
  `MARCA` varchar(30) DEFAULT NULL,
  `MODELO` varchar(30) DEFAULT NULL,
  `MODELO_ACBR` varchar(30) DEFAULT NULL,
  `MODELO_DOCUMENTO_FISCAL` char(2) DEFAULT NULL,
  `VERSAO` varchar(30) DEFAULT NULL,
  `LE` char(1) DEFAULT NULL,
  `LEF` char(1) DEFAULT NULL,
  `MFD` char(1) DEFAULT NULL,
  `LACRE_NA_MFD` char(1) DEFAULT NULL,
  `DOCTO` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_movimento` */

CREATE TABLE `ecf_movimento` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_EMPRESA` int(10) unsigned NOT NULL,
  `ID_ECF_TURNO` int(10) unsigned NOT NULL,
  `ID_ECF_IMPRESSORA` int(10) unsigned NOT NULL,
  `ID_ECF_OPERADOR` int(10) unsigned NOT NULL,
  `ID_ECF_CAIXA` int(10) unsigned NOT NULL,
  `ID_GERENTE_SUPERVISOR` int(10) unsigned NOT NULL,
  `DATA_ABERTURA` date DEFAULT NULL,
  `HORA_ABERTURA` varchar(8) DEFAULT NULL,
  `DATA_FECHAMENTO` date DEFAULT NULL,
  `HORA_FECHAMENTO` varchar(8) DEFAULT NULL,
  `TOTAL_SUPRIMENTO` decimal(20,6) DEFAULT NULL,
  `TOTAL_SANGRIA` decimal(20,6) DEFAULT NULL,
  `TOTAL_NAO_FISCAL` decimal(20,6) DEFAULT NULL,
  `TOTAL_VENDA` decimal(20,6) DEFAULT NULL,
  `TOTAL_DESCONTO` decimal(20,6) DEFAULT NULL,
  `TOTAL_ACRESCIMO` decimal(20,6) DEFAULT NULL,
  `TOTAL_FINAL` decimal(20,6) DEFAULT NULL,
  `TOTAL_RECEBIDO` decimal(20,6) DEFAULT NULL,
  `TOTAL_TROCO` decimal(20,6) DEFAULT NULL,
  `TOTAL_CANCELADO` decimal(20,6) DEFAULT NULL,
  `STATUS_MOVIMENTO` char(1) NOT NULL,
  `SINCRONIZADO` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_CAIXA_MOVIMENTO` (`ID_ECF_CAIXA`),
  KEY `FK_OPERADOR_MOVIMENTO` (`ID_ECF_OPERADOR`),
  KEY `FK_TURNO_MOVIMENTO` (`ID_ECF_TURNO`),
  KEY `FK_IMPRESSORA_MOVIMENTO` (`ID_ECF_IMPRESSORA`),
  KEY `FK_EMPRESA_MOVIMENTO` (`ID_ECF_EMPRESA`),
  CONSTRAINT `ecf_movimento_ibfk_1` FOREIGN KEY (`ID_ECF_CAIXA`) REFERENCES `ecf_caixa` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_movimento_ibfk_2` FOREIGN KEY (`ID_ECF_OPERADOR`) REFERENCES `ecf_operador` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_movimento_ibfk_3` FOREIGN KEY (`ID_ECF_TURNO`) REFERENCES `ecf_turno` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_movimento_ibfk_4` FOREIGN KEY (`ID_ECF_IMPRESSORA`) REFERENCES `ecf_impressora` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_movimento_ibfk_5` FOREIGN KEY (`ID_ECF_EMPRESA`) REFERENCES `ecf_empresa` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_operador` */

CREATE TABLE `ecf_operador` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_FUNCIONARIO` int(10) unsigned NOT NULL,
  `LOGIN` varchar(20) DEFAULT NULL,
  `SENHA` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_FUNCIONARIO_OPERADOR` (`ID_ECF_FUNCIONARIO`),
  CONSTRAINT `ecf_operador_ibfk_1` FOREIGN KEY (`ID_ECF_FUNCIONARIO`) REFERENCES `ecf_funcionario` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_posicao_componentes` */

CREATE TABLE `ecf_posicao_componentes` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_RESOLUCAO` int(10) unsigned NOT NULL,
  `NOME` varchar(100) DEFAULT NULL,
  `ALTURA` int(10) unsigned DEFAULT NULL,
  `LARGURA` int(10) unsigned DEFAULT NULL,
  `TOPO` int(10) unsigned DEFAULT NULL,
  `ESQUERDA` int(10) unsigned DEFAULT NULL,
  `TAMANHO_FONTE` int(10) unsigned DEFAULT '0',
  `TEXTO` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_RESOLUCAO_POSICAO_COMPONENTES` (`ID_ECF_RESOLUCAO`),
  CONSTRAINT `ecf_posicao_componentes_ibfk_1` FOREIGN KEY (`ID_ECF_RESOLUCAO`) REFERENCES `ecf_resolucao` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_pre_venda_cabecalho` */

CREATE TABLE `ecf_pre_venda_cabecalho` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DATA_PV` date DEFAULT NULL,
  `HORA_PV` varchar(8) DEFAULT NULL,
  `SITUACAO` char(1) DEFAULT NULL,
  `CCF` int(10) unsigned DEFAULT NULL,
  `VALOR` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_pre_venda_detalhe` */

CREATE TABLE `ecf_pre_venda_detalhe` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PRODUTO` int(10) unsigned NOT NULL,
  `ID_ECF_PRE_VENDA_CABECALHO` int(10) unsigned NOT NULL,
  `QUANTIDADE` decimal(20,6) DEFAULT NULL,
  `VALOR_UNITARIO` decimal(20,6) DEFAULT NULL,
  `VALOR_TOTAL` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_PV_CAB_DET` (`ID_ECF_PRE_VENDA_CABECALHO`),
  KEY `FK_PRODUTO_PV_DET` (`ID_PRODUTO`),
  CONSTRAINT `ecf_pre_venda_detalhe_ibfk_1` FOREIGN KEY (`ID_ECF_PRE_VENDA_CABECALHO`) REFERENCES `ecf_pre_venda_cabecalho` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_pre_venda_detalhe_ibfk_2` FOREIGN KEY (`ID_PRODUTO`) REFERENCES `produto` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_recebimento_nao_fiscal` */

CREATE TABLE `ecf_recebimento_nao_fiscal` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_MOVIMENTO` int(10) unsigned NOT NULL,
  `DATA_RECBTO` date DEFAULT NULL,
  `DESCRICAO` varchar(50) DEFAULT NULL,
  `VALOR` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_MOVIMENTO_RECBTO_NAO_FISCAL` (`ID_ECF_MOVIMENTO`),
  CONSTRAINT `ecf_recebimento_nao_fiscal_ibfk_1` FOREIGN KEY (`ID_ECF_MOVIMENTO`) REFERENCES `ecf_movimento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_resolucao` */

CREATE TABLE `ecf_resolucao` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RESOLUCAO_TELA` varchar(20) DEFAULT NULL,
  `LARGURA` int(10) unsigned DEFAULT NULL,
  `ALTURA` int(10) unsigned DEFAULT NULL,
  `IMAGEM_TELA` varchar(50) DEFAULT NULL,
  `IMAGEM_MENU` varchar(50) DEFAULT NULL,
  `IMAGEM_SUBMENU` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_sangria` */

CREATE TABLE `ecf_sangria` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_MOVIMENTO` int(10) unsigned NOT NULL,
  `DATA_SANGRIA` date DEFAULT NULL,
  `VALOR` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_MOVIMENTO_SANGRIA` (`ID_ECF_MOVIMENTO`),
  CONSTRAINT `ecf_sangria_ibfk_1` FOREIGN KEY (`ID_ECF_MOVIMENTO`) REFERENCES `ecf_movimento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_suprimento` */

CREATE TABLE `ecf_suprimento` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_MOVIMENTO` int(10) unsigned NOT NULL,
  `DATA_SUPRIMENTO` date DEFAULT NULL,
  `VALOR` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_MOVIMENTO_SUPRIMENTO` (`ID_ECF_MOVIMENTO`),
  CONSTRAINT `ecf_suprimento_ibfk_1` FOREIGN KEY (`ID_ECF_MOVIMENTO`) REFERENCES `ecf_movimento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_tipo_pagamento` */

CREATE TABLE `ecf_tipo_pagamento` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CODIGO` char(3) DEFAULT NULL,
  `DESCRICAO` varchar(20) DEFAULT NULL,
  `TEF` char(1) DEFAULT NULL,
  `IMPRIME_VINCULADO` char(1) DEFAULT NULL,
  `PERMITE_TROCO` char(1) DEFAULT NULL,
  `TEF_TIPO_GP` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_total_tipo_pgto` */

CREATE TABLE `ecf_total_tipo_pgto` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_VENDA_CABECALHO` int(10) unsigned NOT NULL,
  `ID_ECF_TIPO_PAGAMENTO` int(10) unsigned NOT NULL,
  `VALOR` decimal(20,6) DEFAULT NULL,
  `NSU` varchar(30) DEFAULT NULL,
  `ESTORNO` char(1) DEFAULT NULL,
  `REDE` varchar(10) DEFAULT NULL,
  `CARTAO_DC` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_TIPO_PGTO_TOTAL` (`ID_ECF_TIPO_PAGAMENTO`),
  KEY `FK_VENDA_CAB_TOTAL_TIPO_PGTO` (`ID_ECF_VENDA_CABECALHO`),
  CONSTRAINT `ecf_total_tipo_pgto_ibfk_1` FOREIGN KEY (`ID_ECF_TIPO_PAGAMENTO`) REFERENCES `ecf_tipo_pagamento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_total_tipo_pgto_ibfk_2` FOREIGN KEY (`ID_ECF_VENDA_CABECALHO`) REFERENCES `ecf_venda_cabecalho` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_turno` */

CREATE TABLE `ecf_turno` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(10) DEFAULT NULL,
  `HORA_INICIO` varchar(8) DEFAULT NULL,
  `HORA_FIM` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_venda_cabecalho` */

CREATE TABLE `ecf_venda_cabecalho` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_DAV` int(10) unsigned DEFAULT NULL,
  `ID_ECF_PRE_VENDA_CABECALHO` int(10) unsigned DEFAULT NULL,
  `ID_CLIENTE` int(10) unsigned DEFAULT NULL,
  `ID_ECF_FUNCIONARIO` int(10) unsigned DEFAULT NULL,
  `ID_ECF_MOVIMENTO` int(10) unsigned NOT NULL,
  `CFOP` int(10) unsigned NOT NULL,
  `COO` int(10) unsigned DEFAULT NULL,
  `CCF` int(10) unsigned DEFAULT NULL,
  `DATA_VENDA` date DEFAULT NULL,
  `HORA_VENDA` varchar(8) DEFAULT NULL,
  `VALOR_VENDA` decimal(20,6) DEFAULT NULL,
  `TAXA_DESCONTO` decimal(20,6) DEFAULT NULL,
  `DESCONTO` decimal(20,6) DEFAULT NULL,
  `TAXA_ACRESCIMO` decimal(20,6) DEFAULT NULL,
  `ACRESCIMO` decimal(20,6) DEFAULT NULL,
  `VALOR_FINAL` decimal(20,6) DEFAULT NULL,
  `VALOR_RECEBIDO` decimal(20,6) DEFAULT NULL,
  `TROCO` decimal(20,6) DEFAULT NULL,
  `VALOR_CANCELADO` decimal(20,6) DEFAULT NULL,
  `SINCRONIZADO` char(1) DEFAULT NULL,
  `TOTAL_PRODUTOS` decimal(20,6) DEFAULT NULL,
  `TOTAL_DOCUMENTO` decimal(20,6) DEFAULT NULL,
  `BASE_ICMS` decimal(20,6) DEFAULT NULL,
  `ICMS` decimal(20,6) DEFAULT NULL,
  `ICMS_OUTRAS` decimal(20,6) DEFAULT NULL,
  `ISSQN` decimal(20,6) DEFAULT NULL,
  `PIS` decimal(20,6) DEFAULT NULL,
  `COFINS` decimal(20,6) DEFAULT NULL,
  `ACRESCIMO_ITENS` decimal(20,6) DEFAULT NULL,
  `DESCONTO_ITENS` decimal(20,6) DEFAULT NULL,
  `STATUS_VENDA` char(1) DEFAULT NULL,
  `NOME_CLIENTE` varchar(100) DEFAULT NULL,
  `CPF_CNPJ_CLIENTE` varchar(14) DEFAULT NULL,
  `CUPOM_CANCELADO` char(1) DEFAULT NULL,
  `VINCULADO_IMPRESSO_1VIA` char(1) DEFAULT NULL,
  `VINCULADO_IMPRESSO_2VIA` char(1) DEFAULT NULL,
  `HASH_TRIPA` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_MOVIMENTO_VENDA_CAB` (`ID_ECF_MOVIMENTO`),
  KEY `FK_VENDEDOR_VENDA` (`ID_ECF_FUNCIONARIO`),
  KEY `FK_CLIENTE_VENDA` (`ID_CLIENTE`),
  KEY `FK_PV_VENDA` (`ID_ECF_PRE_VENDA_CABECALHO`),
  KEY `FK_DAV_VENDA` (`ID_ECF_DAV`),
  CONSTRAINT `ecf_venda_cabecalho_ibfk_1` FOREIGN KEY (`ID_ECF_MOVIMENTO`) REFERENCES `ecf_movimento` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_venda_cabecalho_ibfk_2` FOREIGN KEY (`ID_ECF_FUNCIONARIO`) REFERENCES `ecf_funcionario` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_venda_cabecalho_ibfk_3` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_venda_cabecalho_ibfk_4` FOREIGN KEY (`ID_ECF_PRE_VENDA_CABECALHO`) REFERENCES `ecf_pre_venda_cabecalho` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_venda_cabecalho_ibfk_5` FOREIGN KEY (`ID_ECF_DAV`) REFERENCES `ecf_dav_cabecalho` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=latin1;

/*Table structure for table `ecf_venda_detalhe` */

CREATE TABLE `ecf_venda_detalhe` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_PRODUTO` int(10) unsigned NOT NULL,
  `ID_ECF_VENDA_CABECALHO` int(10) unsigned NOT NULL,
  `CFOP` int(10) unsigned NOT NULL,
  `ITEM` int(10) unsigned DEFAULT NULL,
  `QUANTIDADE` decimal(20,6) DEFAULT NULL,
  `VALOR_UNITARIO` decimal(20,6) DEFAULT NULL,
  `VALOR_TOTAL` decimal(20,6) DEFAULT NULL,
  `TOTAL_ITEM` decimal(20,6) DEFAULT NULL,
  `BASE_ICMS` decimal(20,6) DEFAULT NULL,
  `TAXA_ICMS` decimal(20,6) DEFAULT NULL,
  `ICMS` decimal(20,6) DEFAULT NULL,
  `TAXA_DESCONTO` decimal(20,6) DEFAULT NULL,
  `DESCONTO` decimal(20,6) DEFAULT NULL,
  `TAXA_ISSQN` decimal(20,6) DEFAULT NULL,
  `ISSQN` decimal(20,6) DEFAULT NULL,
  `TAXA_PIS` decimal(20,6) DEFAULT NULL,
  `PIS` decimal(20,6) DEFAULT NULL,
  `TAXA_COFINS` decimal(20,6) DEFAULT NULL,
  `COFINS` decimal(20,6) DEFAULT NULL,
  `TAXA_ACRESCIMO` decimal(20,6) DEFAULT NULL,
  `ACRESCIMO` decimal(20,6) DEFAULT NULL,
  `ACRESCIMO_RATEIO` decimal(20,6) DEFAULT NULL,
  `DESCONTO_RATEIO` decimal(20,6) DEFAULT NULL,
  `TOTALIZADOR_PARCIAL` varchar(10) DEFAULT NULL,
  `CST` char(3) DEFAULT NULL,
  `CANCELADO` char(1) DEFAULT NULL,
  `MOVIMENTA_ESTOQUE` char(1) DEFAULT NULL,
  `HASH_TRIPA` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_VENDA_CAB_DET` (`ID_ECF_VENDA_CABECALHO`),
  KEY `FK_PRODUTO_VENDA_DET` (`ID_ECF_PRODUTO`),
  CONSTRAINT `ecf_venda_detalhe_ibfk_1` FOREIGN KEY (`ID_ECF_VENDA_CABECALHO`) REFERENCES `ecf_venda_cabecalho` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ecf_venda_detalhe_ibfk_2` FOREIGN KEY (`ID_ECF_PRODUTO`) REFERENCES `produto` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=latin1;

/*Table structure for table `endereco` */

CREATE TABLE `endereco` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` int(10) unsigned NOT NULL,
  `LOGRADOURO` varchar(100) DEFAULT NULL,
  `NUMERO` int(10) unsigned DEFAULT NULL,
  `COMPLEMENTO` varchar(100) DEFAULT NULL,
  `BAIRRO` varchar(50) DEFAULT NULL,
  `CEP` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_CLIENTE_ENDERECO` (`ID_CLIENTE`),
  CONSTRAINT `endereco_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ficha_tecnica` */

CREATE TABLE `ficha_tecnica` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PRODUTO` int(10) unsigned NOT NULL,
  `DESCRICAO` varchar(50) DEFAULT NULL,
  `ID_PRODUTO_FILHO` int(10) unsigned DEFAULT NULL,
  `QUANTIDADE` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_PRODUTO_FICHA_TECNICA` (`ID_PRODUTO`),
  CONSTRAINT `ficha_tecnica_ibfk_1` FOREIGN KEY (`ID_PRODUTO`) REFERENCES `produto` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `nf2_cabecalho` */

CREATE TABLE `nf2_cabecalho` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_ECF_FUNCIONARIO` int(10) unsigned NOT NULL,
  `ID_CLIENTE` int(10) unsigned NOT NULL,
  `CFOP` int(10) unsigned NOT NULL,
  `NUMERO` varchar(6) DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `HORA_EMISSAO` varchar(8) DEFAULT NULL,
  `SERIE` char(2) DEFAULT NULL,
  `SUBSERIE` char(2) DEFAULT NULL,
  `TOTAL_PRODUTOS` decimal(20,6) DEFAULT NULL,
  `TOTAL_NF` decimal(20,6) DEFAULT NULL,
  `BASE_ICMS` decimal(20,6) DEFAULT NULL,
  `ICMS` decimal(20,6) DEFAULT NULL,
  `ICMS_OUTRAS` decimal(20,6) DEFAULT NULL,
  `ISSQN` decimal(20,6) DEFAULT NULL,
  `PIS` decimal(20,6) DEFAULT NULL,
  `COFINS` decimal(20,6) DEFAULT NULL,
  `IPI` decimal(20,6) DEFAULT NULL,
  `TAXA_ACRESCIMO` decimal(20,6) DEFAULT NULL,
  `ACRESCIMO` decimal(20,6) DEFAULT NULL,
  `ACRESCIMO_ITENS` decimal(20,6) DEFAULT NULL,
  `TAXA_DESCONTO` decimal(20,6) DEFAULT NULL,
  `DESCONTO` decimal(20,6) DEFAULT NULL,
  `DESCONTO_ITENS` decimal(20,6) DEFAULT NULL,
  `CANCELADA` char(1) DEFAULT NULL,
  `SINCRONIZADO` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_CLIENTE_NF2` (`ID_CLIENTE`),
  KEY `FK_VENDEDOR_NF2` (`ID_ECF_FUNCIONARIO`),
  CONSTRAINT `nf2_cabecalho_ibfk_1` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `nf2_cabecalho_ibfk_2` FOREIGN KEY (`ID_ECF_FUNCIONARIO`) REFERENCES `ecf_funcionario` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `nf2_detalhe` */

CREATE TABLE `nf2_detalhe` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PRODUTO` int(10) unsigned NOT NULL,
  `ID_NF2_CABECALHO` int(10) unsigned NOT NULL,
  `CFOP` int(10) unsigned NOT NULL,
  `ITEM` int(10) unsigned DEFAULT NULL,
  `QUANTIDADE` decimal(20,6) DEFAULT NULL,
  `VALOR_UNITARIO` decimal(20,6) DEFAULT NULL,
  `VALOR_TOTAL` decimal(20,6) DEFAULT NULL,
  `BASE_ICMS` decimal(20,6) DEFAULT NULL,
  `TAXA_ICMS` decimal(20,6) DEFAULT NULL,
  `ICMS` decimal(20,6) DEFAULT NULL,
  `ICMS_OUTRAS` decimal(20,6) DEFAULT NULL,
  `ICMS_ISENTO` decimal(20,6) DEFAULT NULL,
  `TAXA_DESCONTO` decimal(20,6) DEFAULT NULL,
  `DESCONTO` decimal(20,6) DEFAULT NULL,
  `TAXA_ISSQN` decimal(20,6) DEFAULT NULL,
  `ISSQN` decimal(20,6) DEFAULT NULL,
  `TAXA_PIS` decimal(20,6) DEFAULT NULL,
  `PIS` decimal(20,6) DEFAULT NULL,
  `TAXA_COFINS` decimal(20,6) DEFAULT NULL,
  `COFINS` decimal(20,6) DEFAULT NULL,
  `TAXA_ACRESCIMO` decimal(20,6) DEFAULT NULL,
  `ACRESCIMO` decimal(20,6) DEFAULT NULL,
  `TAXA_IPI` decimal(20,6) DEFAULT NULL,
  `IPI` decimal(20,6) DEFAULT NULL,
  `CANCELADO` char(1) DEFAULT NULL,
  `CST` char(3) DEFAULT NULL,
  `MOVIMENTA_ESTOQUE` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_NF2_CAB_DET` (`ID_NF2_CABECALHO`),
  KEY `FK_PRODUTO_NF2_DET` (`ID_PRODUTO`),
  CONSTRAINT `nf2_detalhe_ibfk_1` FOREIGN KEY (`ID_NF2_CABECALHO`) REFERENCES `nf2_cabecalho` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `nf2_detalhe_ibfk_2` FOREIGN KEY (`ID_PRODUTO`) REFERENCES `produto` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `produto` */

CREATE TABLE `produto` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_UNIDADE_PRODUTO` int(10) unsigned NOT NULL,
  `GTIN` varchar(14) DEFAULT NULL,
  `CODIGO_INTERNO` varchar(20) DEFAULT NULL,
  `NOME` varchar(100) DEFAULT NULL,
  `DESCRICAO` text,
  `DESCRICAO_PDV` varchar(30) DEFAULT NULL,
  `VALOR_VENDA` decimal(20,6) DEFAULT NULL,
  `QTD_ESTOQUE` decimal(20,6) DEFAULT NULL,
  `ESTOQUE_MIN` decimal(20,6) DEFAULT NULL,
  `ESTOQUE_MAX` decimal(20,6) DEFAULT NULL,
  `IAT` char(1) DEFAULT NULL,
  `IPPT` char(1) DEFAULT NULL,
  `NCM` varchar(8) DEFAULT NULL,
  `TIPO_ITEM_SPED` char(2) DEFAULT NULL,
  `DATA_ESTOQUE` date DEFAULT NULL,
  `HASH_TRIPA` varchar(32) DEFAULT NULL,
  `TAXA_IPI` decimal(20,6) DEFAULT NULL,
  `TAXA_ISSQN` decimal(20,6) DEFAULT NULL,
  `TAXA_PIS` decimal(20,6) DEFAULT NULL,
  `TAXA_COFINS` decimal(20,6) DEFAULT NULL,
  `TAXA_ICMS` decimal(20,6) DEFAULT NULL,
  `CST` char(3) DEFAULT NULL,
  `TOTALIZADOR_PARCIAL` varchar(10) DEFAULT NULL,
  `ECF_ICMS_ST` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_UNIDADE_PRODUTO` (`ID_UNIDADE_PRODUTO`),
  CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`ID_UNIDADE_PRODUTO`) REFERENCES `unidade_produto` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9500 DEFAULT CHARSET=latin1;

/*Table structure for table `produto_promocao` */

CREATE TABLE `produto_promocao` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PRODUTO` int(10) unsigned NOT NULL,
  `DATA_INICIO` date DEFAULT NULL,
  `DATA_FIM` date DEFAULT NULL,
  `QUANTIDADE_EM_PROMOCAO` decimal(20,6) DEFAULT NULL,
  `QUANTIDADE_MAXIMA_CLIENTE` decimal(20,6) DEFAULT NULL,
  `VALOR` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_PRODUTO_PROMOCAO` (`ID_PRODUTO`),
  CONSTRAINT `produto_promocao_ibfk_1` FOREIGN KEY (`ID_PRODUTO`) REFERENCES `produto` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `r01` */

CREATE TABLE `r01` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CNPJ_SH` varchar(14) DEFAULT NULL,
  `INSCRICAO_ESTADUAL_SH` varchar(14) DEFAULT NULL,
  `INSCRICAO_MUNICIPAL_SH` varchar(14) DEFAULT NULL,
  `DENOMINACAO_SH` varchar(40) DEFAULT NULL,
  `NOME_PAF_ECF` varchar(40) DEFAULT NULL,
  `VERSAO_PAF_ECF` varchar(10) DEFAULT NULL,
  `MD5_PAF_ECF` varchar(32) DEFAULT NULL,
  `DATA_INICIAL` date DEFAULT NULL,
  `DATA_FINAL` date DEFAULT NULL,
  `VERSAO_ER` varchar(4) DEFAULT NULL,
  `NUMERO_LAUDO_PAF` varchar(40) DEFAULT NULL,
  `RAZAO_SOCIAL_SH` varchar(40) DEFAULT NULL,
  `ENDERECO_SH` varchar(40) DEFAULT NULL,
  `NUMERO_SH` varchar(10) DEFAULT NULL,
  `COMPLEMENTO_SH` varchar(40) DEFAULT NULL,
  `BAIRRO_SH` varchar(40) DEFAULT NULL,
  `CIDADE_SH` varchar(40) DEFAULT NULL,
  `CEP_SH` varchar(8) DEFAULT NULL,
  `UF_SH` char(2) DEFAULT NULL,
  `TELEFONE_SH` varchar(10) DEFAULT NULL,
  `CONTATO_SH` varchar(20) DEFAULT NULL,
  `PRINCIPAL_EXECUTAVEL` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `r02` */

CREATE TABLE `r02` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_OPERADOR` int(10) unsigned NOT NULL,
  `ID_IMPRESSORA` int(10) unsigned NOT NULL,
  `ID_ECF_CAIXA` int(10) unsigned DEFAULT NULL,
  `CRZ` int(10) unsigned DEFAULT NULL,
  `COO` int(10) unsigned DEFAULT NULL,
  `CRO` int(10) unsigned DEFAULT NULL,
  `DATA_MOVIMENTO` date DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `HORA_EMISSAO` varchar(8) DEFAULT NULL,
  `VENDA_BRUTA` decimal(20,6) DEFAULT NULL,
  `GRANDE_TOTAL` decimal(20,6) DEFAULT NULL,
  `SINCRONIZADO` char(1) DEFAULT NULL,
  `HASH_TRIPA` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `r03` */

CREATE TABLE `r03` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_R02` int(10) unsigned NOT NULL,
  `TOTALIZADOR_PARCIAL` varchar(10) DEFAULT NULL,
  `VALOR_ACUMULADO` decimal(20,6) DEFAULT NULL,
  `HASH_TRIPA` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_R02_R03` (`ID_R02`),
  CONSTRAINT `r03_ibfk_1` FOREIGN KEY (`ID_R02`) REFERENCES `r02` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Table structure for table `r06` */

CREATE TABLE `r06` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_OPERADOR` int(10) unsigned NOT NULL,
  `ID_IMPRESSORA` int(10) unsigned NOT NULL,
  `ID_ECF_CAIXA` int(10) unsigned DEFAULT NULL,
  `COO` int(10) unsigned DEFAULT NULL,
  `GNF` int(10) unsigned DEFAULT NULL,
  `GRG` int(10) unsigned DEFAULT NULL,
  `CDC` int(10) unsigned DEFAULT NULL,
  `DENOMINACAO` char(2) DEFAULT NULL,
  `DATA_EMISSAO` date DEFAULT NULL,
  `HORA_EMISSAO` varchar(8) DEFAULT NULL,
  `SINCRONIZADO` char(1) DEFAULT NULL,
  `HASH_TRIPA` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;

/*Table structure for table `r07` */

CREATE TABLE `r07` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_R06` int(10) unsigned DEFAULT NULL,
  `CCF` int(10) unsigned DEFAULT NULL,
  `MEIO_PAGAMENTO` varchar(20) DEFAULT NULL,
  `VALOR_PAGAMENTO` decimal(20,6) DEFAULT NULL,
  `ESTORNO` char(1) DEFAULT NULL,
  `VALOR_ESTORNO` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_R06_R07` (`ID_R06`),
  CONSTRAINT `r07_ibfk_1` FOREIGN KEY (`ID_R06`) REFERENCES `r06` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `sintegra_60a` */

CREATE TABLE `sintegra_60a` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ID_SINTEGRA_60M` int(10) unsigned NOT NULL,
  `SITUACAO_TRIBUTARIA` varchar(4) DEFAULT NULL,
  `VALOR` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `SINTEGRA_60A_FKIndex1` (`ID_SINTEGRA_60M`),
  CONSTRAINT `sintegra_60a_ibfk_1` FOREIGN KEY (`ID_SINTEGRA_60M`) REFERENCES `sintegra_60m` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Table structure for table `sintegra_60m` */

CREATE TABLE `sintegra_60m` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DATA_EMISSAO` date DEFAULT NULL,
  `NUMERO_SERIE_ECF` varchar(20) DEFAULT NULL,
  `NUMERO_EQUIPAMENTO` int(10) unsigned DEFAULT NULL,
  `MODELO_DOCUMENTO_FISCAL` char(2) DEFAULT NULL,
  `COO_INICIAL` int(10) unsigned DEFAULT NULL,
  `COO_FINAL` int(10) unsigned DEFAULT NULL,
  `CRZ` int(10) unsigned DEFAULT NULL,
  `CRO` int(10) unsigned DEFAULT NULL,
  `VALOR_VENDA_BRUTA` decimal(20,6) DEFAULT NULL,
  `VALOR_GRANDE_TOTAL` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `situacao_cli` */

CREATE TABLE `situacao_cli` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOME` varchar(20) DEFAULT NULL,
  `DESCRICAO` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `tipo_email` */

CREATE TABLE `tipo_email` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOME` varchar(20) DEFAULT NULL,
  `DESCRICAO` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tipo_telefone` */

CREATE TABLE `tipo_telefone` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOME` varchar(20) DEFAULT NULL,
  `DESCRICAO` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `unidade_produto` */

CREATE TABLE `unidade_produto` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NOME` varchar(10) DEFAULT NULL,
  `DESCRICAO` text,
  `PODE_FRACIONAR` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;