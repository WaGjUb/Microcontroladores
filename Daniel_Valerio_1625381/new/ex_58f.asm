/*
 * 	ex_58a.asm
 *  Ligue sequencialmente 1 LED da direita para a esquerda (o lED deve permanecer
 *	ligado até que todos os 8 estejam ligados, depois eles devem ser desligados
 *	e o processo repedtido).
 *  Created: 23/04/2014 16:11:42
 *   Author: Paulo
 */ 

.include "m328pdef.inc" //arquivo com as definições dos nomes dos bits e registr. do ATmega328p	
.ORG 0x000				//endereço de início de escrita do código 
.def AUX = R20			//registrador de trabalho
.def MSK = R21			//máscara de bits
 

INICIO:
	LDI R16,0b11111111	//carrega R16 com o valor 0b11111111
	OUT DDRD,R16		//configura todos os pinos do PORTD como saída
	
PRINCIPAL:
	LDI MSK,0b11111111	//inicializa máscara de bits (bit0=1)
	LDI AUX,0b11111111	//inicializa registrador
	OUT PORTD,AUX		//escreve no PORTD
 
CRESCENTE:
;	EOR AUX,MSK		//OU EXCLUSIVO entre AUX e máscara de bit
;	OUT PORTD,MSK
;	BREQ PRINCIPAL		//se MSK == 0 vai para principal
	OUT PORTD,MSK		//escreve no PORTD
	RCALL ATRASO		//chama a sub-rotina de atraso
	DEC MSK			//DECREMENTA MSK PARA ASCENDER OS LEDS
	RJMP CRESCENTE		//volta para crescente
;	LSL  MSK			//desloca os bits máscara para a esquerda		
;	SBIC PORTD,7		//pula próxima instrução se o bit 7 do PORTD estiver em 0 (LED aceso)
;	RJMP CRESCENTE  	//volta para CRESCENTE
;	RJMP PRINCIPAL		//volta para PRINCIPAL

ATRASO:					//atraso de aprox. 200ms
	LDI R19,16	
 volta:		
;	DEC  R17			//decrementa R17, começa com 0x00
;	BRNE volta 			//enquanto R17 > 0 fica decrementando R17
;	DEC  R18			//decrementa R18, começa com 0x00
;	BRNE volta			//enquanto R18 > 0 volta decrementar R18
;	DEC  R19			//decrementa R19
;	BRNE volta			//enquanto R19 > 0 vai para volta
	RET	
//---------------------------------------------------------------------------



