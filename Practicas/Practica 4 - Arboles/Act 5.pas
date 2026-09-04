program act5;
{5. Una veterinaria desea procesar la información de las consultas realizadas durante el año
* De cada consulta se conoce: número de consulta, número de historia clínica de la mascota,
fecha, tipo de consulta y costo de la consulta. La lectura de las consultas finaliza cuando se
ingresa el número de consulta -1.
Implementar un programa que invoque a los siguientes módulos y compruebe el correcto
funcionamiento del mismo.
a. Un módulo que retorne la información de las historias clínicas en un árbol binario de
búsqueda ordenado por número de historia clínica. Para cada historia clínica se debe
almacenar una lista con las consultas realizadas a la mascota correspondiente.
b. Un módulo que imprima recursivamente todas las historias clínicas en orden creciente
de número.
c. Un módulo que reciba el árbol y retorne el número de historia clínica con mayor
cantidad de consultas.
d. Un módulo que reciba el árbol y un número de historia clínica. Debe retornar la
cantidad total de consultas realizadas a dicha mascota. En caso
e. Un módulo que reciba el árbol y un valor de costo. Debe retornar la cantidad de
consultas cuyo costo supera el valor recibido.
f. Un módulo que reciba el árbol y dos números de historia clínica. Debe retornar el costo
total de las consultas correspondientes a las historias clínicas comprendidas entre
ambos números, inclusive.
g. Un módulo que reciba el árbol y genere una nueva estructura ordenada por número de
historia clínica, donde cada historia aparezca una única vez junto con el costo total
acumulado de sus consultas}

type
	consulta = record
		num : integer;
		historia : integer;
		fecha : string;
		tipo : integer;
		costo : real;
	end;
	datoLista = record
		num : integer;
		fecha : string;
		tipo : integer;
		costo : real;
	end;
	lista = ^nodoL;
	nodoL = record
		sig: lista;
		dato: datoLista; 
	end;
	historia = record
		num : integer;
		l: lista;
	end;
	arbol = ^nodoA;
	nodoA = record
		HI: arbol;
		HD: arbol;
		dato: historia;
	end;
	datoNuevo = record
		num : integer;
		costo: real;
	end;
	listaNueva = ^nodoNuevo;
	nodoNuevo = record
		sig: listaNueva;
		dato: datoNuevo;
	end;
	
procedure generarArbol(var a:arbol);
	procedure agregarAdelante(var l:lista; c:consulta);
	var n:lista;
		d:datoLista;
	begin
		new(n);
		d.fecha:=c.fecha;
		d.num := c.num;
		d.costo := c.costo;
		d.tipo:= c.tipo; 
		n^.dato:=d;
		n^.sig:=l;
		l:=n;
	end;
	procedure leerConsulta(var c:consulta);
	begin
		readln(c.num);
		if(c.num <> -1) then
		begin
			readln(c.historia);
			readln(c.fecha);
			readln(c.costo);
			readln(c.tipo);
		end;
	end;
	procedure generarConsulta(var c: consulta);
	begin
		c.num:= random(30) - 1;
		if(c.num <> -1) then
		begin
			c.historia := random(30);
			c.fecha := 'xxx';
			c.tipo := random(5) + 1;
			c.costo:= random(1000) + 100;
		end;
	end;
	procedure agregarArbol(var a:arbol; c:consulta);
	begin
		writeln(c.historia);
		if(a<>nil) then
		begin
			if(a^.dato.num < c.historia) then
				agregarArbol(a^.HD, c)
			else if(a^.dato.num > c.historia) then
				agregarArbol(a^.HI, c)
				else
					agregarAdelante(a^.dato.l, c)
		end
		else
		begin
			new(a);
			a^.HI:=nil;
			a^.HD:=nil;
			a^.dato.num:=c.historia;
			a^.dato.l := nil;
			agregarAdelante(a^.dato.l, c);
		end
	end;
var c:consulta;
begin
	generarConsulta(c);
	while(c.num <> -1) do
	begin
		agregarArbol(a, c);
		generarConsulta(c);
	end;
end;
{b. Un módulo que imprima recursivamente todas las historias clínicas en orden creciente
de número.}
procedure imprimirArbol(a:arbol);
	procedure imprimirLista(l:lista);
	begin
		while(l<>nil) do
		begin
			write('| Consulta: ', l^.dato.num, '| Fecha: ', l^.dato.fecha, '| Tipo: ', l^.dato.tipo,'|Costo: ', l^.dato.costo:8:2);
			l:=l^.sig;
		end;
		writeln;
	end;
begin
	if(a<>nil) then
	begin
		imprimirArbol(a^.HI);
		writeln('Num: ', a^.dato.num);
		imprimirLista(a^.dato.l);
		imprimirArbol(a^.HD);
	end;
end;
{c. Un módulo que reciba el árbol y retorne el número de historia clínica con mayor
cantidad de consultas.}
function getCantLista(l:lista): integer;
var cant:integer;
begin
	cant:=0;
	while(l<>nil) do begin
		cant:=cant+1;
		l:=l^.sig;
	end;
	getCantLista:=cant;
