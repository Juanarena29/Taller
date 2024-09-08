Program adi2;
type

stringe = string[1..20];

  auto = record
    patente : integer;
    año : 2010..2018;
    marca = stringe;
    modelo : integer;
    end;
    
  arbol1 = ^nodoarbol;
  
  nodoarbol = record
    dato : auto;
    hi : arbol1;
    hd : arbol1;
    end; 
  
  reglista = record
    patente : integer;
    modelo : integer;
    año : 2010..2018;
    end;

  liste = ^nodo;,
  
  nodo = record
    dato : reglista;
    sig : liste;
    end;
    
   reg2 = record 
     marca : stringe;
     lista : liste;
   
   arbol2 = ^nodoarbol2;
   
   nodoarbol2 = record 
     dato : reg2;
     hi:arbol2;
     hd:arbol2;
     end;
     
Procedure moduloA(var a1 : arbol1; var a2 : arbol2);

  procedure leerinfo(var d : auto);
    var vm : array[1..6] of string = ('A','B','C','D','E','MMM');
  begin
    d.marca:=vm[random(6)+1];
    if d.marca <> 'MMM' then begin
      d.patente := random(8000);
      d.modelo := random(10)+1;
      d.año := random(9)+2010;
      end;
  end;

  procedure genarbol1(var a1 : arbol1; d : auto);
  begin
    if a1 = nil then
      new(a1);
      a1^.dato:=d;
      a1^.hi:=nil;
      a1^.hd := nil;
      end
      else if a1^.dato.patente > d.patente then 
        genarbol1(a1^.hi,d)
        else 
          genarbol1(a1^.hd,d);
  end;
  
  procedure agregaradelante(var l : liste; rl : reglista);
  var au

  procedure genarbol2(var a2 : arbol2; d: auto;var rl : reglista);
  begin
    rl.patente := d.patente;
    rl.año := d.año;
    rl.modelo := d.modelo;
    if a2 = nil then
      new(a2);
      a2^.dato.marca := d.marca;
      a2^.dato.lista := nil;
      a2^.hi := nil;
      a2^.hd := nil;
      agregaradelante(l,rl);


  end;







var
  d : auto;
  rl : reglista;
begin
  a1 := nil
  leerinfo(d);
  while d.marca <> 'MMM' do begin
    genarbol1(a1,d);
    genarbol2(a2,d,rl)

    leerinfo(d);
    end;
