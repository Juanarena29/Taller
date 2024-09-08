Program adi2;

const
  dimf = 2018;

type
  subrango = 2010..dimf;
  stringe = string[20];

  auto = record
    patente: integer;
    anio: subrango;
    marca: stringe;
    modelo: integer;
  end;

  arbol1 = ^nodoarbol;

  nodoarbol = record
    dato: auto;
    hi: arbol1;
    hd: arbol1;
  end;

  reglista = record
    patente: integer;
    modelo: integer;
    anio: subrango;
  end;

  liste = ^nodo;

  nodo = record
    dato: reglista;
    sig: liste;
  end;

  reg2 = record
    marca: stringe;
    lista: liste;
  end;

  arbol2 = ^nodoarbol2;

  nodoarbol2 = record
    dato: reg2;
    hi: arbol2;
    hd: arbol2;
  end;

  subregvector = record
    modelo: integer;
    marca: stringe;
    patente: integer;
  end;

  listavector = ^nodovector;

  nodovector = record
    dato: subregvector;
    sig: listavector;
  end;

  vectorD = array[subrango] of listavector;

Procedure moduloA(var a1: arbol1; var a2: arbol2);

  procedure leerinfo(var d: auto);
    var 
      vm: array[1..10] of string = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'MMM');
  begin
    d.marca := vm[random(10) + 1];
    if d.marca <> 'MMM' then
    begin
      d.patente := random(8000);
      d.modelo := random(10) + 1;
      d.anio := random(9) + 2010;
    end;
  end;

  procedure genarbol1(var a1: arbol1; d: auto);
  begin
    if a1 = nil then
    begin
      new(a1);
      a1^.dato := d;
      a1^.hi := nil;
      a1^.hd := nil;
    end
    else if a1^.dato.patente > d.patente then
      genarbol1(a1^.hi, d)
    else
      genarbol1(a1^.hd, d);
  end;

  procedure agregaradelante(var l: liste; rl: reglista);
  var 
    aux: liste;
  begin
    new(aux);
    aux^.dato := rl;
    aux^.sig := l;
    l := aux;
  end;

  procedure genarbol2(var a2: arbol2; d: auto; var rl: reglista);
  begin
    rl.patente := d.patente;
    rl.anio := d.anio;
    rl.modelo := d.modelo;
    if a2 = nil then
    begin
      new(a2);
      a2^.dato.marca := d.marca;
      a2^.dato.lista := nil;
      a2^.hi := nil;
      a2^.hd := nil;
      agregaradelante(a2^.dato.lista, rl);
    end
    else if a2^.dato.marca = d.marca then
      agregaradelante(a2^.dato.lista, rl)
    else if a2^.dato.marca < d.marca then
      genarbol2(a2^.hi, d, rl)
    else
      genarbol2(a2^.hd, d, rl);
  end;

var
  d: auto;
  rl: reglista;
begin
  a1 := nil;
  a2 := nil;
  leerinfo(d);
  while d.marca <> 'MMM' do
  begin
    genarbol1(a1, d);
    genarbol2(a2, d, rl);
    leerinfo(d);
  end;
end;

function moduloB(a1: arbol1; marca: stringe): integer;
begin
  if a1 = nil then 
    moduloB := 0
  else if a1^.dato.marca = marca then
    moduloB := 1 + moduloB(a1^.hi, marca) + moduloB(a1^.hd, marca)
  else
    moduloB := moduloB(a1^.hi, marca) + moduloB(a1^.hd, marca);
end;

function moduloC(a2: arbol2; marca: stringe): integer;

  function recorrerlista(l: liste): integer;
  begin
    if l = nil then 
      recorrerlista := 0
    else
      recorrerlista := 1 + recorrerlista(l^.sig);
  end;

begin
  if a2 = nil then 
    moduloC := 0
  else if a2^.dato.marca = marca then
    moduloC := recorrerlista(a2^.dato.lista)
  else if a2^.dato.marca > marca then
    moduloC := moduloC(a2^.hd, marca)
  else
    moduloC := moduloC(a2^.hi, marca);
