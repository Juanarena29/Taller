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

  datolista = record
    isbn : integer;
    dato : lista;
    end;

  lista=^nodolista;

  nodolista = record
    dato : reglista;
    sig : lista;
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

Procedure moduloA(var a1 : arbol1; var a2 : arbol2);

  Procedure cargardatos(var pl : reglista;var p : prestamos);
  begin
    p.prestamo := random(100)*100;
    if p.prestamo <> 0 then begin
      p.socio := random(10000);
      p.dia := random(31)+1;
      p.mes := random (12)+1;
      p.cdp := random(20)+1;
      end;
    pl.socio := p.socio;
    pl.dia := p.dia;
    pl.mes := p.mes;
    pl.cdp := p.cdp;
  end;

  Procedure insertararbol1(var a : arbol; p : prestamos);
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

  Procedure insertararbol2(var a: arbol; code : integer; pl : reglista);

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
      a^.dato.lista:=nil;
      a^.dato.isbn:=code;
      a^.hi:=nil;
      a^.hd:=nil;
      agregaradelante(a^.dato.lista,pl);
      end
      else if code=a^.dato.isbn then
        agregaradelante(a^.dato.lista,pl)
        else if code > a^.dato.isbn then
          insertararbol2(a^.hd,code,pl)
          else insertararbol2(a^.hi,code,pl);
    end;


  end;
