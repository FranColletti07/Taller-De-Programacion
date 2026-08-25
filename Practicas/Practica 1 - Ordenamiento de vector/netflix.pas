program netflix;
type 
	pelicula = record
		codP : integer;
		codG : 1..8;
		puntaje : real;
	end;
	lista = ^nodo;
	nodo = record
		next : lista;
		val : pelicula;
	end;
	mejor = record
		codP : integer;
		puntaje : real;
	end;
	vector = array [1..8] of lista;
	mejores = array [1..8] of mejor;
procedure generarPelicula(var p:pelicula);
begin
	p.codP:= random(100) - 1;
	if(p.codP<>-1) then
	begin
	p.codG := random(8) + 1;
	p.puntaje := random(100) + 1;
	end;
end;
procedure leerPelicula(var p:pelicula);
begin	
	writeln('Codp:');
	readln(p.codP);
	if(p.codP<>-1) then
	begin
	writeln('Codg:');
	readln(p.codG);
	writeln('Puntaje:');
	readln(p.puntaje);
	end;
end;
procedure agregar(var l:lista; p:pelicula);
var n:lista;
begin
	new(n);
	n^.val:=p;
	n^.next:=l;
	l:=n;
end;
procedure inicializar(var v:vector);
var i:integer;
begin
	for i:=1 to 8 do
		v[i]:=nil;
end;
procedure crearEstructura(var v:vector);
var p:pelicula;
begin
	generarPelicula(p);
	while(p.codP<>-1)do
	begin
		agregar(v[p.codG], p);
		leerPelicula(p);
	end;
end;
procedure mejorPelicula(l:lista; var m:mejor);
begin
	m.puntaje := -1;
	m.codP := -1;
	while(l<>nil) do
	begin
		if(l^.val.puntaje >= m.puntaje) then
		begin
			m.puntaje := l^.val.puntaje;
			m.codP := l^.val.codP;
		end;
		l:=l^.next;
	end;
end;
procedure mejoresDelV(v:vector; var m:mejores);
var 
	i : integer;
begin
	for i:=1 to 8 do 
	begin
		mejorPelicula(v[i], m[i]);
	end;
end;
procedure sort(var m:mejores);
var 
	i, j, pos : integer;
	aux : mejor;
begin
	for i:=1 to 7 do 
	begin
		pos:=i;
		for j:=(i+1) to 8 do
		begin
			if(m[pos].puntaje > m[j].puntaje) then
				pos:=j;
			aux:=m[pos];
			m[pos]:=m[j];
			m[j]:=aux;
		end;
	end;
end;
procedure mostrarMejorYPeor(v:mejores);
begin
	writeln('Peor: ', v[8].codP);
	writeln('Mejor:', v[1].codP);
end;
var
	v:vector;
	m:mejores;
begin
	inicializar(v);
	crearEstructura(v);
	mejoresDelV(v, m);
	sort(m);
	mostrarMejorYPeor(m);
end.
	
