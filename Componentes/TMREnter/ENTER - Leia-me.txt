{=======================================================================}
{   TMREnter                                                            }
{                                                                       }
{   Autor : Martins(martins@mrw.com.br)                                 }
{                  (http://www.mrsoftware.com.br/user/martins)          }
{           10/08/1997                                                  }
{           São Paulo - Brazil                                          }
{                                                                       }
{   Colaboradores :                                                     }
{           Dennis Rosa (dra@svn.com.br)                                }
{           Mauricio Rother (mrother@plugon.com.br)                     }
{           Paulo H. Trentin (phtrentin@feob.br)                        }
{           Fernando Sarturi Prass (prass@unifra.br)                    }
{=======================================================================}
{ Historico                                                             }
{                                                                       }
{   30/05/2001 V 2.1                                                    }
{                                                                       }
{   Um BUG introduzido nesta ultima versao fazia com que um erro de     }
{   violacao de acesso fosse encontrado com controles do tipo Lookup    }
{   e combo, foi corrigido...                                           }
{   Obrigado pela força Fernando !!!                                    }
{                                                                       }
{   30/05/2001 V 2.0                                                    }
{                                                                       }
{   Pessoal, o Lançamento da  versao 2.0 se deve ao fato de que         }
{   varias das mudancas foram significativas no funcionamento do        }
{   componente, claro que algumas coisas tambem foram bugs arrumados!   }
{                                                                       }
{   - ENTER --> ENTERENABLED                                            }
{     A Propriedade ENABLED foi alterada para ENTERENABLED              }
{     A funcionalidade permanece a mesma                                }
{                                                                       }
{   - COR EM FOCO                                                       }
{     Quando a cor de um determinado edit era mudada para a cor do      }
{     edit em foco, nao retornava mais para a cor original, ficava      }
{     sempre na cor branca, agora a cor original e' guardada e recu-    }
{     perada para o controle quando ele sai de foco.                    }
{                                                                       }
{   - SETA PARA CIMA EM GROUPBOX                                        }
{     Em alguns casos, normalmente quando os edits estao dentro de      }
{     containers como o GROUPBOX a seta para cima nao estava funcinando }
{     bem ... agora esta :))))                                          }
{                                                                       }
{   - EVENTO ONKEYDOWN                                                  }
{     Desde a criação do componente TMREnter eu tenho convivido com     }
{     um problema chato, e quando o programador quer codificar alguma   }
{     coisa no evento ONKEYDOWN para a tecla ENTER ??? Bem a situacao   }
{     agora é verificada, se o ENTER for precionado e existir algum     }
{     evento codifico em ONKEYDOWN o TMRENTER vai deixar passar esse    }
{     ENTER para o evento, fica entao ao encargo do programador passar  }
{     ou nao para o proximo controle.                                   }
{                                                                       }
{   - PROCESSAMENTO DE HINT                                             }
{     Agora existem mais duas propriedades no componente                }
{       HintEnabled - Indica que o componente vai processar o Hint      }
{       HintColor - Indica a cor que será utilizada para mostrar o      }
{                   hint na tela                                        }
{     Este processamento de Hint se da quando o componente no form      }
{     recebe foco, independente se o Mouse esta ou nao sobre ele, isso  }
{     difere do comportamento tradicional do Hint, mas fica bem útil    }
{     em uma digitacao em serie.                                        }
{                                                                       }
{   Bem, estas foram as alteracoes e os novos recursos que o componente }
{   agora tem, se tiverem ideias legais por favor mandem varios emails  }
{                                                                       }
{   []s Martins                                                         }
{                                                                       }
{   10/02/2001 V 1.8                                                    }
{                                                                       }
{   - so uma correcao de bug introduzido na retirada do plim            }
{   Preciso de novas ideias do que fazer com o componente  :))))        }
{                                                                       }
{   []s Martins                                                         }
{                                                                       }
{   21/12/2000 V 1.7                                                    }
{                                                                       }
{   - Foi implementada a capacidade de o ENTER funcionar como PROXI-    }
{     MA CELULA em um GRID.                                             }
{   - Aquele PLIM que ocorria hora ou outra foi suprimido.              }
{                                                                       }
{   []s Martins                                                         }
{                                                                       }
{   19/10/2000 V 1.6                                                    }
{   Como nada nesse mundo é perfeito eu tinha de deixar passar alguma   }
{   coisa errada.                                                       }
{                                                                       }
{   - quando maxlength estava setado e o usuario retornava no campo     }
{     usando Backspace ele pulava para o proximo campo                  }
{   - foi otimizado o reconhecimento da propriedade COLOR, não tem      }
{     mais flick.                                                       }
{   - FocusControl funciona com qualquer componente que tenha a pro-    }
{     priedade color e não apenas com TEdit e TDBEdit                   }
{                                                                       }
{   []s Martins                                                         }
{                                                                       }
{   17/10/2000 V 1.5                                                    }
{   Depois de um longo e tenebroso inverno eu consegui alterar algumas  }
{   coisas no componente, acho que esta melhor, testei por aqui nas     }
{   versões do Delphi 1,2,3,4 e 5  e esta funcionando legal, só em      }
{   Delphi 1 que nao esta lá essas coisas, mas esta cada vez mais       }
{   dificil manter a compatibilidade ...                                }
{                                                                       }
{   Novas propriedades                                                  }
{     FocusEnabled                 Quando um TEdit ou TDBEdit           }
{                                  receber foco se deve destacar dos    }
{                                  demais                               }
{     FocusColor                   Cor de destaque                      }
{                                                                       }
{   As setas estão funcionando :)                                       }
{                                                                       }
{   Quando seleciona AutoSkip o proximo edit é selecionado quando o     }
{   edit atual esta totalmente completo e não no primeiro caracter do   }
{   proximo campo                                                       }
{   []s                                                                 }
{                                                                       }
{   22/05/1999 V 1.4                                                    }
{   Foi incluida uma nova funcionalidade, quando um derivado de TCustom }
{   edit chega ao final de seu limite do numero de caracteres então ele }
{   passa para o próximo controle automaticamente.                      }
{   Para ativar esta funcionalidade deve-se setar AutoSkip para true, o }
{   default é false.                                                    }
{   Add('TRxDBLookupList');        Suporte aos componentes do RxLib     }
{   Add('TRxDBGrid');                                                   }
{   Add('TRxDBLookupCombo');       Paulo H. Trentin                     }
{   Add('TRxDBCalcEdit');          www.rantac.com.br/users/phtrentin    }
{   Add('TRxDBComboBox');                                               }
{   Add('TRxDBComboEdit');                                              }
{   Add('TDBDateEdit');                                                 }
{   Add('TRxCalcEdit');                                                 }
{   Add('TCurrencyEdit');                                               }
{   Add('TRxLookupEdit');                                               }
{                                                                       }
{   03/03/1999 V 1.3                                                    }
{   Foi incluida uma propriedade chamada                                }
{   KeyBoardArrows : Boolean                                            }
{   esta propriedade quando true permite voltar um componente ou avançar}
{   utilizando as setas no teclado, simulando TAB e SHIFT TAB           }
{   Infelizmente estou tendo problemas para simular o SHIFT TAB em D1   }
{   mas funciona perfeitamente em D2, D3 e D4 ...                       }
{   Como diversas pessoas utilizam o InfoPower os seus componentes mais }
{   comuns foram incluidos automaticamente no create                    }
{   TwwDBGrid                      Suporte aos componentes do InfoPower }
{   TwwDBEdit                      Já que tem um monte de gente que usa }
{   TwwDBComboBox                  achei por bem deixar todos disponí-  }
{   TwwDBSpinEdit                  veis durante a criação do componen-  }
{   TwwDBComboDlg                  te, assim como os outros ....        }
{   TwwDBLookupCombo                                                    }
{   TwwDBLookupComboDlg            ideia do Dennis ...                  }
{   TwwIncrementalSearch           valeu ...                            }
{   TwwDBRitchEdit                 02/03/1999                           }
{   TwwKeyCombo                                                         }
{   Neste pacote esta sendo uncluido um arquivo .RES com um icone de    }
{   instalação do componente que foi feito pelo Mauricio                }
{   Este arquivo esta em 16 bits por motivo de compatibilidade, caso    }
{   o seu Delphi seja de 32 bits, abra o arquivo no Image Editor e      }
{   salve novamente. Valeu Mauricio...                                  }
{                                                                       }
{   17/10/1998 V 1.2                                                    }
{   Atendendo pedidos, outros eventos foram incluidos                   }
{                                                                       }
{   OnHint                                                              }
{   OnHelp                                                              }
{                                                                       }
{   03/10/1998 V 1.1                                                    }
{   Foram incluidos os eventos padrão de TApplication, assim            }
{   pode-se escrever diretamente para estes eventos e não mais          }
{   apenas via codigo. São eles ...                                     }
{                                                                       }
{   OnMessage                                                           }
{   OnIdle                                                              }
{                                                                       }
{   13/09/1998                                                          }
{   Substitui a ação da tecla TAB por um ENTER em todos os forms        }
{   pertencentes a TApplication.                                        }
{                                                                       }
{   ClassList                                                           }
{   Armazena os nomes das classes em que este componente vai            }
{   atuar, as classes abaixo já estão registradas de fabrica :)         }
{                                                                       }
{   TMaskEdit                                                           }
{   TEdit                                                               }
{   TDBEdit                                                             }
{   TDBCheckBox                                                         }
{   TTabbedNoteBook                                                     }
{   TDBCheckDocEdit                                                     }
{   TMRDBExtEdit                                                        }
{   TDBDateEdit                                                         }
{=======================================================================}
{   NOTA                                                                }
{   Obrigado a todos os amigos que mandaram suas ideias e colaborações, }
{   claro que todos temos nossos compromissos e dedicar um pouco do     }
{   tempo de vocês para colaborar com o desenvolvimento deste componen- }
{   te me deixa muito orgulhoso dos amigos que tenho e me lembra que a  }
{   vida é feita de atitudes e não apenas de boas intenções.            }
{                                                                       }
{   Um grande abraço a todos ...                                        }
{   Martins                                                             }
{   martins@mrsoftware.com.br                                           }
{=======================================================================}

  Registre seu e-mail para ser informado quando este componente for
  atualizado.

  Envie uma msg para : martins@mrsoftware.com.br
  Com o subject : TMREnter
