program act4;
{
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
Informática y los almacene en una estructura de datos. La información que se lee es legajo
(1000 a 1050), código de materia (1 a 25), fecha y nota. La lectura de los alumnos finaliza con
legajo 0. La estructura generada debe ser eficiente para la búsqueda por número de legajo y
para cada alumno deben guardarse los finales que rindió en una lista. Nota: No repetir
información!!!
b. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
su cantidad de finales aprobados (nota mayor o igual a 4).
c. Un módulo que reciba la estructura generada en a. y un código de materia. El módulo debe
retornar la cantidad de alumnos que aprobó la materia recibida y la cantidad de alumnos que
desaprobó la materia recibida.
d. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe
retornar la cantidad de alumnos con cantidad de finales rendidos igual al valor entero recibido.
}
type 
	legajoSub = 1000..1050;
	codSub = 1..25;
	fecha = record
		dia: 1..31;
		mes: 1..12;
		anio: 2000..2026;
	end;
	fin = record
		legajo: integer;
		cod : codSub;
		f: fecha;
		nota : real;
	end;
	lista = ^nodoL;
	nodoL = record
		sig: lista;
		dato : fin;
	end;
	legConLista = record
		l: lista;
		legajo: legajoSub;
	end;
	arbol = ^nodoA;
	nodoA = record
		HI: arbol;
		HD: arbol;
		dato: legConLista;
	end;
procedure leerFecha(var f: fecha);
begin
	readln(f.dia);
	readln(f.mes);
	readln(f.anio);
end;
procedure leerFinal(var f: fin);
begin
	readln(f.legajo);
	if(f.legajo<>0) then begin
		readln(f.cod);
		leerFecha(f.f);
		readln(f.nota);
	end;
end;	
procedure generarFinal(var f: fin);
begin
	f.legajo:= random(51) + 1000;
	f.cod:= random(25) + 1;
	f.f.dia:= random(31) + 1;
	f.f.mes:= random(12) + 1;
	f.f.anio:= random(27) + 2000;
	f.nota := random(10);
end;
procedure generarArbol(var a: arbol);
	procedure agregarAdelante(var l:lista; f:fin);
	var n:lista;
	begin
		new(n);
		n^.dato:=f;
		n^.sig:=l;
		l:=n;
	end;
	procedure insertar(var a: arbol; f:fin);
	begin
		if(a<>nil)then
		begin
			if(a^.dato.legajo < f.legajo) then
				insertar(a^.HD, f)
			else begin
				if(a^.dato.legajo > f.legajo) then
					insertar(a^.HI, f)
				else
					agregarAdelante(a^.dato.l, f);
			end;
		end
		else 
		begin
			new(a);
			a^.HI:=nil;
			a^.HD:=nil;
			a^.dato.l:=nil;
			agregarAdelante(a^.dato.l, f);
			a^.dato.legajo:= f.legajo;
		end;
	end;
var 
	f:fin;
	i:integer;
begin
{	leerFinal(f);
	while(f.legajo<>0) do begin
		insertar(a, f);
		leerFinal(f);
	end;}
	for i:= 1 to 50 do begin
		generarFinal(f);
		insertar(a, f);
	end;
end;
procedure informarAprobados(a: arbol);
	function getCantAprobados(l:lista): integer;
	var cant:integer;
	begin
		cant:=0;
		while(l<>nil)do begin
			if(l^.dato.nota >= 4) then
				cant:= cant+1;
			l:=l^.sig;
		end;
		getCantAprobados:=cant;
	end;
begin
	if(a<>nil) then
	begin
		informarAprobados(a^.HI);
		writeln('Legajo: ', a^.dato.legajo, ' cantidad de finales aprobados: ', getCantAprobados(a^.dato.l));
		informarAprobados(a^.HD);
	end;
end;
procedure aprobadosPorMateria(a: arbol; codM : codSub; var cantA, cantD : integer);
	procedure getCantAprobadosYDesaprobadosPorMateriaDeAlumno(l:lista; var cantFinA, cantFinD :integer; codM: codSub);
	begin
		cantFinA:=0;
		cantFinD:=0;
		while(l<>nil) do
		begin
			if(l^.dato.cod = codM) then
			begin
				if(l^.dato.nota >= 4) then cantFinA:=cantFinA+1
				else cantFinD:= cantFinD+1;
			end;
			l:=l^.sig;
		end;
	end;
var cantFinAprobAlumno, cantFinDesAlumno: integer;
begin
	if(a<>nil) then
	begin
		aprobadosPorMateria(a^.HI, codM, cantA, cantD);
		getCantAprobadosYDesaprobadosPorMateriaDeAlumno(a^.dato.l, cantFinAprobAlumno, cantFinDesAlumno, codM);
		cantA:= cantA + cantFinAprobAlumno;
		cantD:= cantD + cantFinDesAlumno;
		aprobadosPorMateria(a^.HD, codM, cantA, cantD);
	end;
end;
function cantAlumnosQueRindieronXFinales(a:arbol;x:integer): integer;
	function rindioXFinales(l: lista; x : integer): boolean;
	var cant : integer;
	begin
		cant:=0;
		while((l<>nil) and (cant<=x)) do
		begin
			cant:=cant+1;
			l:=l^.sig;
		end;
		rindioXFinales:= cant=x;
	end;
begin
	if(a<>nil) then
	begin
		if(rindioXFinales(a^.dato.l, x)) then
			cantAlumnosQueRindieronXFinales:= 1 + cantAlumnosQueRindieronXFinales(a^.HI, x) + cantAlumnosQueRindieronXFinales(a^.HD, x)
		else
			cantAlumnosQueRindieronXFinales:= cantAlumnosQueRindieronXFinales(a^.HI, x) + cantAlumnosQueRindieronXFinales(a^.HD, x);
	end
	else
		cantAlumnosQueRindieronXFinales:=0;
end;
var
	a: arbol;
	codM : codSub;
	x, aprob, desaprob : integer;
	
begin
	//a
	generarArbol(a);
	//b
	informarAprobados(a);
	//c
	aprob:=0;
	desaprob:=0;
	readln(codM);
	aprobadosPorMateria(a, codM, aprob, desaprob);
	writeln('De la materia ', codM, ' hay ',aprob, ' finales aprobados y ', desaprob, ' finales desaprobados'); 
	//d
	writeln('Ingrese el numero de finales a comparar');
	readln(x);
	writeln('Hay ', cantAlumnosQueRindieronXFinales(a, x), ' alumnos que rindieron ', x, ' finales');
end.
	
	
