program tres;
const
  dimf = 20;
  min = 300;
  max = 1550;
type
  vector = array [1..dimf] of integer;
  
procedure cargarvector ( var v : vector;var diml : integer);
var num : integer;
begin
  if diml<dimf then begin
    num:=random(max-min+1)+min;
    diml:=diml+1;
    v[diml]:=num;
    cargarvector(v,diml);
    end;
end;

procedure ordenarvector ( var v : vector; diml : integer);
var pos, i, j, item : integer;
begin
   for i:=1 to (diml-1) do begin {busca el mínimo y guarda en pos la posición}
      pos := i;
      for j := i+1 to diml do
          if v[ j ] < v[ pos ] then pos:=j;
      item := v[ pos ];   
      v[ pos ] := v[ i ];   
      v[ i ] := item;
   end;
end; 

{function buscardicotomica( v : vector; pri, ult, valor : integer): boolean;
var
  mid : integer;
begin
  if pri > ult then
    buscardicotomica:=false
      else begin
        mid := (pri+ult) div 2;
        if v[mid]=valor then
          buscardicotomica:=true
          else if v[mid]>valor then
            buscardicotomica:=buscardicotomica(v,pri,mid-1,valor)
            else buscardicotomica:=buscardicotomica(v,mid + 1,pri,valor);
          end;
end;}
procedure ImprimirVectorRecursivo(v: vector; diml: integer);
begin
  if diml > 0 then
  begin
    writeln('Posicion: ', diml, '  ', v[diml]);
    ImprimirVectorRecursivo(v, diml - 1);
  end;
end;
procedure busquedadicotomica(v : vector; ini, fin, valor : integer; var pos : integer);
var mid : integer;
begin
  if ini > fin then begin
    pos := -1  ;
    writeln(pos);
    end
  else
  begin
    mid := (ini + fin) div 2;  
    if v[mid] = valor then begin
      pos := mid  ;
      writeln(pos);
      end
    else if v[mid] < valor then
      busquedadicotomica(v, mid + 1, fin, valor, pos) 
    else
      busquedadicotomica(v, ini, mid - 1, valor, pos);  
  end;
  
end;

var
 v: vector;
 pos : integer;
 valor : integer;
 diml : integer;
begin

randomize;
cargarvector(v,diml);
ImprimirVectorRecursivo(v,diml);
writeln('------- VECTOR -------');
ordenarvector(v,diml);
writeln('------- VECTOR ORDENADO -------');
ImprimirVectorRecursivo(v,diml);
writeln;
writeln;
writeln('Escriba un valor a buscar:  ');writeln;writeln;;readln(valor);
writeln;writeln('-1 si no se encuentra, posicion en el vector si se encuentra');
writeln;
busquedadicotomica(v,1,diml,valor,pos);
end.
