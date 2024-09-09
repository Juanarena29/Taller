Program parcial2;
const
  dimf = 15;
type

  subrango = 1..dimf;
  meses= 0..12;
  
  consulta = record
    dni : integer;
    mes : meses;
    diagnos : subrango;
    end;
   
  regarbol = record
    dni : integer;
    contador : integer;
    end;
     
  arbol = ^nodoarbol;
  
  nodoarbol = record
    dato :regarbol;
    hi : arbol;
    hd : arbol;
    end;
 
   vector = array[subrango] of integer;
   
procedure moduloA(var a:arbol; var v : vector; var diml : integer);

  procedure leerinfo(var c : consulta);
  begin
    c.mes := random(13);
    if c.mes <> 0 then begin
      c.dni := random(10)+1;
      c.diagnos := random(15)+1;
      end;
  end;
  
  procedure insertararbol(var a : arbol; c: consulta);
  begin
    if a = nil then begin
      new(a);
      a^.dato.dni := c.dni;
      a^.dato.contador :=1;
      a^.hi := nil;
      a^.hd := nil;
      end
      else begin
       if c.dni = a^.dato.dni then a^.dato.contador := a^.dato.contador + 1
       else if c.dni < a^.dato.dni then
         insertararbol(a^.hi,c)
         else insertararbol(a^.hd,c);
      end;
  end;
 
procedure inicializarvector( var v : vector; diml : integer);
begin
  if diml<=dimf then begin
    v[diml]:=0;
    inicializarvector(v,diml+1);
    end;
end;    

var
  c: consulta;
begin
  a:= nil;
  diml := 0;
  inicializarvector(v,1);
  leerinfo(c);
  while c.mes<>0 do begin
    insertararbol(a,c);
    if v[c.diagnos] = 0 then
      diml := diml + 1;
    v[c.diagnos]:=v[c.diagnos] + 1;
    leerinfo(c);
    end;
end;

function moduloB( a : arbol; izq,der,x : integer): integer;
begin
  if a = nil then moduloB := 0
  else if a^.dato.dni > izq then
    if a^.dato.dni < der then
      if a^.dato.contador > x then moduloB := 1 + moduloB(a^.hi,izq,der,x) + moduloB(a^.hd,izq,der,x)
      else moduloB:= moduloB(a^.hi,izq,der,x)
    else moduloB:= moduloB(a^.hd,izq,der,x);
end;

procedure imprimirarbol(a : arbol);
begin
  if a<> nil then begin
    imprimirarbol(a^.hi);
    writeln('DNI : ', a^.dato.dni);
    writeln('CONSULTAS :',a^.dato.contador);
    imprimirarbol(a^.hd);
  end;
end;

var
  a : arbol;
  v : vector;
  diml,min,max,x : integer;
  
begin
  randomize;
  moduloA(a,v,diml);
  imprimirarbol(a);
  writeln;
  writeln('Escriba dos valores min y max y un valor x(0..5)');
  writeln('Min : ');readln(min);
  writeln('Max: ');readln(max);
  writeln('Valor x de consultas: ');readln(x);
  writeln('La cantidad de pacientes dentro del rango cuyas consultas es mayor a ',x,' es:  ',moduloB(a,min,max,x));
end.
