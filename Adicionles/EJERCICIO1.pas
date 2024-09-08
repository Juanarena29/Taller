Program p5e1;
const
  dimf=300;
type
  indice =0..300;
  oficina = record
    codigo : integer;
    dni : integer;
    valor : real;
    end;

  vector = array[1..dimf] of oficina;
  
procedure moduloA(var v : vector; var diml : integer);

  procedure leeroficina(var o : oficina);
 
  begin
    o.codigo:=random(300);
    if o.codigo <> 0 then begin
      o.dni:=random(1000)+1;
      o.valor:=random(300)+200;
    end;
  end;
  
  procedure cargarvector(var v : vector; var  diml : integer; o : oficina);
  begin
    if diml < dimf then begin
      diml := diml + 1;
      v[diml]:=o;
      end;
  end;
  
  var
  o : oficina;
begin
  
  leeroficina(o);
  while o.codigo <> 0 do begin
    cargarvector(v,diml,o);
    leeroficina(o);
    end;
  
end;

procedure moduloB(var v:vector; diml : integer);
var 
  j,i,p : integer;
  item : oficina;
begin
  for i:=1 to diml-1 do begin
    p:=i;
    for j:=i+1 to diml do
      if v[j].codigo < v[p].codigo then p:=j;
    item:=v[p];
    v[p]:=v[i];
    v[i]:=item;
    end;
end;


procedure moduloC(v : vector; ini, fin: integer; valor : integer; var pos : integer);
  var
     mid : integer;
begin
  if ini>fin then begin
    pos:= 0;
    writeln(pos);
    end
    else begin
      mid := (ini+fin) DIV 2;
      if v[mid].codigo = valor then begin
        pos := mid;
        end
        else if valor < v[mid].codigo then
          moduloC(v,ini,mid-1,valor,pos)
          else
            moduloC(v,mid+1,fin,valor,pos);
      end;
end;

function moduloD(v:vector;diml : integer):real;
begin
  if diml = 0 then moduloD:=0
  else
     moduloD:= v[diml].valor + moduloD(v,diml-1);
end;

procedure imprimirvector(v : vector;diml : integer);
begin
  if diml <> 0 then begin
     writeln('-------');
    writeln('Codigo : ',v[diml].codigo);
    writeln('DNI :', v[diml].dni);
    writeln('Valor : ',v[diml].valor:2:0);
    imprimirvector(v,diml-1);
    end;
end;




var 
  diml : integer;
  v : vector;
  valor : integer;
  pos : integer;
  
  ini : integer;
begin
  randomize;
  diml :=0;
  moduloA(v,diml);
  writeln('Vector creado ');
  writeln;
  writeln('--------');
  writeln;
  moduloB(v,diml);
  writeln('Vector Ordenado');
  imprimirvector(v,diml);
  writeln;
  writeln('Escriba un codigo de identificacion: ');readln(valor); ini:=1;
  moduloC(v,ini,diml,valor,pos);
  if pos = 0 then writeln('No se encontrop la oficina')
  else writeln('El propietario de la oficina ',valor,' es - DNI : ',v[pos].dni);
  writeln;
  writeln('El monto total de las expensas es: ',moduloD(v,diml):2:2);
end.
