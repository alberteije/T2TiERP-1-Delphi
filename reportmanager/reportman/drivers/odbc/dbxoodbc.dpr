{
  Kylix / Delphi open source DbExpress driver for ODBC
  Version 2.010, 2003-11-12

  Copyright (c) 2001, 2003 Edward Benson

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU Lesser General Public License for more details.
}
library dbxoodbc;
// DLL version of DbExpress Open Source Odbc Driver.
uses
{$IFDEF LINUX}
  ShareExcept,
{$ENDIF}
  DbxOpenOdbc;

{$IFDEF MSWINDOWS}
{$R *.res} // Include Library information
{$ENDIF}

exports getSQLDriverODBC;
begin
end.
