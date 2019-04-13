{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpmdconsts                                      }
{                                                       }
{       Resource strings for reportmanager engine and   }
{       designer                                        }
{                                                       }
{       Copyright (c) 1994-2007 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpmdconsts;

interface

{$I rpconf.inc}

{$IFDEF MSWINDOWS}
uses SysUtils,Windows;
{$ENDIF}

{$IFDEF LINUX}
uses SysUtils;
{$ENDIF}

{$IFDEF MSWINDOWS}
const
 C_DIRSEPARATOR='\';
{$ENDIF}
{$IFDEF LINUX}
const
 C_DIRSEPARATOR='/';
{$ENDIF}

const
 RM_VERSION='2.9h';
 REPMAN_WEBSITE='http://reportman.sourceforge.net';
 MAX_PAGECOUNT=999999;
type
  TPageWidthHeight = record
    Width: Integer;
    Height: Integer;
  end;

const PageSizeNames: array [0..148] of widestring =
('A4', 'B5','Letter','Legal','Executive','A0', 'A1', 'A2',
    'A3', 'A5', 'A6', 'A7', 'A8', 'A9', 'B0', 'B1', 'B10', 'B2',
     'B3', 'B4', 'B6','B7', 'B8', 'B9', 'C5E', 'Comm10E',
     'DLE', 'Folio', 'Ledger', 'Tabloid', 'psNPageSize',
 // 31
 'Letter',
 'Letter Small',
 'Tabloid',
 'Ledger',
 'Legal',
 'Statement',
 'Executive',
 'A3',
 'A4',
 'A4',
 'A5',
 'B4',
 'B5 (JIS)',
 'Folio',
 'Quarto',
 '10x14',
 '11x17',
 'Note',
 'Envelope #9',
 'Envelope #10',
 'Envelope #11',
 'Envelope #12',
 'Envelope #14',
 'C size sheet',
 'D size sheet',
 'E size sheet',
 'Envelope DL',
 'Envelope C5',
 'Envelope C3',
 'Envelope C4',
 'Envelope C6',
 'Envelope C65',
 'Envelope B4',
 'Envelope B5',
 'Envelope B6',
 'Envelope',
 'Envelope Monarch',
 '6 34 Envelope',
 'US Std Fanfold',
 'German Std Fanfold',
 'German Legal Fanfold',
 'B4',
 'Japanese Postcard',
 '9 x 11',
 '10 x 11',
 '15 x 11',
 'Envelope Invite',
 'RESERVED--DO NOT USE',
 'RESERVED--DO NOT USE',
 'Letter Extra',
 'Legal Extra',
 'Tabloid Extra',
 'A4 Extra',
 'Letter Transverse',
 'A4 Transverse',
 'Letter Extra Transverse',
 'SuperASuperAA4',
 'SuperBSuperBA3',
 'Letter Plus',
 'A4 Plus',
 'A5 Transverse',
 'B5 (JIS) Transverse',
 'A3 Extra',
 'A5 Extra',
 'B5 (ISO) Extra',
 'A2',
 'A3 Transverse',
 'A3 Extra Transverse',
 'Japanese Double Postcard',
 'A6',
 'Japanese Envelope Kaku #2',
 'Japanese Envelope Kaku #3',
 'Japanese Envelope Chou #3',
 'Japanese Envelope Chou #4',
 'Letter Rotated',
 'A3 Rotated',
 'A4 Rotated',
 'A5 Rotated',
 'B4 (JIS) Rotated',
 'B5 (JIS) Rotated',
 'Japanese Postcard Rotated',
 'Double Japanese Postcard Rotated',
 'A6 Rotated',
 'Japanese Envelope Kaku #2',
 'Japanese Envelope Kaku #3',
 'Japanese Envelope Chou #3',
 'Japanese Envelope Chou #4',
 'B6 (JIS)',
 'B6 (JIS) Rotated',
 '12 x 11',
 'Japanese Envelope You #4',
 'Japanese Envelope You #4 Rotated',
 'PRC 16K',
 'PRC 32K',
 'PRC 32K(Big)',
 'PRC Envelope #1',
 'PRC Envelope #2',
 'PRC Envelope #3',
 'PRC Envelope #4',
 'PRC Envelope #5',
 'PRC Envelope #6',
 'PRC Envelope #7',
 'PRC Envelope #8',
 'PRC Envelope #9',
 'PRC Envelope #10',
 'PRC 16K Rotated',
 'PRC 32K Rotated',
 'PRC 32K(Big) Rotated',
 'PRC Envelope #1 Rotated',
 'PRC Envelope #2 Rotated',
 'PRC Envelope #3 Rotated',
 'PRC Envelope #4 Rotated',
 'PRC Envelope #5 Rotated',
 'PRC Envelope #6 Rotated',
 'PRC Envelope #7 Rotated',
 'PRC Envelope #8 Rotated',
 'PRC Envelope #9 Rotated',
 'PRC Envelope #10 Rotated');
// Last=118

  PageSizeArray: array[0..148] of TPageWidthHeight =
    (
      (Width: 8268; Height: 11693),  // psA4
      (Width: 7165; Height: 10118),  // psB5
      (Width: 8500; Height: 11000),  // psLetter
      (Width: 8500; Height: 14000),  // psLegal
      (Width: 7500; Height: 10000),  // psExecutive
      (Width: 33110; Height: 46811), // psA0
      (Width: 23386; Height: 33110), // psA1
      (Width: 16535; Height: 23386), // psA2
      (Width: 11693; Height: 16535), // psA3
      (Width: 5827; Height: 8268),   // psA5
      (Width: 4134; Height: 5827),   // psA6
      (Width: 2913; Height: 4134),   // psA7
      (Width: 2047; Height: 2913),   // psA8
      (Width: 1457; Height: 2047),   // psA9
      (Width: 40551; Height: 57323), // psB0
      (Width: 28661; Height: 40551), // psB1
      (Width: 1260; Height: 1772),   // psB10
      (Width: 20276; Height: 28661), // psB2
      (Width: 14331; Height: 20276), // psB3
      (Width: 10118; Height: 14331), // psB4
      (Width: 5039; Height: 7165),   // psB6
      (Width: 3583; Height: 5039),   // psB7
      (Width: 2520; Height: 3583),   // psB8
      (Width: 1772; Height: 2520),   // psB9
      (Width: 6417; Height: 9016),   // psC5E
      (Width: 4125; Height: 9500),   // psComm10E
      (Width: 4331; Height: 8661),   // psDLE
      (Width: 8250; Height: 13000),  // psFolio
      (Width: 17000; Height: 11000), // psLedger
      (Width: 11000; Height: 17000), // psTabloid
      (Width: -1; Height: -1),        // psNPageSize
                                    // Windows equivalents begins at 31
      (Width: 8500; Height: 11000), // Letter 8 12 x 11 in
      (Width: 8500; Height: 11000), // Letter Small 8 12 x 11 in
      (Width: 11000; Height: 17000),  // Tabloid 11 x 17 in
      (Width: 17000; Height: 11000),  // Ledger 17 x 11 in
      (Width: 8500; Height: 14000),  // Legal 8 12 x 14 in
      (Width: 55000; Height: 8500),  // Statement 5 12 x 8 12 in
      (Width: 7500; Height: 10500), // Executive 7 14 x 10 12 in
      (Width: 11693; Height: 16535), // A3 297 x 420 mm                     }
      (Width: 8268; Height: 11693),      // A4 210 x 297 mm                     }
      (Width: 8268; Height: 11693),// A4 Small 210 x 297 mm               }
      (Width: 5827; Height: 8268), // A5 148 x 210 mm                     }
      (Width: 10118; Height: 14331),    // B4 (JIS) 250 x 354                  }
      (Width: 7165; Height: 10118), // B5 (JIS) 182 x 257 mm               }
      (Width: 8250; Height: 13000), // Folio 8 12 x 13 in                  }
      (Width: 8465; Height: 10827), // Quarto 215 x 275 mm                 }
      (Width: 10000; Height: 14000), // 10x14 in                            }
    (Width: 11000; Height: 17000),// 11x17 in                            }
    (Width: 8500; Height: 11000), // Note 8 12 x 11 in                   }
    (Width: 3875; Height: 8875),// Envelope #9 3 78 x 8 78             }
    (Width: 4125; Height: 9500),// Envelope #10 4 18 x 9 12            }
    (Width: 4500; Height: 10375),// Envelope #11 4 12 x 10 38           }
    (Width: 4276; Height: 11000),// Envelope #12 4 \276 x 11            }
    (Width: 5000; Height: 11500),// Envelope #14 5 x 11 12              }
    (Width: 16969; Height: 21969),// C size sheet 431 x 558 mm                       }
    (Width: 21969; Height: 33976),// D size sheet 558 x 863 mm                      }
    (Width: 33976; Height: 43976),// E size sheet 863 x 1117 mm                       }
    (Width: 4331; Height: 8661),// Envelope DL 110 x 220mm             }
    (Width: 6378; Height: 9016),// Envelope C5 162 x 229 mm            }
    (Width: 12756; Height: 18031),// Envelope C3  324 x 458 mm           }
    (Width: 9016; Height: 12756),// Envelope C4  229 x 324 mm           }
    (Width: 4488; Height: 6378),// Envelope C6  114 x 162 mm           }
    (Width: 4488; Height: 9016),// Envelope C65 114 x 229 mm           }
    (Width: 9843; Height: 13898),// Envelope B4  250 x 353 mm           }
    (Width: 6929; Height: 9843),// Envelope B5  176 x 250 mm           }
    (Width: 6929; Height: 4921),// Envelope B6  176 x 125 mm           }
    (Width: 4331; Height: 9056),// Envelope 110 x 230 mm               }
    (Width: 3875; Height: 7500), // Envelope Monarch 3.875 x 7.5 in     }
    (Width: 3625; Height: 6500),// 6 34 Envelope 3 58 x 6 12 in        }
    (Width: 14875; Height: 11000),// US Std Fanfold 14 78 x 11 in        }
    (Width: 8500; Height: 12000),// German Std Fanfold 8 12 x 12 in    }
    (Width: 8500; Height: 13000),// German Legal Fanfold 8 12 x 13 in  }
    (Width: 9843; Height: 13898),// B4 (ISO) 250 x 353 mm               }
    (Width: 3937; Height: 5827),// Japanese Postcard 100 x 148 mm      }
    (Width: 9000; Height: 11000), // 9 x 11 in                           }
    (Width: 10000; Height: 11000), // 10 x 11 in                          }
    (Width: 15000; Height: 11000), // 15 x 11 in                          }
    (Width: 8661; Height: 8661), // Envelope Invite 220 x 220 mm        }
    (Width: 100; Height: 100), // RESERVED--DO NOT USE                }
    (Width: 100; Height: 100), // RESERVED--DO NOT USE                }
    (Width: 9275; Height: 12000), // Letter Extra 9 \275 x 12 in         }
    (Width: 9275; Height: 15000), // Legal Extra 9 \275 x 15 in          }
    (Width: 11690; Height: 18000), // Tabloid Extra 11.69 x 18 in         }
    (Width: 9270; Height: 12690), // A4 Extra 9.27 x 12.69 in            }
    (Width: 8275; Height: 11000),  // Letter Transverse 8 \275 x 11 in    }
    (Width: 8268; Height: 11693),  // A4 Transverse 210 x 297 mm          }
    (Width: 9275; Height: 12000), // Letter Extra Transverse 9\275 x 12 in  }
    (Width: 8937; Height: 14016),     // SuperASuperAA4 227 x 356 mm       }
    (Width: 12008; Height: 19172),    // SuperBSuperBA3 305 x 487 mm       }
    (Width: 8500; Height: 12690),    // Letter Plus 8.5 x 12.69 in          }
    (Width: 8268; Height: 12992),    // A4 Plus 210 x 330 mm                }
    (Width: 5828; Height: 8268),    // A5 Transverse 148 x 210 mm          }
    (Width: 7166; Height: 10118),    // B5 (JIS) Transverse 182 x 257 mm    }
    (Width: 13071; Height: 17520),    // A3 Extra 322 x 445 mm               }
    (Width: 6850; Height: 9252),    // A5 Extra 174 x 235 mm               }
    (Width: 7913; Height: 10867),    // B5 (ISO) Extra 201 x 276 mm         }
    (Width: 16536; Height: 23386),    // A2 420 x 594 mm                     }
    (Width: 11693; Height: 16535),    // A3 Transverse 297 x 420 mm          }
    (Width: 13071; Height: 17520),     // A3 Extra Transverse 322 x 445 mm    }
    (Width: 7874; Height: 5827), // Japanese Double Postcard 200 x 148 mm }
    (Width: 4173; Height:5827),  // A6 105 x 148 mm                 }
    (Width: 9449; Height: 13071),  // Japanese Envelope Kaku #2 240 x 332 mm       }
    (Width: 8504; Height: 10906),  // Japanese Envelope Kaku #3 216 x 277 mm     }
    (Width: 4724; Height: 9252),  // Japanese Envelope Chou #3 120 x 235 mm      }
    (Width: 3543; Height: 8071),  // Japanese Envelope Chou #4  90 x 205 mm    }
    (Width: 11000; Height: 8500),  // Letter Rotated 11 x 8 1/2 11 in }
    (Width: 16535; Height: 11693),  // A3 Rotated 420 x 297 mm         }
    (Width: 11693; Height: 8268),  // A4 Rotated 297 x 210 mm         }
    (Width: 8268; Height: 5828),  // A5 Rotated 210 x 148 mm         }
    (Width: 14331; Height: 10118),  // B4 (JIS) Rotated 364 x 257 mm   }
    (Width: 10118; Height: 7165),  // B5 (JIS) Rotated 257 x 182 mm   }
    (Width: 5827; Height: 3937), // Japanese Postcard Rotated 148 x 100 mm }
    (Width: 5827; Height: 7874), // Double Japanese Postcard Rotated 148 x 200 mm }
    (Width: 5827; Height: 4173), // A6 Rotated 148 x 105 mm         }
    (Width: 13071; Height: 9449),  // Japanese Envelope Kaku #2 Rotated}
    (Width: 10906; Height: 8504),  // Japanese Envelope Kaku #3 Rotated}
    (Width: 9252; Height: 4724),  // Japanese Envelope Chou #3 Rotated}
    (Width: 8071; Height: 3543),  // Japanese Envelope Chou #4 Rotated}
    (Width: 5039; Height: 7165),  // B6 (JIS) 128 x 182 mm           }
    (Width: 7165; Height: 5039),  // B6 (JIS) Rotated 182 x 128 mm   }
    (Width: 12000; Height: 11000),  // 12 x 11 in                      }
    (Width: 4134; Height: 9252),  // Japanese Envelope You #4 105 x 235 mm       }
    (Width: 9252; Height: 4134),  // Japanese Envelope You #4 Rotated}
    (Width: 5748; Height: 8465),  // PRC 16K 146 x 215 mm            }
    (Width: 3819; Height: 5945),  // PRC 32K 97 x 151 mm             }
    (Width: 3819; Height: 5945),  // PRC 32K(Big) 97 x 151 mm        }
    (Width: 4134; Height: 6496),  // PRC Envelope #1 102 x 165 mm    }
    (Width: 4134; Height: 6929),  // PRC Envelope #2 102 x 176 mm    }
    (Width: 4921; Height: 5929),  // PRC Envelope #3 125 x 176 mm    }
    (Width: 4331; Height: 8189),  // PRC Envelope #4 110 x 208 mm    }
    (Width: 4331; Height: 8661), // PRC Envelope #5 110 x 220 mm    }
    (Width: 4724; Height: 9055), // PRC Envelope #6 120 x 230 mm    }
    (Width: 6299; Height: 9055), // PRC Envelope #7 160 x 230 mm    }
    (Width: 4724; Height: 12165), // PRC Envelope #8 120 x 309 mm    }
    (Width: 9016; Height: 12756), // PRC Envelope #9 229 x 324 mm    }
    (Width: 12756; Height: 18031), // PRC Envelope #10 324 x 458 mm   }
    (Width: 8465; Height: 5748), // PRC 16K Rotated                 }
    (Width: 5945; Height: 3819), // PRC 32K Rotated                 }
    (Width: 5945; Height: 3819), // PRC 32K(Big) Rotated            }
    (Width: 6496; Height: 4134), // PRC Envelope #1 Rotated 165 x 102 mm}
    (Width: 6929; Height: 4134), // PRC Envelope #2 Rotated 176 x 102 mm}
    (Width: 6929; Height: 4921), // PRC Envelope #3 Rotated 176 x 125 mm}
    (Width: 8189; Height: 4331), // PRC Envelope #4 Rotated 208 x 110 mm}
    (Width: 8661; Height: 4331), // PRC Envelope #5 Rotated 220 x 110 mm}
    (Width: 9055; Height: 4724), // PRC Envelope #6 Rotated 230 x 120 mm}
    (Width: 9055; Height: 6299), // PRC Envelope #7 Rotated 230 x 160 mm}
    (Width: 12165; Height: 4724), // PRC Envelope #8 Rotated 309 x 120 mm}
    (Width: 12756; Height: 9016), // PRC Envelope #9 Rotated 324 x 229 mm}
    (Width: 18031; Height: 12756) // PRC Envelope #10 Rotated 458 x 324 mm }

    );




function TranslateStr (index:integer; defvalue:Widestring):WideString;
var
 SRpNoFilename:WideString='No filename assigned';
 SRpErrorFork:WideString='Error forking';
 SRpEnglish:WideString='English';
 SRpSpanish:WideString='Spanish';
 SRpCatalan:WideString='Catalan';
 SRpFrench:WideString='French';
 SRpDirCantBeCreated:WideString='Directory can''t be created: ';
 SRpConfigFileNotExists:WideString='Configuration file missing: ';
 SRpPage:WideString='Page';
 SRpItem:WideString='Item';
 SRpCancel:WideString='Cancel';
 SRpInvalidClipboardFormat:WideString='Invalid clipboard format';
 SRpErrorReadingReport:WideString='Error reading report: ';
 SRpIgnoreError:WideString='Ignore?';
 SRpMainDataset:WideString='Main Dataset';
 SRpNewGroup:WideString='New Group';
 SRpSGroupName:WideString='Group Name';
 SRpGroupAlreadyExists:WideString='Group already exists:';
 SRpNoSpaceToPrint:WideString='No space to print ';
 SRpSection:WideString='Section';
 SRpNothingToPrint:WideString='Nothing to print';

  SRpLastPageReached:WideString='Last page already reached';
  SRPAliasNotExists:WideString='Data alias does not exists: ';
  SRpCopyStreamError:WideString='Error copying stream in metafile image object';
  SRpDriverNotSupported:WideString='Database driver not supported ';
  SrpDriverIBX:WideString='Interbase Express';
  SrpDriverADO:WideString='ADO Express (dbGo)';
  SrpDriverBDE:WideString='Borland Database Engine (BDE)';
  SrpDriverDBX:WideString='SQL Express (DBX)';
  SRpDriverAliasIsNotInterbase:WideString='The dbx driver alias is not Interbase';
  SRpNoDatabase:WideString='No Interbase Database specified';
  SRpSubreportAliasNotFound:WideString='Subreport alias not found:';
  SrpSAggregate:WideString='Aggregate';
  SRpNone:WideString='None';
  SRpGeneral:WideString='General';
  SrpSAgeGroup:WideString='Ag.Group';
  SrpSAgeType:WideString='Ag.Type';
  SrpSum:WideString='Sum';
  SRpMin:WideString='Min';
  SRpMax:WideString='Max';
  SRpAvg:WideString='Average';
  SRpStdDev:WideString='Std.Desv.';
  SrpSIniValue:WideString='Ag.I.Value';
  SrpSIdentifier:WideString='Identifier';
  SRpErrorIdenExpression:WideString='Error expression item no assigned (idenexpression)';
  SRpSHorzLine:WideString='Horz.Line';
  SRpSVertLine:WideString='Vert.Line';
  SRPHorzDesp:WideString='Horz.Desp.';
  SRpInvalidBoolean:WideString='Invalid boolean: ';
  SRpPaperNotFount:WideString='Paper name not found';
  SRpErrorCreatingPaper:WideString='Error creating paper form (privileges?): ';
  SRpSureDeleteSection:WideString='Delete selected section?';
  SRpNoDatasets:WideString='No datasets defined';
  SRpSampleTextToLabels:WideString='Text';
  SRpOnlyAReportOwner:WideString='Only a report can be the owner of :';
  SrpErrorProcesingFileMenu:WideString='Error procesing the File Menu for last saved files';
  SRpRepToTxt1:WideString='reptotxt';
  SRpRepToTxt2:WideString='Converts a report file from report manager (.rep) to a plain file';
  SRpRepToTxt3:WideString='Usage: reptotxt -stdin|sourcefilename [destinationfilename]';
  SRpMetaPrint1:WideString='metaprint';
  SRpMetaPrint2:WideString='Prints a metafile report (.rpmf)';
  SRpMetaPrint3:WideString='Usage: metaprint [Options] -stdin|metafilename';
  SRpMetaPrint4:WideString='Options: -d        Delete the file after printing it';
  SRpMetaPrint5:WideString='         -q        Quiet mode, don''t show progress';
  SRpMetaPrint6:WideString='         -from   n Prints report from page pnum';
  SRpMetaPrint7:WideString='         -to     n Prints report to page pnum';
  SRpMetaPrint8:WideString='         -copies n Prints pnum copies';
  SRpMetaPrint9:WideString='         -collate  Collate the copies';
  SRpTooManyParams:WideString='Too many parameters';
  SRpPrintingFile:WideString='Printing';
  SRpPrinted:WideString='Printed';
  SRpPrintedFileDeleted:WideString='Printed file deleted';
  SRpNoDriverPassedToPrint:WideString='No driver passed to beginprint of TrpReport';
  SRpTxtToRep1:WideString='txttorep';
  SRpTxtToRep2:WideString='Converts a plain file containing object descriptions to a report manager (.rep) file';
  SRpTxtToRep3:WideString='Usage: txttorep -stdin|sourcefilename [destinationfilename]';
  SRpPrintRep1:WideString='printrep';
  SRpPrintRep2:WideString='Prints a report manager (.rep) file';
  SRpPrintRep3:WideString='Usage: printrep [Options] -stdin|reportfilename [outputfilename]';
  SRpPrintRep4:WideString='         -q        Quiet mode, don''t show progress';
  SRpPrintRep5:WideString='         -from   n Prints report from page pnum';
  SRpPrintRep6:WideString='         -to     n Prints report to page pnum';
  SRpPrintRep7:WideString='         -copies n Prints pnum copies';
  SRpPrintRep8:WideString='         -collate  Collate the copies';
  SRpPrintRep9:WideString='         -preview  Show the preview window instead printing';
  SRpPrintRep10:WideString='         -pdialog  Show the print dialog';
  SRpPrintPDFRep1:WideString='printreptopdf';
  SRpPrintPDFRep2:WideString='Prints a report manager (.rep) file to a Adobe PDF file';
  SRpPrintPDFRep3:WideString='Usage: printreptopdf [Options] -stdin|reportfilename [outputfilename]';
  SRpPrintPDFRep4:WideString='         -q        Quiet mode, don''t show progress';
  SRpPrintPDFRep5:WideString='         -from   n Prints report from page pnum';
  SRpPrintPDFRep6:WideString='         -to     n Prints report to page pnum';
  SRpPrintPDFRep7:WideString='         -copies n Prints pnum copies';
  SRpPrintPDFRep8:WideString='         -u        Generate not compressed pdf';
  SRpPrintPDFRep9:WideString='         -m        Generate Report Metafile Stream format';
  SrpSubReport:WideString='SubReport';
  SRpRepman:WideString='Report manager designer';
  SRpError:WideString='Error';
  SRpOpenSelec:WideString='Opens the selected file';
  SRptReportnotfound:WideString='Report not found';
  SRpMustInstall:WideString='No printers installed, you must install one';
  SRpConverstoolarge:WideString='Conversion overflow';
  SRpErrorMapmode:WideString='Error in mapmode of the device';
  SRpErrorUnitconversion:WideString='Error in unit conversion';
  SRpMinHeight:WideString='Minimal height exceeded';
  SRpMaxWidth:WideString='Maximum height exceeded';
  SRpAssignFunc:WideString='Can not set a value to a function';
  SRpAssignConst:WideString='Can not set a value to a constant';
  SRpAssignfield:WideString='Can not set a value to a field';
  SRpNohelp:WideString='No help available';
  SRpNoaparams:WideString='No parameters';
  SRpNomodel:WideString='No model';
  SRpTrueHelp:WideString='A constant with True value';
  SRpFalseHelp:WideString='A constant with False value';
  SRpFieldHelp:WideString='Database field';
  SRpUpperCase:WideString='Return the string in uppercase';
  SRpPUpperCase:WideString='s is the string to do uppercase';
  SRpLowerCase:WideString='Returns the string in lowercase';
  SRpPLowerCase:WideString='s is the string to do lowercase';
  SRpHourMinSec:WideString='Converts a number to a time string hh:mm:ss';
  SRpPHourMinSec:WideString='H represents hours, idenH is the conversion string '+#10+'for hours, idenM for minutes and '+#10+'idenS for seconds';
  SRpFloatToDateTime:WideString='Converts a float to a datetime type';
  SRpPFloatToDateTime:WideString='n is the number to convert';
  SRpSin:WideString='Returns the sin of an angle';
  SRpPSin:WideString='ang is expressed in radians';
  SRpRound:WideString='Rounds to a multiple of a number.';
  SRpPRound:WideString='num is the number to round and r i the multiplier';
  SRpInt:WideString='Returns the integer part of a number';
  SRpPInt:WideString='num is the number to obtain the int part.';
  SRpStr:WideString='Converts a number to a string';
  SRpPStr:WideString='num is the number to convert';
  SRpVal:WideString='Converts a string to a number';
  SRpPVal:WideString='s is the string to convert';
  SRpTrim:WideString='Returns a string without spaces in right-left sides';
  SRpPtrim:WideString='s is the string to be trimmed';
  SRpLeft:WideString='Returns the left side of a string';
  SRpPLeft:WideString='s is the source string,count is the number of chars to return';
  SRpPos:WideString='Returns the position index of a string inside another string (0 if not found)';
  SRpPPos:WideString='SubStr is the substring to search for';

  SRpAllDriver:WideString='[All]';
  SRpSelectDriver:WideString='You must select a driver first';
  SRpNewConnection:WideString='Create a new connection';
  SRpConnectionName:WideString='Connection name';
  SRpDropConnection:WideString='Drop connection';
  SRpSureDropConnection:WideString='Are you sure you want to drop connection: ';
  SRpVendorLib:WideString='Vendor Library';
  SRpLibraryName:WideString='Library name';
  SRpSelectConnectionFirst:WideString='You must select a connection first';
  SRpConnectionOk:WideString='Test connection passed';
  SRpFieldNotFound:WideString='Field not found: ';
  SRpNotAField:WideString='Not a field: ';
  SRpNotBinary:WideString='Not a binary field: ';
  SRpErrorReadingFromFieldStream:WideString='Error reading from field stream';
  SRpSQrt:WideString='The square of a number';
  SRpPSQRt:WideString='num is the number to square';
  SRpMod:WideString='Returns the module that is the rest of the integer division';
  SRpPMod:WideString='d1 is the dividend d2 is the divisor';
  SRpToday:WideString='Returns today date in datetime data type';
  SRpNow:WideString='Returns today and time in datetime data type';
  SRpTimeH:WideString='Returns the time in datetime datatype';
  SRpNull:WideString='Null';
  SRpMonthName:WideString='The name of the month in string';
  SRpPMonthName:WideString='d es de date to be decoded';
  SRpEvalText:WideString='Evals an expresion, returns the evaluated result';
  SRpPEvalText:WideString='expr is the expresion to evaluate';
  SRpMonth:WideString='Returns the month number (1-12)';
  SRpPMonth:WideString='d is the date to decode';
  SRpYear:WideString='Returns the year';
  SRpPyear:WideString='d is the date to decode';
  SRpDay:WideString='Returns the day';
  SRpPDay:WideString='d is the date to decode';
  SRpRight:WideString='Returns the right side of a string';
  SRpPRight:WideString='s is the source string and count is the number of characters to copy';
  SRpSubStr:WideString='Returns a substring of a string';
  SRpPSubStr:WideString='cadena is the sorce string, index is the index to copy from '+#10+' and count is the number of characters to copy';
  SRpFormatStr:WideString='Formats a string in diferent ways taking a picture of characters';
  SRpPFormatStr:WideString='Format is the format string: ex.''dd/mm/yyyy'''+#10+' and v is the value to convert to a formated string';
  SRpNumToText:WideString='Text representation of a number';
  SRpPNumToText:WideString='n is the number, f says if it'' female';
  SRpDivisioZero :WideString= 'Division by zero';
  SRpEvalType :WideString= 'Type conversion error';
  SRpInvalidOperation :WideString= 'Invalid operation';
  SRpEvalDescIden :WideString= 'Unknown identifier: ';
  SRpEvalParent :WideString= 'Parentesis error';
  SRpConvertError :WideString= 'Type conversion error';
  SRpIdentifierexpected :WideString= 'Indentifier expected';
  SRpstringexpected :WideString= 'String expected';
  SRpNumberexpected :WideString= 'Number expected';
  SRpOperatorExpected :WideString= 'Operator expected';
  SRpInvalidBinary :WideString= 'Invalid Binary';
  SRpExpected :WideString= 'Expected %s';
  SRpEvalsyntax :WideString= 'Syntax error';
  SRpsetexpression:WideString='Can not set a value to a expression';
  SRpFieldDuplicated :WideString= 'Duplicated field you must use the alias';
  SRpVariabledefined :WideString= 'Variable redefined';
  SRpOperatorSum:WideString='Sum operator';
  SRpOperatorDif:WideString='Substract operator';
  SRpOperatorMul:WideString='Multiply operator';
  SRpOperatorDiv:WideString='Division operator';
  SRpOperatorComp:WideString='Comparison operator';
  SRpOperatorLog:WideString='Logical operator';
  SRpOperatorDec:WideString='Decision operator';
  SRpOperatorDecM:WideString='IIF(condition,action1,action2)';
  SRpOperatorDecP:WideString='Condition is a boolean expresion, if it''s true the '+#10+' first parameter is executed, else the second is executed';
  SRpOperatorSep:WideString='Separator operator';
  SRpOperatorSepP:WideString='Is used to execute more than one expresión, the last is the result';
  SRpErrorOpenImp:WideString='Error opening the printer ';
  SRpPaperexists:WideString='The paper size already exists';
  SRpPrinting:WideString='The printer is already printing';
  SRpDefaultPrinter:WideString='Default printer';
  SRpReportPrinter:WideString='Reporting printer';
  SRpTicketPrinter:WideString='Ticket printer';
  SRpGraphicprinter:WideString='Graphics printer';
  SRpCharacterprinter:WideString='Character based printer';
  SRpReportPrinter2:WideString='Reporting printer 2';
  SRpTicketPrinter2:WideString='Ticket printer 2';
  SRpUserPrinter1:WideString='User printer 1';
  SRpUserPrinter2:WideString='User printer 2';
  SRpUserPrinter3:WideString='User printer 3';
  SRpUserPrinter4:WideString='User printer 4';
  SRpUserPrinter5:WideString='User printer 5';
  SRpUserPrinter6:WideString='User printer 6';
  SRpUserPrinter7:WideString='User printer 7';
  SRpUserPrinter8:WideString='User printer 8';
  SRpUserPrinter9:WideString='User printer 9';
  SRpREmoveElements:WideString='This sections has childs that will be removed.';
  SRpPageHeader:WideString='Page header';
  SRpReportHeader:WideString='Report header';
  SRpGeneralPageHeader:WideString='Global scope';
  SRpGeneralReportHeader:WideString='General report header';
  SRpDetail:WideString='Detail';
  SRpHeader:WideString='Header';
  SRpFooter:WideString='Footer';
  SRpPageFooter:WideString='Page footer';
  SRpReportFooter:WideString='Report footer';
  SRpGroup:WideString='Group';
  SRpMaxGroupsExceded:WideString='Max number of groups execeded';
  SRpSelectGroupToRemove:WideString='Select the group to remove';
  SRpSelectGroup:WideString='Select a group';
  SRpGroupNameError:WideString='The group name is already in use, change it';
  SRpReportChanged:WideString='Report changed. Save the changes before close?';
  SRpErrorWriteSeccion:WideString='Error writing a section';
  SRpErrorReadSeccion:WideString='Error reading a section';
  SRpUntitled:WideString='Untitled';
  SRpSaveAborted:WideString='Save aborted';
  SRpOperationAborted:WideString='Operation aborted';
  SRpFileNameRequired:WideString='File name required to adquire config file';
  SRpAliasExists:WideString='The database alias already exists: ';
  SRPDabaseAliasNotFound:WideString='Database alias not found';
  SRpCircularDatalink:WideString='There is a circular datalink with: ';
  SRPMasterNotFound:WideString='Master dataset not found: ';
  SRpInvalidComponentAssigment:WideString='Error assigning the type must be a valid database';
  SRpNewDatabaseconf:WideString='New database alias configuration';
  SRpEnterTheName:WideString='Enter the alias';
  SRpChangeAliasConf:WideString='Rename the database configuration alias';
  SRpEnterTheNewName:WideString='Enter the new name';
  SRpDatabaseAliasNull:WideString='A database alias cannot be null';
  SRpDatabasenotassined:WideString='There is not database to connect/disconnect in alias';
  SRpConnectionsuccesfull:WideString='Connection Test OK';
  SRpNewaliasDef:WideString='New table/query';
  SRpAliasName:WideString='Alias Name';
  SRpTableAliasExists:WideString='The Alias Name already exists';
  SRpBadSignature:WideString='Bad report metafile signature';
  SRpBadFileHeader:WideString='Bad report metafile file header';
  SrpMtPageSeparatorExpected:WideString='Page separator expected in report metafile';
  SrpMtObjectSeparatorExpected:WideString='Object separator expected in report metafile';
  SrpObjectTypeError:WideString='Object type error in report metafile';
  SrpObjectDataError:WideString='Object data error in report metafile';
  SRpMetaIndexPageOutofBounds:WideString='Index page out of bounds in metafile';
  SRpMetaIndexObjectOutofBounds:WideString='Index object out of bounds in metafile';
  SRpPrintDriverIncorrect:WideString='Incorrect print driver';
  SRpWinGDINotInit:WideString='Report metafile wingdi driver not initialized';
  SRpQtDriverNotInit:WideString='Report metafile qt driver not initialized';
  SRpGDIDriverNotInit:WideString='Report metafile GDI driver not initialized';
  SRPNoSelectedSubreport:WideString='No selected subreport';
  SRPNoSelectedSection:WideString='No selected section';
  SRpGroupNameRequired:WideString='Group name required';
  SRpSubReportNotFound:WideString='Subreport not found';
  SRpSectionNotFound:WideString='Section not found';
  SRpAtLeastOneDetail:WideString='At least one detail must exists in a subreport';
  SRpAtLeastOneSubreport:WideString='At least one subreport must exists in a report';
  SrpNewDataset:WideString='New dataset';
  SrpRenameDataset:WideString='Rename dataset';
  SRpSaveChanges:WideString='Save configuration?';
  SRpParamNotFound:WideString='Parameter not found: ';
  SRpNewParam:WideString='New param';
  SRpParamName:WideString='Name';
  SRpParamNameExists:WideString='Param name already exists';
  SRpRenameParam:WideString='Rename param';
  SRpBold:WideString='Bold';
  SRpUnderline:WideString='Underline';
  SRpItalic:WideString='Italic';
  SRpStrikeOut:WideString='StrikeOut';
  SRpSFontRotation:WideString='F.Rotation';
  SRpSTop:WideString='Top';
  SRpSLeft:WideString='Left';
  SRpSWidth:WideString='Width';
  SRpSHeight:WideString='Height';
  SRpSCurrency:WideString='Currency';
  SRpSString:WideString='String';
  SRpSColor:WideString='Color';
  SRpSInteger:WideString='Integer';
  SRpSLargeInteger:WideString='LargeInt';
  SRpSWFontName:WideString='WFont Name';
  SRpSLFontName:WideString='LFont Name';
  SRpSType1Font:WideString='PDF Font';
  SrpSFontSize:WideString='Font Size';
  SrpSFontColor:WideString='Font Color';
  SrpSBackColor:WideString='Back Color';
  SrpSFontStyle:WideString='Font Style';
  SrpSTransparent:WideString='Transparent';
  SRpSBool:WideString='Boolean';
  SRpSList:WideString='List';
  SrpSText:WideString='Text';
  SrpSExpression:WideString='Expression';
  SrpSBarcode:WideString='Barcode';
  SrpSCalculatingBarcode:WideString='Error calculating barcode';
  SrpSDisplayFormat:WideString='Display format';
  SRpUnknownType:WideString='(Unknown type)';
  SrpSOnlyOne:WideString='P.Only One';
  SRpSBarcodeType:WideString='Bar type';
  SRpSShowText:WideString='Show Text';
  SRpSChecksum:WideString='Calc.Checksum';
  SRpSModul:WideString='Bar.Modul';
  SRpSRatio:WideString='Bar.Ratio';
  SRpWrongBarcodeType:WideString='Wrong Barcode Type';
  SRpSBSolid:WideString='Solid';
  SRpSBClear:WideString='Clear';
  SRpSBHorizontal:WideString='Horizontal';
  SRpSBVertical:WideString='Vertical';
  SRpSBFDiagonal:WideString='Diagonal A';
  SRpSBBDiagonal:WideString='Diagonal B';
  SRpSBCross:WideString='Cross';
  SRpSBDiagCross:WideString='Diag. Cross';
  SRpSBDense1:WideString='Dense 1';
  SRpSBDense2:WideString='Dense 2';
  SRpSBDense3:WideString='Dense 3';
  SRpSBDense4:WideString='Dense 4';
  SRpSBDense5:WideString='Dense 5';
  SRpSBDense6:WideString='Dense 6';
  SRpSBDense7:WideString='Dense 7';
  SRpSPSolid:WideString='Solid';
  SRpSPDash:WideString='Dash';
  SRpSPDot:WideString='Dot';
  SRpSPDashDot:WideString='Dash-Dot';
  SRpSPDashDotDot:WideString='Dash-Dot-Dot';
  SRpSPClear:WideString='Clear';
  SRpsSCircle:WideString='Circle';
  SRpsSEllipse:WideString='Ellipse';
  SRpsSRectangle:WideString='Rectangle';
  SRpsSRoundRect:WideString='Round Rect';
  SRpsSRoundSquare:WideString='Round Square';
  SRpsSSquare:WideString='Square';
  SRpSAutoExpand:WideString='Auto Expand.';
  SRpSAutoContract:WideString='Auto Contract';
  SRpSAfterPrint:WideString='After print';
  SRpSBeforePrint:WideString='Before print';
  SRpSPrintCondition:WideString='Print condition';
  SRpSGroupExpression:WideString='Group Expression';
  SRPSChangeBool:WideString='Bool Expression';
  SRPSPageRepeat:WideString='Page repeat';
  SRPSBeginPage:WideString='Begin Page';
  SRPSkipPage:WideString='Skip Page';
  SRPAlignBottom:WideString='Align Bottom';
  SRPBottom:WideString='Bottom';
  SRpSRight:WideString='Right';
  SRPAlign:WideString='Align';
  SRpIdentifierAlreadyExists:WideString='Identifier already exists';
  SrpSCutText:WideString='Cut Text';
  SrpSWordwrap:WideString='Word wrap';
  SrpSSingleLine:WideString='Single Line';
  SrpSAlignment:WideString='H.Alignment';
  SrpSVAlignment:WideString='V.Alignment';
  SRpSAlignNone:WideString='None';
  SRpSAlignLeft:WideString='Left';
  SRpSAlignRight:WideString='Right';
  SRpSAlignCenter:WideString='Center';
  SRpSAlignTop:WideString='Top';
  SRpSAlignBottom:WideString='Bottom';
  SRPSDrawCrop:WideString='Crop';
  SRPSDrawStretch:WideString='Strecth';
  SRPSDrawFull:WideString='Full';
  SrpSImage:WideString='Image';
  SRpKbytes:WideString='Kbytes';
  SRpInvalidImageFormat:WideString='Invalid image format';
  SRpPropertyisnotstream:WideString='Property is not a stream: ';
  SrpSShape:WideString='Shape';
  SrpSBrushStyle:WideString='Brush Style';
  SrpSBrushColor:WideString='Brush Color';
  SrpSPenStyle:WideString='Pen Style';
  SrpSPenColor:WideString='Pen Color';
  SrpSPenWIdth:WideString='Pen Width';
  SRpBlackness:WideString='Blackness';
  SRpDstInvert:WideString='DstInvert';
  SRpMergeCopy:WideString='MergeCopy';
  SRpMergePaint:WideString='MergePaint';
  SRpNotSrcCopy:WideString='NotSrcCopy';
  SRpNotSrcErase:WideString='NotSrcErase';
  SRpPatCopy:WideString='PatCopy';
  SRpPatInvert:WideString='PatInvert';
  SRpPatPaint:WideString='PatPaint';
  SRpSrcAnd:WideString='SrcAnd';
  SRpSrcCopy:WideString='SrcCopy';
  SRpSrcErase:WideString='SrcErase';
  SRpSrcInvert:WideString='SrcInvert';
  SRpSrcPaint:WideString='SrcPaint';
  SRpWhiteness:WideString='SrcWhiteness';
  SRpCreateMask:WideString='CreateMask';
  SrpCopyMode:WideString='CopyMode';
  SRpDPIRes:WideString='Resolution(dpi)';
  SRpDrawStyle:WideString='Draw Style';
  SRpDrawTile:WideString='Tile';
  SRpErrorWritingPage:WideString='Error writting metafile page';
  SrpStreamErrorPage:WideString='Error in metafile page format';
  SRpBringToFront:WideString='To Front';
  SRpSendToBack:WideString='To Back';
  SRpInvalidStreaminRpImage:WideString='Invalid stream in TRpImage';
  SRpPropertyNotFound:WideString='Property not found: ';
  SRpPropertyHaveNoListValues:WideString='This property have not a list of values';
  SRpIncorrectComponentForInterface:WideString='Incorrect component type for interface creation';
  SRpPropName:WideString='Property Name';
  SRpPropValue:WideString='Property Value';
  SRpUndefinedPaintInterface:WideString='Undefined paint interface';
  SRpNoDriverName:WideString='No drivername assigned to connection: ';
  SRpIncorrectCalltoDeawGrid:WideString='Incorrect call to DrawBitmapGrid';
  SRpSNotYetImplemented:WideString='Feature not yet implemented';
  SRpNoFileNameProvided:WideString='No filename provided';
  SRpRecordCount:WideString='Record count';
  SRpNoStreamToSaveReport:WideString='No Stream to save Report (TRpDesigner)';
  SRpDocNotInstalled:WideString='Documentation not installed.';
  SRpDocNotInstalled2:WideString='Download it and install in the application directory.';
  SRpDocNotInstalled3:WideString='http://reportman.sourceforge.net';
  SRpSelectAddConnection:WideString='You must select first add/select connection';
  SRpStreamNotValid:WideString='PDF Stream not valid';
  SRpNotPrintingPDF:WideString='Not in pdf printing state';
  SRpInvalidBitmapHeaderSize:WideString='Invalid Bitmap Header Size';
  SRpBadBitmapFileHeader:WideString='Bad bitmap file header';
  SRpBadBitmapStream:WideString='Bad bitmap stream';
  SRpBitMapInfoHeaderBitCount:WideString='Invalid bit depth in bitmap';
  SRpInvalidBitmapPalette:WideString='Invalid bitmap palette';
  SRpBadColorIndex:WideString='Bad color index in bitmap';
  SRpRLECompBitmapPDF:WideString='Compressed RLE bitmaps not supported in PDF Export';
  SRpMonochromeBitmapPDF:WideString='Monochrome bitmaps not supported in PDF Export';
  SRpParamBDENotSupported:WideString='Parameters not supported in BDE Tables';
  SRpPDFFile:WideString='PDF File - compressed';
  SRpPDFFileUn:WideString='PDF File - uncompressed';
  SRpRepMetafile:WideString='Report Metafile';
  SRpRepFile:WideString='Report File';
  SRpAnyFile:WideString='Any File';
  SRpBitmapImages:WideString='Bitmap images';
  SRpUnkownClassForMultiSelect:WideString='Unknown class for multi-select';
  SRpClassNotRegistered:WideString='Class not registered -';
  SRpSampleBarCode:WideString='5449000000996';
  SRpDatasetNotExists:WideString='Dataset not exists';
  SRpDatabaseNotExists:WideString='Database not exists';
  SrpSChartType:WideString='Chart Type';
  SrpSChart:WideString='TRpChart';
  SrpSChangeSerieExp:WideString='Serie Change exp.';
  SrpSChangeSerieBool:WideString='Bool S.Change';
  SrpSCaptionExp:WideString='Caption Exp.';
  SrpSGetValueCondition:WideString='Get V.Cond.';
  SRpIndexOutOfBounds:WideString='Index out of bounds';
  SRpSOblique1:WideString='Oblique1';
  SRpSOblique2:WideString='Oblique2';
  SRpNoFilenameAssignedNotTRpTranslator:WideString='No Filename assigned to TRpTranslator';
  SRpParameter:WideString='Parameter';
  SRpYes:WideString='Yes';
  SRpNo:WideString='No';
  SRpOk:WideString='Ok';
  SRpRetry:WideString='Retry';
  SRpAbort:WideString='Abort';
  SRpIgnore:WideString='Ignore';
  SRpInformation:WideString='Information';
  SRpWarning:WideString='Warning';
  SRpCritical:WideString='Error';
  SRpNotFound:WideString='Not found';
  SRpServerAlreadyRunning:WideString='Report Server already running';
  SRpAuthFailed:WideString='Authorization failed (user name or password incorrect)';
  SRpAuthorized:WideString='Authorization Ok';
  SRpReceivedPacket:WideString='Received Packet:';
  SRpServerStarted:WideString='Server started';
  SRpClientConnected:WideString='Client connected';
  SRpServerStoped:WideString='Server stoped';
  SRpSureDeleteReport:WideString='The selected report will be deleted. Are you sure?';
  SRpGraphicClear:WideString='Clears the graphic data';
  SRpGraphicNew:WideString='Adds data to the graphic';
  SRpPGraphicClear:WideString='Gr is the graphic identifier';
  SRpPGraphicNew:WideString='Gr is the graphic identifier,V is the value, C indications serie change,etiq is the caption of value and caption the serie';
  SRpNoDataAvailableToPrint:WideString='No data available to print';
  SRpPrintOnlyIfDataAvailable:WideString='Print only if data available';
  SRpPasswordConfirmationIncorrect:WideString='Password confirmation incorrect';
  SRpAAliasnameBeAssigned:WideString='A alias name must be specified';
  SRpAPathMustBeAssigned:WideString='A path must be specified';
  SRpAUserNameMustbeAssigned:WideString='A user name must be specified';
  SRpUserorPasswordIncorrect:WideString='User or password incorrect';
  SRpWindowsNTRequired:WideString='Windows NT required to use this feature';
  SRpCannotExecute:WideString='Can not execute';
  SRpServiceStopped:WideString='Stopped';
  SRpServiceStarted:WideString='Started';
  SRpServiceUnInstalled:WideString='Not Installed';
  SRpSExternalpath:WideString='External path';
  SRpGetFieldValue:WideString='Executes a query and returns the first field value';
  SRpPGetFieldValue:WideString='connname is the connection name, query is the sql query to execute';
  SRpChildSubRep:WideString='Child Subreport';
  SRpNewDatabaseInfo:WideString='Select a driver and click add button';
  SRpNewDataInfo:WideString='Click add button, then select a connection and the SQL sentence or other options';
  SRpSExternalData:WideString='External database';
  SRpExternalSectionNotFound:WideString='Error reading external section';
  SRpRecordnotExists:WideString='The record does not exist, do you want to create it?';
  SRpLoadSection:WideString='Do you want to load the section?';
  SRpSInvalidJPEG:WideString='Invalid JPEG/PNG stream';
  SRpSJpegImages:WideString='JPeg images';
  SRpSPNGImages:WideString='PNG images';
  SRpSXPMImages:WideString='XPM images';
  SRpSWMFImages:WideString='WMF Windows Metafile';
  SRpSEMFImages:WideString='EMF Enhaced Metafile';
  SRpSICOImages:WideString='ICO Icons';
  SRpSUnknownType:WideString='Unknown';
  SRpSFloat:WideString='Float';
  SRpSDate:WideString='Date';
  SRpSDateTime:WideString='Date Time';
  SRpSTime:WideString='Time';
  SRpSBoolean:WideString='Boolean';
  SRpSDataType:WideString='Data type';
  SRpSDefault:WideString='Default';
  SRpSDriver:WideString='Driver';
  SRpSChartDriverEngine:WideString='RpChart';
  SRpSChartDriverTeeChart:WideString='TeeChart';
  SRpChartLine:WideString='Line';
  SRpChartBar:WideString='Bar';
  SRpChartPoint:WideString='Point';
  SRpChartHorzBar:WideString='Horz.Bar';
  SRpChartArea:WideString='Area';
  SRpChartPie:WideString='Pie';
  SRpChartArrow:WideString='Arrow';
  SRpChartBubble:WideString='Bubble';
  SRpChartGantt:WideString='Gantt';
  SRPSView3D:WideString='View3D';
  SRPSView3DWalls:WideString='3D Walls';
  SRPSPerspective:WideString='Perspective';
  SRPSElevation:WideString='Elevation';
  SRPSRotation:WideString='Rotation';
  SRPSOrthogonal:WideString='Orthogonal';
  SRPSZoom:WideString='Zoom';
  SRPSHOffset:WideString='H.Offset';
  SRPSVOffset:WideString='V.Offset';
  SRPSTilt:WideString='Tilt';
  SRPSMultibar:WideString='Multibar';
  SRpSNone:WideString='None';
  SRpSSide:WideString='Side';
  SRpSStacked:WideString='Stacked';
  SRpSStacked100:WideString='Stacked100';
  SRpSForcePrint:WideString='Force print';
  SRpSHSkipExpre:WideString='H.Skip.Expre.';
  SRpSVSkipExpre:WideString='V.Skip.Expre.';
  SRpSHRelativeSkip:WideString='H.Relative Skip';
  SRpSVRelativeSkip:WideString='V.Relative Skip';
  SRpSSkipType:WideString='Skip Type';
  SRpSSkipBefore:WideString='Skip Before';
  SRpSSkipAfter:WideString='Skip After';
  SRpSSkipToPage:WideString='S.To Page';
  SRpSPOnlyData:WideString='P.Only data avail.';
  SRpSTwoPassReportNeeded:WideString='Two pass report needed';
  SRpIniNumPage:WideString='Init.PageNum';
  SRpPrintNulls:WideString='Print Nulls';
  SrpSExpressionB:WideString='Expres.Bef.Open';
  SrpSExpressionA:WideString='Expres.Aft.Open';
  SRpSParamSubs:WideString='String Substi.';
  SRpSRightToLeft:WideString='BiDi Mode';
  SRpSBidiNo:WideString='No Bidi';
  SRpSBidiPartial:WideString='Partial Bidi';
  SRpSBidiFull:WideString='Full Bidi';
  SRpMultiPage:WideString='Multi Page';
  SRpDataUnionNotFound:WideString='Data Union not found in Mybase';
  SRpCannotCombine:WideString='Cannot combine-union a dataset to other dataset with fewer field number';
  SRpSParamList:WideString='Value list';
  SRpSParamListDesc:WideString='Strings to show (left) and strings to assign (right)';
  SRpReplaceStr:WideString='Replace a string within a string';
  SRpPReplaceStr:WideString='x Replace a string within a string';
  SRpParseParamsH:WideString='         -paramPARAMNAME=paramvalue  Assign a value to a parameter';
  SrpSClearExpChart:WideString='Clear expression';
  SrpSBoolClearExp:WideString='Bool C.expression';
  SRpStreamFormat:WideString='Invalid Stream format';
  SRpZLibNotSupported:WideString='ZLib Streams not supported';
  SRpPreferedFormat:WideString='Prefered save format';
  SRpStreamZLib:WideString='ZLib compressed - binary';
  SRpStreamBinary:WideString='Binary stream';
  SRpStreamText:WideString='Text stream';
  SRpSOptions:WideString='Options';
  SRpSReady:WideString='Ready';
  SRpSsysInfo:WideString='System information';
  SRpSsysInfoH:WideString='Shows system and printer information';
  SRpSHighResolution:WideString='High resolution';
  SRpSMediumResolution:WideString='Medium resolution';
  SRpSLowResolution:WideString='Low resolution';
  SRpSDraftResolution:WideString='Draft resolution';
  SRpSColorPrinting:WideString='Color printing';
  SRpSMonoPrinting:WideString='Monochrome printing';
  SRSPlotter:WideString='Plotter, vector printer';
  SRSRasterDisplay:WideString='Raster display';
  SRSRasterPrinter:WideString='Raster printer';
  SRSRasterCamera:WideString='Raster camera';
  SRSCharStream:WideString='Character stream';
  SRSDisplayFile:WideString='Display file';
  SRpSMetafile:WideString='Windows Metafile';
  SRpSPolyline:WideString='Polyline';
  SRpSMarker:WideString='Marker';
  SRpSPolyMarker:WideString='Multiple Marker';
  SRpSWideCap:WideString='Wide capability';
  SRpSSTyledCap:WideString='Styled capability';
  SRpSWideSTyledCap:WideString='Wide styled capability';
  SRpSInteriorsCap:WideString='Interiors capability';
  SRpSPolygon:WideString='Polygon capability';
  SRpSRectanglecap:WideString='Rectangle capability';
  SRpSWindPolygon:WideString='Winding-fill cap.';
  SRpSSCANLINE:WideString='Scan line cap.';
  SRpSCircleCap:WideString='Circle cap.';
  SRpSPiecap:WideString='Pie wedges cap.';
  SRpSCHordCap:WideString='Chord arcs cap.';
  SRpSEllipses:WideString='Ellipses cap.';
  SRpSRoundRectCap:WideString='Round rect.cap.';
  SRpSBandingRequired:WideString='Banding required';
  SRpSBitmapTransfer:WideString='Bitmap transfer cap.';
  SRpSBitmapTransfer64:WideString='B.transfer>64K cap.';
  SRpSDIBTransfer:WideString='Dev.Ind.Bitmap support';
  SRpSDIBDevTransfer:WideString='DIBToDevice support';
  SRpSFloodFillcap:WideString='Flood Fill cap.';
  SRpSGDI20Out:WideString='Win.GDI 2.0 support';
  SRPSPaletteDev:WideString='Palette device';
  SRpSScalingCap:WideString='Scaling cap.';
  SRpSStretchCap:WideString='Stretch blitter cap.';
  SRpSStretchDIBCap:WideString='Stretch DIB cap.';
  SRpSCharOutput:WideString='Character precision cap.';
  SRpSCharStroke:WideString='Character stroke precision';
  SRpSClipStroke:WideString='Clip stroke precision';
  SRpS90Rotation:WideString='90 Degree Rotation cap.';
  SRpSAnyRotation:WideString='Any Degree Rotation cap.';
  SRpSScaleXY:WideString='Scale X/Y direction cap.';
  SRpSDoubleChar:WideString='Double scale chars cap.';
  SRpSIntegerScale:WideString='Interger scale only cap.';
  SRpSAnyrScale:WideString='Exact char scaling cap.';
  SRpSDoubleWeight:WideString='Double weight cap.';
  SRpRasterFonts:WideString='Raster fonts';
  SRpVectorFonts:WideString='Vector fonts';
  SRpNobitBlockScroll:WideString='No bitblock scroll';
  SRpExcelFile:WideString='Excel file';
  SRpExcelNotSupported:WideString='Excel not supported';
  SRpFieldsFileNotDefined:WideString='Fields file not defined';
  SRpSMemo:WideString='Memo';
  SRpSInvReportHandle:WideString='Invalid report handle';
  SRpSNotAvail:WideString='Not available';
  SRpLinesPerInchIncorrect:WideString='Incorrect lines per inch';
  SRpStepBySize:WideString='By size';
  SRpStep20:WideString='20 cpi';
  SRpStep17:WideString='17 cpi';
  SRpStep15:WideString='15 cpi';
  SRpStep12:WideString='12 cpi';
  SRpStep10:WideString='10 cpi';
  SRpStep6:WideString='6 cpi';
  SRpStep5:WideString='5 cpi';
  SRpSFontStep:WideString='Font Step';
  SRpDBExpressDesc:WideString='Borland DBExpress is a new multi-database, server-based, '+
   'database driver technology, it''s simple  and thin,so database drivers are usually small '+
   'and efficient. Each database driver needs a  diferent shared object library, you '+
   'can also find third party dbexpress database drivers. By  default you can connect '+
   'to most common sql databases, but also a ODBC (OpenODBC) driver is  provided to '+
   'allow connection to any ODBC compliant database. It''s available in Windows and Linux  (unixODBC required in Linux).';
  SRpMybaseDesc:WideString='B.Mybase and text files is a file based database driver, '+
   'it can read XML database (Borland TClientDataset specification) and plain text '+
   'files, the path to the XML/text file can be specified in the Database property of'+
   ' dbxconnections file. For text files you can specify a field configuration file where '+
   'the fields position-type-size are stored, you can use the provided tool to generate this'+
   ' configuration file.';
  SRpIBXDesc:WideString='Interbase Express -IBX allows fast connections to any Interbase '+
   'and Firebird database, it does not need any shared object library, only Firebird/Interbase '+
   'client library. The database configuration (database path, language driver, user and password)'+
   ' is read from dbxconnections configuration file. It''s available in Windows and Linux.';
  SRpBDEDesc:WideString='Borland Database Engine is a mature engine allowing connexions to '+
   'a wide range of databases,  including file based (DBase-FoxPro-Paradox) and server based'+
   ' (any SQL Link installed on the  system). It can allows connection to any ODBC database. '+
   'Requires Borland Database Engine installed on your system, from control panel you can add,'+
   ' remove BDE database aliases, the database connection is the BDE alias name, the password '+
   'if  required is read from dbxconnections file. It''s available only in Microsoft Windows.';
  SRpADODesc:WideString='Microsoft DAO - Microsoft Data Access Components is an interface'+
   ' to connect databases using Microsoft DAO, you can build a connection string using the'+
   ' Connection Wizard or write the connection string manually. The connection string can '+
   'contain user-password-lang.drivers, so no more configuration is read from any external '+
   'file. This connection driver allow you also to connect to any ODBC data source, but '+
   'it''s recommended to use OLEDB database drivers. It''s available only in Microsoft Windows';
  SRpIBODesc:WideString='Interbase Objects -IBO is a Delphi native database driver '+
   '(and more) by Jason Wharton, this is a commercial product so it''s supported but '+
   'not distributed with Report Manager. It''s only available in Windows.';
  SRpErrorCreatePipe:WideString='Error creating pipe';
  SRpErrorForking:WideString='Error creating fork';
  SRpCreatingTempFile:WideString='Error creating temporary file';
  SRpPlainFile:WideString='Text file';
  SRpOpenDrawerBefore:WideString='Open drawer before';
  SRpOpenDrawerAfter:WideString='Open drawer after';
  SRpPrintPDFRep10:WideString='         -text     Generate text output with escape codes to print';
  SRpPrintPDFRep11:WideString='         -textdriver driver Use the text driver for text output';
  SRpPrintPDFRep12:WideString='         -oemconvert        Force recode to oem for text output';
  SRpCommandLineStdIN:WideString='         -stdin    Read from standard input instead from a file';
  SRpTextDrivers:WideString='Text drivers';
  SrpDriverZeos:WideString='Zeos Database Objects';
  SrpDriverZeosDesc:WideString='Zeos Database Objects is a Opensource database driver technology for Delphi/Kylix/Builder.';
  SrpDriverIBO:WideString='Interbase Objects';
  SRpBitmapFile:WideString='Bitmap File';
  SRpBitmapFileMono:WideString='Bitmap - monochrome';
  SRpPFormatMask:WideString='Format is the format string: ex.''99,99,99'''+#10+' and v is the value to convert to a formated string';
  SrpSAlignJustify:WideString='Justified';
  SRpSelectedPrinter:WideString='Selected printer';
  SRPVertDesp:WideString='Vert.Desp.';
  SRpLineTooLong:WideString='Line too long';
  SRpFileExists:WideString='Returns true if the file exists';
  SRpPFileExists:WideString='s is filename to check';
  SRpPRpAliasRequired:WideString='To load from library a TRPAlias must be assigned';
  SRpExistReportInThisGroup:WideString='Still exists one report in this group';
  SRpGroupParent:WideString='This group is parent of other groups';
  SRpNewReport:WideString='New Report';
  SRpReportName:WideString='Report Name';
  SRpSelectReport:WideString='You must select a report';
  SRpConfigLib:WideString='Configure libraries';
  SRpOpenFrom:WideString='Open from library';
  SRpSaveTo:WideString='Save to library';
  SRpConfigLibH:WideString='Open report libraries dialog';
  SRpOpenFromH:WideString='Open a report from a database library';
  SRpSaveToH:WideString='Save the report to a database library';
  SRpLibSelection:WideString='Library selection';
  SRpNewFolder:WideString='New report group';
  SRpDeleteSelection:WideString='Delete selection';
  SRpSearchReport:WideString='Search report';
  SRpExportFolder:WideString='Exports to folder';
  SRpExportFolderH:WideString='Exports all reports to a directory tree';
  SRpClientDatasetNotSupported:WideString='TClientDataset not supported';
  SRpVariables:WideString='Variables';
  SRpNoDataset:WideString='No Dataset';
  SRpRefresh:WideString='Refresh';
  SRpData:WideString='Data';
  SRpStructure:WideString='Structure';
  SRpDatabaseBrowser:WideString='Database browser';
  SRPEmptyAliasPath:WideString='Empty alias path';
  SrpDirectoryNotExists:WideString='Directory not exists or not enought privileges.';
  SRpuserGroups:WideString='User groups';
  SRpAliasGroups:WideString='This alias is accessible by this user groups';
  SRpUserGroupsHint:WideString='The user is member of this groups';
  SRpAdd:WideString='Add';
  SRpDelete:WideString='Delete';
  SRpAliasPath:WideString='To use a report library enter the alias preceded by : symbol (:TESTLIB)';
  SRpPrintRep11:WideString='         -excel    Output to excel';
  SRpPrintRep12:WideString='         -showparams Show Parameters before execution';
  SRpAboutBoxPreview:WideString='About box in preview';
  SRpString:WideString='String';
  SRpInteger:WideString='Integer';
  SRpSmallInt:WideString='SmallInt';
  SRpWord:WideString='Word';
  SRpUnknown:WideString='Unknown';
  SRpBoolean:WideString='Boolean';
  SRpFloat:WideString='Float';
  SRpCurrency:WideString='Currency';
  SRpBCD:WideString='BCD';
  SRpDate:WideString='Date';
  SRpTime:WideString='Time';
  SRpDateTime:WideString='DateTime';
  SRpBytes:WideString='Bytes';
  SRpVarBytes:WideString='VarBytes';
  SRpAutoInc:WideString='AutoInc';
  SRpBlob:WideString='Blob';
  SRpMemo:WideString='Memo';
  SRpGraphic:WideString='Graphic';
  SRpFmtMemo:WideString='FmtMemo';
  SRpParadoxOle:WideString='ParadoxOLE';
  SRpDBaseOLE:WideString='DBaseOLE';
  SRpTypedBinary:WideString='TypedBinary';
  SRpCursor:WideString='Cursor';
  SRpFixedChar:WideString='FixedChar';
  SRpWideString:WideString='WideString';
  SRpADT:WideString='ADT';
  SRpArray:WideString='Array';
  SRpReference:WideString='Reference';
  SRpDataset:WideString='Dataset';
  SRpOraBlob:WideString='OracleBlob';
  SRpOraClob:WideString='OracleClob';
  SRpVariant:WideString='Variant';
  SRpInterface:WideString='Interface';
  SRpIDispatch:WideString='IDispatch';
  SRpGUID:WideString='GUID';
  SRpTimeStamp:WideString='TimeStamp';
  SRpFmtBCD:WideString='FmtBCD';
  SRpAllProps:WideString='All';
  SRpPosition:WideString='Position';
  SRpText:WideString='Text';
  SRpLabel:WideString='Label';
  SRpExpression:WideString='Expression';
  SRpImage:WideString='Image';
  SRpShape:WideString='Shape';
  SRpChartData:WideString='Data';
  SRpChartAspect:WideString='Aspect';
  SRpBarcode:WideString='Barcode';
  SRpExeMetafile:WideString='Executable metafile';
  SRpExeReport:WideString='Executable report';
  SRpRename:WideString='Rename';
  SRpRenameHint:WideString='Renames the component';
  SRpAlreadyWithname:WideString='Already exists a component with this name';
  SRpNewName:WideString='New name';
  SRpAllowNulls:WideString='Allow Nulls';
  SRpAllowNullsHint:WideString='Makes visible or invisible the null checkbox in parameters window';
  SRpPortuguesse:WideString='Portuguesse';
  SRpGerman:WideString='Germany';
  SRpItalian:WideString='Italian';
  SRpHtmlFile:WideString='Html file';
  SRpHtmlFileSingle:WideString='Html file (single)';
  SRpPrintPDFRep13:WideString='         -html     Generate Html output';
  SRpPrintPDFRep13b:WideString='         -htmlsingle     Generate Html output in a single file';
  SRpOutputFilenameHTML:WideString='Output filename required, generating HTML output';
  SRPLeftRight:WideString='Left/Right';
  SRPTopBottom:WideString='Top/Bottom';
  SRPAllClient:WideString='All Client';
  SRpPrintRep14:WideString='         -pdf      Generate PDF output';
  SRpChartHint:WideString='Hint';
  SRpChartLegend:WideString='Legend';
  SRpAbs:WideString='Returns absolute value of a number.';
  SRpPAbs:WideString='num is the number change sign';
  SrpSBackExpression:WideString='Back.Expression';
  SrpSInvBackImage:WideString='Invalid background image';
  SRpSBackStyle:WideString='Back.Style';
  SRpSBDesign:WideString='Design';
  SRpSBPreview:WideString='Preview only';
  SRpSBPrint:WideString='Print';
  SRpAsc2:WideString='Convert special european chars to ASCII';
  SRpLength:WideString='Returns the length, in characters, of a string';
  SRpPLength:WideString='s is the source string';
  SRpSVGFile:WideString='Scalable Vector Graphics file';
  SRpTurkish:WideString='Turkish';
  SRpCSVFile:WideString='Comma separated values file';
  SRpTXTProFile:WideString='Custom text file';
  SRpPrintRep15:WideString='         -csv      Output to comma separated values';
  SRpPrintRep16:WideString='         -svg      Output to scalable vector graphics format';
  SRpPrintRep17:WideString='         -ctxt     Output to custom text';
  SRpPreviewMargins:WideString='Printable margins in preview';
  SRpSExportExpression:WideString='Export Expression';
  SRpSExportLine:WideString='Exp. Line';
  SRpSExportPos:WideString='Exp. Position';
  SRpSExportSize:WideString='Exp. Size';
  SRpSExportAlign:WideString='Exp. Align';
  SRpSExportDoNewLine:WideString='Exp. New Line';
  SRpSExportFormat:WideString='Exp. Format';
  SRpSFeaturenotsup:WideString='Feature not supported';
  SRpFormatNum:WideString='Formats a number using a mask';
  SRpPFormatNum:WideString='The mask can be like ##,##,##,##0.00';
  SRpNoTrueType:WideString='The font is not TrueType';
  SRpFontDataIndexNotFound:WideString='Font data index not found';
  SRpErrorProcessing:WideString='Can not continue processing report because a previous error';
  SRpEvalDescIdenLeft:WideString='Left side can not be assigned';
  SRpGraphicBounds:WideString='Adds bounds data to the graphic';
  SRpPGraphicBounds:WideString='Gr is the graphic identifier,automatic, lower and higher bounds values';
  SRpSetFontPropsAsDefault:WideString='Set font as default';
  SRpSetFontPropsAsDefaultHint:WideString='Set this component font properties as default for new components';
  SRpGetValueFromSQL:WideString='Obtain a value from a sql sentence';
  SRpGetValueFromSQLP:WideString='You use a connection name and a sql sentence that should return a value';
  SRpPaperSource:WideString='Paper source (Windows)';
  SRpBinFirst:WideString='First source';
  SRpBinLower:WideString='Lower source';
  SRpBinMiddle:WideString='Middle source';
  SRpBinManual:WideString='Manual source';
  SRpBinEnvelope:WideString='Envelope source';
  SRpBinEnvelopeManual:WideString='Manual envelope source';
  SRpBinAuto:WideString='Automatic source';
  SRpBinTractor:WideString='Tractor source';
  SRpBinSmallFMT:WideString='Small format source';
  SRpBinLargeFMT:WideString='Large format source';
  SRpBinLargeCapacity:WideString='Large capacity source';
  SRpBinCassette:WideString='Cassette source';
  SRpFormSource:WideString='Form source';
  SRpDuplex:WideString='Duplex option (Windows)';
  SRpDuplexS:WideString='Simple duplex';
  SRpDuplexHor:WideString='Horizontal duplex';
  SRpDuplexVer:WideString='Vertical duplex';
  SRpPrintRep18:WideString='         -bmp       Generate Bitmap output';
  SRpPrintRep19:WideString='         -bmpresx   Bitmap Horzontal DPI resolution(100)';
  SRpPrintRep20:WideString='         -bmpresx   Bitmap Verticall DPI resolution(100)';
  SRpPrintRep21:WideString='         -sendfax   phonenum Sends the report to a fax number';
  SRpPrintRep22:WideString='         -faxcover  coverstring Fax conver string, default report name';
  SRpPrintRep23:WideString='         -faxdevice TAPI device, default, show selection dialog';
  SRpPrintRep24:WideString='         -bmpcolor  Save to full color bmp';
  SRpPhoneNum:WideString='Phone number';
  SRpStatus:WideString='Status';
  SRpConversion:WideString='Conversion';
  SRpWrongREsult:Widestring='Wrong result from function:';
  SRpBitmapProps:WideString='Bitmap properties';
  SRpMonochrome:WideString='Monochrome';
  SRpHorzRes:WideString='Horizontal resolution in dots per inches';
  SRpVertRes:WideString='Vertical resolution in dots per inches';
  SRpForceForm:WideString='Force form name';
  SRpFormName:WideString='Form name';
  SRpFormPageSize:WideString='Form page size';
  SRpPageSize:WideString='Page size';
  SRpCompareValue:WideString='Returns -1 if first number is lower, 1 if first number is greater or zero if equal.';
  SRpPCompareValue:WideString='num1 and num2 are numbers to compare, epsilon de diference tolerance';
  SRpDrawTiledpi:WideString='Tile proportional';
  SRpConnecting:WideString='Connecting';
  SRpGenerating:WideString='Generating';
  SRpSending:WideString='Sending';
  SRpTransmiting:WideString='Transmiting';
  SrpSSerieCaptionExp:WideString='Serie Caption Ex.';
  SRpBarcodeCodeTooLarge:WideString='Bar code too large';
  SRpGLIOutOfRangeBarcode:WideString='GLI Out of range in PDF417 barcode';
  SRpInvalidCodeword:WideString='Invalid codeword in PDF417 barcode';
  SRpECCLevel:WideString='PDF417 ECC';
  SRpNumRows:WideString='Num. Rows';
  SRpNumCols:WideString='Num. Cols';
  SRpTruncatedPDF417:WideString='Truncate PDF417';
  SRpPrintRep25:WideString='         -printer printername  Select printer before print';
  SRpSetLanguage:WideString='Sets the language for the report at runtime';
  SRpUseKPrinter:WideString='         -kprinter  Use kprinter interface';
  SRpExcelFileNoMulti:WideString='Excel file (one sheet)';
  SRpPlainPrinter:WideString='Plain text printer';
  SRpPlainFullPrinter:WideString='Full plain text printer';
  SRpTimeOut:WideString='Timeout detected';
  SRpPrintRep26:WideString='         -onesheet Optional one sheet excel output';
  SRpTypeInfo:WideString='Data type information';
  SRpStreamXML:WideString='XML';
  SRpStreamXMLComp:WideString='XML Compressed';
  SRpMarkType:WideString='Mark Style';
  SRpSMarkType0:WideString='Value';
  SRpSMarkType1:WideString='Percent';
  SRpSMarkType2:WideString='Label';
  SRpSMarkType3:WideString='Label-Percent';
  SRpSMarkType4:WideString='Label-Value';
  SRpSMarkType5:WideString='Legend';
  SRpSMarkType6:WideString='Percent-Total';
  SRpSMarkType7:WideString='LabelPercentTotal';
  SRpSMarkType8:WideString='XValue';
  SRpSVertAxisFSize:WideString='F.Size V.Axis';
  SRpSVertAxisFRot:WideString='F.Rot. V.Axis';
  SRpSHorzAxisFSize:WideString='F.Size H.Axis';
  SRpSHorzAxisFRot:WideString='F.Rot. H.Axis';
  SrpSSerieColor:WideString='S.Color Expression';
  SrpSValueColor:WideString='Color Expression';
  SRpGraphicColor:WideString='Set color for last value';
  SRpGraphicSerieColor:WideString='Set color for last serie';
  SRpSMultiple:WideString='Multiple sel.';
  SRpSLookupDatasetNotavail:WideString='Lookup dataset not available for parameter';
  SrpLookupDataset:WideString='Lookup dataset';
  SrpSearchDataset:WideString='Search dataset';
  SRpValueSearch:WideString='Value search help';
  SRpOpenOnStart:WideString='Open on start';
  SRpSearchValue:WideString='Search value';
  SRpSearch:WideString='Search';
  SRpSLinesInchError:WideString='Lines per inch should be between 1 and 30';
  SRpLithuanian:WideString='Lithuanian';
  SRpDanish:WideString='Danish';
  SRpDutch:WideString='Dutch';
  SRpSpanishMe:WideString='Spanish Mexico';
  SRpGreek:WideString='Greek';
  SRpHungar:WideString='Hungarian';

  SRpSelectDest:WideString='Select destination';
  SRpProcessing:WideString='Processing';
  SrpRegCopy:WideString='Copying record';
  SrpChangeLevel:WideString='Change Level';
  SrpReboot:WideString='Reboot';
  SRpDriverDotNet:WideString='Dot net driver';
  SRpDriverDotNetDesc:WideString='Dot net driver allow the execution of reports using '+
   ' dot net technology exclusively';
  SRpEmptyResponse:WideString='Empty response';
  SRpRepMetafileUn:WideString='Report Metafile uncompressed';
  SRpPrintRep28:WideString='         -csvseparator     CSV output separator';
  SRpPrintRep29:WideString='         -async     Asynchronous execution';
  SRpAsyncExecution:WideString='Asynchronous execution';
  SRpMaximumPages:WideString='Maximum number of pages reached';
  SRpPMax:WideString='Returns the maximum value';
  SRpChsToCht:WideString='Convert simplified to traditional Chinese';
  SRpChtToChs:WideString='Convert traditional to simplified Chinese';
  SRpParameterExists:WideString='Parameter already exists';
  SRpCached:WideString='Shared Image';
  SRpIsInteger:WideString='Returns true if the string is a valid integer';
  SRpIsNumeric:WideString='Returns true if the string is a valid number';
  SRpIsValidDateTime:WideString='Returns true if the string is a valid date and time';
  SRpCheckExpression:WideString='Raises an exception with provided message if the expression is false';
  SRpCachedFixed:WideString='Fixed Image';
  SRpCachedVariable:WideString='Variable Image';
  SRpSParamSubsE:WideString='String Substi.Ex.';
  SRpExcelFiles:WideString='Excel Files';
  SRpDBFFiles:WideString='DBF Files';
  SRpShowPrintDialog:WideString='Show print dialog';

  SRpWaitTwain:WideString='Waiting for image in twain source';
  SRpWaitTwainExceededMax:WideString='Scanned image is too large, current size and maximum in KBytes: ';
  SRpCompletedUpload:WideString='Upload completed';
  SRpUploadProg:WideString='Uploading %d of %d (Kbytes)';
  SRpNoTwain:WideString='No twain sources';
  SRpGetIniValue:WideString='Get a (string) value from an ini file';
  SrpSpanishAr:WideString='Spanish (Argentina)';
  SRpPortuguesseBrasil:WideString='Portuguesse (Brasil)';
  SrpCroatian:WideString='Croatian';
  SrpCzech:WideString='Checo';
  SRpDutchFlemish:WideString='Dutch (Flemish)';
  SRpFinn:WideString='Finn';
  SRpNorwegian:WideString='Norwegian';
  SRpGalician:WideString='Galician';
  SRpRussian:WideString='Russian';
  SRpPolish:WideString='Polish';
  SRpSwedish:WideString='Swedish';
  SRpSlovenian:WideString='Slovenian';
  SRpBasque:WideString='Basque';
  SRpJapanese:WideString='Japanese';
  SRpErrorGeneratingFax:WideString='Error generating fax';
  SRpErrorFilter:WideString='Error on filter';
  SRpDecode64:WideString='Decode base 64 string';
  SRpStringToBin:WideString='Converts string to binary stream';
  SRpLoadfile:WideString='Loads a file inside a string';
  SRpDefaultCopies:WideString='Default printer copies';

  //
  SRpSParamSubsList:WideString='String Subs.List';
  SRpSParamInitialExpression:WideString='Initial expression';
  //
  SRpCommonFields:WideString='Common fields that match with the first dataset, semicolon separated';
implementation

uses rptranslator;

var
 atrans:TRpTranslator;

function TranslateStr(index:integer;defvalue:Widestring):WideString;
begin
 if Not Assigned(atrans) then
 begin
  atrans:=TRpTranslator.Create(nil);
  atrans.Filename:='reportmanres';
  atrans.Active:=true;
 end;
 Result:=atrans.LoadString(index,defvalue);
end;

procedure TranslateVar(index:integer;var astring:Widestring);
begin
 if Not Assigned(atrans) then
 begin
  atrans:=TRpTranslator.Create(nil);
  atrans.Filename:='reportmanres';
  atrans.Active:=true;
 end;
 astring:=atrans.LoadString(index,astring);
end;

procedure ConvertAllStrings;
begin
 TranslateVar(95,SRpSDefault);
 TranslateVar(262,SRpNoFilename);
 TranslateVar(263,SRpErrorFork);
 TranslateVar(264,SRpEnglish);
 TranslateVar(265,SRpSpanish);
 TranslateVar(266,SRpCatalan);
 TranslateVar(267,SRpDirCantBeCreated);
 TranslateVar(268,SRpConfigFileNotExists);
 TranslateVar(269,SRpPage);
 TranslateVar(270,SRpItem);
 TranslateVar(271,SRpCancel);
 TranslateVar(272,SRpInvalidClipboardFormat);
 TranslateVar(273,SRpErrorReadingReport);
 TranslateVar(274,SRpIgnoreError);
 TranslateVar(275,SRpMainDataset);
 TranslateVar(276,SRpNewGroup);
 TranslateVar(277,SRpSGroupName);
 TranslateVar(278,SRpGroupAlreadyExists);
 TranslateVar(279,SRpNoSpaceToPrint);
 TranslateVar(280,SRpSection);
 TranslateVar(281,SRpNothingToPrint);
 TranslateVar(282,SRpLastPageReached);
 TranslateVar(283,SRPAliasNotExists);
 TranslateVar(284,SRpCopyStreamError);
 TranslateVar(285,SRpDriverNotSupported);
 TranslateVar(286,SrpDriverIBX);
 TranslateVar(287,SrpDriverADO);
 TranslateVar(288,SrpDriverBDE);
 TranslateVar(289,SrpDriverDBX);
 TranslateVar(290,SRpDriverAliasIsNotInterbase);
 TranslateVar(291,SRpNoDatabase);
 TranslateVar(292,SRpSubreportAliasNotFound);
 TranslateVar(293,SrpSAggregate);
 TranslateVar(294,SRpNone);
 TranslateVar(295,SRpGeneral);
 TranslateVar(296,SrpSAgeGroup);
 TranslateVar(297,SrpSAgeType);
 TranslateVar(298,SrpSum);
 TranslateVar(299,SRpMin);
 TranslateVar(300,SRpMax);
 TranslateVar(301,SRpAvg);
 TranslateVar(302,SRpStdDev);
 TranslateVar(303,SrpSIniValue);
 TranslateVar(304,SrpSIdentifier);
 TranslateVar(305,SRpErrorIdenExpression);
 TranslateVar(306,SRpSHorzLine);
 TranslateVar(307,SRpSVertLine);
 TranslateVar(308,SRPHorzDesp);
 TranslateVar(309,SRpInvalidBoolean);
 TranslateVar(310,SRpPaperNotFount);
 TranslateVar(311,SRpErrorCreatingPaper);
 TranslateVar(312,SRpSureDeleteSection);
 TranslateVar(313,SRpNoDatasets);
 TranslateVar(314,SRpSampleTextToLabels);
 TranslateVar(315,SRpOnlyAReportOwner);
 TranslateVar(316,SrpErrorProcesingFileMenu);
 TranslateVar(317,SRpRepToTxt1);
 TranslateVar(318,SRpRepToTxt2);
 TranslateVar(319,SRpRepToTxt3);
 TranslateVar(320,SRpMetaPrint1);
 TranslateVar(321,SRpMetaPrint2);
 TranslateVar(322,SRpMetaPrint3);
 TranslateVar(323,SRpMetaPrint4);
 TranslateVar(324,SRpMetaPrint5);
 TranslateVar(325,SRpMetaPrint6);
 TranslateVar(326,SRpMetaPrint7);
 TranslateVar(327,SRpMetaPrint8);
 TranslateVar(328,SRpMetaPrint9);
 TranslateVar(329,SRpTooManyParams);
 TranslateVar(330,SRpPrintingFile);
 TranslateVar(331,SRpPrinted);
 TranslateVar(332,SRpPrintedFileDeleted);
 TranslateVar(333,SRpNoDriverPassedToPrint);
 TranslateVar(334,SRpTxtToRep1);
 TranslateVar(335,SRpTxtToRep2);
 TranslateVar(336,SRpTxtToRep3);
 TranslateVar(337,SRpPrintRep1);
 TranslateVar(338,SRpPrintRep2);
 TranslateVar(339,SRpPrintRep3);
 TranslateVar(340,SRpPrintRep4);
 TranslateVar(341,SRpPrintRep5);
 TranslateVar(342,SRpPrintRep6);
 TranslateVar(343,SRpPrintRep7);
 TranslateVar(344,SRpPrintRep8);
 TranslateVar(345,SRpPrintPDFRep1);
 TranslateVar(346,SRpPrintPDFRep2);
 TranslateVar(347,SRpPrintPDFRep3);
 TranslateVar(348,SRpPrintPDFRep4);
 TranslateVar(349,SRpPrintPDFRep5);
 TranslateVar(350,SRpPrintPDFRep6);
 TranslateVar(351,SRpPrintPDFRep7);
 TranslateVar(352,SRpPrintPDFRep8);
 TranslateVar(353,SrpSubReport);
 TranslateVar(354,SRpRepman);
 TranslateVar(355,SRpError);
 TranslateVar(356,SRpOpenSelec);
 TranslateVar(357,SRptReportnotfound);
 TranslateVar(358,SRpMustInstall);
 TranslateVar(359,SRpConverstoolarge);
 TranslateVar(360,SRpErrorMapmode);
 TranslateVar(361,SRpErrorUnitconversion);
 TranslateVar(362,SRpMinHeight);
 TranslateVar(363,SRpMaxWidth);
 TranslateVar(364,SRpAssignFunc);
 TranslateVar(365,SRpAssignConst);
 TranslateVar(366,SRpAssignfield);
 TranslateVar(367,SRpNohelp);
 TranslateVar(368,SRpNoaparams);
 TranslateVar(369,SRpNomodel);
 TranslateVar(370,SRpTrueHelp);
 TranslateVar(371,SRpFalseHelp);
 TranslateVar(372,SRpFieldHelp);
 TranslateVar(373,SRpUpperCase);
 TranslateVar(374,SRpPUpperCase);
 TranslateVar(375,SRpLowerCase);
 TranslateVar(376,SRpPLowerCase);
 TranslateVar(377,SRpHourMinSec);
 TranslateVar(378,SRpPHourMinSec);
 TranslateVar(379,SRpFloatToDateTime);
 TranslateVar(380,SRpPFloatToDateTime);
 TranslateVar(381,SRpSin);
 TranslateVar(382,SRpPSin);
 TranslateVar(383,SRpRound);
 TranslateVar(384,SRpPRound);
 TranslateVar(385,SRpInt);
 TranslateVar(386,SRpPInt);
 TranslateVar(387,SRpStr);
 TranslateVar(388,SRpPStr);
 TranslateVar(389,SRpVal);
 TranslateVar(390,SRpPVal);
 TranslateVar(391,SRpTrim);
 TranslateVar(392,SRpPtrim);
 TranslateVar(393,SRpLeft);
 TranslateVar(394,SRpPLeft);
 TranslateVar(395,SRpPos);
 TranslateVar(396,SRpPPos);
 TranslateVar(397,SRpAllDriver);
 TranslateVar(398,SRpSelectDriver);
 TranslateVar(399,SRpNewConnection);
 TranslateVar(400,SRpConnectionName);
 TranslateVar(401,SRpDropConnection);
 TranslateVar(402,SRpSureDropConnection);
 TranslateVar(403,SRpVendorLib);
 TranslateVar(404,SRpLibraryName);
 TranslateVar(405,SRpSelectConnectionFirst);
 TranslateVar(406,SRpConnectionOk);
 TranslateVar(407,SRpFieldNotFound);
 TranslateVar(408,SRpNotAField);
 TranslateVar(409,SRpNotBinary);
 TranslateVar(410,SRpErrorReadingFromFieldStream);
 TranslateVar(411,SRpSQrt);
 TranslateVar(412,SRpPSQRt);
 TranslateVar(413,SRpMod);
 TranslateVar(414,SRpPMod);
 TranslateVar(415,SRpToday);
 TranslateVar(416,SRpNow);
 TranslateVar(417,SRpTimeH);
 TranslateVar(418,SRpNull);
 TranslateVar(419,SRpMonthName);
 TranslateVar(420,SRpPMonthName);
 TranslateVar(421,SRpEvalText);
 TranslateVar(422,SRpPEvalText);
 TranslateVar(423,SRpMonth);
 TranslateVar(424,SRpPMonth);
 TranslateVar(425,SRpYear);
 TranslateVar(426,SRpPyear);
 TranslateVar(427,SRpDay);
 TranslateVar(428,SRpPDay);
 TranslateVar(429,SRpRight);
 TranslateVar(430,SRpPRight);
 TranslateVar(431,SRpSubStr);
 TranslateVar(432,SRpPSubStr);
 TranslateVar(433,SRpFormatStr);
 TranslateVar(434,SRpPFormatStr);
 TranslateVar(435,SRpNumToText);
 TranslateVar(436,SRpPNumToText);
 TranslateVar(437,SRpDivisioZero);
 TranslateVar(438,SRpEvalType);
 TranslateVar(439,SRpInvalidOperation);
 TranslateVar(440,SRpEvalDescIden);
 TranslateVar(441,SRpEvalParent);
 TranslateVar(442,SRpConvertError);
 TranslateVar(443,SRpIdentifierexpected);
 TranslateVar(444,SRpstringexpected);
 TranslateVar(445,SRpNumberexpected);
 TranslateVar(446,SRpOperatorExpected);
 TranslateVar(447,SRpInvalidBinary);
 TranslateVar(448,SRpExpected);
 TranslateVar(449,SRpEvalsyntax);
 TranslateVar(450,SRpsetexpression);
 TranslateVar(451,SRpFieldDuplicated);
 TranslateVar(452,SRpVariabledefined);
 TranslateVar(453,SRpOperatorSum);
 TranslateVar(454,SRpOperatorDif);
 TranslateVar(455,SRpOperatorMul);
 TranslateVar(456,SRpOperatorDiv);
 TranslateVar(457,SRpOperatorComp);
 TranslateVar(458,SRpOperatorLog);
 TranslateVar(459,SRpOperatorDec);
 TranslateVar(460,SRpOperatorDecM);
 TranslateVar(461,SRpOperatorDecP);
 TranslateVar(462,SRpOperatorSep);
 TranslateVar(463,SRpOperatorSepP);
 TranslateVar(464,SRpErrorOpenImp);
 TranslateVar(465,SRpPaperexists);
 TranslateVar(466,SRpPrinting);
 TranslateVar(467,SRpDefaultPrinter);
 TranslateVar(468,SRpReportPrinter);
 TranslateVar(469,SRpTicketPrinter);
 TranslateVar(470,SRpGraphicprinter);
 TranslateVar(471,SRpCharacterprinter);
 TranslateVar(472,SRpReportPrinter2);
 TranslateVar(473,SRpTicketPrinter2);
 TranslateVar(474,SRpUserPrinter1);
 TranslateVar(475,SRpUserPrinter2);
 TranslateVar(476,SRpUserPrinter3);
 TranslateVar(477,SRpUserPrinter4);
 TranslateVar(478,SRpUserPrinter5);
 TranslateVar(479,SRpUserPrinter6);
 TranslateVar(480,SRpUserPrinter7);
 TranslateVar(481,SRpUserPrinter8);
 TranslateVar(482,SRpUserPrinter9);
 TranslateVar(483,SRpREmoveElements);
 TranslateVar(484,SRpPageHeader);
 TranslateVar(485,SRpReportHeader);
 TranslateVar(486,SRpGeneralPageHeader);
 TranslateVar(487,SRpGeneralReportHeader);
 TranslateVar(488,SRpDetail);
 TranslateVar(489,SRpHeader);
 TranslateVar(490,SRpFooter);
 TranslateVar(491,SRpPageFooter);
 TranslateVar(492,SRpReportFooter);
 TranslateVar(493,SRpGroup);
 TranslateVar(494,SRpMaxGroupsExceded);
 TranslateVar(495,SRpSelectGroupToRemove);
 TranslateVar(496,SRpSelectGroup);
 TranslateVar(497,SRpGroupNameError);
 TranslateVar(498,SRpReportChanged);
 TranslateVar(499,SRpErrorWriteSeccion);
 TranslateVar(500,SRpErrorReadSeccion);
 TranslateVar(501,SRpUntitled);
 TranslateVar(502,SRpSaveAborted);
 TranslateVar(503,SRpOperationAborted);
 TranslateVar(504,SRpFileNameRequired);
 TranslateVar(505,SRpAliasExists);
 TranslateVar(506,SRPDabaseAliasNotFound);
 TranslateVar(507,SRpCircularDatalink);
 TranslateVar(508,SRPMasterNotFound);
 TranslateVar(509,SRpInvalidComponentAssigment);
 TranslateVar(510,SRpNewDatabaseconf);
 TranslateVar(511,SRpEnterTheName);
 TranslateVar(512,SRpChangeAliasConf);
 TranslateVar(513,SRpEnterTheNewName);
 TranslateVar(514,SRpDatabaseAliasNull);
 TranslateVar(515,SRpDatabasenotassined);
 TranslateVar(516,SRpConnectionsuccesfull);
 TranslateVar(517,SRpNewaliasDef);
 TranslateVar(518,SRpAliasName);
 TranslateVar(519,SRpTableAliasExists);
 TranslateVar(520,SRpBadSignature);
 TranslateVar(521,SRpBadFileHeader);
 TranslateVar(522,SrpMtPageSeparatorExpected);
 TranslateVar(523,SrpMtObjectSeparatorExpected);
 TranslateVar(524,SrpObjectTypeError);
 TranslateVar(525,SrpObjectDataError);
 TranslateVar(526,SRpMetaIndexPageOutofBounds);
 TranslateVar(527,SRpMetaIndexObjectOutofBounds);
 TranslateVar(528,SRpPrintDriverIncorrect);
 TranslateVar(529,SRpWinGDINotInit);
 TranslateVar(530,SRpQtDriverNotInit);
 TranslateVar(531,SRpGDIDriverNotInit);
 TranslateVar(532,SRPNoSelectedSubreport);
 TranslateVar(533,SRPNoSelectedSection);
 TranslateVar(534,SRpGroupNameRequired);
 TranslateVar(535,SRpSubReportNotFound);
 TranslateVar(536,SRpSectionNotFound);
 TranslateVar(537,SRpAtLeastOneDetail);
 TranslateVar(538,SRpAtLeastOneSubreport);
 TranslateVar(539,SrpNewDataset);
 TranslateVar(540,SrpRenameDataset);
 TranslateVar(541,SRpSaveChanges);
 TranslateVar(542,SRpParamNotFound);
 TranslateVar(543,SRpNewParam);
 TranslateVar(544,SRpParamName);
 TranslateVar(545,SRpParamNameExists);
 TranslateVar(546,SRpRenameParam);
 TranslateVar(547,SRpBold);
 TranslateVar(548,SRpUnderline);
 TranslateVar(549,SRpItalic);
 TranslateVar(550,SRpStrikeOut);
 TranslateVar(551,SRpSFontRotation);
 TranslateVar(552,SRpSTop);
 TranslateVar(553,SRpSLeft);
 TranslateVar(554,SRpSWidth);
 TranslateVar(555,SRpSHeight);
 TranslateVar(556,SRpSCurrency);
 TranslateVar(557,SRpSString);
 TranslateVar(558,SRpSColor);
 TranslateVar(559,SRpSInteger);
 TranslateVar(560,SRpSWFontName);
 TranslateVar(561,SRpSLFontName);
 TranslateVar(562,SRpSType1Font);
 TranslateVar(563,SrpSFontSize);
 TranslateVar(564,SrpSFontColor);
 TranslateVar(565,SrpSBackColor);
 TranslateVar(566,SrpSFontStyle);
 TranslateVar(567,SrpSTransparent);
 TranslateVar(568,SRpSBool);
 TranslateVar(569,SRpSList);
 TranslateVar(570,SrpSText);
 TranslateVar(571,SrpSExpression);
 TranslateVar(572,SrpSBarcode);
 TranslateVar(573,SrpSCalculatingBarcode);
 TranslateVar(574,SrpSDisplayFormat);
 TranslateVar(575,SRpUnknownType);
 TranslateVar(576,SrpSOnlyOne);
 TranslateVar(577,SRpSBarcodeType);
 TranslateVar(578,SRpSShowText);
 TranslateVar(579,SRpSChecksum);
 TranslateVar(580,SRpSModul);
 TranslateVar(581,SRpSRatio);
 TranslateVar(582,SRpWrongBarcodeType);
 TranslateVar(583,SRpSBSolid);
 TranslateVar(584,SRpSBClear);
 TranslateVar(585,SRpSBHorizontal);
 TranslateVar(586,SRpSBVertical);
 TranslateVar(587,SRpSBFDiagonal);
 TranslateVar(588,SRpSBBDiagonal);
 TranslateVar(589,SRpSBCross);
 TranslateVar(590,SRpSBDiagCross);
 TranslateVar(591,SRpSBDense1);
 TranslateVar(592,SRpSBDense2);
 TranslateVar(593,SRpSBDense3);
 TranslateVar(594,SRpSBDense4);
 TranslateVar(595,SRpSBDense5);
 TranslateVar(596,SRpSBDense6);
 TranslateVar(597,SRpSBDense7);
 TranslateVar(598,SRpSPSolid);
 TranslateVar(599,SRpSPDash);
 TranslateVar(600,SRpSPDot);
 TranslateVar(601,SRpSPDashDot);
 TranslateVar(602,SRpSPDashDotDot);
 TranslateVar(603,SRpSPClear);
 TranslateVar(604,SRpsSCircle);
 TranslateVar(605,SRpsSEllipse);
 TranslateVar(606,SRpsSRectangle);
 TranslateVar(607,SRpsSRoundRect);
 TranslateVar(608,SRpsSRoundSquare);
 TranslateVar(609,SRpsSSquare);
 TranslateVar(610,SRpSAutoExpand);
 TranslateVar(611,SRpSAutoContract);
 TranslateVar(612,SRpSAfterPrint);
 TranslateVar(613,SRpSBeforePrint);
 TranslateVar(614,SRpSPrintCondition);
 TranslateVar(615,SRpSGroupExpression);
 TranslateVar(616,SRPSChangeBool);
 TranslateVar(617,SRPSPageRepeat);
 TranslateVar(618,SRPSBeginPage);
 TranslateVar(619,SRPSkipPage);
 TranslateVar(620,SRPAlignBottom);
 TranslateVar(621,SRPBottom);
 TranslateVar(622,SRpSRight);
 TranslateVar(623,SRPAlign);
 TranslateVar(624,SRpIdentifierAlreadyExists);
 TranslateVar(625,SrpSCutText);
 TranslateVar(626,SrpSWordwrap);
 TranslateVar(627,SrpSSingleLine);
 TranslateVar(628,SrpSAlignment);
 TranslateVar(629,SrpSVAlignment);
 TranslateVar(630,SRpSAlignNone);
 TranslateVar(631,SRpSAlignLeft);
 TranslateVar(632,SRpSAlignRight);
 TranslateVar(633,SRpSAlignCenter);
 TranslateVar(634,SRpSAlignTop);
 TranslateVar(635,SRpSAlignBottom);
 TranslateVar(636,SRPSDrawCrop);
 TranslateVar(637,SRPSDrawStretch);
 TranslateVar(638,SRPSDrawFull);
 TranslateVar(639,SrpSImage);
 TranslateVar(640,SRpKbytes);
 TranslateVar(641,SRpInvalidImageFormat);
 TranslateVar(642,SRpPropertyisnotstream);
 TranslateVar(643,SrpSShape);
 TranslateVar(644,SrpSBrushStyle);
 TranslateVar(645,SrpSBrushColor);
 TranslateVar(646,SrpSPenStyle);
 TranslateVar(647,SrpSPenColor);
 TranslateVar(648,SrpSPenWIdth);
 TranslateVar(649,SRpBlackness);
 TranslateVar(650,SRpDstInvert);
 TranslateVar(651,SRpMergeCopy);
 TranslateVar(652,SRpMergePaint);
 TranslateVar(653,SRpNotSrcCopy);
 TranslateVar(654,SRpNotSrcErase);
 TranslateVar(655,SRpPatCopy);
 TranslateVar(656,SRpPatInvert);
 TranslateVar(657,SRpPatPaint);
 TranslateVar(658,SRpSrcAnd);
 TranslateVar(659,SRpSrcCopy);
 TranslateVar(660,SRpSrcErase);
 TranslateVar(661,SRpSrcInvert);
 TranslateVar(662,SRpSrcPaint);
 TranslateVar(663,SRpWhiteness);
 TranslateVar(664,SRpCreateMask);
 TranslateVar(665,SrpCopyMode);
 TranslateVar(666,SRpDPIRes);
 TranslateVar(667,SRpDrawStyle);
 TranslateVar(668,SRpDrawTile);
 TranslateVar(669,SRpErrorWritingPage);
 TranslateVar(670,SrpStreamErrorPage);
 TranslateVar(671,SRpBringToFront);
 TranslateVar(672,SRpSendToBack);
 TranslateVar(673,SRpInvalidStreaminRpImage);
 TranslateVar(674,SRpPropertyNotFound);
 TranslateVar(675,SRpPropertyHaveNoListValues);
 TranslateVar(676,SRpIncorrectComponentForInterface);
 TranslateVar(677,SRpPropName);
 TranslateVar(678,SRpPropValue);
 TranslateVar(679,SRpUndefinedPaintInterface);
 TranslateVar(680,SRpNoDriverName);
 TranslateVar(681,SRpIncorrectCalltoDeawGrid);
 TranslateVar(682,SRpSNotYetImplemented);
 TranslateVar(683,SRpNoFileNameProvided);
 TranslateVar(684,SRpRecordCount);
 TranslateVar(685,SRpNoStreamToSaveReport);
 TranslateVar(686,SRpDocNotInstalled);
 TranslateVar(687,SRpDocNotInstalled2);
 TranslateVar(688,SRpDocNotInstalled3);
 TranslateVar(689,SRpSelectAddConnection);
 TranslateVar(690,SRpStreamNotValid);
 TranslateVar(691,SRpNotPrintingPDF);
 TranslateVar(692,SRpInvalidBitmapHeaderSize);
 TranslateVar(693,SRpBadBitmapFileHeader);
 TranslateVar(694,SRpBadBitmapStream);
 TranslateVar(695,SRpBitMapInfoHeaderBitCount);
 TranslateVar(696,SRpInvalidBitmapPalette);
 TranslateVar(697,SRpBadColorIndex);
 TranslateVar(698,SRpRLECompBitmapPDF);
 TranslateVar(699,SRpMonochromeBitmapPDF);
 TranslateVar(700,SRpParamBDENotSupported);
 TranslateVar(701,SRpPDFFile);
 TranslateVar(702,SRpPDFFileUn);
 TranslateVar(703,SRpRepMetafile);
 TranslateVar(704,SRpRepFile);
 TranslateVar(705,SRpAnyFile);
 TranslateVar(706,SRpBitmapImages);
 TranslateVar(707,SRpUnkownClassForMultiSelect);
 TranslateVar(708,SRpClassNotRegistered);
 TranslateVar(709,SRpSampleBarCode);
 TranslateVar(710,SRpDatasetNotExists);
 TranslateVar(711,SRpDatabaseNotExists);
 TranslateVar(712,SrpSChartType);
 TranslateVar(713,SrpSChart);
 TranslateVar(714,SrpSChangeSerieExp);
 TranslateVar(715,SrpSChangeSerieBool);
 TranslateVar(716,SrpSCaptionExp);
 TranslateVar(717,SrpSGetValueCondition);
 TranslateVar(718,SRpIndexOutOfBounds);
 TranslateVar(719,SRpSOblique1);
 TranslateVar(720,SRpSOblique2);
 TranslateVar(721,SRpNoFilenameAssignedNotTRpTranslator);
 TranslateVar(722,SRpParameter);
 TranslateVar(723,SRpYes);
 TranslateVar(724,SRpNo);
 TranslateVar(93,SRpOk);
 TranslateVar(725,SRpRetry);
 TranslateVar(726,SRpAbort);
 TranslateVar(727,SRpIgnore);
 TranslateVar(728,SrpInformation);
 TranslateVar(729,SrpWarning);
 TranslateVar(730,SRpError);
 TranslateVar(731,SRpNotFound);
 TranslateVar(768,SRpServerAlreadyRunning);
 TranslateVar(771,SRpAuthFailed);
 TranslateVar(772,SRpAuthorized);
 TranslateVar(776,SRpReceivedPacket);
 TranslateVar(787,SRpServerStarted);
 TranslateVar(788,SRpClientConnected);
 TranslateVar(789,SRpServerStoped);
 TranslateVar(794,SRpSureDeleteReport);
 TranslateVar(795,SRpGraphicClear);
 TranslateVar(796,SRpGraphicNew);
 TranslateVar(797,SRpPGraphicClear);
 TranslateVar(798,SRpPGraphicNew);
 TranslateVar(799,SRpNoDataAvailableToPrint);
 TranslateVar(800,SRpPrintOnlyIfDataAvailable);
 TranslateVar(801,SRpPasswordConfirmationIncorrect);
 TranslateVar(802,SRpAAliasnameBeAssigned);
 TranslateVar(803,SRpAPathMustBeAssigned);
 TranslateVar(804,SRpAUserNameMustbeAssigned);
 TranslateVar(805,SRpUserorPasswordIncorrect);
 TranslateVar(814,SRpWindowsNTRequired);
 TranslateVar(815,SRpCannotExecute);
 TranslateVar(822,SRpServiceUnInstalled);
 TranslateVar(823,SRpServiceStopped);
 TranslateVar(824,SRpServiceStarted);
 TranslateVar(830,SRpSExternalpath);
 TranslateVar(831,SRpGetFieldValue);
 TranslateVar(832,SRpPGetFieldValue);
 TranslateVar(834,SRpChildSubRep);
 TranslateVar(859,SRpNewDatabaseInfo);
 TranslateVar(861,SRpSExternalData);
 TranslateVar(866,SRpExternalSectionNotFound);
 TranslateVar(867,SRpRecordnotExists);
 TranslateVar(868,SRpLoadSection);
 TranslateVar(879,SRpSInvalidJPEG);
 TranslateVar(880,SRpSJpegImages);
 TranslateVar(881,SRpSPNGImages);
 TranslateVar(882,SRpSXPMImages);
 TranslateVar(883,SRpSWMFImages);
 TranslateVar(884,SRpSEMFImages);
 TranslateVar(885,SRpSICOImages);
 TranslateVar(886,SRpSUnknownType);
 TranslateVar(887,SRpSFloat);
 TranslateVar(888,SRpSDate);
 TranslateVar(889,SRpSDateTime);
 TranslateVar(890,SRpSTime);
 TranslateVar(891,SRpSBoolean);
 TranslateVar(892,SRpSDataType);
 TranslateVar(893,SRpSChartDriverEngine);
 TranslateVar(894,SRpSChartDriverTeeChart);
 TranslateVar(67,SRpSDriver);
 TranslateVar(895,SRpChartLine);
 TranslateVar(897,SRpChartBar);
 TranslateVar(896,SRpChartPoint);
 TranslateVar(898,SRpChartHorzBar);
 TranslateVar(899,SRpChartArea);
 TranslateVar(900,SRpChartPie);
 TranslateVar(901,SRpChartArrow);
 TranslateVar(902,SRpChartBubble);
 TranslateVar(903,SRpChartGantt);
 TranslateVar(904,SRPSView3D);
 TranslateVar(905,SRPSView3DWalls);
 TranslateVar(906,SRPSPerspective);
 TranslateVar(907,SRPSElevation);
 TranslateVar(908,SRPSRotation);
 TranslateVar(909,SRPSOrthogonal);
 TranslateVar(910,SRPSZoom);
 TranslateVar(911,SRPSHOffset);
 TranslateVar(912,SRPSVOffset);
 TranslateVar(913,SRPSTilt);
 TranslateVar(914,SRPSMultibar);
 TranslateVar(915,SRpSNone);
 TranslateVar(916,SRpSSide);
 TranslateVar(917,SRpSStacked);
 TranslateVar(918,SRpSStacked100);
 TranslateVar(919,SRpSForcePrint);
 TranslateVar(920,SRpSHRelativeSkip);
 TranslateVar(921,SRpSVRelativeSkip);
 TranslateVar(922,SRpSHSkipExpre);
 TranslateVar(923,SRpSVSkipExpre);
 TranslateVar(924,SRpSSkipBefore);
 TranslateVar(925,SRpSSkipAfter);
 TranslateVar(926,SRpSSkipType);
 TranslateVar(927,SRpSSkipToPage);
 TranslateVar(928,SRpSPOnlyData);
 TranslateVar(929,SRpSTwoPassReportNeeded);
 TranslateVar(931,SRpNewDataInfo);
 TranslateVar(932,SRpPrintPDFRep9);
 TranslateVar(953,SRpFrench);
 TranslateVar(940,SRpIniNumPage);
 TranslateVar(941,SRpPrintNulls);
 TranslateVar(942,SrpSExpressionB);
 TranslateVar(943,SrpSExpressionA);
 TranslateVar(951,SRpSParamSubs);
 TranslateVar(954,SRpSRightToLeft);
 TranslateVar(955,SRpSBidiNo);
 TranslateVar(956,SRpSBidiPartial);
 TranslateVar(957,SRpSBidiFull);
 TranslateVar(958,SRpMultiPage);
 TranslateVar(959,SRpDataUnionNotFound);
 TranslateVar(960,SRpCannotCombine);
 TranslateVar(961,SRpSParamList);
 TranslateVar(962,SRpSParamListDesc);
 TranslateVar(963,SRpReplaceStr);
 TranslateVar(964,SRpPReplaceStr);
 TranslateVar(965,SRpParseParamsH);
 TranslateVar(966,SrpSClearExpChart);
 TranslateVar(967,SrpSBoolClearExp);
 TranslateVar(968,SRpStreamFormat);
 TranslateVar(969,SRpZLibNotSupported);
 TranslateVar(970,SRpPreferedFormat);
 TranslateVar(971,SRpStreamZLib);
 TranslateVar(972,SRpStreamBinary);
 TranslateVar(973,SRpStreamText);
 TranslateVar(974,SRpSOptions);
 TranslateVar(975,SRpSReady);
 TranslateVar(976,SRpSsysInfo);
 TranslateVar(977,SRpSsysInfoH);
 TranslateVar(978,SRpSHighResolution);
 TranslateVar(979,SRpSMediumResolution);
 TranslateVar(980,SRpSLowResolution);
 TranslateVar(981,SRpSDraftResolution);
 TranslateVar(982,SRpSColorPrinting);
 TranslateVar(983,SRpSMonoPrinting);
 TranslateVar(984,SRSPlotter);
 TranslateVar(985,SRSRasterDisplay);
 TranslateVar(986,SRSRasterPrinter);
 TranslateVar(987,SRSRasterCamera);
 TranslateVar(988,SRSCharStream);
 TranslateVar(989,SRSDisplayFile);
 TranslateVar(990,SRpSMetafile);
 TranslateVar(991,SRpSPolyline);
 TranslateVar(992,SRpSmarker);
 TranslateVar(993,SRpSPolyMarker);
 TranslateVar(994,SRpSWideCap);
 TranslateVar(995,SRpSSTyledCap);
 TranslateVar(996,SRpSWideSTyledCap);
 TranslateVar(997,SRpSInteriorsCap);
 TranslateVar(998,SRpSPolygon);
 TranslateVar(999,SRpSRectanglecap);
 TranslateVar(1000,SRpSWindPolygon);
 TranslateVar(1001,SRpSSCANLINE);
 TranslateVar(1002,SRpSCircleCap);
 TranslateVar(1003,SRpSPiecap);
 TranslateVar(1004,SRpSCHordCap);
 TranslateVar(1005,SRpSEllipses);
 TranslateVar(1006,SRpSRoundRectCap);
 TranslateVar(1007,SRpSBandingRequired);
 TranslateVar(1008,SRpSBitmapTransfer);
 TranslateVar(1009,SRpSBitmapTransfer64);
 TranslateVar(1010,SRpSDIBTransfer);
 TranslateVar(1011,SRpSDIBDevTransfer);
 TranslateVar(1012,SRpSFloodFillcap);
 TranslateVar(1013,SRpSGDI20Out);
 TranslateVar(1014,SRPSPaletteDev);
 TranslateVar(1015,SRpSScalingCap);
 TranslateVar(1016,SRpSStretchCap);
 TranslateVar(1017,SRpSStretchDIBCap);
 TranslateVar(1018,SRpSCharOutput);
 TranslateVar(1019,SRpSCharStroke);
 TranslateVar(1020,SRpSClipStroke);
 TranslateVar(1021,SRpS90Rotation);
 TranslateVar(1022,SRpSAnyRotation);
 TranslateVar(1023,SRpSScaleXY);
 TranslateVar(1024,SRpSDoubleChar);
 TranslateVar(1025,SRpSIntegerScale);
 TranslateVar(1026,SRpSAnyrScale);
 TranslateVar(1027,SRpSDoubleWeight);
 TranslateVar(1028,SRpRasterFonts);
 TranslateVar(1029,SRpVectorFonts);
 TranslateVar(1030,SRpNobitBlockScroll);
 TranslateVar(1031,SRpExcelFile);
 TranslateVar(1032,SRpExcelNotSupported);
 TranslateVar(1033,SRpFieldsFileNotDefined);
 TranslateVar(1034,SRpSMemo);
 TranslateVar(1035,SRpSInvReportHandle);
 TranslateVar(1036,SRpSNotAvail);
 TranslateVar(1037,SRpLinesPerInchIncorrect);
 TranslateVar(1038,SRpStepBySize);
 TranslateVar(1039,SRpSFontStep);
 TranslateVar(1040,SRpDBExpressDesc);
 TranslateVar(1041,SRpMybaseDesc);
 TranslateVar(1042,SRpIBXDesc);
 TranslateVar(1043,SRpBDEDesc);
 TranslateVar(1044,SRpADODesc);
 TranslateVar(1045,SRpIBODesc);
 TranslateVar(1046,SRpErrorCreatePipe);
 TranslateVar(1047,SRpErrorForking);
 TranslateVar(1048,SRpCreatingTempFile);
 TranslateVar(1049,SRpPlainFile);
 TranslateVar(1050,SRpPrintRep9);
 TranslateVar(1051,SRpPrintRep10);
 TranslateVar(1052,SRpOpenDrawerBefore);
 TranslateVar(1053,SRpOpenDrawerAfter);
 TranslateVar(1054,SRpPrintPDFRep10);
 TranslateVar(1055,SRpPrintPDFRep11);
 TranslateVar(1056,SRpPrintPDFRep12);
 TranslateVar(1057,SRpCommandLineStdIN);
 TranslateVar(1058,SRpTextDrivers);
 TranslateVar(1107,SrpDriverZeos);
 TranslateVar(1108,SrpDriverZeosDesc);
 TranslateVar(1109,SrpDriverIBO);
 TranslateVar(1110,SRpBitmapFile);
 TranslateVar(1111,SRpBitmapFileMono);
 TranslateVar(1112,SRpPFormatMask);
 TranslateVar(1113,SrpSAlignJustify);
 TranslateVar(1114,SRpSelectedPrinter);
 TranslateVar(1124,SRPVertDesp);
 TranslateVar(1125,SRpLineTooLong);
 TranslateVar(1126,SRpFileExists);
 TranslateVar(1127,SRpPFileExists);
 TranslateVar(1128,SRpPRpAliasRequired);
 TranslateVar(1129,SRpExistReportInThisGroup);
 TranslateVar(1130,SRpGroupParent);
 TranslateVar(1131,SRpNewReport);
 TranslateVar(1132,SRpReportName);
 TranslateVar(1133,SRpSelectReport);
 TranslateVar(1134,SRpConfigLib);
 TranslateVar(1135,SRpOpenFrom);
 TranslateVar(1136,SRpSaveTo);
 TranslateVar(1137,SRpConfigLibH);
 TranslateVar(1138,SRpOpenFromH);
 TranslateVar(1139,SRpSaveToH);
 TranslateVar(1140,SRpLibSelection);
 TranslateVar(1141,SRpNewFolder);
 TranslateVar(1142,SRpDeleteSelection);
 TranslateVar(1143,SRpSearchReport);
 TranslateVar(1144,SRpExportFolder);
 TranslateVar(1145,SRpExportFolderH);
 TranslateVar(1146,SRpClientDatasetNotSupported);
 TranslateVar(1147,SRpVariables);
 TranslateVar(1148,SRpNoDataset);
 TranslateVar(1149,SRpRefresh);
 TranslateVar(1150,SRpData);
 TranslateVar(1151,SRpStructure);
 TranslateVar(1152,SRpDatabaseBrowser);
 TranslateVar(1153,SRPEmptyAliasPath);
 TranslateVar(1154,SrpDirectoryNotExists);
 TranslateVar(1155,SRpuserGroups);
 TranslateVar(1156,SRpAliasGroups);
 TranslateVar(1157,SRpUserGroupsHint);
 TranslateVar(1158,SRpAdd);
 TranslateVar(1159,SRpDelete);
 TranslateVar(1160,SRpAliasPath);
 TranslateVar(1161,SRpPrintRep11);
 TranslateVar(1162,SRpPrintRep12);
 TranslateVar(1163,SRpAboutBoxPreview);
 TranslateVar(1164,SRpString);
 TranslateVar(1165,SRpInteger);
 TranslateVar(1166,SRpSmallInt);
 TranslateVar(1167,SRpWord);
 TranslateVar(1168,SRpUnknown);
 TranslateVar(1169,SRpBoolean);
 TranslateVar(1170,SRpFloat);
 TranslateVar(1171,SRpCurrency);
 TranslateVar(1172,SRpBCD);
 TranslateVar(1173,SRpDate);
 TranslateVar(1174,SRpTime);
 TranslateVar(1175,SRpDateTime);
 TranslateVar(1176,SRpBytes);
 TranslateVar(1177,SRpVarBytes);
 TranslateVar(1178,SRpAutoInc);
 TranslateVar(1179,SRpBlob);
 TranslateVar(1180,SrpMemo);
 TranslateVar(1181,SRpGraphic);
 TranslateVar(1182,SRpFmtMemo);
 TranslateVar(1183,SRpParadoxOle);
 TranslateVar(1184,SRpDBaseOle);
 TranslateVar(1185,SRpTypedBinary);
 TranslateVar(1186,SRpCursor);
 TranslateVar(1187,SRpFixedChar);
 TranslateVar(1188,SRpWideString);
 TranslateVar(1189,SRpADT);
 TranslateVar(1190,SRpArray);
 TranslateVar(1191,SRpReference);
 TranslateVar(1192,SRpDataset);
 TranslateVar(1193,SRpOraBlob);
 TranslateVar(1194,SRpOraClob);
 TranslateVar(1195,SRpVariant);
 TranslateVar(1196,SRpIDispatch);
 TranslateVar(1197,SRpGUID);
 TranslateVar(1198,SRpTimeStamp);
 TranslateVar(1199,SRpFmtBCD);
 TranslateVar(1200,SRpAllProps);
 TranslateVar(1201,SRpPosition);
 TranslateVar(1202,SRpText);
 TranslateVar(1203,SRpLabel);
 TranslateVar(1204,SRpExpression);
 TranslateVar(1205,SRpImage);
 TranslateVar(1206,SRpShape);
 TranslateVar(1207,SRpChartData);
 TranslateVar(1208,SRpChartAspect);
 TranslateVar(1209,SRpBarcode);
 TranslateVar(1210,SRpExeMetafile);
 TranslateVar(1211,SRpExeReport);
 TranslateVar(1212,SRpRename);
 TranslateVar(1213,SRpRenameHint);
 TranslateVar(1214,SRpAlreadyWithname);
 TranslateVar(1215,SRpNewName);
 TranslateVar(1216,SRpAllowNulls);
 TranslateVar(1217,SRpAllowNullsHint);
 TranslateVar(1218,SRpPortuguesse);
 TranslateVar(1219,SRpGerman);
 TranslateVar(1220,SRpItalian);
 TranslateVar(1221,SRpHtmlFile);
 TranslateVar(1222,SRpPrintPDFRep13);
 TranslateVar(1223,SRpOutputFilenameHTML);
 TranslateVar(1224,SRPLeftRight);
 TranslateVar(1225,SRPTopBottom);
 TranslateVar(1226,SRPAllClient);
 TranslateVar(1227,SRpPrintRep14);
 TranslateVar(1228,SRpChartHint);
 TranslateVar(1229,SRpChartLegend);
 TranslateVar(1246,SRpAbs);
 TranslateVar(1247,SRpPAbs);
 TranslateVar(1248,SrpSBackExpression);
 TranslateVar(1249,SrpSInvBackImage);
 TranslateVar(1250,SRpSBackStyle);
 TranslateVar(1251,SRpSBDesign);
 TranslateVar(1252,SRpSBPreview);
 TranslateVar(1253,SRpSBPrint);
 TranslateVar(1254,SRpAsc2);
 TranslateVar(1255,SRpLength);
 TranslateVar(1256,SRpPLength);
 TranslateVar(1257,SRpSVGFile);
 TranslateVar(1258,SRpTurkish);
 TranslateVar(1259,SRpCSVFile);
 TranslateVar(1260,SRpTXTProFile);
 TranslateVar(1261,SRpPrintRep15);
 TranslateVar(1262,SRpPrintRep16);
 TranslateVar(1263,SRpPrintRep17);
 TranslateVar(1264,SRpPreviewMargins);
 TranslateVar(1265,SRpSExportExpression);
 TranslateVar(1266,SRpSExportLine);
 TranslateVar(1267,SRpSExportPos);
 TranslateVar(1268,SRpSExportSize);
 TranslateVar(1269,SRpSExportAlign);
 TranslateVar(1270,SRpSExportDoNewLine);
 TranslateVar(1271,SRpSExportFormat);
 TranslateVar(1272,SRpSFeaturenotsup);
 TranslateVar(1273,SRpFormatNum);
 TranslateVar(1274,SRpPFormatNum);
 TranslateVar(1276,SRpNoTrueType);
 TranslateVar(1277,SRpFontDataIndexNotFound);
 TranslateVar(1278,SRpErrorProcessing);
 TranslateVar(1279,SRpEvalDescIdenLeft);
 TranslateVar(1280,SRpGraphicBounds);
 TranslateVar(1281,SRpPGraphicBounds);
 TranslateVar(1282,SRpSetFontPropsAsDefault);
 TranslateVar(1283,SRpSetFontPropsAsDefaultHint);
 TranslateVar(1284,SRpGetValueFromSQL);
 TranslateVar(1285,SRpGetValueFromSQLP);
 TranslateVar(1286,SRpPaperSource);
 TranslateVar(1287,SRpBinFirst);
 TranslateVar(1288,SRpBinLower);
 TranslateVar(1289,SRpBinMiddle);
 TranslateVar(1290,SRpBinManual);
 TranslateVar(1291,SRpBinEnvelope);
 TranslateVar(1292,SRpBinEnvelopeManual);
 TranslateVar(1293,SRpBinAuto);
 TranslateVar(1294,SRpBinTractor);
 TranslateVar(1295,SRpBinSmallFMT);
 TranslateVar(1296,SRpBinLargeFMT);
 TranslateVar(1297,SRpBinLargeCapacity);
 TranslateVar(1298,SRpBinCassette);
 TranslateVar(1299,SRpFormSource);
 TranslateVar(1300,SRpDuplex);
 TranslateVar(1301,SRpDuplexS);
 TranslateVar(1302,SRpDuplexHor);
 TranslateVar(1303,SRpDuplexVer);
 TranslateVar(1304,SRpPrintRep18);
 TranslateVar(1305,SRpPrintRep19);
 TranslateVar(1306,SRpPrintRep20);
 TranslateVar(1307,SRpPrintRep21);
 TranslateVar(1308,SRpPrintRep22);
 TranslateVar(1309,SRpPrintRep23);
 TranslateVar(1310,SRpPrintRep24);
 TranslateVar(1311,SRpPhoneNum);
 TranslateVar(1312,SRpStatus);
 TranslateVar(1313,SRpConversion);
 TranslateVar(1314,SRpWrongREsult);
 TranslateVar(1315,SRpBitmapProps);
 TranslateVar(1316,SRpMonochrome);
 TranslateVar(1317,SRpHorzRes);
 TranslateVar(1318,SRpVertRes);
 TranslateVar(1319,SRpForceForm);
 TranslateVar(1320,SRpFormName);
 TranslateVar(1321,SRpFormPageSize);
 TranslateVar(1322,SRpPageSize);
 TranslateVar(1324,SRpCompareValue);
 TranslateVar(1325,SRpPCompareValue);
 TranslateVar(1326,SRpDrawTiledpi);
 TranslateVar(1327,SRpConnecting);
 TranslateVar(1328,SRpGenerating);
 TranslateVar(1329,SRpSending);
 TranslateVar(1330,SRpTransmiting);
 TranslateVar(1331,SrpSSerieCaptionExp);
 TranslateVar(1332,SRpBarcodeCodeTooLarge);
 TranslateVar(1333,SRpGLIOutOfRangeBarcode);
 TranslateVar(1334,SRpInvalidCodeword);
 TranslateVar(1335,SRpECCLevel);
 TranslateVar(1336,SRpNumRows);
 TranslateVar(1337,SRpNumCols);
 TranslateVar(1338,SRpTruncatedPDF417);
 TranslateVar(1339,SRpPrintRep25);
 TranslateVar(1340,SRpSetLanguage);
 TranslateVar(1341,SRpUseKPrinter);
 TranslateVar(1342,SRpExcelFileNoMulti);
 TranslateVar(1343,SRpPlainPrinter);
 TranslateVar(1344,SRpPlainFullPrinter);
 TranslateVar(1345,SRpTimeOut);
 TranslateVar(1346,SRpPrintRep26);
 TranslateVar(1349,SRpTypeInfo);
 TranslateVar(1350,SRpStreamXMLComp);
 TranslateVar(1351,SRpMarkType);
 TranslateVar(1352,SRpSMarkType0);
 TranslateVar(1353,SRpSMarkType1);
 TranslateVar(1354,SRpSMarkType2);
 TranslateVar(1355,SRpSMarkType3);
 TranslateVar(1356,SRpSMarkType4);
 TranslateVar(1357,SRpSMarkType5);
 TranslateVar(1358,SRpSMarkType6);
 TranslateVar(1359,SRpSMarkType7);
 TranslateVar(1360,SRpSMarkType8);
 TranslateVar(1361,SRpSVertAxisFSize);
 TranslateVar(1362,SRpSVertAxisFRot);
 TranslateVar(1363,SRpSHorzAxisFSize);
 TranslateVar(1364,SrpSSerieColor);
 TranslateVar(1365,SrpSValueColor);
 TranslateVar(1366,SRpGraphicColor);
 TranslateVar(1367,SRpGraphicSerieColor);
 TranslateVar(1368,SRpSMultiple);
 TranslateVar(1369,SRpSLookupDatasetNotavail);
 TranslateVar(1370,SrpLookupDataset);
 TranslateVar(1371,SrpSearchDataset);
 TranslateVar(1372,SRpValueSearch);
 TranslateVar(1373,SRpOpenOnStart);
 TranslateVar(1374,SRpSearchValue);
 TranslateVar(1375,SRpSearch);
 TranslateVar(1376,SRpSHorzAxisFRot);
 TranslateVar(1378,SRpSLinesInchError);

 TranslateVar(1383,SRpLithuanian);
 TranslateVar(1384,SRpDanish);
 TranslateVar(1385,SRpDutch);
 TranslateVar(1386,SRpSpanishMe);
 TranslateVar(1387,SRpGreek);
 TranslateVar(1388,SRpHungar);

 TranslateVar(1389,SRpSelectDest);
 TranslateVar(1390,SRpProcessing);
 TranslateVar(1391,SRpRegCopy);
 TranslateVar(1392,SrpChangeLevel);
 TranslateVar(1393,SrpReboot);
 TranslateVar(1394,SRpDriverDotNet);
 TranslateVar(1395,SRpDriverDotNetDesc);
 TranslateVar(1396,SRpEmptyResponse);
 TranslateVar(1397,SRpRepMetafileUn);
 TranslateVar(1398,SRpPrintRep28);
 TranslateVar(1399,SRpPrintRep29);
 TranslateVar(1400,SRpMaximumPages);

 TranslateVar(1405,SRpPMax);
 TranslateVar(1406,SRpChsToCht);
 TranslateVar(1407,SRpChtToChs);
 TranslateVar(1408,SRpParameterExists);
 TranslateVar(1409,SRpCached);
 TranslateVar(1410,SRpIsInteger);
 TranslateVar(1411,SRpIsNumeric);
 TranslateVar(1412,SRpIsValidDateTime);
 TranslateVar(1413,SRpCheckExpression);
 TranslateVar(1420,SRpCachedFixed);
 TranslateVar(1421,SRpCachedVariable);
 TranslateVar(1422,SRpSParamSubsE);
 TranslateVar(1423,SRpExcelFiles);
 TranslateVar(1424,SRpDBFFiles);
 TranslateVar(1425,SRpShowPrintDialog);
 TranslateVar(1426,SRpGetIniValue);

 TranslateVar(1427,SRpWaitTwain);
 TranslateVar(1428,SRpWaitTwainExceededMax);
 TranslateVar(1429,SRpCompletedUpload);
 TranslateVar(1430,SRpUploadProg);
 TranslateVar(1431,SRpNoTwain);


 TranslateVar(1432,SRpDefaultCopies);


 TranslateVar(783,SRpAsyncExecution);

 TranslateVar(1438,SRpHtmlFileSingle);
 TranslateVar(1439,SRpPrintPDFRep13b);

 TranslateVar(1442,SRpSParamSubsList);
 TranslateVar(1443,SRpSParamInitialExpression);
 TranslateVar(1444,SRpCommonFields);
end;




{$IFDEF LINUX}
procedure RestoreEnviromentLocale;
var
 avalue:string;
begin
 avalue:=GetEnvironmentVariable('KYLIX_DEFINEDENVLOCALES');
 if Length(avalue)<1 then
  exit;
 avalue:=GetEnvironmentVariable('KYLIX_DECIMAL_SEPARATOR');
 if Length(avalue)>0 then
  DecimalSeparator:=avalue[1]
 else
  DecimalSeparator:=chr(0);
 avalue:=GetEnvironmentVariable('KYLIX_THOUSAND_SEPARATOR');
 if Length(avalue)>0 then
  ThousandSeparator:=avalue[1]
 else
  ThousandSeparator:=chr(0);
 avalue:=GetEnvironmentVariable('KYLIX_DATE_SEPARATOR');
 if Length(avalue)>0 then
  DateSeparator:=avalue[1]
 else
  DateSeparator:=chr(0);
 avalue:=GetEnvironmentVariable('KYLIX_TIME_SEPARATOR');
 if Length(avalue)>0 then
  TimeSeparator:=avalue[1]
 else
  TimeSeparator:=chr(0);
 avalue:=GetEnvironmentVariable('KYLIX_DATE_FORMAT');
 if Length(avalue)>0 then
  ShortDateFormat:=avalue;
 avalue:=GetEnvironmentVariable('KYLIX_TIME_FORMAT');
 if Length(avalue)>0 then
  ShortTimeFormat:=avalue;
end;
{$ENDIF}


{$IFDEF MSWINDOWS}
{$IFNDEF USEVARIANTS}
function GetEnvironmentVariable(aname:string):string;
var
 aTempBuf:array[0..MAX_PATH] of char;
begin
 atempBuf[0]:=chr(0);
 Windows.GetEnvironmentVariable(PChar(aname),aTempBuf,MAX_PATH);
 Result:=StrPas(atempBuf);
end;

{$ENDIF}

procedure RestoreEnviromentLocale;
var
 avalue:string;
begin
 avalue:=GetEnvironmentVariable('KYLIX_DEFINEDENVLOCALES');
 if Length(avalue)<1 then
  exit;
 avalue:=GetEnvironmentVariable('KYLIX_DECIMAL_SEPARATOR');
 if Length(avalue)>0 then
  DecimalSeparator:=avalue[1]
 else
  DecimalSeparator:=chr(0);
 avalue:=GetEnvironmentVariable('KYLIX_THOUSAND_SEPARATOR');
 if Length(avalue)>0 then
  ThousandSeparator:=avalue[1]
 else
  ThousandSeparator:=chr(0);
 avalue:=GetEnvironmentVariable('KYLIX_DATE_SEPARATOR');
 if Length(avalue)>0 then
  DateSeparator:=avalue[1]
 else
  DateSeparator:=chr(0);
 avalue:=GetEnvironmentVariable('KYLIX_TIME_SEPARATOR');
 if Length(avalue)>0 then
  TimeSeparator:=avalue[1]
 else
  TimeSeparator:=chr(0);
 avalue:=GetEnvironmentVariable('KYLIX_DATE_FORMAT');
 if Length(avalue)>0 then
  ShortDateFormat:=avalue;
 avalue:=GetEnvironmentVariable('KYLIX_TIME_FORMAT');
 if Length(avalue)>0 then
  ShortTimeFormat:=avalue;
end;
{$ENDIF}





initialization

ConvertAllStrings;
RestoreEnviromentLocale;

finalization
 if assigned(atrans) then
 begin
  atrans.free;
  atrans:=nil;
 end;
end.