end;
procedure getMaxConsultas(a:arbol; var max, maxNum : integer);
var cant: integer;
begin
	if(a<>nil) then
	begin
		cant:=getCantLista(a^.dato.l);
		if(cant > max) then
		begin
			max:= cant;
			maxNum:= a^.dato.num;
		end;
		getMaxConsultas(a^.HI, max, maxNum);
		getMaxConsultas(a^.HD, max, maxNum);
	end;
end;
{d. Un módulo que reciba el árbol y un número de historia clínica. Debe retornar la
cantidad total de consultas realizadas a dicha mascota. En caso}
function totalConsultas(a: arbol; num: integer): integer;
begin
	if(a<>nil) then
	begin
		if(a^.dato.num > num) then
			totalConsultas:= totalConsultas(a^.HI, num)
		else if(a^.dato.num < num) then
			totalConsultas:= totalConsultas(a^.HD, num)
		else
			totalConsultas := getCantLista(a^.dato.l);
	end
	else
		totalConsultas:=0;
end; 
function getMayoresQueLista(l: lista; c: real): integer;
var cant: integer;
begin
	cant:=0;
	while(l<>nil)do
	begin
		if(l^.dato.costo > c) then cant:=cant+1;
		l:=l^.sig;
	end;
	getMayoresQueLista:= cant;
end;
function mayoresQue(a: arbol; c: real): integer;
{e. Un módulo que reciba el árbol y un valor de costo. Debe retornar la cantidad de
consultas cuyo costo supera el valor recibido.}
begin
	if(a<>nil) then
	begin
		mayoresQue:= mayoresQue(a^.HI, c) + mayoresQue(a^.HD, c) + getMayoresQueLista(a^.dato.l, c); 
	end
	else
		mayoresQue:=0;
end;
{f. Un módulo que reciba el árbol y dos números de historia clínica. Debe retornar el costo
total de las consultas correspondientes a las historias clínicas comprendidas entre
ambos números, inclusive.}
function getTotal(l:lista):real;
var acum: real;
begin
	acum:=0;
	while(l<>nil) do begin
		acum:= acum + l^.dato.costo;
		l:=l^.sig;
	end;
	getTotal:=acum;
end;
function getCostoTotal(a:arbol; ini, fin: integer): real;
begin
	if(a<>nil) then
	begin
		if(a^.dato.num < ini) then
			getCostoTotal := getCostoTotal(a^.HD, ini, fin)
		else if(a^.dato.num > fin) then
			getCostoTotal := getCostoTotal(a^.HI, ini, fin)
		else
			getCostoTotal:= getCostoTotal(a^.HI, ini, fin) + getCostoTotal(a^.HD, ini, fin) + getTotal(a^.dato.l);
	end
	else
		getCostoTotal:=0;
end;
{
g. Un módulo que reciba el árbol y genere una nueva estructura ordenada por número de
historia clínica, donde cada historia aparezca una única vez junto con el costo total
acumulado de sus consultas}
procedure nuevaEstructura(a: arbol; var l:listaNueva);
	procedure agregarAdelanteNueva(var l:listaNueva; d:datoNuevo);
	var nuevo:listaNueva;
	begin
		new(nuevo);
		nuevo^.sig:=l;
		nuevo^.dato:=d;
		l:=nuevo;
	end;
var d:datoNuevo;
begin
	if(a<>nil) then begin
		nuevaEstructura(a^.HD, l);
		d.num:= a^.dato.num;
		d.costo := getTotal(a^.dato.l);
		agregarAdelanteNueva(l, d);
		nuevaEstructura(a^.HI, l);
	end;
end;
//BONUS
procedure imprimirNuevo(l:listaNueva);
begin
	while(l<>nil) do begin
		writeln('Num: ', l^.dato.num, ' con costo: ', l^.dato.costo:6:1);
		l:=l^.sig;
	end;
end;
var
	a: arbol;
	ini, fin, max, num, maxNum: integer;
	c: real;
	l: listaNueva;
begin
	a:=nil;
	//A
	generarArbol(a);
	//B
	imprimirArbol(a);
	//C
	max:=-1;
	maxNum:= -1;
	getMaxConsultas(a, max, maxNum);
	if(max<>-1) then writeln('Historia con más consultas: ',maxNum);
	//D
	writeln('Ingrese un numero de historia clinica');
	readln(num);
	writeln('Total de consultas realizadas a ', num, ': ', totalConsultas(a, num));
	//E
	writeln('Ingrese un costo de visita');
	readln(c);
	writeln('Cantidad de consultas con costo mayor a ', c:8:2, ': ', mayoresQue(a, c));
	//F
	writeln('Ingrese inicio del rango: ');
	readln(ini);
	writeln('Ingrese fin del rango: ');
	readln(fin);
	writeln('El costo total entre ', ini, ' y ', fin, ' es ', getCostoTotal(a, ini, fin):8:2);
	//G
	l:=nil;
	nuevaEstructura(a, l);
	imprimirNuevo(l);
end.
