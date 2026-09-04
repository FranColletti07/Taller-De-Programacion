program Act4;
{
Una empresa de alquiler de bicicletas desea procesar la información de los alquileres 
realizados durante un mes. De cada alquiler se conoce: código de bicicleta, número de 
cliente, día del alquiler, cantidad de horas alquiladas e importe abonado. La lectura de los 
alquileres finaliza cuando se ingresa el código de bicicleta 0. 
Implementar un programa que invoque a los siguientes módulos y  compruebe el correcto 
funcionamiento del mismo. 
a. Un módulo que lea los alquileres y genere dos estructuras de datos, ambas eficientes 
para la búsqueda por código de bicicleta: 
i. En la primera estructura, cada alquiler debe almacenarse en un nodo diferente del 
árbol. Si se ingresa nuevamente un alquiler para una bicicleta cuyo código ya se 
encuentra en el árbol, el nuevo alquiler deberá insertarse a la derecha. 
ii. En la segunda estructura, cada nodo debe contener un código de bicicleta una sola 
vez y una lista con todos los alquileres realizados para dicha bicicleta. 
Nota: Prestar especial atención a los datos que se almacenan en cada estructura para 
evitar repetir información innecesariamente. }
Type
	alquiler = record
		cod : integer;
		num: integer;
		dia: 1..31;
		horas: integer;
		importe: real;
	end;
	alquilerL = record 
		num: integer;
		dia: 1..31;
		horas: integer;
		importe: real;
	end;
	lista = ^nodoL;
	nodoL = record
		sig: lista;
		dato: alquilerL;
	end;
	bicicleta = record
		cod: integer;
		l: lista;
	end;
	arbolA = ^nodoA;
	nodoA = record
		HI: arbolA;
		HD: arbolA;
		dato: alquiler;
	end;
	arbolB = ^nodoB;
	nodoB = record
		HI: arbolB;
		HD: arbolB;
		dato: bicicleta;
	end;
	datoHoras = record
		cod : integer;
		horas: integer;
	end;
	listaHoras = ^nodoHoras;
	nodoHoras = record
		sig : listaHoras;
		dato: datoHoras;
	end;
	arbolC = ^nodoC;
	nodoC = record
		HI: arbolC;
		HD: arbolC;
		dato: datoHoras;
	end;
procedure moduloA(var aA: arbolA; var aB: arbolB);
	procedure generarAlquiler(var a: alquiler);
	begin
		a.cod:= random(100);
		a.num:= random(10) + 1;
		a.dia:= random(30) + 1;
		a.horas:= random(24) + 1;
		a.importe:= random(1000) + 100;
	end;
	procedure leerAlquiler(var a: alquiler);
	begin
		readln(a.cod);
		readln(a.num);
		readln(a.dia);
		readln(a.horas);
		readln(a.importe);
	end;
	procedure insertarArbolA(var a: arbolA; alq:alquiler);
	begin
		if(a<>nil) then
		begin
			if(a^.dato.cod <= alq.cod) then
				insertarArbolA(a^.HD, alq)
			else
				insertarArbolA(a^.HI, alq)
		end
		else 
		begin
			new(a);
			a^.dato:= alq;
			a^.HD:=nil;
			a^.HI:=nil;
		end
	end;
	procedure agregarAdelante(var l: lista; a: alquiler);
	var n: lista;
	begin
		new(n);
		n^.sig := l;
		n^.dato.num := a.num;
		n^.dato.dia := a.dia;
		n^.dato.importe := a.importe;
		n^.dato.horas := a.horas;
		l:= n; 
	end;
	procedure insertarArbolB(var a: arbolB; alq: alquiler);
	begin
		if(a<>nil) then
		begin
			if(a^.dato.cod < alq.cod) then
				insertarArbolB(a^.HD, alq)
			else if(a^.dato.cod > alq.cod) then
				insertarArbolB(a^.HI, alq)
			else
				agregarAdelante(a^.dato.l, alq);
		end
		else
		begin
			new(a);
			a^.dato.cod := alq.cod;
			a^.dato.l := nil;
			agregarAdelante(a^.dato.l, alq);
			a^.HD:=nil;
			a^.HI:=nil;
		end;
	end;
var a: alquiler;
begin
	generarAlquiler(a);
	while(a.cod<>0) do begin
		insertarArbolA(aA, a);
		insertarArbolB(aB, a);
		generarAlquiler(a);
	end;
