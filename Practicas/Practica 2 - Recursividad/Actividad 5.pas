program Act5;
{5.- Realizar un programa que lea números y que utilice un módulo recursivo que escriba el
equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa
el número 0 (cero)}
type
	binario = 0..1;
function leerNumero(): LongInt;
begin
	readln(leerNumero);
end;
procedure pasarABinario(var n: LongInt);
	function potencia(n, exp:LongInt):LongInt;
	begin
		if(exp>0) then
		begin
			potencia:= n * potencia(n, exp-1);
		end
		else
			potencia:=1;
	end;
	function aBinarioNoRecursivo(n:integer):integer;
	var dig, sum, pos:integer;
	begin
		sum:=0;
		pos:= 0;
		while(n<>0) do
		begin
			dig := n MOD 2;
			sum := sum + (dig * potencia(10, pos));
			pos:= pos + 1;
			n := n DIV 2;
		end;
		aBinarioNoRecursivo:=sum;
	end;
	function aBinarioRecursivo(n, pos :LongInt): LongInt;
	var dig : LongInt;
	begin
		if(n<>0) then 
		begin
			dig := n MOD 2;
			aBinarioRecursivo := (dig * potencia(10, pos)) + aBinarioRecursivo(n DIV 2, pos + 1);
		end
		else
			aBinarioRecursivo:=0;
	end;
begin
	readln(n);
	while(n <> 0) do begin
		writeln(n, ' = ',aBinarioRecursivo(n, 0));
		readln(n);
    end;
end;
var n:LongInt;
begin
	pasarABinario(n);
end.
