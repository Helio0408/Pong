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

reset:


limpa: string "                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                "
inicio: string "PONG TUSCA                                                                                                                                                                                                                                                                                                                                                                                                                                                                               aperte espaco para comecar"
cenario: string "+--------------------------------------+|     CAASO: 0     ||    Federal: 0    |+--------------------------------------+|                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      ||                                      |+--------------------------------------+"
caaso_vit: string "VITORIA DO CAASO"
fed_vit: string "JOGO INVALIDO"

;time1: string "CAASO: "

vbola: var #1

dbh: var #1
static dbh + #0, #0
dbv: var #1
static dbv + #0, #0

pbola: var #1	
static pbola +#0, #619

pcaaso: var #1
static pcaaso + #0, #0

pfed: var #1
static pfed + #0, #0

;---- Inicio do Programa Principal -----

;VARIAVEIS SALVAS:
;r3 = tamanho da linha
;r6 = posicao da barra 1
;r7 = posicao da barra 2

main:
	loadn r3, #40 		; Tamanho da linha
	
	call Delay
	call Delay
	call Delay
	call Delay

	call InicioPrint	; Printa a tela de inicio
	
	call InputLoopIni		; Loop esperando input para sair da tela inicial
	
	call Delay
	call Delay
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

	call BolaPrint		; Printa a bola
	
move:
	call MoveLoop		; Chama o loop de movimento 
	jmp move		; LOOP DE TESTE, TROCAR POR PULO CONDICIONAL
	
	jmp Fim			; Finaliza o programa
	
InputLoopIni:
	loadn r5, #32		; Carrega r5 com o valor de input nulo
	inchar r2		; Salva o valor do input recebido em r2
	
	cmp r2, r5		; Verifica se o input foi nulo
	jne InputLoopIni		; Se for nulo continua no loop
	
	rts	
	
	
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

PrintPlacar:
	loadn r0, #pcaaso		; Posicao da bola na tela
	loadi r0, r0
	
	loadn r1, #'0'
	add r1, r1, r0
	
	loadn r0, #53
	outchar r1, r0		; Printa a bola
	
	loadn r0, #pfed		; Posicao da bola na tela
	loadi r0, r0
	
	loadn r1, #'0'
	add r1, r1, r0
	
	loadn r0, #74
	outchar r1, r0		; Printa a bola
	
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
	loadn r0, #pbola		; Posicao da bola na tela
	loadi r0, r0
	loadn r1, #'O'		; Define a bola como 'O'
	outchar r1, r0		; Printa a bola
	
	rts

InputLoop:
	inchar r2		; Salva o valor do input recebido em r2
	rts	
	
MoveLoop:
	call InputLoop		; Espera um input nao nulo
	
	call MoveBola
	call BolaPrint
	call PrintPlacar
	
	loadn r4, #'s'		
	loadn r5, #'w'
	loadn r0, #'j'
	loadn r1, #'i'
	
	cmp r2, r5		
	jeq MoveUp1		; Se o input for 'w' move pra cima
	
	cmp r2, r4
	jeq MoveD1		; Se o input for 's' move pra baixo

ret_move1:

	cmp r2, r1		
	jeq MoveUp2
	
	cmp r2, r0		
	jeq MoveD2
	
ret_move2:
	
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

	jmp ret_move1

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
	
	jmp ret_move1
	
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

	jmp ret_move2

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
	
	jmp ret_move2

Delay:
	push r0
	push r1
	
	loadn r0, #0
	loadn r1, #6000

loopdelay:
	inc r0
	cmp r0, r1
	jne loopdelay		
	
	pop r1
	pop r0
	
	rts		
	
MoveBola:
	loadn r0, #pbola		; Posicao da bola na tela
	loadi r0, r0
	loadn r1, #' '		; Define a bola como 'O'
	outchar r1, r0		; Printa a bola

	loadn r1, #dbv
	loadi r1, r1
	loadn r0, #0
	cmp r0, r1
	
	jeq mbd
	jmp mbu

ret_b1:
	loadn r0, #pbola		; Posicao da bola na tela
	loadi r0, r0
	loadn r1, #' '		; Define a bola como 'O'
	outchar r1, r0		; Printa a bola

	loadn r1, #dbh
	loadi r1, r1
	loadn r0, #0
	cmp r0, r1
	
	jeq mbl
	jmp mbr
	
ret_b2:
	rts
	
