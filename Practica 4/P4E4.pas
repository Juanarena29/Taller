Program P4E4;
  type
 
  prestamos = record
    isbn : integer;
    socio: integer;
    dia : 1..31;
    mes : 1..12;
    cdp : integer;
    end;

  reglista = record
    socio: integer;
    dia : 1..31;
    mes : 1..12;
    cdp : integer;
    end;

  lista=^nodolista;

  nodolista = record
    dato : reglista;
    sig : lista;
    end;

  datolista = record
    isbn : integer;
    listadato: lista;
    end;

  arbol1 = ^nodoarbol1;

  nodoarbol1 = record
    dato :prestamos;
    hi : arbol1;
    hd : arbol1;
    end;
    
  arbol2 = ^nodoarbol2;

  nodoarbol2 = record
    dato: datolista;
    hi : arbol2;
    hd : arbol2;
    end;
    
  reglista3 = record
    isbn : integer;
    cantprest : integer;
    end;

  lista3= ^nodolista3;
  
  nodolista3 = record
    dato : reglista3;
    sig : lista3;
     end;

Procedure moduloA(var a1 : arbol1; var a2 : arbol2);

  Procedure cargardatos(var pl : reglista;var p : prestamos);
  begin
    p.isbn := random(20)*100;
    if p.isbn <> 0 then begin
      p.socio := random(30)+1;
      p.dia := random(31)+1;
      p.mes := random (12)+1;
      p.cdp := random(20)+1;
      end;
    pl.socio := p.socio;
    pl.dia := p.dia;
    pl.mes := p.mes;
    pl.cdp := p.cdp;
  end;

  Procedure insertararbol1(var a : arbol1; p : prestamos);
  begin
    if a=nil then begin
      new(a);
      a^.dato:=p;
      a^.hi:=nil;
      a^.hd:=nil;
      end
      else if p.isbn >= a^.dato.isbn then insertararbol1(a^.hd,p)
      else insertararbol1(a^.hi,p);
  end;

  Procedure insertararbol2(var a: arbol2; code : integer; pl : reglista);

    Procedure agregaradelante(var l : lista; dato : reglista);
    var aux : lista;
    begin
      new(aux);
      aux^.dato:=dato;
      aux^.sig:=l;
      l:=aux;
    end;

  begin
    if a = nil then begin
      new(a);
      a^.dato.listadato:=nil;
      a^.dato.isbn:=code;
      a^.hi:=nil;
      a^.hd:=nil;
      agregaradelante(a^.dato.listadato,pl);
      end
      else if code=a^.dato.isbn then
        agregaradelante(a^.dato.listadato,pl)
        else if code > a^.dato.isbn then
          insertararbol2(a^.hd,code,pl)
          else insertararbol2(a^.hi,code,pl);
    end;
  

var
  pl : reglista;
  p : prestamos;
begin
  a1:=nil;
  a2:=nil;
  cargardatos(pl,p);
  while p.isbn <> 0 do begin
    insertararbol1(a1,p);
    insertararbol2(a2,p.isbn,pl);
    cargardatos(pl,p);
    end;
end;


function moduloB(a : arbol1): integer;
begin
  if a = nil then moduloB:=-9999
  else begin
    moduloB:=a^.dato.isbn;
    if a^.hd<>nil then moduloB:=moduloB(a^.hd);
  end;
end;

function moduloC(a : arbol2): integer;
begin 
  if a= nil then moduloC:=9999
  else begin
    moduloC:=a^.dato.isbn;
    if a^.hi <> nil then moduloC:=moduloC(a^.hi);
    end;
end;

function moduloD(a : arbol1; nrosocio : integer):integer;
begin
  if a=nil then moduloD:=0
  else
   if a^.dato.socio = nrosocio then 
    moduloD:= 1+ moduloD(a^.hd,nrosocio) + moduloD(a^.hi,nrosocio)
      else moduloD:=moduloD(a^.hd,nrosocio) + moduloD(a^.hi,nrosocio);
    end;
  

function moduloE(a : arbol2; nrosocio: integer):integer;

function recorrerlista(l : lista;nrosocio : integer):integer;
begin
  if l = nil then recorrerlista:=0
  else if l^.dato.socio = nrosocio then
    recorrerlista := 1 + recorrerlista(l^.sig,nrosocio)
    else recorrerlista:= recorrerlista(l^.sig,nrosocio);
end;

var cant : integer;
begin
  if a=nil then moduloE:=0
  else begin 
    cant:=recorrerlista(a^.dato.listadato,nrosocio);
    moduloE:= cant + moduloE(a^.hi,nrosocio) + moduloE(a^.hd,nrosocio);
    end;
end;


procedure moduloF( a1 : arbol1; var l: lista3);

