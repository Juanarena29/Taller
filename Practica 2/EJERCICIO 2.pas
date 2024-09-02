program dos;
const
  min = 100;
  max = 150;
  
type
  rango1=min..max;
  lista = ^nodo;
  nodo = record
    dato : integer;
    sig : lista;
    end;

  
  
procedure iniciarlista(var l : lista);
begin 
  l:= nil;
end;

procedure cargarlista(var l : lista);

  procedure agregaratras(var l : lista; num : integer);
  var nue, ult : lista;
  begin
    new(nue);
    nue^.dato:=num;
    nue^.sig:=nil;
    if l = nil then 
      l:=nue
      else begin
        ult:=l;
        while (ult^.sig <> nil) do
          ult := ult^.sig;
        ult^.sig:=nue;
        end;
  end;
  
var num : integer;

begin
  num:=random(max-min+1)+min;
  if num <> 100 then begin
    agregaratras(l,num);
    cargarlista(l);
    end;
end;

procedure imprimirlista(l : lista);
begin
  if l<>nil then begin
    writeln('NRO: ', l^.dato);
    imprimirlista(l^.sig);
    end;
end;

procedure imprimirrecursivoinverso(l : lista);
begin
  if l<>nil then
    begin
      imprimirrecursivoinverso(l^.sig); 
      writeln(l^.dato);
      end;
end;
    
 

function buscarminimo ( l : lista): integer;
var min : integer;
begin
  if l=nil then
   min:=9999
    else begin
      min:=buscarminimo(l^.sig);
      if l^.dato<min then min:= l^.dato;
      end;
   buscarminimo:=min;
end; 
      



function buscarvalor( l : lista; valor : integer): boolean;
begin
  if l=nil then
    buscarvalor:=false
    else
      if l^.dato=valor then buscarvalor:=true
        else buscarvalor:=buscarvalor(l^.sig,valor);
end;
var
 l : lista;

 valor : rango1;

begin
randomize;
iniciarlista(l);
cargarlista(l);
writeln;
writeln('---------------IMPRIMIR LISTA---------------');
imprimirlista(l);
writeln;
writeln('---------------IMPRIMIR LISTA INVERSO---------------');
imprimirrecursivoinverso(l);
writeln;
writeln;

writeln('VALOR MINIMO DE LA LISTA:  ',buscarminimo(l));
writeln;
writeln;
writeln('Escriba un numero entre 100 y 150: ');
readln(valor);

writeln;
writeln;
if buscarvalor(l,valor) then writeln('El numero se encuentra en la lista')
else writeln('El numero no se encuentra en la lista');
end.
