
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
    
  regarbol3 = record
    isbn : integer;
    cantprest : integer;
    end;

  arbol3= ^nodoarbol3;
  
  nodoarbol3 = record
    dato : regarbol3;
    hi : arbol3 ;
     hd : arbol3 ;
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

procedure moduloD(a : arbol1; nrosocio : integer;var cant : integer);
begin
  if a<>nil then begin
    if a^.dato.socio = nrosocio then cant := cant + 1;
    if a^.hi <> nil then moduloD(a^.hi,nrosocio,cant);
    if a^.hd <> nil then moduloD(a^.hd,nrosocio,cant);
    end;
end;  

Procedure moduloE(a : arbol2; nrosocio: integer; var cant : integer);
begin
  if a=nil then cant:=0
  else begin 
    if a^.hi <> nil then moduloE(a^.hi,nrosocio,cant);
      while a^.dato.listadato <> nil do begin
        if a^.dato.listadato^.dato.socio = nrosocio then
          cant:=cant+1;
        a^.dato.listadato:=a^.dato.listadato^.sig;
        end;
    if a^.hd <> nil then moduloE(a^.hd,nrosocio,cant);
    end;
end;


procedure moduloF( a1 : arbol1; var a3 : arbol3);

procedure insertararbol3(var a:arbol3; codigo : integer);
begin
  if a=nil then begin
    new(a);
    a^.dato.isbn:=codigo;
    a^.dato.cantprest := 1;
    a^.hi:=nil;
    a^.hd := nil;
    end
    else if 
      codigo = a^.dato.isbn then 
      a^.dato.cantprest := a^.dato.cantprest + 1
      else if a^.dato.isbn < codigo then insertararbol3(a^.hd,codigo)
      else insertararbol3(a^.hi,codigo);
      end;


procedure generararbol(var a3 : arbol3; a1:arbol1);
begin
  if a1<>nil then begin
    generararbol(a3,a1^.hi);
    insertararbol3(a3,a1^.dato.isbn);
    generararbol(a3,a1^.hd);
    end;
end;

begin
  a3 := nil;
  generararbol(a3,a1);
  writeln('El arbol numero 3 se ha generado con exito');
end;

procedure imprimirarbol1(a : arbol1);
begin
  if a<>nil then begin
    writeln('Isbn: ',a^.dato.isbn);
    writeln('Socio: ',a^.dato.socio);
    writeln('Dia/mes: ',a^.dato.dia,'/',a^.dato.mes);
    writeln('Dias prestados: ',a^.dato.cdp);
    writeln('-----------');
    if a^.hi <> nil then imprimirarbol1(a^.hi);
    if a^.hd <> nil then imprimirarbol1(a^.hd);
    end;
end;

procedure moduloG(var a4 : arbol3; a2 : arbol2);

procedure insertararbol4(var a : arbol3;codigo : integer; cant : integer);
begin
  if a <> nil then begin
    new(a);
    a^.dato.isbn := codigo;
    a^.dato.cantprest := 1;
    a^.hi := nil;
    a^.hd:= nil;
    end
    else if a^.dato.isbn < codigo then insertararbol4(a^.hi,codigo,cant)
    else insertararbol4(a^.hd,codigo,cant);
end;

procedure generararbol4(var a4 : arbol3;a2 : arbol2);
var cant : integer; l : lista;
begin
  if a4<>nil then begin
    l:=a2^.dato.listadato;
    if a2^.hi <> nil then generararbol4(a4,a2^.hi);
    cant := 0;
    while l<> nil do begin
      cant := cant + 1;
      l := l^.sig;
      end;
    insertararbol4(a4,a2^.dato.isbn,cant);
    generararbol4(a4,a2);
    end;
end;
begin
  a4 :=nil;
  generararbol4(a4,a2);
  writeln('El arbol numero 4 se ha generado con exito');
end;




























var
  a1 : arbol1;
  a2 : arbol2;
  a3 : arbol3;
  cantd : integer;
  sociod : integer;
begin
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
  moduloD(a1,sociod,cantd);
  writeln;
  Writeln('E1 - El socio ',sociod,' tuvo un total de ',cantd,' prestamos.');
  writeln;
  cantd:=0;
  moduloE(a2,sociod,cantd);
  Writeln('E2 - El socio ',sociod,' tuvo un total de ',cantd,' prestamos.');
  writeln;
  writeln('Arbol 3');
  writeln;
  moduloF(a1,a3);
end.
