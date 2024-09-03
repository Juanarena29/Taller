Program P3E3;
const
  codmat = 50;
type
  dias = 1..31;
  meses = 1..12;
  anios = 2020..2024;
  
  fechas = record
    dia : dias;
    mes : meses;
    anio : anios;
    end;
  
  finalx = record
    codigomat : 1..codmat;
    fecha : fechas;
    nota : 1..10;
    end;
  
  listafinal = ^nodofinal;
  
  nodofinal = record
    dato : finalx;
    sig : listafinal;
    end;
   
   datofinal = record
    legajo : integer;
    finales : listafinal;
    end;
   
  arbol=^alumno;
  
  alumno = record
    dato : datofinal;
    hi : arbol;
    hd : arbol;
    end;

procedure leerfinal(var f : finalx);

  begin
  f.codigomat := random(codmat);
  f.fecha.dia := random(31) + 1;
  f.fecha.mes := random(12) + 1;
  f.fecha.anio := random(3) + 2022;
  f.nota := random(10) + 1;
end;

procedure finalalumno(var d : datofinal);
var f : finalx;
begin
  d.legajo:=random(1000);
  leerfinal(f);
  d.finales^.dato:=f;
end;

procedure generararboles(var a : arbol);

 procedure agregaradelante(var l: listafinal; final : finalx);
    var
      aux: listafinal;
    begin
      new(aux);
      aux^.dato := final;
      aux^.sig := l;
      l := aux;
    end;


procedure arbol(var a : arbol; d : datofinal );


begin
  if a = nil then begin
    new(a);
    a^.dato.legajo:=d.legajo;
    a^.dato.finales:=nil;
    a^.hi:=nil;
    a^.hd:=nil;
    agregaradelante(a^.dato.finales,d.finales^.dato);
    end
    else if d.legajo > a^.dato.legajo then arbol (a^.hd,d)
    else arbol(a^.hi,d);
end;
var
d : datofinal;
begin
  finalalumno(d);
  while d.legajo <> 0 do begin
    arbol(a,d);
    finalalumno(d);
  end;
  Writeln('----');
  writeln('LISTA CARGADA');
  Writeln('----');
end;


function esimpar(num : integer): boolean;
begin
  esimpar := (num MOD 2 = 1);
end;

procedure leerlegajos(a : arbol;var contador : integer);
begin
  if a = nil then
    contador := 0
    else begin
      leerlegajos(a^.hi,contador);
       if esimpar(a^.dato.legajo) then contador := contador + 1;
      leerlegajos(a^.hd,contador)
    end;
end;

procedure finaprobados(a : arbol;var cant : integer);

procedure recorrerlista(l : listafinal; var cant: integer);
begin
  cant :=0;
  while l<>nil do begin
    if l^.dato.nota >= 4 then cant := cant + 1;
    l:=l^.sig;
    end;
end;

var 
  canti : integer;
begin
  if a <> nil then begin
    finaprobados(a^.hi,canti);
    recorrerlista(a^.dato.finales,canti);
    finaprobados(a^.hd,canti);
    end;
end;

procedure promedios(a : arbol;valor : real);

function funpromedio(l : listafinal): real;
var
cantfin : integer;
notatotal : integer;
begin
  cantfin:=0;
  notatotal:=0;
  while l<>nil do begin
    cantfin:=cantfin + 1;
    notatotal := notatotal + l^.dato.nota;
    l:=l^.sig;
    end;
  funpromedio := (notatotal / cantfin);
end;

begin
  if a<>nil then begin
    promedios(a^.hi,valor);
    if funpromedio(a^.dato.finales) > valor then begin
      writeln('Alumno de legajo: ',a^.dato.legajo);
      writeln('tiene un promedio mayor a ',valor);
      end;
    promedios(a^.hd,valor);
    end;
end;
var
a : arbol;

begin
randomize;
generararboles(a);


end.
