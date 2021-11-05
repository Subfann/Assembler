; ===================================================
.386
.model flat, stdcall
option casemap: none
; ===================================================

include \masm32\include\windows.inc
include \masm32\include\masm32rt.inc
include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc
include \masm32\macros\macros.asm
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib


.data

datum db "25 Oktober 2021", 0
name db "Spielmann, Eric", 0
matrikel db "Matrikel-Nr.: 217108", 0


eingabe db "Geben Sie 4 Zahlen ein, für: a b c d", 0


a1 dd 1
b1 dd 1
c1 dd 1
d1 dd 1


x1 dd 1
y1 dd 1






.code

prg proc
push ebp
mov ebp, esp


; div eg z     +16
;n1 y		   +12
;n2 x		    +8
;ret			+4


;Div Rechnung

mov edx, 0
mov eax, dword ptr [ebp + 8]				;n2 x
mov ebx, dword ptr [ebp +12]				;n1 y
div ebx										 ; eax= eax: ebx (erg wird in eax gespeichert)

mov dword ptr [ebp + 16], eax				 ; erg von eax in var





mov esp, ebp
pop ebp
ret
prg endp






main:

								;erste Seite
invoke locate, 1, 2
invoke StdOut, addr datum



invoke locate, 1, 12
invoke StdOut, addr name




invoke locate, 1, 14
invoke StdOut, addr matrikel

								;zweite Seite

invoke locate, 1, 20
invoke StdOut, addr eingabe							; ausgabe Text dass zahlen eingegeben werden sollen


invoke locate, 1, 21
mov dword ptr [a1], sval(input("Zahl für a: "))		; nutzer wird aufgefordet zahlen einzugeben und gibt ein

invoke locate, 1, 22
mov dword ptr [b1], sval(input("Zahl für b: "))

invoke locate, 1, 23
mov dword ptr [c1], sval(input("Zahl für c: "))

invoke locate, 1, 24
mov dword ptr [d1], sval(input("Zahl für d: "))

												
											;Rechnung

mov eax, 0
mov ebx, 0
mov ebx, dword ptr [a1]
mov eax, dword ptr [b1]
mul ebx
									;erg in eax




invoke locate, 1, 25							;ausgabe der Rechnunng
printf("X= %d", eax)

mov dword ptr [x1], eax


mov eax; 0
mov ebx, 0 
mov eax, dword ptr [c1]
mov ebx, dword ptr [d1]
add eax, ebx							;erg in eax



invoke locate, 1, 25
printf("Y= %d" eax)

mov dword ptr [y1], eax				;erg rechnung aus register  in var


								;vorbereitung für stack
mov eax, 0
mov ebx, 0
mov ecx, 0


push ebx ;z

push dword ptr [y1]
push dword ptr [x1]


call prg

pop eax							; x
pop eax							; y


invoke locate, 1, 27
pop eax							; z
printf("Y= %d", eax)





invoke locate, 0, 28
pause


exit
end main