mbd:
	loadn r0, #pbola
	loadi r0, r0
	
	loadn r1, #1120
	cmp r1, r0
	jle ColBolaBaixo

	loadn r1, #40
	loadn r0, #pbola
	loadi r0, r0 
	add r0, r0, r1
	
	store pbola, r0
	jmp ret_b1
	
ColBolaBaixo:
	loadn r0, #1
	store dbv, r0
	jmp MoveBola

mbu:
	loadn r0, #pbola
	loadi r0, r0
	
	loadn r1, #160
	cmp r1, r0
	jgr ColBolaCima
	
	loadn r1, #40
	loadn r0, #pbola
	loadi r0, r0 
	sub r0, r0, r1
	
	store pbola, r0
	jmp ret_b1
	
ColBolaCima:
	loadn r0, #0
	store dbv, r0
	jmp MoveBola

mbl:
	loadn r0, #pbola
	loadn r1, #40
	loadi r0, r0
	mod r0, r0, r1 
	
	loadn r1, #2
	cmp r1, r0
	jeg ColBolaEsq
	
	loadn r1, #1
	loadn r0, #pbola
	loadi r0, r0 
	sub r0, r0, r1
	
	store pbola, r0
	jmp ret_b2

ColBolaEsq:
	loadn r1, #40
	loadn r0, #pbola
	loadi r0, r0
	div r0, r0, r1
	div r1, r6, r1
	loadn r2, #8
	add r2, r1, r2

	cmp r0, r1
	
	jle nao_colidiu_fed
	
	cmp r0, r2
	
	jgr nao_colidiu_fed
	
ret_fed:
	loadn r0, #1
	store dbh, r0
	jmp MoveBola
	
nao_colidiu_fed:
	loadn r0, #pfed
	loadi r0, r0
	inc r0
	store pfed, r0 
	
	call ResetBall
	call ChecarVitoria
	jmp ret_fed

mbr:
	loadn r0, #pbola
	loadn r1, #40
	loadi r0, r0
	mod r0, r0, r1 
	
	loadn r1, #36
	cmp r1, r0
	jle ColBolaDir
	
	loadn r1, #1
	loadn r0, #pbola
	loadi r0, r0 
	add r0, r0, r1
	
	store pbola, r0
	jmp ret_b2
	
ColBolaDir:
	loadn r1, #40
	loadn r0, #pbola
	loadi r0, r0
	div r0, r0, r1
	div r1, r7, r1
	loadn r2, #8
	add r2, r1, r2

	cmp r0, r1
	
	jle nao_colidiu	
	
	cmp r0, r2
	
	jgr nao_colidiu

col_retorno:
	loadn r0, #0
	store dbh, r0
	jmp MoveBola
	rts


nao_colidiu:
	loadn r0, #pcaaso
	loadi r0, r0
	inc r0
	store pcaaso, r0 
	
	call ResetBall
	call ChecarVitoria
	jmp col_retorno


	
ChecarVitoria:
	loadn r2, #5 
	loadn r0, #pcaaso
	loadi r0, r0
	
	cmp r2, r0
	
	jeq VitoriaCaaso

	loadn r0, #pfed
	loadi r0, r0
	
	cmp r2, r0

	jeq VitoriaFederal
	rts

	
VitoriaCaaso:
	call PrintPlacar
	loadn r0, #611			; Posicao na tela onde a mensagem sera escrita
	loadn r1, #caaso_vit	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #2816			; Cor = branco
	call Imprimestr
	
	jmp Fim

VitoriaFederal:
	call PrintPlacar
	loadn r0, #613		; Posicao na tela onde a mensagem sera escrita
	loadn r1, #fed_vit	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #2304		; Cor = branco
	call Imprimestr
	jmp Fim
	
ResetBall:
	loadn r0, #619
	store pbola, r0
	
delay:
	push r0
	push r1
	
	loadn r0, #0
	loadn r1, #65000
	
init_delay:
	inc r0
	nop
	nop
	nop
	nop
	cmp r0, r1
	jne init_delay
	
	pop r1
	pop r0
	rts
	
Fim:
	loadn r5, #32		; Carrega r5 com o valor de input nulo
	inchar r2		; Salva o valor do input recebido em r2
	
	cmp r2, r5		; Verifica se o input foi nulo
	jne Fim		; Se for nulo continua no loop
	
	loadn r0, #0
	store pcaaso, r0
	store pfed, r0
	
	loadn r0, #0		; Posicao na tela onde a mensagem sera escrita
	loadn r1, #limpa	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0		; Cor = branco
	
	call Imprimestr
	
	jmp reset
	halt			; Encerra o programa
