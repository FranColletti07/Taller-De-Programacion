program Act3;
{Un centro cultural desea procesar la información de las inscripciones a los talleres que 
ofrece. De cada inscripción se conoce: número de inscripción, código de taller, número de 
documento del participante y cantidad de clases a las que asistió. 
La lectura de las inscripciones finaliza cuando se ingresa el número de inscripción -1. 
Implementar un programa que invoque a los siguientes módulos y  compruebe el correcto 
funcionamiento del mismo. 
a. Un módulo que retorne la información de los talleres en una estructura de datos 
eficiente para la búsqueda por código de taller. De cada taller deben almacenarse: 
código de taller, cantidad total de participantes inscriptos y cantidad total de 
asistencias registradas. 
b. Un módulo que imprima el contenido de la estructura ordenado por código de taller. 
c. Un módulo que retorne el código del taller con mayor cantidad de participantes 
inscriptos. 
d. Un módulo que retorne la cantidad de talleres cuyos códigos sean menores que un 
valor recibido como parámetro. 
e. Un módulo que retorne la cantidad total de asistencias correspondientes a los talleres 
cuyos códigos se encuentren comprendidos entre dos valores recibidos como 
parámetros, sin incluir dichos valores.
}
TYPE 
	inscripcion = record
		num: integer;
		cod: integer;
		doc: integer;
		cantClases: integer;
	end;
	taller = record
		cod: integer;
		cantParticipantes: integer;
		cantClases : integer;
	end;
	arbol= ^nodo;
	nodo = record
		HI: arbol;
		HD: arbol;
		dato: taller;
	end;
	var c:integer;
procedure generarArbol(var a:arbol);
	procedure generarInscripcion(var i:inscripcion);
	begin
		i.cod:=random(100) + 1;
		i.num:=c;
		c:=c-1;
		i.doc:= random(800) + 1;
		i.cantClases:=random(10) + 1;
	end;
	procedure leerInscripcion(var i:inscripcion);
	begin
		readln(i.cod);
		readln(i.num);
		readln(i.doc);
		readln(i.cantClases);
	end;
	procedure insertar(var a:arbol; i:inscripcion);
		begin
			if(a<>nil)then
			begin
				if(a^.dato.cod< i.cod)then
					insertar(a^.HD, i)
				else if(a^.dato.cod > i.cod) then
					insertar(a^.HI, i)
				else
				begin
					a^.dato.cantParticipantes:= a^.dato.cantParticipantes + 1;
					a^.dato.cantClases:= i.cantClases + a^.dato.cantClases;					
				end;
			end
			else
			begin
				new(a);
				a^.dato.cod:=i.cod;
				a^.dato.cantParticipantes:= 1;
				a^.dato.cantClases:= i.cantClases;
				a^.HI:=nil;
				a^.HD:=nil;
			end;
		end;
	var i: inscripcion;
	begin
		c:=100;
		a:=nil;
		generarInscripcion(i);
		while(i.num<>-1)do begin
			insertar(a, i);
			generarInscripcion(i);
		end;
	end;
procedure moduloB(a: arbol);
begin
	if(a<>nil) then
	begin
		moduloB(a^.HI);
		writeln('Cod: ', a^.dato.cod, '| cantParticipantes ',a^.dato.cantParticipantes, ' |cantClases: ', a^.dato.cantClases);
		moduloB(a^.HD);
	end;
end;
procedure maxParticipantes(a:arbol; var max, codMax:integer);
begin
	if(a<>nil)then
	begin
		if(a^.dato.cantParticipantes>max) then
		begin
			max:=a^.dato.cantParticipantes;
			codMax:= a^.dato.cod;
		end;
		maxParticipantes(a^.HI, max, codMax);
		maxParticipantes(a^.HD, max, codMax);
	end;
end;
function cantTalleresMenoresA(a:arbol; c:integer): integer;
begin
	if(a<>nil)then
	begin
		if(a^.dato.cod >= c) then
			cantTalleresMenoresA:= cantTalleresMenoresA(a^.HI, c)
		else 
		begin
			cantTalleresMenoresA:= 1 + cantTalleresMenoresA(a^.HD, c) + cantTalleresMenoresA(a^.HI, c);
		end;
	end
	else
		cantTalleresMenoresA:=0;
end;
function moduloE(a:arbol; limI, limS: integer): integer;
begin
	if(a<>nil) then
	begin
		if(a^.dato.cod >= limS) then
			moduloE:=moduloE(a^.HI, limI, limS)
		else if(a^.dato.cod <= limI) then
			moduloE:=moduloE(a^.HD, limI, limS)
		else
			moduloE:= moduloE(a^.HI, limI, limS) + moduloE(a^.HD, limI, limS) + a^.dato.cantClases;
	end
	else
		moduloE:=0;
end;
var a:arbol;
max, cod,codMax, limI, limS :integer;
begin
	randomize;
	
	generarArbol(a);
	moduloB(a);
	max:=0;
	codMax:=-1;
	maxParticipantes(a, max, codMax);
	if(codMax<>-1)then writeln('Codigo del taller con mas participantes: ', codMax);
	writeln('Ingrese un codigo de taller');
	readln(cod);
	writeln('Cant de taller menores a ', cod, ': ', cantTalleresMenoresA(a, cod));
	writeln;
	write('Limite inferior: ');
	readln(limI);
	write('Limite superior: ');
	readln(limS);
	write('Cant de asistencias de talleres entre ', limI,' y ', limS, ': ', moduloE(a, limI, limS));
end.
		
