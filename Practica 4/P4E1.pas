Program ImperativoClase4;

type
  venta = record
    codigoVenta     : integer;
    codigoProducto  : integer;
    cantUnidades    : integer;
    precioUnitario  : real;
  end;

  productoVendido = record
    codigo            : integer;
    cantTotalUnidades : integer;
    montoTotal        : real;
  end;

  arbol = ^nodoArbol;

  nodoArbol = record
    dato : productoVendido;
    HI   : arbol;
    HD   : arbol;
  end;

procedure ModuloA(var a: arbol);
{ Almacene los productos vendidos en una estructura eficiente para la búsqueda por código de producto. 
  De cada producto deben quedar almacenados la cantidad total de unidades vendidas y el monto total. }

  procedure CargarVenta(var v: venta);
  begin
    v.codigoVenta := random(51) * 100;
    if (v.codigoVenta <> 0) then
    begin
      v.codigoProducto := random(100) + 1;
      v.cantUnidades := random(15) + 1;
      v.precioUnitario := (100 + random(100)) / 2;
    end;
  end;

  procedure InsertarElemento(var a: arbol; elem: venta);
  var
    p: productoVendido;

    procedure ArmarProducto(var p: productoVendido; v: venta);
    begin
      p.codigo := v.codigoProducto;
      p.cantTotalUnidades := v.cantUnidades;
      p.montoTotal := v.cantUnidades * v.precioUnitario;
    end;

  begin
    if (a = nil) then
    begin
      new(a);
      ArmarProducto(p, elem);
      a^.dato := p;
      a^.HI := nil;
      a^.HD := nil;
    end
    else if (elem.codigoProducto = a^.dato.codigo) then
    begin
      a^.dato.cantTotalUnidades := a^.dato.cantTotalUnidades + elem.cantUnidades;
      a^.dato.montoTotal := a^.dato.montoTotal + (elem.cantUnidades * elem.precioUnitario);
    end
    else if (elem.codigoProducto < a^.dato.codigo) then
      InsertarElemento(a^.HI, elem)
    else
      InsertarElemento(a^.HD, elem);
  end;

var
  unaVenta: venta;

begin
  writeln;
  writeln('----- Ingreso de ventas y armado de arbol de productos ----->');
  writeln;
  a := nil;
  CargarVenta(unaVenta);
  while (unaVenta.codigoVenta <> 0) do
  begin
    InsertarElemento(a, unaVenta);
    CargarVenta(unaVenta);
  end;
  writeln;
  writeln('-----------------------------------------------');
  writeln;
end;

procedure ModuloB(a: arbol);
{ Imprima el contenido del árbol ordenado por código de producto. }

  procedure ImprimirArbol(a: arbol);
  begin
    if (a <> nil) then
    begin
      if (a^.HI <> nil) then
        ImprimirArbol(a^.HI);
      writeln('Codigo producto: ', a^.dato.codigo, 
              ' cantidad unidades: ', a^.dato.cantTotalUnidades, 
              ' monto total: ', a^.dato.montoTotal:2:2);
      if (a^.HD <> nil) then
        ImprimirArbol(a^.HD);
    end;
  end;

begin
  writeln;
  writeln('----- Modulo B ----->');
  writeln;
  if (a = nil) then
    writeln('Arbol vacio')
  else
    ImprimirArbol(a);
  writeln;
  writeln('-----------------------------------------------');
  writeln;
end;

procedure ModuloC(a: arbol);
{ Retornar el menor código de producto. }

  function ObtenerMinimo(a: arbol): integer;
  begin
    if (a = nil) then
      ObtenerMinimo := 9999
    else if (a^.HI = nil) then
      ObtenerMinimo := a^.dato.codigo
    else
      ObtenerMinimo := ObtenerMinimo(a^.HI);
  end;

var
  menorCodigo: integer;

begin
  writeln;
  writeln('----- Modulo C ----->');
  writeln;
  write('Menor codigo de producto: ');
  writeln;
  menorCodigo := ObtenerMinimo(a);
  if (menorCodigo = 9999) then
    writeln('Arbol vacio')
  else
  begin
    writeln;
    writeln('El codigo menor es ', menorCodigo);
    writeln;
  end;
  writeln;
  writeln('-----------------------------------------------');
  writeln;
end;

procedure ModuloD(a: arbol);
{ Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe como parámetro }

  function CantidadDeCodigosMenores(a: arbol; cod: integer): integer;
  begin
    if a = nil then CantidadDeCodigosMenores:=0
	else begin
	  if a^.dato.codigo < cod then 
	    CantidadDeCodigosMenores:=CantidadDeCodigosMenores(a^.HI,cod)+1+CantidadDeCodigosMenores(a^.HD,cod)
		else
		  CantidadDeCodigosMenores:=CantidadDeCodigosMenores(a^.HI,cod);
  end;
end;

var
  cantidad, unCodigo: integer;

begin
  writeln;
  writeln('----- Modulo D ----->');
  writeln;
  write('Ingresar un codigo: ');
  readln(unCodigo);
  cantidad := CantidadDeCodigosMenores(a, unCodigo);
  writeln;
  writeln('La cantidad de codigos menores al codigo ', unCodigo, ' es: ', cantidad);
  writeln;
  writeln;
  writeln('-----------------------------------------------');
  writeln;
end;

procedure ModuloE(a: arbol);
{ Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de producto y retorne el monto total entre todos los códigos de productos comprendidos entre los dos valores recibidos (sin incluir). }

  function montorango(a: arbol; izq, der: integer): real;
  begin
    if a = nil then montorango:=0
	else begin
	  if (a^.dato.codigo>izq) and (a^.dato.codigo<der) then
	    montorango := montorango(a^.HI,izq,der) + montorango(a^.HD,izq,der) + a^.dato.montoTotal
		else begin
		if a^.dato.codigo > izq then
		  montorango:=montorango(a^.HI,izq,der)
		  else begin
		  if a^.dato.codigo < der then
		    montorango:=montorango(a^.HD,izq,der);
		  end;
	    end;
	end;
  end;

var
  codigo1, codigo2: integer;
  montoTotal: real;

begin
  writeln;
  writeln('----- Modulo E ----->');
  writeln;
  write('Ingrese primer codigo de producto: ');
  readln(codigo1);
  write('Ingrese segundo codigo de producto (mayor al primer codigo): ');
  readln(codigo2);
  writeln;
  montoTotal := montorango(a, codigo1, codigo2);
  if (montoTotal = 0) then
    writeln('No hay codigos entre ', codigo1, ' y ', codigo2)
  else
  begin
    writeln;
    writeln('El monto total entre el codigo ', codigo1, ' y el codigo : ', codigo2, ' es: ', montoTotal:2:2);
    writeln;
  end;
  writeln;
  writeln('-----------------------------------------------');
  writeln;
end;

var
  a: arbol;

begin
  randomize;
  ModuloA(a);
  ModuloB(a);
  ModuloC(a);
  
    ModuloD(a);
   ModuloE(a);
  
end.
