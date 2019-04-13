{*******************************************************************************
Title: T2Ti ERP
Description: Unit que contém os atributos (annotations)

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
*******************************************************************************}
unit Atributos;

interface

type
  TLocalDispay = (ldNone, ldGrid, ldLookup, ldGridLookup);
  // Mapeia uma classe como uma entidade persistente
  TEntity = class(TCustomAttribute)
  end;


  // Mapeia a classe de acordo com a tabela do banco de dados
  TTable = class(TCustomAttribute)
  private
    FName: String;
    FCatalog: String;
    FSchema: String;
  public
    constructor Create(pName, pCatalog, pSchema: String); overload;
    constructor Create(pName, pSchema: String); overload;
    constructor Create(pName: String); overload;
    property Name: String read FName write FName;
    property Catalog: String read FCatalog write FCatalog;
    property Schema: String read FSchema write FSchema;
  end;

  // Mapeia o identificador da classe, a chave primária na tabela do banco de dados
  TId = class(TCustomAttribute)
  private
    FNameField: String;
  public
    constructor Create(pNameField: String);
    property NameField: String read FNameField write FNameField;
  end;

  // Mapeia um campo de uma tabela no banco de dados
  TColumn = class(TCustomAttribute)
  private
    FName: String;
    FCaption: String;
    FUnique: Boolean;
    FLookup: Boolean;
    FLength: Integer;
    FLocalDispay: TLocalDispay;
    FTransiente: Boolean;
  public
    constructor Create(pName: String; pCaption: String; pUnique: Boolean; pLength: Integer); overload;
    constructor Create(pName: String; pUnique: Boolean; pLength: Integer); overload;
    constructor Create(pName: String; pCaption: String; pUnique: Boolean; pOutro: Boolean); overload;
    constructor Create(pName: String; pUnique: Boolean); overload;
    constructor Create(pName: String; pLength: Integer); overload;
    constructor Create(pName: String; pCaption: String); overload;
    constructor Create(pName: String; pCaption: String; pLocalDispay: TLocalDispay; pTransiente: Boolean); overload;
    constructor Create(pName: String; pCaption: String; pLocalDispay: TLocalDispay; pLenpth: integer); overload;
    constructor Create(pName: String; pCaption: String; pLocalDispay: TLocalDispay; pLenpth: integer; pLookup : Boolean); overload;
    constructor Create(pName: String); overload;
    property Name: String read FName write FName;
    property Caption: String read FCaption write FCaption;
    property Unique: Boolean read FUnique write FUnique;
    property Lookup: Boolean read FLookup write FLookup;
    property Length: Integer read FLength write FLength;
    property LocalDispay: TLocalDispay read FLocalDispay write FLocalDispay;
    property Transiente: Boolean read FTransiente write FTransiente;
  end;


  // Informa a estratégia de geração de valores para chaves primárias
  TGeneratedValue = class(TCustomAttribute)
  private
    { TABLE = chave gerada por uma tabela exclusiva para este fim
      SEQUENCE = utilização se sequence do banco de dados
      IDENTITY = utilização se identity do banco de dados
      AUTO = o provedor de persistência escolhe a estratégia mais adequada dependendo do banco de dados
      }
    FStrategy: String;
    FGenerator: String;
  public
    constructor Create(pStrategy, pGenerator: String); overload;
    constructor Create(pStrategy: String); overload;
    property Strategy: String read FStrategy write FStrategy;
    property Generator: String read FGenerator write FGenerator;
  end;

implementation

{ TTable }

constructor TTable.Create(pName, pCatalog, pSchema: String);
begin
  FName := pName;
  FCatalog := pCatalog;
  FSchema := pSchema;
end;

constructor TTable.Create(pName, pSchema: String);
begin
  FName := pName;
  FSchema := pSchema;
end;

constructor TTable.Create(pName: String);
begin
  FName := pName;
end;

{ TId }

constructor TId.Create(pNameField: String);
begin
  FNameField := pNameField;
end;

{ TColumn }

constructor TColumn.Create(pName: String; pUnique: Boolean; pLength: Integer);
begin
  FName := pName;
  FUnique := pUnique;
  FLength := pLength;
end;

constructor TColumn.Create(pName: String; pLength: Integer);
begin
  FName := pName;
  FLength := pLength;
end;

constructor TColumn.Create(pName: String; pUnique: Boolean);
begin
  FName := pName;
  FUnique := pUnique;
end;

constructor TColumn.Create(pName: String);
begin
  FName := pName;
end;

constructor TColumn.Create(pName, pCaption: String; pLocalDispay: TLocalDispay;
  pLenpth: integer; pLookup: Boolean);
begin
  FName := pName;
  FCaption := pCaption;
  FLocalDispay := pLocalDispay;
  FLength := pLenpth;
  FLookup := pLookup;
end;

constructor TColumn.Create(pName, pCaption: String; pLocalDispay: TLocalDispay;
  pLenpth: integer);
begin
  FName := pName;
  FCaption := pCaption;
  FLocalDispay := pLocalDispay;
  FLength := pLenpth;
end;

constructor TColumn.Create(pName: String; pCaption: String; pUnique: Boolean; pOutro: Boolean);
begin
  FName := pName;
  FCaption := pCaption;
  FUnique := pUnique;
  FLookup := pOutro;
end;

constructor TColumn.Create(pName, pCaption: String; pLocalDispay: TLocalDispay; pTransiente: Boolean);
begin
  FName := pName;
  FCaption := pCaption;
  FLocalDispay := pLocalDispay;
  FTransiente := pTransiente;
end;

constructor TColumn.Create(pName, pCaption: String; pUnique: Boolean; pLength: Integer);
begin
  FName := pName;
  FCaption := pCaption;
  FUnique := pUnique;
  FLength := pLength;
end;

constructor TColumn.Create(pName, pCaption: String);
begin
  FName := pName;
  FCaption := pCaption;
end;

{ TGeneratedValue }

constructor TGeneratedValue.Create(pStrategy, pGenerator: String);
begin
  FStrategy := pStrategy;
  FGenerator := pGenerator;
end;

constructor TGeneratedValue.Create(pStrategy: String);
begin
  FStrategy := pStrategy;
end;


end.
