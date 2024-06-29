; ------- TABELA DE CORES -------
; adicione ao caracter para Selecionar a cor correspondente

; 0 branco							0000 0000
; 256 marrom						0001 0000
; 512 verde							0010 0000
; 768 oliva							0011 0000
; 1024 azul marinho					0100 0000
; 1280 roxo							0101 0000
; 1536 teal							0110 0000
; 1792 prata						0111 0000
; 2048 cinza						1000 0000
; 2304 vermelho						1001 0000
; 2560 lima							1010 0000
; 2816 amarelo						1011 0000
; 3072 azul							1100 0000
; 3328 rosa							1101 0000
; 3584 aqua							1110 0000
; 3840 branco						1111 0000

inicio: string "PONG TUSCA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 aperte qualquer tecla                       para comecar"
cenario: string "+--------------------------------------+|     CAASO: 1     ||    Federal: 0    |+--------------------------------------+|                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      |+--------------------------------------+"
;time1: string "CAASO: "

;---- Inicio do Programa Principal -----

main:
	loadn r3, #40 		; Passar pra nova linha

	call InicioPrint
	
	call InputLoop
	
	call CenaPrint
	
	loadn r6, #481		; Posicao na tela da barra 1
	loadn r1, #'#'		; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #2816		; Cor = amarelo
	
	mov r0, r6
	call BarraPrint
	
	loadn r7, #518		; Posicao na tela da barra 2
	loadn r1, #'#'		; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #2304		; Cor = vermelho
	
	mov r0, r7
	call BarraPrint
	
	loadn r0, #619
	call BolaPrint
	
move:
	call MoveLoop
	jmp move
	
	jmp Fim
	
;---- Fim do Programa Principal -----
	
;---- Inicio das Subrotinas -----
	
Imprimestr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

ImprimestrLoop:	
	loadi r4, r1
	cmp r4, r3
	jeq ImprimestrSai
	add r4, r2, r4
	outchar r4, r0
	inc r0
	inc r1
	jmp ImprimestrLoop
	
ImprimestrSai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts

InicioPrint:
	loadn r0, #374		; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #inicio	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0		; Cor = branco
	
	call Imprimestr
	rts

CenaPrint:
	loadn r0, #0		; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #cenario	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0		; Cor = branco
	
	call Imprimestr
	rts
	
BarraPrint:	
	add r1, r1, r2
	outchar	r1, r0
	
	add r0, r0, r3
	outchar r1, r0
	add r0, r0, r3
	outchar r1, r0
	add r0, r0, r3
	outchar r1, r0
	add r0, r0, r3
	outchar r1, r0
	add r0, r0, r3
	outchar r1, r0
	add r0, r0, r3
	outchar r1, r0
	add r0, r0, r3
	outchar r1, r0
	
	rts

BolaPrint:
	loadn r1, #'O'
	outchar r1, r0
	
	rts

InputLoop:
	loadn r5, #255
	inchar r2
	
	cmp r2, r5
	jeq InputLoop
	
	rts	
	
MoveLoop:
	call InputLoop
	loadn r4, #'s'
	loadn r5, #'w'
	
	cmp r2, r5
	jeq MoveUp
	
	cmp r2, r4
	jeq MoveD
	
	jmp MoveLoop
	
MoveUp:
	mov r0, r6
	sub r0, r0, r3
	
	loadn r2, #2816
	loadn r1, #'#'
	add r1, r1, r2
	outchar r1, r0
	
	loadn r5, #320
	add r0, r0, r5
	
	loadn r1, #' '
	outchar r1, r0
	
	sub r6, r6, r3
	
	rts

MoveD:
	mov r0, r6
	loadn r1, #' '	
	outchar r1, r0
	
	loadn r2, #2816
	loadn r1, #'#'
	add r1, r1, r2
	
	loadn r5, #320
	add r0, r0, r5
	
	outchar r1, r0
	
	add r6, r6, r3
	
	rts
	
Fim:
	halt