end;
{b. Un módulo recursivo que reciba la estructura generada en i) y retorne el código de 
bicicleta más grande. }
function getMaxCodA(aA : arbolA): integer;
begin
	if(aA<>nil) then 
	begin
		if(aA^.HD <>nil) then
			getMaxCodA:=getMaxCodA(aA^.HD)
		else
			getMaxCodA:=aA^.dato.cod;
	end
	else
		getMaxCodA:=-1;
end;
{c. Un módulo recursivo que reciba la estructura generada en ii) y retorne el código de 
bicicleta más pequeño. }
function getMaxCodB(aB : arbolB): integer;
begin
	if(aB<>nil) then 
	begin
		if(aB^.HI <>nil) then
			getMaxCodB:=getMaxCodB(aB^.HI)
		else
			getMaxCodB:=aB^.dato.cod;
	end
	else
		getMaxCodB:=999;
end;
{d. Un módulo recursivo que reciba la estructura generada en i) y un número de cliente. 
Debe retornar la cantidad de alquileres realizados por dicho cliente. 
}
function getCantAlquileresA(a: arbolA; n: integer): integer;
begin
	if(a<>nil) then
	begin
		if(a^.dato.num = n) then
			getCantAlquileresA := 1 + getCantAlquileresA(a^.HI, n) + getCantAlquileresA(a^.HD, n)
		else
			getCantAlquileresA := getCantAlquileresA(a^.HI, n) + getCantAlquileresA(a^.HD, n)
	end
	else
		getCantAlquileresA:=0;
end;
{e. Un módulo recursivo que reciba la estructura generada en ii) y un número de cliente. 
Debe retornar la cantidad de alquileres realizados por dicho cliente. }
function obtenerCantAlquileres(l:lista; n: integer): integer;
var cont:integer;
begin
	cont:=0;
	while(l<>nil) do
	begin
		if(l^.dato.num = n) then cont:=cont+1;
		l:=l^.sig;
	end;
	obtenerCantAlquileres:=cont;
end;
function getCantAlquileresB(a: arbolB; n: integer): integer;
begin
	if(a<>nil) then
	begin
		getCantAlquileresB:= obtenerCantAlquileres(a^.dato.l, n) + getCantAlquileresB(a^.HI, n) + getCantAlquileresB(a^.HD, n);
	end
	else
		getCantAlquileresB:=0;
end;
{f. 
Un módulo que reciba la estructura generada en i) y genere una nueva estructura 
ordenada por código de bicicleta, donde cada código aparezca una única vez junto con 
la cantidad total de horas alquiladas. }
procedure generarEstructuraA(var aC: arbolC; a:arbolA);
	procedure insertarArbolC(var a: arbolC; d: datoHoras);
	begin
		if(a<>nil) then
		begin
			if(a^.dato.cod < d.cod) then
				insertarArbolC(a^.HD, d)
			else if(a^.dato.cod > d.cod) then
				insertarArbolC(a^.HI, d)
			else
				a^.dato.horas := a^.dato.horas + d.horas;
		end
		else
		begin
			new(a);
			a^.dato := d;
			a^.HD:=nil;
			a^.HI:=nil;
		end;
	end;
var d:datoHoras;
begin
	if(a<>nil) then
	begin
		generarEstructuraA(aC, a^.HI);
		d.horas := a^.dato.horas;
		d.cod := a^.dato.cod;
		insertarArbolC(aC, d);
		generarEstructuraA(aC, a^.HD);
	end;
end;
{g. Un módulo que reciba la estructura generada en ii) y genere una nueva estructura 
ordenada por código de bicicleta, donde cada código aparezca una única vez junto con 
la cantidad total de horas alquiladas.} 
procedure agregarAListaHorasB(var l:listaHoras; d: datoHoras);
var n:listaHoras;
begin
	new(n);
	n^.dato:=d;
	n^.sig:=l;
	l:=n;
end;
procedure generarEstructuraB(a: arbolB; var l:listaHoras);
	function obtenerTotalHorasLista(l:lista): integer;
	var total:integer;
	begin
		total:=0;
		while(l<>nil) do
		begin
			total:= total + l^.dato.horas;
			l:=l^.sig;
		end;
		obtenerTotalHorasLista:=total;
	end;
