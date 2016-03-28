/*
 * 	ex_58a.asm
 *  Ligue sequencialmente 1 LED da direita para a esquerda (o lED deve permanecer
 *	ligado at� que todos os 8 estejam ligados, depois eles devem ser desligados
 *	e o processo repedtido).
 *  Created: 23/04/2014 16:11:42
 *   Author: Paulo
 */ 

.include "m328pdef.inc" //arquivo com as defini��es dos nomes dos bits e registr. do ATmega328p	
.ORG 0x000				//endere�o de in�cio de escrita do c�digo 
.def AUX = R20			//registrador de trabalho
.def MSK = R21		//m�scara de bits

INICIO:
	LDI R16,0b11111111	//carrega R16 com o valor 0b11111111
	OUT DDRD,R16		//configura todos os pinos do PORTD como sa�da
	
PRINCIPAL:
	LDI MSK,0b01111111	//inicializa m�scara de bits (bit0=1)
	LDI AUX,0b10000000	//inicializa registrador			
	OUT PORTD,MSK		//escreve no PORTD
	RCALL ATRASO
 
IDA:
;	EOR AUX,MSK		//OU EXCLUSIVO entre AUX e m�scara de bits
	LSR  MSK			//desloca os bits m�scara para a esquerda	
	OR MSK,AUX 		//ADD O BIT PARA SER APAGADO VOLTANDO 
	LDI AUX, 0b10000000
	OUT PORTD,MSK		//escreve no PORTD
	RCALL ATRASO		//chama a sub-rotina de atraso
	SBIC PORTD,0		//pula pr�xima instru��o se o bit 0 do PORTD estiver em 0 (LED aceso)
	RJMP IDA	  	//volta para IDA
	RJMP VOLTAa		//VAI para VOLTA

VOLTAa: 
	LSL MSK			//SHIFT PARA DIREITA NA MASCARA
	INC MSK			//INCREMENTA 1
	OUT PORTD,MSK		//ESCREVE A MASCARA NO PORTD
	RCALL ATRASO
	SBIC PORTD,7		//if bit 7 = 0
	RJMP VOLTAa		//do
;	RCALL ATRASO		//else chama o atrado 
	RJMP IDA 		//else vai para ida

ATRASO:					//atraso de aprox. 200ms
	LDI R19,16	
 volta:		
	DEC  R17			//decrementa R17, come�a com 0x00
	BRNE volta 			//enquanto R17 > 0 fica decrementando R17
	DEC  R18			//decrementa R18, come�a com 0x00
	BRNE volta			//enquanto R18 > 0 volta decrementar R18
	DEC  R19			//decrementa R19
	BRNE volta			//enquanto R19 > 0 vai para volta
	RET	
//---------------------------------------------------------------------------



