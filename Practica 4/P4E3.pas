Program P4E3;
type

  producto = record
    codigo : integer;
    univendidas : integer;
    montototal : real;
    end;
 
  venta = record
    codigoventa : integer;
    codeproducto : integer;
    cantunidades : integer;
    preciouni : real;
    end;
    
  arbol = ^nodoarbol;
  
  nodoarbol = record
    dato : producto;
    hi : arbol;
    hd : arbol;
    end;
    
procedure generararbol(var a : arbol);

  procedure cargarventa(var v : venta);
  begin
    v.codigoventa:=random(101)-1;
    if v.codigoventa <> -1 then begin
      v.codeproducto := random(50);
      v.cantunidades := random(20);
      v.preciouni := random(100)/10;
    end;
  end;

  procedure generarproducto(var p : producto; v : venta);
  begin
    p.codigo:=v.codeproducto;
    p.univendidas:=v.cantunidades;
    p.montototal:=(v.cantunidades * v.preciouni);
  end;
  
  procedure insertarelemento(var a: arbol; p : producto);
  begin
  if a = nil then begin
    new(a);
    a^.dato:=p;
    a^.hi:=nil;
    a^.hd:=nil;
    end
    else if a^.dato.codigo = p.codigo then
      begin
        a^.dato.univendidas:= a^.dato.univendidas + p.univendidas;
        a^.dato.montototal := a^.dato.montototal + p.montototal;
      end
      else if a^.dato.codigo > p.codigo then insertarelemento(a^.hd,p)
      else insertarelemento(a^.hi,p);
  end;

var
 unaventa : venta;
 p : producto;
begin
  writeln('CARGAR LISTA');
  a:=nil;
  cargarventa(unaventa);
  while unaventa.codigoventa<>-1 do begin
    generarproducto(p,unaventa);
    insertarelemento(a,p);
    cargarventa(unaventa);
    end;
  writeln;
  writeln('LISTA CARGADA');
end;

procedure imprimirarbol ( a : arbol; var codemayor, cantmayor : integer );
begin
  if a<>nil then begin
    if a^.hi<>nil then imprimirarbol(a^.hi,codemayor,cantmayor);
    writeln('----------');
    writeln('Codigo: ',a^.dato.codigo);
    writeln('Unidades vendidas: ',a^.dato.univendidas);
    writeln('Monto total: $',(a^.dato.montototal):2:0);
    if a^.dato.univendidas>cantmayor then begin
      codemayor := a^.dato.codigo;
      cantmayor := a^.dato.univendidas;
      end;
    if a^.hd <> nil then imprimirarbol(a^.hd,codemayor,cantmayor);
  end;
end;

function menoresque(a : arbol; valor : integer): integer; //arreglar,devuelve 0
begin
  if a=nil then menoresque:=0 
  else begin
    if a^.dato.codigo < valor then
      menoresque:=menoresque(a^.hi,valor)+1+menoresque(a^.hd,valor)
      else
        menoresque:=menoresque(a^.hi,valor);
    end;
end;

function entrerango(a:arbol; izq,der : integer): integer;
begin
  if a= nil then entrerango:=0
  else begin
    if (a^.dato.codigo>izq) and (a^.dato.codigo>der) then
      entrerango:=entrerango(a^.hi,izq,der)+1+entrerango(a^.hd,izq,der)
      else
        if (a^.dato.codigo>izq) then
          entrerango:=entrerango(a^.hi,izq,der)
          else if (a^.dato.codigo<der) then
            entrerango:=entrerango(a^.hd,izq,der);
    end;
end;
var
  a : arbol;
  cantmay : integer;
  codemax : integer;
  valor : integer;
  valinferior:integer;
  valsuperior: integer;
begin
  cantmay:=-1;
  generararbol(a);
  writeln('1');
  imprimirarbol(a,codemax,cantmay);
  writeln('-----------');
  writeln('El producto con mas unidades vendidas es: ',codemax);
  writeln;
  writeln('Escriba un valor entero: ');readln(valor);
  writeln;
  writeln('La cantidad de productos con codigos menores a ',valor,' es : ',menoresque(a,valor));
  writeln;
  writeln('Escriba dos valores enteros para el rango: ');
  writeln('Valor inferior: ');readln(valinferior);
   writeln('Valor superior: ');readln(valsuperior);
   writeln;
   writeln('La cantidad de productos cuyo codigo se encuentra dentro del rango son: ',entrerango(a,valinferior,valsuperior));
   
end.
