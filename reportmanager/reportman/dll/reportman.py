"""
This file is copyright 2004 by Shawn L. Church.  Permission to copy,  use,
and distribute this file is granted in accordance with the wxWidgets license 
agreement found at http://wxwidgets.org/newlicen.htm

This module implements python bindings to the ReportMan ActiveX control.
For more information on ReportManager see: http://ReportMan.sourceforge.net

Requirements: ctypes module.  To download see: http://starship.python.net/crew/theller/ctypes/index.html

Limitations: Currently implemented for Windows only although Linux should work with
a change to the _rp_lib= statement to reference the Linux shared library for Report Manager.

INSTALLATION:   1) Install ctypes module if necassary.
                2) Copy reportman.py to Python site-packages directory

TODO:   1) Implement Cross-platform compatibility with Linux.   Should also
        also implement MAC compatability but I have no way to test this.
        
        2) Add capabilities to export other ReportManager-supported file types
        such as excel, CSV,  text,  etc.
        
        3) Add remote printing capabilities.
    
USAGE:  1) Import reportman module
        2) The ReportMan class is provided for general use.  It takes
        care of opening and closing the report handle.        
        3) The rp_* functions are available for low level access to the 
        Report Manager API.
"""

__version__="0.1.0.0"

import ctypes as _c
from os.path import splitext as _splitext

# Load ReportMan shared library:
_rp_lib=_c.windll.LoadLibrary("ReportMan.ocx")

# This is used as the return value paramater for the low-level api calls:
def _rp_lasterror(retval):
    """ Returns non-zero return values unchanged.  Otherwise raises a 
    value exception containing the error description """

    if not retval:
        rp_lasterror=_rp_lib.rp_lasterror
        rp_lasterror.restype=_c.c_char_p
        raise ValueError,rp_lasterror()
    return retval

# Low-level API functions:

def rp_open(filename):
    """ 
    Wrapper for: int rp_open(char *filename); 

    returns ReportManager handle as int on success or ValurError on error
    """

    filename=_c.c_char_p(filename)
    rp_open=_rp_lib.rp_open
    rp_open.restype=_rp_lasterror
    return rp_open(filename)

def rp_execute(hreport,outputfilename, metafile, compressed):
    """ 
    Wrapper for: int rp_execute(int hreport,char *outputfilename,
                                int metafile,int compressed); 
    
    returns None on success or ValueError on error.    
    """

    hreport=_c.c_int(hreport)    
    metafile=_c.c_int(metafile)
    outputfilename=_c.c_char_p(outputfilename)
    compressed=_c.c_int(compressed)
    rp_execute=_rp_lib.rp_execute
    rp_execute.restype=_rp_lasterror
    rp_execute(hreport,outputfilename,metafile,compressed)
    rp_execute(hreport,outputfilename,metafile,compressed)

def rp_setparamvalue(hreport, paramname, paramvalue):
    """ 
    Wrapper for: int rp_setparamvalue(int hreport,char *paramname,
                                          int paramtype,void *paramvalue); 
                                          
    returns None on success or ValueError on error.    
    """

    hreport=_c.c_int(hreport)
    paramname=_c.c_char_p(paramname)

    if paramvalue is None: paramtype=1
    elif type(paramvalue) is int: paramtype=3; paramvalue=_c.byref(_c.c_int(paramvalue))
    elif type(paramvalue) is float: paramtype=5; paramvalue=_c.byref(_c.c_double(paramvalue))
    elif type(paramvalue) is long: paramtype=14; paramvalue=_c.byref(_c.c_longlong(paramvalue))
    elif type(paramvalue) is unicode: paramtype=8; paramvalue=_c.c_wchar_p(paramvalue)
    elif type(paramvalue) is str: paramtype=256; paramvalue=_c.c_char_p(paramvalue)
    else: raise ValueError,"Unsupported paramater type: %s" % type(paramvalue)

    rp_setparamvalue=_rp_lib.rp_setparamvalue
    rp_setparamvalue.restype=_rp_lasterror
    rp_setparamvalue(hreport,paramname, paramtype, paramvalue)

def rp_getparamcount(hreport):
    """ 
    Wrapper for: int rp_getparamcount(int hreport,int *paramcount); 
    
    returns paramater count as int on success or ValueError on error.    
    """

    hreport=_c.c_int(hreport)
    paramcount=_c.c_int(0)
    rp_getparamcount=_rp_lib.rp_getparamcount
    rp_getparamcount.restype=_rp_lasterror
    rp_getparamcount(hreport,_c.byref(paramcount))
    return paramcount.value

def rp_getparamname(hreport,index):
    """ 
    Wrapper for: int rp_getparamname(int hreport,int index,char *abuffer); 
    
    returns paramater name as str on success or ValueError on error.    
    """

    hreport=_c.c_int(hreport)
    index=_c.c_int(index)
    abuffer=_c.c_buffer(256)
    rp_getparamname=_rp_lib.rp_getparamname
    rp_getparamname.restype=_rp_lasterror
    rp_getparamname(hreport,index,abuffer)
    return abuffer.value

