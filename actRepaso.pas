program wasa;
TYPE
	lista=^nodo;
	nodo = record
		sig:lista;
		val:integer;
	end;
procedure agregar(var l:lista; n : integer);
var nuevo, aux, ant : lista;
begin
	new(nuevo);
	nuevo^.val:=n;
	if(l=nil)then 
	begin
		nuevo^.sig:=nil;
		l:=nuevo;
	end
	else begin
		aux:=l;
		ant:=nil;
		while((aux<>nil) and (aux^.val < n)) do 
		begin
			ant:=aux;
			aux:=aux^.sig;
		end;
		if (aux = l) then
		begin
			nuevo^.sig:= l;
			l:= nuevo;
		end
		else
		begin
			ant^.sig:= nuevo;
			nuevo^.sig:= aux;
		end;
		end;
	end;
procedure CargarListaOrdenada(var l:lista; min:integer; max:integer);
var num:integer;
begin
	num := min + random(max-min+1);
	while (num<>120) do
	begin
		agregar(l, num);
		num := min + random(max-min+1);		
		writeln('Elemento agregado', num);
	end;
end;
procedure imprimirLista(l:lista);
begin
	while(l<>nil)do
	begin
		writeln(l^.val);
		l:=l^.sig;
	end;
end;
function find(l:lista; n:integer):boolean;
begin
	while((l<>nil) and (l^.val<n))do
		l:=l^.sig;
	find:=((l<>nil) and (l^.val=n));
end;
var 
	l:lista;
	n:integer;
begin
//a) Implemente un módulo CargarListaOrdenada que cree una lista de
//enteros y le agregue valores aleatorios entre el 100 y 150, hasta que se
//genere el 120. Los valores dentro de la lista deben quedar ordenados
//de menor a mayor.
	randomize;
	l:=nil;
	CargarListaOrdenada(l, 120, 150);
	imprimirLista(l);
	writeln('Ingrese el numero pa ver si está');
	readln(n);
	writeln(find(l, n));
end.