end;

procedure inicializarvector(var vD: vectorD; diml: integer);
begin
  if diml <= dimf then
  begin
    vD[diml] := nil;
    inicializarvector(vD, diml + 1);
  end;
end;

procedure moduloD(var vD: vectorD; a1: arbol1);

  procedure agregaradelante(var l: listavector; dato: subregvector);
  var 
    aux: listavector;
  begin
    new(aux);
    aux^.dato := dato;
    aux^.sig := l;
    l := aux;
  end;

var
  da: subregvector;
begin
  if a1 <> nil then
  begin
    moduloD(vD, a1^.hi);
    da.modelo := a1^.dato.modelo;
    da.marca := a1^.dato.marca;
    da.patente := a1^.dato.patente;
    agregaradelante(vD[a1^.dato.anio], da);
    moduloD(vD, a1^.hd);
  end;
end;

procedure imprimirarbol(a1: arbol1);
begin
  if a1 <> nil then
  begin
    imprimirarbol(a1^.hi);
    writeln('--------');
    writeln('Patente: ', a1^.dato.patente);
    writeln('Marca: ', a1^.dato.marca);
    writeln('Modelo: ', a1^.dato.modelo);
    writeln('Anio: ', a1^.dato.anio);
    imprimirarbol(a1^.hd);
  end;
end;

procedure imprimirvector(v: vectorD; diml: integer);

  procedure imprimirlista(l: listavector);
  begin
    if l <> nil then
    begin
      writeln('     --     ');
      writeln('Patente: ', l^.dato.patente);
      writeln('Marca: ', l^.dato.marca);
      writeln('Modelo: ', l^.dato.modelo);
      imprimirlista(l^.sig);
    end;
  end;

begin
  if diml <= dimf then
  begin
    writeln('--------------');
    writeln('Anio: ', diml);
    imprimirlista(v[diml]);
    imprimirvector(v, diml + 1);
  end;
end;

function moduloE(a: arbol1; patente: integer): integer;
begin
  if a = nil then 
    moduloE := 0
  else if a^.dato.patente = patente then
    moduloE := a^.dato.modelo
  else if a^.dato.patente > patente then
    moduloE := moduloE(a^.hi, patente)
  else
    moduloE := moduloE(a^.hd, patente);
end;

function moduloG(a: arbol2; patente: integer): integer;

  function reclista(l: liste; patente: integer): integer;
  begin
    if l = nil then 
      reclista := 0
    else if l^.dato.patente = patente then
      reclista := l^.dato.modelo
    else
      reclista := reclista(l^.sig, patente);
  end;

begin
  if a = nil then 
    moduloG := 0
  else if reclista(a^.dato.lista, patente) = 0 then 
    moduloG := moduloG(a^.hi, patente) + moduloG(a^.hd, patente)
  else 
    moduloG := reclista(a^.dato.lista, patente);
end;

var
  vD: vectorD;
  a1: arbol1;
  a2: arbol2;
  marca: stringe;
  diml: integer;
  patent: integer;

begin
  randomize;
  diml := 2010;
  inicializarvector(vD, diml);
  moduloA(a1, a2);
  writeln;
  writeln('Los arboles se han generado con exito');
  writeln;
  imprimirarbol(a1);
  writeln;
  writeln('Escriba una marca: "A", "B", "C", "D", "E", "F", "G", "H", "I"');
  readln(marca);
  writeln;
  writeln('De la estructura 1: ', moduloB(a1, marca));
  writeln;
  writeln('De la estructura 2: ', moduloC(a2, marca));
  writeln;
  moduloD(vD, a1);
  writeln;
  writeln('Escriba una patente: ');
  readln(patent);
  writeln('El modelo de auto con patente ', patent, ' es: ', moduloE(a1, patent));
  writeln;
  writeln('El modelo de auto con patente ', patent, ' es: ', moduloG(a2, patent));
end.

