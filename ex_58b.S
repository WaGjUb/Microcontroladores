;/*
; * 	ex_58a.asm
; *  Ligue sequencialmente 1 LED da direita para a esquerda (o lED deve permanecer
; *	ligado at� que todos os 8 estejam ligados, depois eles devem ser desligados
; *	e o processo repedtido).
; *  Created: 23/04/2014 16:11:42
; *   Author: Paulo*/
  

;.include "m328Pdef.inc" arquivo com as defini��es dos nomes dos bits e registr. do ATmega328p


#include <avr/io.h>
.ORG 0x000				//endere�o de in�cio de escrita do c�digo 
;.def AUX = R20			//registrador de trabalho
;.def MSK = R21			//m�scara de bits
.global main 

main:
	LDI R16,0b11111111	//carrega R16 com o valor 0b11111111
	OUT DDRD,R16		//configura todos os pinos do _SFR_IO_ADDR(PORTD) como sa�da
	
PRINCIPAL:
	LDI R21,0b10000000	 //inicializa m�scara de bits (bit0=1)
	LDI R20,0b11111111	//inicializa registrador
	OUT _SFR_IO_ADDR(PORTD),R20		//escreve no _SFR_IO_ADDR(PORTD)
 
CRESCENTE:
	EOR R20,R21			//OU EXCLUSIVO entre AUX e m�scara de bits
	OUT _SFR_IO_ADDR(PORTD),R20		//escreve no _SFR_IO_ADDR(PORTD)
	RCALL ATRASO		//chama a sub-rotina de atraso
	LSR  R21			//desloca os bits m�scara para a esquerda	
	SBIC _SFR_IO_ADDR(PORTD),7		//pula pr�xima instru��o se o bit 7 do _SFR_IO_ADDR(PORTD) estiver em 0 (LED aceso)
	RJMP CRESCENTE  	//volta para CRESCENTE
	RJMP PRINCIPAL		//volta para PRINCIPAL

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