var
	d: datoHoras;
begin
	if(a<>nil) then
	begin
		generarEstructuraB(a^.HD, l);
		d.cod:= a^.dato.cod;
		d.horas:= obtenerTotalHorasLista(a^.dato.l);
		agregarAListaHorasB(l, d);
		generarEstructuraB(a^.HI, l);
	end;
end;
{h. Un módulo recursivo que reciba la estructura generada en g) y muestre su contenido. }
procedure imprimirG(l:listaHoras);
begin
	while(l<>nil) do
	begin
		writeln('Cod: ', l^.dato.cod, '| Total: ', l^.dato.horas);
		l:=l^.sig;
	end;
end;
{i. 
Un módulo recursivo que reciba la estructura generada en i) y dos códigos de bicicleta. 
Debe retornar el importe total recaudado por los alquileres de las bicicletas cuyos 
códigos se encuentren comprendidos entre los dos valores recibidos, inclusive. 
}
function devolverTotalEntreDosA(a: arbolA; cod1, cod2: integer): real;
begin
	if(a<>nil) then
	begin
		if(a^.dato.cod < cod1) then
			devolverTotalEntreDosA := devolverTotalEntreDosA(a^.HD, cod1, cod2)
		else if(a^.dato.cod > cod2) then
			devolverTotalEntreDosA := devolverTotalEntreDosA(a^.HI, cod1, cod2)
		else
			devolverTotalEntreDosA := devolverTotalEntreDosA(a^.HI, cod1, cod2) + devolverTotalEntreDosA(a^.HD, cod1, cod2) + a^.dato.importe;
	end
	else
		devolverTotalEntreDosA:=0;
end;
{j. 
Un módulo recursivo que reciba la estructura generada en ii) y dos códigos de bicicleta. 
Debe retornar el importe total recaudado por los alquileres de las bicicletas cuyos 
códigos se encuentren comprendidos entre los dos valores recibidos, inclusive.
}
function devolverTotalEntreDosB(a: arbolB; cod1, cod2: integer): real;
	function obtenerTotalImporte(l:lista): real;
	var total:real;
	begin
		total:=0;
		while(l<>nil) do begin
			total:=total + l^.dato.importe;
			l:=l^.sig;
		end;
		obtenerTotalImporte:=total;
	end;
begin
	if(a<>nil) then
	begin
		if(a^.dato.cod < cod1) then
			devolverTotalEntreDosB := devolverTotalEntreDosB(a^.HD, cod1, cod2)
		else if(a^.dato.cod > cod2) then
			devolverTotalEntreDosB := devolverTotalEntreDosB(a^.HI, cod1, cod2)
		else
			devolverTotalEntreDosB := devolverTotalEntreDosB(a^.HI, cod1, cod2) + devolverTotalEntreDosB(a^.HD, cod1, cod2) + obtenerTotalImporte(a^.dato.l);
	end
	else
		devolverTotalEntreDosB:=0;
end;
procedure imprimirArbol(a: arbolC);
begin
	if(a<>nil) then
	begin
		writeln('Cod: ',a^.dato.cod, ' | Total', a^.dato.horas);
		imprimirArbol(a^.HI);
		imprimirArbol(a^.HD);
	end;
end;
var
	aA : arbolA;
	aB: arbolB;
	aC: arbolC;
	lB: listaHoras;
	n, ini, fin : integer;
	
begin
	aA:=nil;
	aB:=nil;
	aC:=nil;
	lB:=nil;
	// A
	moduloA(aA, aB);
	//B
	writeln(getMaxCodA(aA));
	//C
	writeln(getMaxCodB(aB));
	//D y E
	writeln('Ingrese un cod');
	readln(n);
	writeln(getCantAlquileresA(aA, n));
	writeln(getCantAlquileresB(aB, n));
	//F y G
	generarEstructuraA(aC, aA);
	generarEstructuraB(aB, lB); 
	// H
	writeln('A:');
	imprimirArbol(aC);
	writeln('B:');
	imprimirG(lB);
	// I y J
	writeln('Ini:');
	readln(ini);
	writeln('Fin:');
	readln(fin);
	writeln('A',devolverTotalEntreDosA(aA, ini, fin):8:2);
	writeln('B',devolverTotalEntreDosB(aB, ini, fin):9:2);
end.
