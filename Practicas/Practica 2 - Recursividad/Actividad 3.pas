program Act3;
{3.- Escribir un programa que invoque a los siguientes módulos e informe el resultado:
a. Un módulo recursivo que retorne un vector de a lo sumo 20 caracteres que conformen una
palabra. La lectura de los caracteres termina en ‘.’
b. Un módulo recursivo que reciba la “palabra” generada en a) y determine si dicha palabra es
un palíndromo, es decir, si puede leerse de la misma manera de izquierda a derecha que de
derecha a izquierda. Este módulo debe retornar el valor booleano correspondiente.
}
type 
	vector = array [1..20] of char;
procedure crearVector(var v:vector; var dimL : integer);
	procedure crearVectorRecursivo(var v:vector; var dimL:integer);
	var c:char;
	begin
		readln(c);
		if((c <> '.') and (dimL<20)) then
		begin
			dimL:=dimL+1;
			v[dimL]:=c;
			crearVectorRecursivo(v, dimL);
		end;
	end;
begin
	dimL:=0;
	crearVectorRecursivo(v, dimL);
end;
procedure imprimirVector(v:vector; dimL:integer);
var i:integer;
begin
	for i:=1 to dimL do 
	begin
		write(v[i]);
	end;
end;

function isPalindromo(v:vector; dimL:integer): boolean;
	function isPalindromoRecursivo(v: vector; i, dimL: integer): boolean;
	begin
		if(dimL>=i) then
		begin	
			i:=i+1;
			dimL:=dimL-1;
			isPalindromoRecursivo:=(v[i] = v[dimL]) and isPalindromoRecursivo(v, i, dimL);
		end
		else
			isPalindromoRecursivo:=true;
	end;
begin
	if(dimL<1)then isPalindromo:=false
	else isPalindromo:=isPalindromoRecursivo(v, 1, dimL);
end;
var
	dimL:integer;
	v:vector;
begin
	dimL:=0;
	crearVector(v, dimL);
	writeln;
	imprimirVector(v, dimL);	
	writeln;
	if(isPalindromo(v, dimL)) then writeln('Es un palindromo')
	else writeln('No es un palindromo');
end.
