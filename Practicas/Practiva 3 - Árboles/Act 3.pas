program act3;
{3. Implementar un programa que contenga:
a. Un módulo que lea información de los préstamos de libros realizados por los socios de una
biblioteca y los almacene en una estructura de datos. De cada préstamo se lee: número de
socio (1 a 60), código de libro (200 a 230), fecha de préstamo y cantidad de días del préstamo.
La lectura de los préstamos finaliza con número de socio 0. La estructura generada debe ser
eficiente para la búsqueda por número de socio y, para cada socio, deben almacenarse en una
lista los préstamos de libros que realizó. Nota: No repetir información.
b. Un módulo que reciba la estructura generada en el inciso a) y retorne la cantidad de socios
cuyo número de socio es múltiplo de 5.
c. Un módulo que reciba la estructura generada en el inciso a) e informe, para cada socio, su
número de socio y la cantidad de préstamos de libros cuya duración fue menor o igual a 7 días.
d. Un módulo que reciba la estructura generada en el inciso a) y un valor real que representa
una cantidad promedio de días. El módulo debe retornar los números de socio y el promedio
de días de préstamo de aquellos socios cuyo promedio supere el valor ingresado.
}
type
	codSocio = 0..60;
	codLibro = 200..230;
	fecha = record
		dia : 1..31;
		mes : 1..12;
		anio : 1900..2026;
	end;
	prestamo = record
		socio : codSocio;
		libro : codLibro;
		f : fecha;
		dias : integer;
	end;
	arbolP = ^nodoP;
	nodoP = record
		HI: arbolP;
		HD: arbolP;
		dato: prestamo;
	end;
	lista = ^nodoL;
	nodoL = record
		sig: lista;
		dato: prestamo;
	end;
	datoSocio = record
		l: lista;
		cod: codSocio;
	end;
	arbolS = ^nodoS;
	nodoS = record
		HI: arbolS;
		HD: arbolS;
		dato: datoSocio;
	end;
procedure generarFecha(var f:fecha);
begin
	f.dia := random(31) + 1;
	f.mes := random(12) + 1;
	f.anio := random(126) + 1900;
end;
procedure generarPrestamo(var p:prestamo);
begin
	p.socio := random(61);
	generarFecha(p.f);
	p.libro := random(31) + 200;
	p.dias := random(30);
end;
procedure generarArboles(var aP: arbolP; var aS: arbolS);
	{procedure insertarEnArbolP(var a: arbolP; p: prestamo);
	begin
		if(a<>nil) then
		begin
			if(a^.dato.socio < p.socio) then
				insertarEnArbolP(a^.HD, p)
			else
				insertarEnArbolP(a^.HI, p);
		end
		else
		begin
			new(a);
			a^.HI:=nil;
			a^.HD:=nil;
			a^.dato:=p;
		end;
	end;}
	procedure insertarEnArbolS(var a: arbolS; p: prestamo);
		procedure agregarAdelante(var l:lista; p:prestamo);
		var n: lista;
		begin
			new(n);
			n^.dato:=p;
			n^.sig:=l;
			l:=n;
		end;
	begin
		if(a<>nil) then
		begin
			if(a^.dato.cod < p.socio) then
				insertarEnArbolS(a^.HD, p)
			else
			begin
				if(a^.dato.cod > p.socio) then
					insertarEnArbolS(a^.HI, p)
				else
					agregarAdelante(a^.dato.l, p);
			end;
		end
		else
		begin
			new(a);
			a^.HI:=nil;
			a^.HD:=nil;
			a^.dato.cod:=p.socio;
			agregarAdelante(a^.dato.l, p);
		end;
	end;
var 
	p : prestamo;
begin
	generarPrestamo(p);
	while(p.socio <> 0) do
	begin
{		insertarEnArbolP(aP, p);}
		insertarEnArbolS(aS, p);
		generarPrestamo(p);
	end;
end;
{procedure imprimirArbolP(a: arbolP);
begin
	if(a<>nil) then
	begin
		imprimirArbolP(a^.HI);
		write(a^.dato.socio, '|', a^.dato.f.dia, '/',a^.dato.f.mes, '/', a^.dato.f.anio, '|', a^.dato.dias);
		writeln;
		imprimirArbolP(a^.HD);
	end;
end;}
function cantMultiplo5(a:arbolS):integer;
begin
	if(a<>nil) then
	begin
		if((a^.dato.cod MOD 5) = 0) then 
			cantMultiplo5:= 1 + cantMultiplo5(a^.HI) + cantMultiplo5(a^.HD)
		else 
			cantMultiplo5:= cantMultiplo5(a^.HI) + cantMultiplo5(a^.HD);
	end
	else
		cantMultiplo5:= 0;
end;
procedure informarPrestamosCortos(a: arbolS);
	function contarPrestamosCortos(l:lista): integer;
	var cant:integer;
	begin
		cant:=0;
		while(l<>nil) do begin
			if(l^.dato.dias <= 7) then
				cant:=cant+1;
			l:=l^.sig;
		end;
		contarPrestamosCortos:=cant;
	end;
	
begin
	if(a<>nil) then
	begin
		informarPrestamosCortos(a^.HI);
		writeln('Socio :', a^.dato.cod, ' prestamos de menos de 7 dias: ', contarPrestamosCortos(a^.dato.l));
		informarPrestamosCortos(a^.HD);
	end;
end;
procedure informarPromediosSuperiores(a: arbolS; promGeneral: real);
	function obtenerPromedio(l:lista): real;
	var sum, cont : integer;
	begin
		sum:=0;
		cont:=0;
		while(l<>nil) do
		begin
			sum:= sum + l^.dato.dias;
			cont:= cont + 1;
			l:=l^.sig;
		end;
		if(cont<>0)  then
			obtenerPromedio:=sum/cont
		else
			obtenerPromedio:=0;
	end; 
var prom: real;
begin
	if(a<>nil)then
	begin
		prom:=obtenerPromedio(a^.dato.l);
		if(prom >=promGeneral) then
			writeln('Socio n', a^.dato.cod, ' tiene promedio: ',prom:8:2);
		informarPromediosSuperiores(a^.HI, promGeneral);
		informarPromediosSuperiores(a^.HD, promGeneral);
	end;
end;
var
	aP: arbolP;
	aS: arbolS;
	prom:real;
begin
	{TODO EL TEMA DE aP FUE AL PEDO, ERA UN SOLO ARBOL }
	generarArboles(aP, aS);
	//b
	writeln('Cant multiplo 5: ', cantMultiplo5(aS));
	//c 
	informarPrestamosCortos(aS);
	//d
	readln(prom);
	informarPromediosSuperiores(aS, prom);
end.
	
	
	
	