procedure agregaradelante(var l : lista3; r : reglista3);
var aux : lista3;
begin
    new(aux);
    aux^.dato:=r;
    aux^.sig:=l;
    l:=aux;
end;

var 
  re : reglista3;

begin
  if a1 <>nil then begin
  if a1^.hd <> nil then moduloF(a1^.hd,l);
  re.isbn:=a1^.dato.isbn;
  re.cantprest:=1;
  if (l<>nil) and (l^.dato.isbn = re.isbn) then
     l^.dato.cantprest := l^.dato.cantprest + 1
    else
    agregaradelante(l,re);
  
  if a1^.hi <> nil then moduloF(a1^.hi,l);
  end;
end;

function recorrerlis3(l : lista): integer;
begin
  if l = nil then recorrerlis3 := 0
  else recorrerlis3:= 1 + recorrerlis3(l^.sig);
end;

procedure moduloG(a2 : arbol2;var ll : lista3);

procedure agregarade2(var ll : lista3; r: reglista3);
var aux : lista3;
begin
    new(aux);
    aux^.dato:=r;
    aux^.sig:=ll;
    ll:=aux;
end;

var re:reglista3;
begin
  if a2^.hd <> nil then moduloG(a2^.hd,ll);
  re.isbn := a2^.dato.isbn;
  re.cantprest:=recorrerlis3(a2^.dato.listadato);
  agregarade2(ll,re);
  if a2^.hi <> nil then moduloG(a2^.hi,ll);
end;

procedure moduloH(ll : lista3);
begin
    if ll <> nil then begin
    Writeln('Codigo: ',ll^.dato.isbn);
    writeln('Prestamos: ',ll^.dato.cantprest);
    moduloH(ll^.sig);
  end;
end;

function moduloI(a : arbol1; izq,der : integer):integer;
begin
  if a=nil then moduloI:=0
  else 
    if (a^.dato.isbn >= izq) then 
      if a^.dato.isbn <= der then
        moduloI:= 1 + moduloI(a^.hi,izq,der)+moduloI(a^.hd,izq,der)
        else moduloI:=moduloI(a^.hi,izq,der)
   else moduloI:=moduloI(a^.hd,izq,der);
end;

function moduloJ(a2 : arbol2; izq,der : integer): integer;

begin
	if a2 = nil then moduloJ :=0
		else 
        if a2^.dato.isbn >= izq then
          if a2^.dato.isbn <= der then
            moduloJ:= recorrerlis3(a2^.dato.listadato) + moduloJ(a2^.hi,izq,der) + moduloJ(a2^.hd,izq,der)
            else moduloJ := moduloJ(a2^.hi,izq,der)
          else moduloJ:= moduloJ(a2^.hd,izq,der)         
end;          

procedure imprimirarbol1(a : arbol1);
begin
  if a<>nil then begin
  if a^.hi <> nil then imprimirarbol1(a^.hi);
    writeln('Isbn: ',a^.dato.isbn);
    writeln('Socio: ',a^.dato.socio);
    writeln('Dia/mes: ',a^.dato.dia,'/',a^.dato.mes);
    writeln('Dias prestados: ',a^.dato.cdp);
    writeln('-----------');
    if a^.hd <> nil then imprimirarbol1(a^.hd);
    end;
end;

var
  a1 : arbol1;
  a2 : arbol2;
  l,ll : lista3;
  cantd, min,max : integer;
  sociod : integer;
begin
  l := nil;
  ll:=nil;
  randomize;
  moduloA(a1,a2);
  imprimirarbol1(a1);
  writeln;
  writeln;
  writeln('De la estructura 1, el ISBN mas grande es: ',moduloB(a1));
  writeln;
  writeln('De la estructura 2, el ISBN mas pequenio es: ',moduloC(a2));
  cantd:=0;
  Writeln;
  writeln('Escriba el numero de socio que desea consultar: ');readln(sociod);
  cantd:=moduloD(a1,sociod);
  writeln;
  Writeln('E1 - El socio ',sociod,' tuvo un total de ',cantd,' prestamos.');
  writeln;
  cantd:=0;
  cantd:=moduloE(a2,sociod);
  Writeln('E2 - El socio ',sociod,' tuvo un total de ',cantd,' prestamos.');
  writeln;
  writeln('Lista 1:');
  writeln;
  moduloF(a1,l);
  writeln('f');
  writeln;
  moduloG(a2,ll);
  writeln;
  moduloH(ll);
  writeln('Escriba dos numeros dentro del rango [100,1900]');
  writeln('Min: ');readln(min);
  writeln;
  writeln('Max: ');readln(max);
  writeln;
  writeln('E1 --> La cantidad de prestamos dentro del rango especificado es: ', moduloI(a1,min,max));
  writeln;
  writeln('E2 --> La cantidad de prestamos dentro del rango especificado es: ', moduloJ(a2,min,max));
end.
