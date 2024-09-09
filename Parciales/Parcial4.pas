Program pcorreo;

type
  dias = 1..31;

  envio = record
    cliente : integer;
    dia : dias;
    cp : integer;
    peso : real;
  end;

  reglista = record
    cliente : integer;
    dia : dias;
    peso : real;
  end; 

  lista = ^nodolista;

  nodolista = record 
    dato : reglista;
    sig : lista;
  end;

  regarbol = record
    cp : integer;
    envio : lista;
  end;
  
  arbol = ^nodoarbol;

  nodoarbol = record 
    dato : regarbol;
    hi : arbol;
    hd : arbol;
  end;

procedure agregaradelante(var l : lista; r : reglista);
var 
  aux : lista;
begin
  new(aux);
  aux^.dato := r;
  aux^.sig := l;
  l := aux;
end;

procedure moduloA(var a : arbol);

  procedure leerenvio(var e : envio);
  begin
    e.cliente := random(500);
    if e.cliente <> 0 then
    begin
      e.cp := random(30);
      e.dia := random(31) + 1;
      e.peso := (random(100) + 1) / 10;
    end;
  end;
  
  procedure insertararbol(var a : arbol; e : envio);
  var
    r : reglista;
  begin
    if a = nil then
    begin
      new(a);
      a^.dato.cp := e.cp;
      a^.dato.envio := nil;
      a^.hi := nil;
      a^.hd := nil;
      r.cliente := e.cliente;
      r.dia := e.dia;
      r.peso := e.peso;
      agregaradelante(a^.dato.envio, r);
    end
    else if a^.dato.cp = e.cp then
    begin
      r.cliente := e.cliente;
      r.dia := e.dia;
      r.peso := e.peso;
      agregaradelante(a^.dato.envio, r);
    end
    else if e.cp < a^.dato.cp then
      insertararbol(a^.hi, e)
    else
      insertararbol(a^.hd, e);
  end;

var
  e : envio;
begin
  a := nil;
  leerenvio(e);
  while e.cliente <> 0 do
  begin
    insertararbol(a, e);
    leerenvio(e);
  end;
end;

procedure moduloB(a : arbol; cp : integer; var l : lista);
begin
  if a <> nil then
  begin
    if a^.dato.cp = cp then
      l := a^.dato.envio
    else if cp < a^.dato.cp then
      moduloB(a^.hi, cp, l)
    else
      moduloB(a^.hd, cp, l);
  end;
end;

procedure moduloC(l : lista; var codemax, codemin: integer; var pesomax, pesomin: real);
begin
  if l <> nil then
  begin
    if l^.dato.peso > pesomax then
    begin
      pesomax := l^.dato.peso;
      codemax := l^.dato.cliente;
    end;
    if l^.dato.peso < pesomin then
    begin
      pesomin := l^.dato.peso;
      codemin := l^.dato.cliente;
    end;
    moduloC(l^.sig, codemax, codemin, pesomax, pesomin);
  end;
end;

var
  l : lista;
  a : arbol;
  cp, codemax, codemin : integer;
  pesomax, pesomin : real;
begin
  randomize;
  l := nil;
  moduloA(a);
  writeln('El arbol se ha generado correctamente');
  writeln;
  writeln('Ingrese el codigo postal a consultar: ');
  readln(cp);
  moduloB(a, cp, l);
  writeln;
  if l <> nil then
  begin
    writeln('La lista del codigo postal ', cp, ' fue generada');
    writeln;
    pesomax := -1;
    pesomin := 11;
    moduloC(l, codemax, codemin, pesomax, pesomin);
    writeln;
    writeln('El envio con mayor peso corresponde al cliente ', codemax);
    writeln('El envio con menor peso corresponde al cliente ', codemin);
  end
  else
    writeln('No existen envios asociados al codigo postal ingresado');
end.
