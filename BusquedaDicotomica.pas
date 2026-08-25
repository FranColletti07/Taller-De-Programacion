program busquedaDicRec;
const dimF=20;
type 
	vector = array [1..dimF] of integer;
procedure cargar(var v:vector);
var i:integer;
begin
	for i:=1 to dimF do begin
		v[i]:= 100 + random(50);
	end;
end;
procedure imprimir(v:vector; pos:integer);
begin
	if(pos<=dimF)then
	begin
		write(v[pos], '|');
		imprimir(v, pos+1);
	end;
end;
procedure sort(var v:vector);
var i, j, pos, aux : integer;
begin
	for i:= 1 to dimF-1 do 
	begin
		pos:=i;
		for j := pos+1 to dimF do
			if (v[pos] > v[j]) then pos:=j;
		aux:= v[pos];
		v[pos]:=v[i];
		v[i]:=aux;
	end;
end;
function getPos(v:vector; n:integer): integer;
var
	medio, ini, fin : integer;
	ok:boolean;
begin
	ini:=1;
	fin:=dimF;
	ok:=false;
	while((ini <= fin) and (not ok)) do
	begin
		writeln;
		medio:=((fin-ini) DIV 2) + ini;
		if(v[medio] < n) then
			ini:= medio + 1
		else begin
			if(v[medio] > n) then
				fin:= medio - 1
			else begin
				ok:=true;
			end;
		end;
	end;
	if(ok) then
		getPos:= medio
	else getPos:=-1;
end;
Procedure busquedaDicotomica (v: vector; ini,fin, dato:integer; var pos: integer);
begin
	if(ini <= fin) then begin
		pos := ((fin - ini) DIV 2) + ini;
		writeln(pos);
		if(v[pos] > dato) then
		begin
			busquedaDicotomica(v, ini, pos - 1, dato, pos);
		end
		else
		begin
			if(v[pos] < dato) then
				busquedaDicotomica(v, pos + 1, fin, dato, pos);
		end; 
	end
	else pos:=-1;
end;

var
	n, pos:integer;
	v:vector;
begin
	cargar(v);
	writeln('Vector');
	write('|');
	imprimir(v, 1);
	writeln;
	sort(v);
	writeln('Vector');
	write('|');
	imprimir(v, 1);
	writeln;
	readln(n);{
	pos:=getPos(v, n);
	writeln('Esta en: ', pos);}
	busquedaDicotomica(v, 1, dimF, n, pos);
	writeln('Esta en dicotomica:', pos);
end.
