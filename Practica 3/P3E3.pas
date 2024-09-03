Program P3E3;

const
  codmat = 50;

type
  dias = 1..31;
  meses = 1..12;
  anios = 2020..2024;

  fechas = record
    dia  : dias;
    mes  : meses;
    anio : anios;
  end;

  examen = record
    codigomat : 1..codmat;
    fecha     : fechas;
    nota      : 1..10;
  end;

  listafinal = ^nodofinal;

  nodofinal = record
    dato : examen;
    sig  : listafinal;
  end;

  finalalumno = record
    legajo : integer;
    final  : listafinal;
  end;

  arbol = ^alumno;

  alumno = record
    dato : finalalumno;
    hi   : arbol;
    hd   : arbol;
  end;

procedure finalalumnos(var d : finalalumno; var f : examen);
begin
  d.legajo := random(20);
  f.codigomat := random(codmat);
  f.fecha.dia := random(31) + 1;
  f.fecha.mes := random(12) + 1;
  f.fecha.anio := random(3) + 2022;
  f.nota := random(10) + 1;
end;

procedure generararboles(var a : arbol);

  procedure agregaradelante(var l: listafinal; final : examen);
  var
    aux: listafinal;
  begin
    new(aux);
    aux^.dato := final;
    aux^.sig := l;
    l := aux;
  end;

  procedure arbol(var a : arbol; d : finalalumno; f : examen);
  begin
    if a = nil then
    begin
      new(a);
      a^.dato.legajo := d.legajo;
      a^.dato.final := nil;
      a^.hi := nil;
      a^.hd := nil;
      agregaradelante(a^.dato.final, f);
    end
    else if d.legajo = a^.dato.legajo then
      agregaradelante(a^.dato.final, f)
    else if d.legajo > a^.dato.legajo then
      arbol(a^.hd, d, f)
    else
      arbol(a^.hi, d, f);
  end;

var
  d : finalalumno;
  f : examen;

begin
  finalalumnos(d, f);
  while d.legajo <> 0 do
  begin
    arbol(a, d, f);
    finalalumnos(d, f);
  end;
  Writeln('----');
  Writeln('LISTA CARGADA');
  Writeln('----');
end;

function esimpar(num : integer): boolean;
begin
  esimpar := (num MOD 2 = 1);
end;

procedure leerlegajos(a : arbol; var contador : integer);
begin
  if a <> nil then
  begin
    leerlegajos(a^.hi, contador);
    if esimpar(a^.dato.legajo) then
      contador := contador + 1;
    leerlegajos(a^.hd, contador);
  end;
end;

procedure finaprobados(a : arbol; var canti : integer);

  procedure recorrerlista(l : listafinal; var cant: integer);
  begin
    
    while l <> nil do
    begin
      if l^.dato.nota >= 4 then
        cant := cant + 1;
      l := l^.sig;
    end;
  end;

begin
  if a <> nil then
  begin
    finaprobados(a^.hi, canti);
    recorrerlista(a^.dato.final, canti);
    finaprobados(a^.hd, canti);
  end;
end;

procedure promedios(a : arbol; valor : real);

  function funpromedio(l : listafinal): real;
  var
    cantfin    : integer;
    notatotal  : integer;
  begin
    cantfin := 0;
    notatotal := 0;
    while l <> nil do
    begin
      cantfin := cantfin + 1;
      notatotal := notatotal + l^.dato.nota;
      l := l^.sig;
    end;
    if cantfin = 0 then
      funpromedio := 0
    else
      funpromedio := (notatotal / cantfin);
  end;

begin
  if a <> nil then
  begin
    promedios(a^.hi, valor);
    if funpromedio(a^.dato.final) > valor then
    begin
      Writeln('Alumno de legajo: ', a^.dato.legajo);
      Writeln('tiene un promedio mayor a ', valor:2:2);
    end;
    promedios(a^.hd, valor);
  end;
end;

procedure leerexamenes(l : listafinal);
begin
  while l <> nil do
  begin
    Writeln('nota examen: ', l^.dato.nota);
    l := l^.sig;
  end;
end;

procedure enorden(a : arbol);
begin
  if a <> nil then
  begin
    if a^.hi <> nil then
      enorden(a^.hi);
    Writeln('LEGAJO: ', a^.dato.legajo);
    leerexamenes(a^.dato.final);
    if a^.hd <> nil then
      enorden(a^.hd);
  end;
end;

var
  a        : arbol;
  contador : integer;
  canti    : integer;
  valor    : real;

begin
  a := nil;
  randomize;
  generararboles(a);
  enorden(a);
  contador := 0;
  leerlegajos(a, contador);
  Writeln;
  Writeln('La cantidad de alumnos con legajo impar es: ', contador);
  Writeln;
  canti := 0;
  finaprobados(a, canti);
  Writeln('La cantidad de exámenes aprobados es: ', canti);
  Writeln;
  Writeln('Escriba un valor real: ');
  Readln(valor);
  promedios(a, valor);
end.
