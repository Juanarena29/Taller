program parcial;
const
  dimf = 5;
type
  
  compra = record
    comida : integer;
    cliente : integer;
    categoria : string;
    end;
    
  regarbol = record
    comida : integer;
    cantidad : integer;
    end;
    
  arbol = ^nodoarbol;
  
  nodoarbol = record
    dato : regarbol;
    hi : arbol;
    hd : arbol;
    end;
    
  regvector = record
    categoria : string;
    cantidad : integer;
    end;
      
  vector = array[1..dimf] of regvector;

procedure moduloA(var a : arbol; var v : vector);

  procedure leercompra(var c : compra;var cat : integer);
  var v: array[1..dimf] of string = ('Full','Super','Media','Normal','Basica');
  begin
    c.cliente := random(200);
      if c.cliente <> 0 then begin
        c.comida := random(20)+1;
        cat := random(dimf)+1;
        c.categoria := v[cat];
        end;
  end;
  
  procedure insertararbol(var a : arbol; c : compra);
  begin
    if a=nil then 
      begin
        new(a);
        a^.dato.comida:=c.comida;
        a^.dato.cantidad:=1;
        a^.hi:=nil;
        a^.hd:=nil;
        end
        else if c.comida = a^.dato.comida then
          a^.dato.cantidad:= a^.dato.cantidad + 1
          else if c.comida < a^.dato.comida then
            insertararbol(a^.hi,c)
            else insertararbol(a^.hd,c);
  end;
 
   procedure iniciarvector(var v :vector; diml : integer);
   var be: array[1..dimf] of string = ('Full','Super','Media','Normal','Basica');
   begin
     if diml <= dimf then begin
       v[diml].cantidad := 0;
       v[diml].categoria:=be[diml];
       iniciarvector(v,diml+1);
       end;
   end;
     
var
  c: compra;
  cat : integer;
begin
  iniciarvector(v,1);
  leercompra(c,cat);
  while c.cliente <> 0 do begin
    insertararbol(a,c);
    v[cat].cantidad:= v[cat].cantidad + 1;
    leercompra(c,cat);
  end;
end;

function moduloB( a : arbol; codecom : integer):integer;
begin
  if a= nil then moduloB:= 0
  else
   if a^.dato.comida = codecom then
     moduloB:= a^.dato.cantidad
     else if codecom < a^.dato.comida then
       moduloB:= moduloB(a^.hi,codecom)
       else moduloB:=moduloB(a^.hd,codecom);
end;

procedure moduloC(var v : vector ; diml : integer; var catemax : string);
var
  i,j,pos : integer;
  item : regvector;
begin
  for i:=1 to diml-1 do begin
    pos:=i;
    for j:=i+1 to diml do
      if v[j].cantidad < v[pos].cantidad then pos:=j;
    item := v[pos];
    v[pos]:=v[i];
    v[i]:=item;
  end;
  catemax:=v[diml].categoria;
end;

procedure imprimirvector(v:vector;diml : integer);
begin
  if diml<=dimf then begin
    writeln('Categoria :',v[diml].categoria,' - Cantidad :', v[diml].cantidad);
    imprimirvector(v,diml+1);
    end;
end;

var
  a : arbol;
  v : vector;
  codecom : integer;
  catemax : string;
begin
  randomize;
  a:=nil;
  moduloA(a,v);
  writeln('El arbol y el vector se han generado correctamente');
  writeln;
  imprimirvector(v,1);
  writeln;
  writeln('Ingrese el codigo de comida  a consultar');
  readln(codecom);
  writeln;
  writeln('El codigo de comida ',codecom,' tiene un total de ',moduloB(a,codecom),' entregas realizadas');
  writeln;
  moduloC(v,dimf,catemax);
  writeln('La categoria que mas entregas tuvo fue ',catemax);
end.
