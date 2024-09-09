program parcial3;

type
  anios = 2000..2024;
  meses = 1..12;

  alquiler = record
    dni: integer;
    patente: integer;
    mes: meses;
    anio: anios;
  end;

  reglista = record
    dni: integer;
    anio: anios;
    mes: meses;
  end;

  lista = ^nodolista;

  nodolista = record
    dato: reglista;
    sig: lista;
  end;

  regarbol = record
    patente: integer;
    datolista: lista;
  end;

  arbol = ^nodoarbol;

  nodoarbol = record
    dato: regarbol;
    hi: arbol;
    hd: arbol;
  end;

procedure moduloA(var a: arbol);

  procedure leeralquiler(var a: alquiler);
  begin
    a.patente := random(700);
    if a.patente <> 0 then
    begin
      a.dni := random(50) + 1;
      a.anio := 2000 + random(25);  
      a.mes := meses(random(12) + 1); 
      end;
  end;

  procedure agregaradelante(var l: lista; d: alquiler);
  var
    r: reglista; aux: lista;
  begin
    r.dni := d.dni; r.anio := d.anio; r.mes := d.mes;
    new(aux);
    aux^.dato := r;
    aux^.sig := l;
    l := aux;
  end;

  procedure insertararbol(var a: arbol; d: alquiler);
  begin
    if a = nil then
    begin
      new(a);
      a^.dato.patente := d.patente;
      a^.dato.datolista := nil;
      a^.hi := nil;
      a^.hd := nil;
      agregaradelante(a^.dato.datolista, d);
    end
    else if a^.dato.patente = d.patente then
      agregaradelante(a^.dato.datolista, d)
    else if d.patente < a^.dato.patente then
      insertararbol(a^.hi, d)
    else
      insertararbol(a^.hd, d);
  end;

var
  d: alquiler;
begin
  a := nil;
  leeralquiler(d);
  while d.patente <> 0 do
  begin
    insertararbol(a, d);
    leeralquiler(d);
  end;
end;

function moduloB(a: arbol; dni: integer): integer;

  function recorrerlista(l: lista; dni: integer): integer;
  begin
    if l = nil then
      recorrerlista := 0
    else if l^.dato.dni = dni then
      recorrerlista := 1 + recorrerlista(l^.sig, dni)
    else
      recorrerlista := recorrerlista(l^.sig, dni);
  end;

begin
  if a = nil then
    moduloB := 0
  else
    moduloB := recorrerlista(a^.dato.datolista, dni) + moduloB(a^.hi, dni) + moduloB(a^.hd, dni);
end;

function contarlista(l: lista; anio: anios): integer;
begin
  if l = nil then
    contarlista := 0
  else if l^.dato.anio = anio then
    contarlista := 1 + contarlista(l^.sig, anio)
  else
    contarlista := contarlista(l^.sig, anio);
end;

function moduloC(a: arbol; izq, der: integer; x: anios): integer;
var
  cant: integer;
begin
  if a = nil then
    moduloC := 0
  else if a^.dato.patente >= izq then
    if a^.dato.patente <= der then
    begin
      cant := contarlista(a^.dato.datolista, x);
      moduloC := cant + moduloC(a^.hi, izq, der, x) + moduloC(a^.hd, izq, der, x);
    end
    else
      moduloC := moduloC(a^.hi, izq, der, x)
  else
    moduloC := moduloC(a^.hd, izq, der, x);
end;

procedure imprimirarbol(a: arbol);

  function contarlistax(l: lista): integer;
  begin
    if l = nil then
      contarlistax := 0
    else
      contarlistax := 1 + contarlistax(l^.sig);
  end;

begin
  if a <> nil then
  begin
    imprimirarbol(a^.hi);
    writeln('Patente: ', a^.dato.patente, '  -- Alquileres: ', contarlistax(a^.dato.datolista));
    imprimirarbol(a^.hd);
  end;
end;

var
  a: arbol;
  izq, der, anio, dni: integer;
begin
  randomize;
  moduloA(a);
  writeln('El arbol se ha generado correctamente');
  writeln;
  imprimirarbol(a);
  writeln;
  writeln('Ingrese un DNI: ');
  readln(dni);
  writeln;
  writeln('Existe una cantidad de ', moduloB(a, dni), ' alquileres asociados al dni ', dni);
  writeln;
  writeln('Ingrese dos valores (1..100) y un anio (2000..2024): ');
  writeln;
  writeln('Valor min: ');
  readln(izq);
  writeln;
  writeln('Valor max: ');
  readln(der);
  writeln;
  writeln('Anio: ');
  readln(anio);
  writeln;
  writeln('Dentro del rango (', izq, ',', der, '), en el anio ', anio, ' hay una cantidad de ', moduloC(a, izq, der, anio), ' alquileres');
end.