def rp_close(hreport):
    """ 
    Wrapper for: int rp_close(int hreport); 
    
    returns None on success or ValueError on error.    
    """

    hreport=_c.c_int(hreport)
    rp_close=_rp_lib.rp_close
    rp_close.restype=_rp_lasterror
    rp_close(hreport)

def rp_print(hreport,title,showprogress=True,showprintdialog=False):
    """ 
    Wrapper for: int rp_print(int hreport,char *title,int showprogress,
                              int showprintdialog); 
    
    returns None on success or ValueError on error.    
    """

    hreport=_c.c_int(hreport)
    title=_c.c_char_p(title)
    showprogress=_c.c_int(showprogress)
    showprintdialog=_c.c_int(showprintdialog)
    rp_print=_rp_lib.rp_print
    rp_print.restype=_rp_lasterror
    rp_print(hreport,title,showprogress,showprintdialog)

def rp_preview(hreport,title):
    """ 
    Wrapper for: int rp_preview(int hreport,char *title); 
    
    returns None on success or ValueError on error.    
    """

    hreport=_c.c_int(hreport)
    title=_c.c_char_p(title)
    rp_preview=_rp_lib.rp_preview
    rp_preview.restype=_rp_lasterror
    rp_preview(hreport,title)


# High Level Interface:

class ReportMan(object):
    """ 
    Implements wrapper class around Report Manager ActiveX control.
    
    Usage:  
    
        Py 0.9.4
        Python 2.3.3 (#51, Dec 18 2003, 20:22:39) [MSC v.1200 32 bit (Intel)] on win32
        Type "help", "copyright", "credits" or "license" for more information.
        >>> from reportman import ReportMan
        >>> report=ReportMan("c:\\test.rep")
        >>> report.set_param("title", "This is the report title")
        >>> report.preview()
        >>> report.execute() # produces test.pdf in same directory as test.rep
        >>> report.execute(metafile=True) # produces test.rpmf in same directory as test.rep
        >>> report.execute("c:\\report.pdf") # Proudces c:\\report.pdf
        >>> report.params
        ['TITLE', 'DATETEST']
        >>>         ... 
    """
    
    def __init__(self,report_filename):
        """ 
        Initializes a report manager report handle.

        report_filename = "\\path\\to\\your\\report.rep" 
        """

        self._report_filename=report_filename
        self._hreport=None
        self._hreport=rp_open(report_filename)

    def __del__(self):
        """ 
        Closes report manager report handle 
        """
        
        if self._hreport is not None:
            rp_close(self._hreport)

    def printout(self,title=None, showprogress=True, showprintdialog=False):
        """ 
        Prints report to printer.

        title=Caption to appear in status dialog.
        showprogress=True to show status dialog.
        showprintdialog=True to show standard printer dialog before printing report

        returns None on success or ValueError on error.    
        """

        if title is None: title=self._report_filename
        rp_print(self._hreport,title,showprogress,showprintdialog)

    def preview(self,title=None):
        """ 
        Previews report to screen.

        title=Caption of to appear on preview window.

        returns None on success or ValueError on error.    
        """

        if title is None: title=self._report_filename
        rp_preview(self._hreport,title)

    def execute(self,filename=None,metafile=False,compressed=True):
        """ 
        Creates a PDF or Report Manager Meta File 

        filename=name of report file (defaults to report file name+.pdf/.rpmf)
        metafile=True to produce Report Manager meta-file or false for PDF.
        compressed=True to produce commpressed file output.
            
        returns None on success or ValueError on error.    
        """

        if filename is None:
            filename,ext=_splitext(self._report_filename)
            if metafile: filename+=".rpmf"
            else: filename+=".pdf"
        rp_execute(self._hreport,filename,metafile,compressed)

    params=property(lambda self: [rp_getparamname(self._hreport,index) 
                        for index in range(rp_getparamcount(self._hreport))],
                    doc="Read Only list of paramater names")

    def set_param(self,paramname,paramvalue):
        """ 
        Sets the specified paramater to the specified value 
        
        paramname=Name of the paramater.
        paramvalue=Value of the paramater must be one of the following types:
        
            None:       Sets paramater to SQL NULL - c-void*    (None)
            int:        Sets paramater using c-int              (1,2,3)
            long:       Sets paramater using c-longlong         (1L,2L)
            str:        Sets paramater to string                ("string")
            unicode:    Sets paramater to unicode string        (u"Unicode")
            float:      Sets paramater using c-double           (12.54321)
            
            Other types result in a value exception.  I use strings to pass
            dates and just adjust the SQL statement to convert them for
            comparison purposes.
            
        returns None on success or ValueError on error.                
        """
        
        rp_setparamvalue(self._hreport,paramname,paramvalue)
        
# TODO: Remote Printing:

# int rp_executeremote(char *hostname,int port,char *user,char *password,char *aliasname,
#   char *reportname,char *outputfilename,int metafile,int compressed);
# int rp_previewremote(char *hostname,int port,char *user,char *password,
#   char *aliasname,char *reportname,char *title);
# int rp_printremote(char *hostname,int port,char *user,char *password,
#   char *aliasname,char *reportname,char *title,int showprogress,
#   int showprintdialog);

