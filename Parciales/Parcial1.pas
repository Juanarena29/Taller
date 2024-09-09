Program Parcial1;

const
  dimf = 12;

type
  dias = 1..31;
  meses = 1..12;

  compra = record
    codigo: integer;
    cliente: integer;
    dia: dias;
    mes: meses;
  end;

  arbol = ^nodoarbol;

  nodoarbol = record
    dato: compra;
    hi: arbol;
    hd: arbol;
  end;

  vector = array[meses] of integer;

procedure moduloA(var a: arbol; var v: vector; var diml: integer);

  procedure leercompra(var c: compra);
  begin
    c.cliente := random(100);
    if (c.cliente <> 0) then
    begin
      c.dia := random(31) + 1;
      c.mes := random(12) + 1;
      c.codigo := random(20000) + 1;
    end;
  end;

  procedure insertararbol(var a: arbol; c: compra);
  begin
    if a = nil then
    begin
      new(a);
      a^.dato := c;
      a^.hi := nil;
      a^.hd := nil;
    end
    else if c.cliente < a^.dato.cliente then
      insertararbol(a^.hi, c)
    else
      insertararbol(a^.hd, c);
  end;

  procedure inicializarvector(var v: vector; diml: integer);
  begin
    if diml <= dimf then
    begin
      v[diml] := 0;
      inicializarvector(v, diml + 1);
    end;
  end;

var
  c: compra;
begin
  inicializarvector(v, 1);
  leercompra(c);
  while c.cliente <> 0 do
  begin
    insertararbol(a, c);
    if v[c.mes] = 0 then
      diml := diml + 1;
    v[c.mes] := v[c.mes] + 1;
    leercompra(c);
  end;
end;

procedure moduloB(a: arbol; code: integer);

procedure buscararbol(a : arbol; code:integer;var found: boolean);
begin
  if a <> nil then
    if a^.dato.cliente = code then
    begin
      found := true;
      writeln('Compra realizada: ');
      writeln('Videojuego: ', a^.dato.codigo);
      writeln('Dia: ', a^.dato.dia);
      writeln('Mes: ', a^.dato.mes);
      buscararbol(a^.hd, code,found);
    end
    else if code < a^.dato.cliente then
      buscararbol(a^.hi, code,found)
    else
      buscararbol(a^.hd, code,found);
end;

var
 found : boolean;

begin
  found:=false;
  buscararbol(a,code,found);
  if found = false then
    writeln('no se encontraron compras ');
end;

procedure moduloC(var v: vector; diml: integer);
var
  i, j, pos, item: integer;
begin
  for i := 1 to diml - 1 do
  begin
    pos := i;
    for j := i + 1 to diml do
      if v[j] < v[pos] then
        pos := j;
    item := v[pos];
    v[pos] := v[i];
    v[i] := item;
  end;
end;

procedure imprimirvector(v: vector; diml: integer);
begin
  if diml <= dimf then
  begin
    writeln('Mes: ', diml, ' - Cantidad: ', v[diml]);
    imprimirvector(v, diml + 1);
  end;
end;

function contararbol(a: arbol): integer;
begin
  if a = nil then
    contararbol := 0
  else
    contararbol := 1 + contararbol(a^.hi) + contararbol(a^.hd);
end;

var
  diml: integer;
  v: vector;
  code: integer;
  a: arbol;

begin
  a := nil;
  randomize;
  diml := 0;
  moduloA(a, v, diml);
  writeln('En el arbol hay una cantidad de: ', contararbol(a), ' Compras');
  writeln('El arbol y el vector se han generado correctamente');
  writeln;
  writeln('Escriba el codigo de cliente que desea consultar: ');
  readln(code);
  moduloB(a, code);
  moduloC(v, diml);
  writeln;
  imprimirvector(v, 1);
end.
