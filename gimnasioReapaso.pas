program gym;
//Un gimnasio necesita procesar las asistencias de sus clientes. Cada asistencia
//tiene día, mes, año, número de cliente (entre 1 y 500) y la actividad realizada
//(valor entre 1 y 5).
type 
	asistencia = record
		dia : 1..31;
		mes: 1..12;
		anio: 2000..2026;
		num : 1..500;
		act : 1..5;
	end;
	lista = ^nodo;
	nodo = record
		sig : lista;
		val : asistencia;
	end;
	contador = array [1..5] of integer;
procedure insertarOrdenado(var l:lista; a:asistencia);
var 
	nuevo, act, ant:lista;
begin
	new(nuevo);
	nuevo^.val:=a;
	if(l=nil)then
	begin
		nuevo^.sig:=nil;
		l:=nuevo;
	end
	else
	begin
		act:=l;
		ant:=l;
		while((act<>nil) and (act^.val.num < a.num)) do
		begin
			ant:=act;
			act:=act^.sig;
		end;
		if(act=l)then
			l:=nuevo
		else 
			ant^.sig:=nuevo;
		nuevo^.sig:=act;
	end;
end;
procedure crearAsistencia(var a:asistencia; num:integer);
begin
	a.dia:= 1 + random(31);
	a.mes:= 1 + random(12);
	a.anio:= 2000 + random(26 + 1);
	a.num:= num;
	a.act:= 1 + random(5);
end;
procedure crearLista(var l:lista);
var a:asistencia;num:integer;
begin
//a) Implemente un módulo que retorne una lista de asistencias de clientes un
//gimnasio. Las asistencias dentro de la lista deben quedar ordenadas de menor
//a mayor por número de cliente. Generar aleatoriamente los valores hasta
//generar un valor cero para el número de cliente.
	num := random(20);
	crearAsistencia(a, num);
	while(num<>0)do 
	begin
		insertarOrdenado(l, a);
		num := random(20);
		crearAsistencia(a, num);
	end;
end;
procedure imprimirAsistencia(a:asistencia);
begin
	writeln(a.dia);
	writeln(a.mes);
	writeln(a.anio);
	writeln('Num:',a.num);
	writeln('Act',a.act);
end;
procedure imprimirLista(l:lista); 
begin
	//b) Implemente un módulo que reciba la lista generada en a) e imprima todos
	//los valores de la lista en el mismo orden que están almacenados.
	while(l<>nil)do
	begin
		imprimirAsistencia(l^.val);
		l:=l^.sig;
	end;
end;
function cantAsistencia(l:lista; num: integer): integer;
var cant:integer;
begin
//c) Implemente un módulo que reciba la lista generada en a) y un número de
//cliente y retorne la cantidad de asistencias del cliente recibido. Mostrar el
//resultado desde el programa principal.
	cant:=0;
	while((l<>nil) and (l^.val.num <= num))do
	begin
		if(l^.val.num = num)then cant:=cant+1;
		l:=l^.sig;
	end;
	cantAsistencia:=cant;
end;
procedure inicializarContador(var v : contador);
begin
	v[1]:=0;
	v[2]:=0;
	v[3]:=0;
	v[4]:=0;
	v[5]:=0;
end;
function mayorAsistencia(l:lista) : integer;
var
	i, max, maxIndex:integer;
	v: contador;
begin
//d) Implemente un módulo que reciba la lista generada en a) y retorne la
//actividad con mayor cantidad de asistencias. Mostrar el resultado desde el
//programa principal.
	inicializarContador(v);
	while(l<>nil) do 
	begin
		v[l^.val.act] := v[l^.val.act] + 1;
		l:=l^.sig;
	end;
	max:=0;
	for i:=1 to 5 do
	begin
		writeln('Actividad N°', i, ':',v[i]);
		if(v[i]>=max)then 
		begin
			max:=v[i];
			maxIndex:=i;
		end;
	end;
	mayorAsistencia := maxIndex;
end;
var
	l:lista;
begin
	randomize;
	crearLista(l);
	imprimirLista(l);
	writeln('Cant asistencia de 1:', cantAsistencia(l, 1));
	writeln('Act mas frecuente: ', mayorAsistencia(l));
end.
