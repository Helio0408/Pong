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

;VARIAVEIS SALVAS:
;r3 = tamanho da linha
;r6 = posicao da barra 1
;r7 = posicao da barra 2

main:
	loadn r3, #40 		; Tamanho da linha

	call InicioPrint	; Printa a tela de inicio
	
	call InputLoopIni		; Loop esperando input para sair da tela inicial
	
	call Delay
	call Delay
	
	call CenaPrint		; Printa o cenario
	
	loadn r6, #481		; Posicao inicial da barra 1 na tela
	loadn r1, #'#'		; Unidade da barra
	loadn r2, #2816		; Cor = amarelo
	
	mov r0, r6		; Copia o valor de r6 para r0
	call BarraPrint		; Printa a barra 1
	
	loadn r7, #518		; Posicao inicial da barra 2 na tela
	loadn r1, #'#'		; Unidade da barra
	loadn r2, #2304		; Cor = vermelho
	
	mov r0, r7		; Copia o valor de r7 para r0
	call BarraPrint		; Printa a barra 2
	
	loadn r0, #619		; Posicao da bola na tela
	call BolaPrint		; Printa a bola
	
move:
	call MoveLoop		; Chama o loop de movimento
	
	jmp move		; LOOP DE TESTE, TROCAR POR PULO CONDICIONAL
	
	jmp Fim			; Finaliza o programa
		
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
	pop r4			; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts

InicioPrint:
	loadn r0, #374		; Posicao na tela onde a mensagem sera escrita
	loadn r1, #inicio	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0		; Cor = branco
	
	call Imprimestr
	rts

CenaPrint:
	loadn r0, #0		; Posicao na tela onde a mensagem sera escrita
	loadn r1, #cenario	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0		; Cor = branco
	
	call Imprimestr
	rts
	
BarraPrint:	
	add r1, r1, r2		; Define a cor da barra
	outchar	r1, r0		; Printa o primeiro caractere da barra
	
	add r0, r0, r3		; Passa pra prox pos da barra (prox linha)
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
	
ColisaoBaixo:
	rts

ColisaoTopo:
	rts

BolaPrint:
	loadn r1, #'O'		; Define a bola como 'O'
	outchar r1, r0		; Printa a bola
	
	rts

InputLoopIni:
	loadn r5, #255		; Carrega r5 com o valor de input nulo
	inchar r2		; Salva o valor do input recebido em r2
	
	cmp r2, r5		; Verifica se o input foi nulo
	jeq InputLoopIni		; Se for nulo continua no loop
	
	rts	
	

InputLoop:
	inchar r2		; Salva o valor do input recebido em r2
	
	rts	
	
MoveLoop:
	call InputLoop		; Espera um input nao nulo
	loadn r4, #'s'		
	loadn r5, #'w'
	loadn r0, #'j'
	loadn r1, #'i'
	
	cmp r2, r5		
	jeq MoveUp1		; Se o input for 'w' move pra cima
	
	cmp r2, r4
	jeq MoveD1		; Se o input for 's' move pra baixo
	
	cmp r2, r1		
	jeq MoveUp2
	
	cmp r2, r0		
	jeq MoveD2
	
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	
	jmp MoveLoop		; Se nao for nenhum dos dois espera novo input
	
	
MoveUp1:
	mov r0, r6		; Copia o valor de r6(Pos barra 1) para r0
	sub r0, r0, r3		; Subtrai uma linha da posicao da barra 1
	
	loadn r1, #121
	cmp r1, r0
	jgr ColisaoTopo
	
	loadn r2, #2816		
	loadn r1, #'#'	
	add r1, r1, r2		
	outchar r1, r0		; Printa um caractere de barra na nova posicao da barra 1
	
	loadn r5, #320		
	add r0, r0, r5		; Passa para o endereco do caractere mais baixo da barra
	
	loadn r1, #' '
	outchar r1, r0		; Apaga esse caractere
	
	sub r6, r6, r3		; Coloca a posicao da barra 1 uma linha pra cima

	rts

MoveD1:
	mov r0, r6		; Copia o valor de r6(Pos barra 1) para r0
	
	loadn r1, #840
	cmp r1, r6
	jle ColisaoBaixo
	
	loadn r1, #' '	
	outchar r1, r0		; Apaga o caractere mais alto da barra 1
	
	loadn r2, #2816
	loadn r1, #'#'
	add r1, r1, r2
	
	loadn r5, #320
	add r0, r0, r5		; Passa para o endereco abaixo do caractere mais baixo da barra
	
	outchar r1, r0		; Printa um caractere de barra na nova posicao da barra 1
	
	add r6, r6, r3		; Coloca a barra 1 uma linha pra baixo
	
	rts
	
MoveUp2:
	mov r0, r7		; Copia o valor de r6(Pos barra 1) para r0
	sub r0, r0, r3		; Subtrai uma linha da posicao da barra 1
	
	loadn r1, #158
	cmp r1, r0
	jgr ColisaoTopo
	
	loadn r2, #2304		
	loadn r1, #'#'	
	add r1, r1, r2		
	outchar r1, r0		; Printa um caractere de barra na nova posicao da barra 1
	
	loadn r5, #320		
	add r0, r0, r5		; Passa para o endereco do caractere mais baixo da barra
	
	loadn r1, #' '
	outchar r1, r0		; Apaga esse caractere
	
	sub r7, r7, r3		; Coloca a posicao da barra 1 uma linha pra cima

	rts

MoveD2:
	mov r0, r7		; Copia o valor de r6(Pos barra 1) para r0
	
	loadn r1, #877
	cmp r1, r0
	jle ColisaoBaixo
	
	loadn r1, #' '	
	outchar r1, r0		; Apaga o caractere mais alto da barra 1
	
	loadn r2, #2304
	loadn r1, #'#'
	add r1, r1, r2
	
	loadn r5, #320
	add r0, r0, r5		; Passa para o endereco abaixo do caractere mais baixo da barra
	
	outchar r1, r0		; Printa um caractere de barra na nova posicao da barra 1
	
	add r7, r7, r3		; Coloca a barra 1 uma linha pra baixo
	
	rts

Delay:
	push r0
	push r1
	
	loadn r0, #0
	loadn r1, #60000
	
loopdelay:
	inc r0
	cmp r0, r1
	jne loopdelay		
	
	pop r1
	pop r0
	
	rts				;return

	
Fim:
	halt			; Encerra o programa
