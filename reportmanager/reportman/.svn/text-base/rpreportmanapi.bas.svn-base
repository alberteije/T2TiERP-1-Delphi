Attribute VB_Name = "reportmanapi"
Public Declare Function rp_new Lib "Reportman.ocx" As Long
Public Declare Function rp_open Lib "Reportman.ocx" (ByVal filename As String) As Long
Public Declare Function rp_close Lib "Reportman.ocx" (ByVal hreport As Long) As Long
Public Declare Function rp_execute Lib "Reportman.ocx" (ByVal hreport As Long, ByVal outputfilename As String, ByVal Metafile As Long, ByVal Compressed As Long) As Long
Public Declare Function rp_executeremote_report Lib "Reportman.ocx" (ByVal hreport As Long, ByVal hostname As String, ByVal port As Long, ByVal user As String,ByVal password As String,ByVal aliasname As String,ByVal reportname As String,ByVal outputfilename As String,ByVal metafile As Long,ByVal Compressed As Long) As Long
Public Declare Function rp_executeremote Lib "Reportman.ocx" (ByVal hreport As Long, ByVal hostname As String, ByVal port As Long, ByVal user As String,ByVal password As String,ByVal aliasname As String,ByVal reportname As String,ByVal outputfilename As String,ByVal metafile As Long,ByVal Compressed As Long) As Long
Public Declare Function rp_getremoteparams Lib "Reportman.ocx" (ByVal hreport As Long, ByVal hostname As String, ByVal port As Long, ByVal user As String,ByVal password As String,ByVal aliasname As String,ByVal reportname As String) As Long
Public Declare Function rp_lasterror Lib "Reportman.ocx" () As String
Public Declare Function rp_preview Lib "Reportman.ocx" (ByVal hreport As Long, ByVal title As String) As Long
Public Declare Function rp_print Lib "Reportman.ocx" (ByVal hreport As Long, ByVal title As String, ByVal ShowProgress As Long, ByVal ShowPrintDialog As Long) As Long
Public Declare Function rp_setparamvalue Lib "Reportman.ocx" (ByVal hreport As Long, ByVal paramname As String, ByVal paramtype As Long, ByVal paramvalue As Long) As Long
Public Declare Function rp_setparamvaluevar Lib "Reportman.ocx" (ByVal hreport As Long, ByVal paramname As String, ByVal paramvalue As Variant) As Long
Public Declare Function rp_getparamcount Lib "Reportman.ocx" (ByVal hreport As Long, ByRef paramcount As Long) As Long
Public Declare Function rp_getparamname Lib "Reportman.ocx" (ByVal hreport As Long, ByVal index as Long, ByVal abuffer As String) As Long
Public Declare Function rp_setadoconnectionstring Lib "Reportman.ocx" (ByVal hreport As Long, ByVal conname As String, ByVal constring As String) As Long
Public Declare Function rp_getprinters Lib "Reportman.ocx" () As String
Public Declare Function rp_getdefaultprinter Lib "Reportman.ocx" () As String
Public Declare Function rp_setdefaultprinter Lib "Reportman.ocx" (ByVal device As String) As Long
Public Declare Function rp_previewremote Lib "Reportman.ocx" (ByVal hostname As String, ByVal port As Long, ByVal user As String,ByVal password As String,ByVal aliasname As String,ByVal reportname As String,ByVal title As String) As Long
Public Declare Function rp_previewremote_report Lib "Reportman.ocx" (ByVal hreport As Long,ByVal hostname As String, ByVal port As Long, ByVal user As String,ByVal password As String,ByVal aliasname As String,ByVal reportname As String,ByVal title As String) As Long
Public Declare Function rp_printremote Lib "Reportman.ocx" (ByVal hostname As String, ByVal port As Long, ByVal user As String,ByVal password As String,ByVal aliasname As String,ByVal reportname As String,ByVal title As String) As Long
Public Declare Function rp_printremote_report Lib "Reportman.ocx" (ByVal hreport As Long,ByVal hostname As String, ByVal port As Long, ByVal user As String,ByVal password As String,ByVal aliasname As String,ByVal reportname As String,ByVal title As String) As Long
Public Declare Function rp_bitmap Lib "Reportman.ocx" (ByVal hreport As Long, ByVal outputfilename As String, ByVal ask As Long, ByVal mono As Long, ByVal vertres As Long, ByVal horzres As Long) As Long

