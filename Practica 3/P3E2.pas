program dos;

const
  cod = 21;
  can = 20;

type 
  dias = 1..31;
  meses = 1..12;
  anios = 2022..2024;

  fechas = record
    dia: dias;
    mes: meses;
    anio: anios;
  end;

  venta = record
    codigo: integer;
    fecha: fechas;
    cantidad: integer;
  end;

  arbola = ^nodoa;
  
  nodoa = record
    dato: venta;
    hi: arbola;
    hd: arbola;
  end;
    
  arbolb = ^nodob;
  
  nodob = record
    codigob: integer;
    cantidadb: integer;
    hi: arbolb;
    hd: arbolb;
  end;
  
  listac = ^nodolista;
  
  nodolista = record
    dato: integer;
    sig: listac;
  end;

  arbolc = ^nodoc;
  
  nodoc = record
    codigoc: integer;
    lista: listac;
    hi: arbolc;
    hd: arbolc;
  end;

procedure leerventa(var v: venta);
begin
  v.codigo := random(cod);
  v.fecha.dia := random(31) + 1;
  v.fecha.mes := random(12) + 1;
  v.fecha.anio := random(3) + 2022;
  v.cantidad := random(can) + 1;
end;

procedure generararboles(var a: arbola; var b: arbolb; var c: arbolc);

  procedure enOrden(a: arbola);
  begin
    if a <> nil then
    begin
      enOrden(a^.hi);
      writeln('FECHA: ', a^.dato.fecha.dia, '/', a^.dato.fecha.mes, '/', a^.dato.fecha.anio);
      writeln('CODIGO: ', a^.dato.codigo);
      writeln('CANTIDAD: ', a^.dato.cantidad);
      writeln;
      enOrden(a^.hd);
    end;
  end;

  procedure arbolaa(var a: arbola; v: venta);
  begin
    if a = nil then
    begin
      new(a);
      a^.dato := v;
      a^.hi := nil;
      a^.hd := nil;
    end
    else 
      if v.codigo >= a^.dato.codigo then arbolaa(a^.hd, v)
      else arbolaa(a^.hi, v);
  end;

  procedure arbolbb(var b: arbolb; v: venta);
  begin  
    if b = nil then
    begin
      new(b);
      b^.codigob := v.codigo;
      b^.cantidadb := v.cantidad;
      b^.hi := nil;
      b^.hd := nil;
    end
    else
      if v.codigo >= b^.codigob then arbolbb(b^.hd, v)
      else arbolbb(b^.hi, v);
  end;

  procedure arbolcc(var c: arbolc; v: venta);

    procedure agregaradelante(var l: listac; num: integer);
    var
      aux: listac;
    begin
      new(aux);
      aux^.dato := num;
      aux^.sig := l;
      l := aux;
    end;

  begin
    if c = nil then
    begin
      new(c);
      c^.codigoc := v.codigo;
      c^.lista := nil; // inicializo la lista de venta en nil
      c^.hi := nil;
      c^.hd := nil;
      agregaradelante(c^.lista, v.cantidad); // le paso por parámetro la lista
    end
    else if c^.codigoc = v.codigo then
      agregaradelante(c^.lista, v.cantidad) // nodo encontrado, agrego a la lista
    else if v.codigo < c^.codigoc then arbolcc(c^.hi, v)
    else arbolcc(c^.hd, v);
  end;

var
  v: venta;

begin
  a := nil;
  b := nil;
  c := nil;
  leerventa(v);
  while v.codigo <> 0 do
  begin
    arbolaa(a, v);
    arbolbb(b, v);
    arbolcc(c, v);
    leerventa(v);
  end;
  enOrden(a);
end;

function cantidad(a: arbola; f: fechas): integer;

  procedure acumular(a: arbola; f: fechas; var total: integer);
  begin
    if a <> nil then
    begin
      acumular(a^.hi, f, total); // Recorrer el subárbol izquierdo
      if (a^.dato.fecha.dia = f.dia) and (a^.dato.fecha.mes = f.mes) and (a^.dato.fecha.anio = f.anio) then
        total := total + a^.dato.cantidad; // Sumar cantidad si la fecha coincide
      acumular(a^.hd, f, total); // Recorrer el subárbol derecho
    end;
  end;

var
  total: integer;

begin
  total := 0; // Inicializar total en 0 antes de comenzar
  acumular(a, f, total); // Llamar al procedimiento auxiliar
  cantidad := total; // Devolver el resultado
end;

function mayorcant(b: arbolb): integer;

  procedure buscar(b: arbolb; var mayor: integer; var codemayor: integer);
  begin
    if b <> nil then
    begin
      buscar(b^.hi, mayor, codemayor);
      if b^.cantidadb > mayor then
      begin
        codemayor := b^.codigob;
        mayor := b^.cantidadb;
      end;
      buscar(b^.hd, mayor, codemayor);
    end;
  end;

var
  mayor, codemayor: integer;

begin
  mayor := -1;
  codemayor := -1;
  buscar(b, mayor, codemayor);
  mayorcant := codemayor;
end;

function masventas(c: arbolc): integer;

  procedure busco(c: arbolc; var codemax, maxvent: integer);
  var
    cont: integer;
    aux: listac;
  begin
    if c <> nil then
    begin
      busco(c^.hi, codemax, maxvent);
      cont := 0;
      aux := c^.lista;
      while aux <> nil do
      begin
        cont := cont + 1;
        aux := aux^.sig;
      end;
      if cont > maxvent then
      begin
        codemax := c^.codigoc;
        maxvent := cont;
      end;
      busco(c^.hd, codemax, maxvent);
    end;
  end;

var
  codemax, maxvent: integer;

begin
  codemax := -1;
  maxvent := 0;
  busco(c, codemax, maxvent);
  masventas := codemax;
end;

var
  a: arbola;
  b: arbolb;
  c: arbolc;
  f: fechas;

begin
  randomize;
  generararboles(a, b, c);
  writeln;
  writeln('Cantidad de productos en fecha');
  writeln;
  writeln('DIA: '); readln(f.dia);
  writeln('MES: '); readln(f.mes);
  writeln('ANIO: '); readln(f.anio);
  writeln('La cantidad de productos vendidos en la fecha - ', f.dia, '/', f.mes, '/', f.anio);
  writeln('cantidad: ', cantidad(a, f));
  writeln;
  writeln('El código del producto más vendido es: ', mayorcant(b));
  writeln;
  writeln;
  writeln('El producto con más ventas es: ', masventas(c));
end.
