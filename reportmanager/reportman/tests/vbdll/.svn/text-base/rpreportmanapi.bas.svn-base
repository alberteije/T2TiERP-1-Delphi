Attribute VB_Name = "reportmanapi"
Public Declare Function rp_open Lib "Reportman.ocx" (ByVal filename As String) As Long
Public Declare Function rp_close Lib "Reportman.ocx" (ByVal hreport As Long) As Long
Public Declare Function rp_execute Lib "Reportman.ocx" (ByVal hreport As Long, ByVal outputfilename As String, ByVal Metafile As Long, ByVal Compressed As Long) As Long
Public Declare Function rp_lasterror Lib "Reportman.ocx" () As String
Public Declare Function rp_preview Lib "Reportman.ocx" (ByVal hreport As Long, ByVal title As String) As Long
Public Declare Function rp_print Lib "Reportman.ocx" (ByVal hreport As Long, ByVal title As String, ByVal ShowProgress As Long, ByVal ShowPrintDialog As Long) As Long
Public Declare Function rp_setparamvalue Lib "Reportman.ocx" (ByVal hreport As Long, ByVal paramname As String, ByVal paramtype As Long, ByVal paramvalue As Long) As Long
Public Declare Function rp_setparamvaluevar Lib "Reportman.ocx" (ByVal hreport As Long, ByVal paramname As String, ByVal paramvalue As Variant) As Long
Public Declare Function rp_getparamcount Lib "Reportman.ocx" (ByVal hreport As Long, ByRef paramcount As Long) As Long
Public Declare Function rp_getparamname Lib "Reportman.ocx" (ByVal hreport As Long, ByVal index as Long, ByVal abuffer As String) As Long
Public Declare Function rp_setadoconnectionstring Lib "Reportman.ocx" (ByVal hreport As Long, ByVal conname As String, ByVal constring As String) As Long