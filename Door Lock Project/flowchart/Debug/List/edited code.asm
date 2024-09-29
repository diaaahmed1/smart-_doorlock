
;CodeVisionAVR C Compiler V3.38 Evaluation
;(C) Copyright 1998-2019 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _button=R5
	.DEF _number=R6
	.DEF _number_msb=R7
	.DEF _start=R4
	.DEF _hundreds=R9
	.DEF _tens=R8
	.DEF _units=R11
	.DEF _EEnum=R10
	.DEF _re_enter_store=R13
	.DEF __lcd_x=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _Adminaccess
	JMP  _change_pass_code
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0

_0x0:
	.DB  0x59,0x6F,0x75,0x20,0x45,0x6E,0x74,0x65
	.DB  0x72,0x65,0x64,0x3A,0x20,0x25,0x64,0x0
	.DB  0x59,0x6F,0x75,0x20,0x45,0x6E,0x74,0x65
	.DB  0x72,0x65,0x64,0x3A,0x20,0x2A,0x0,0x59
	.DB  0x6F,0x75,0x20,0x45,0x6E,0x74,0x65,0x72
	.DB  0x65,0x64,0x3A,0x20,0x2A,0x25,0x64,0x0
	.DB  0x59,0x6F,0x75,0x20,0x45,0x6E,0x74,0x65
	.DB  0x72,0x65,0x64,0x3A,0x20,0x2A,0x2A,0x0
	.DB  0x59,0x6F,0x75,0x20,0x45,0x6E,0x74,0x65
	.DB  0x72,0x65,0x64,0x3A,0x20,0x2A,0x2A,0x25
	.DB  0x64,0x0,0x59,0x6F,0x75,0x20,0x45,0x6E
	.DB  0x74,0x65,0x72,0x65,0x64,0x3A,0x20,0x2A
	.DB  0x2A,0x2A,0x0,0x59,0x6F,0x75,0x20,0x45
	.DB  0x6E,0x74,0x65,0x72,0x65,0x64,0x3A,0x20
	.DB  0x25,0x64,0x25,0x64,0x0,0x59,0x6F,0x75
	.DB  0x20,0x45,0x6E,0x74,0x65,0x72,0x65,0x64
	.DB  0x3A,0x20,0x25,0x64,0x25,0x64,0x25,0x64
	.DB  0x0,0x20,0x20,0x44,0x6F,0x6F,0x72,0x20
	.DB  0x4F,0x70,0x65,0x6E,0x65,0x64,0x0,0x57
	.DB  0x65,0x6C,0x63,0x6F,0x6D,0x65,0x0,0x53
	.DB  0x6D,0x61,0x72,0x74,0x20,0x4C,0x6F,0x63
	.DB  0x6B,0x0,0x50,0x72,0x65,0x73,0x73,0x20
	.DB  0x2A,0x20,0x74,0x6F,0x20,0x65,0x6E,0x74
	.DB  0x65,0x72,0x0,0x20,0x45,0x6E,0x74,0x65
	.DB  0x72,0x20,0x79,0x6F,0x75,0x72,0x20,0x49
	.DB  0x44,0x20,0x21,0x0,0x48,0x69,0x2C,0x20
	.DB  0x41,0x6D,0x72,0x2E,0x0,0x20,0x45,0x6E
	.DB  0x74,0x65,0x72,0x20,0x79,0x6F,0x75,0x72
	.DB  0x20,0x50,0x43,0x21,0x0,0x59,0x6F,0x75
	.DB  0x20,0x6D,0x61,0x79,0x20,0x45,0x6E,0x74
	.DB  0x65,0x72,0x2E,0x0,0x20,0x57,0x72,0x6F
	.DB  0x6E,0x67,0x20,0x50,0x61,0x73,0x73,0x77
	.DB  0x6F,0x72,0x64,0x20,0x0,0x48,0x69,0x2C
	.DB  0x41,0x68,0x6D,0x65,0x64,0x2E,0x0,0x48
	.DB  0x69,0x2C,0x20,0x41,0x64,0x65,0x6C,0x2E
	.DB  0x0,0x48,0x69,0x2C,0x20,0x4F,0x6D,0x61
	.DB  0x72,0x2E,0x0,0x48,0x69,0x2C,0x20,0x50
	.DB  0x72,0x6F,0x66,0x2E,0x48,0x2E,0x0,0x20
	.DB  0x57,0x72,0x6F,0x6E,0x67,0x20,0x49,0x44
	.DB  0x20,0x0,0x50,0x72,0x65,0x73,0x73,0x20
	.DB  0x2A,0x20,0x74,0x6F,0x20,0x73,0x74,0x61
	.DB  0x72,0x74,0x0,0x41,0x64,0x6D,0x69,0x6E
	.DB  0x20,0x41,0x63,0x65,0x73,0x73,0x0,0x52
	.DB  0x65,0x71,0x75,0x65,0x73,0x74,0x65,0x64
	.DB  0x0,0x20,0x45,0x6E,0x74,0x65,0x72,0x20
	.DB  0x41,0x64,0x6D,0x69,0x6E,0x20,0x50,0x43
	.DB  0x20,0x21,0x0,0x45,0x6E,0x74,0x65,0x72
	.DB  0x20,0x53,0x74,0x75,0x64,0x65,0x6E,0x74
	.DB  0x20,0x49,0x44,0x0,0x20,0x45,0x6E,0x74
	.DB  0x65,0x72,0x20,0x6E,0x65,0x77,0x20,0x50
	.DB  0x43,0x20,0x21,0x0,0x50,0x43,0x20,0x63
	.DB  0x68,0x61,0x6E,0x67,0x65,0x64,0x20,0x21
	.DB  0x21,0x0,0x20,0x57,0x72,0x6F,0x6E,0x67
	.DB  0x20,0x50,0x43,0x20,0x0,0x20,0x45,0x6E
	.DB  0x74,0x65,0x72,0x20,0x6F,0x6C,0x64,0x20
	.DB  0x50,0x43,0x20,0x21,0x0,0x52,0x65,0x2D
	.DB  0x65,0x6E,0x74,0x65,0x72,0x20,0x6E,0x65
	.DB  0x77,0x20,0x50,0x43,0x20,0x21,0x0,0x43
	.DB  0x6F,0x6E,0x74,0x61,0x63,0x74,0x20,0x41
	.DB  0x64,0x6D,0x69,0x6E,0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x160

	.CSEG
;/*
; *
; *
; Names :
;
; 1- Diaa Ahmed Riad
; 2- Raed Abd-ElHakim
; 3- Hazem Ayman
; 4- Mustafa nasr-Eldein
; 5- Eslam Mansour
;
; * Created: 12/22/2023 1:34:01 AM
; * Author: dell
; */
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <alcd.h>
;#include <delay.h>
;// GLobal variables
;char button; //avariable to store the operation value of the keypad
;int  number;  //variable stor the address of the eepron which is the ID
;char start = 0; //flag
;char hundreds,tens,units;   // to calculate the number enetered
;char EEnum;                 //the product of the modulus operation to store the data stored in the eeprom //EEnum = numb ...
;char re_enter_store;        // to store the rentered new pw
;
;
;
;//keypad Function
;unsigned char getnumberKP ()
; 0000 001F {

	.CSEG
_getnumberKP:
; .FSTART _getnumberKP
; 0000 0020     while (1)
_0x3:
; 0000 0021         {
; 0000 0022         PORTA.0 = 0;
	CBI  0x1B,0
; 0000 0023         PORTA.1 = 1;
	SBI  0x1B,1
; 0000 0024         PORTA.2 = 1;
	SBI  0x1B,2
; 0000 0025         if (PINA.3 == 0)    //Returns number one
	SBIC 0x19,3
	RJMP _0xC
; 0000 0026             {
; 0000 0027             while (PINA.3 == 0);
_0xD:
	SBIS 0x19,3
	RJMP _0xD
; 0000 0028             return 1;
	LDI  R30,LOW(1)
	RET
; 0000 0029             }
; 0000 002A         if (PINA.4 == 0)   //Returns number four
_0xC:
	SBIC 0x19,4
	RJMP _0x10
; 0000 002B             {
; 0000 002C             while (PINA.4 == 0);
_0x11:
	SBIS 0x19,4
	RJMP _0x11
; 0000 002D             return 4;
	LDI  R30,LOW(4)
	RET
; 0000 002E             }
; 0000 002F         if (PINA.5 == 0)    //Returns number seven
_0x10:
	SBIC 0x19,5
	RJMP _0x14
; 0000 0030             {
; 0000 0031             while (PINA.5 == 0);
_0x15:
	SBIS 0x19,5
	RJMP _0x15
; 0000 0032             return 7;
	LDI  R30,LOW(7)
	RET
; 0000 0033             }
; 0000 0034         if (PINA.6 == 0)    //Returns *
_0x14:
	SBIC 0x19,6
	RJMP _0x18
; 0000 0035             {
; 0000 0036             while (PINA.6 == 0);
_0x19:
	SBIS 0x19,6
	RJMP _0x19
; 0000 0037             return '*';
	LDI  R30,LOW(42)
	RET
; 0000 0038             }
; 0000 0039 
; 0000 003A         PORTA.0 = 1;
_0x18:
	SBI  0x1B,0
; 0000 003B         PORTA.1 = 0;
	CBI  0x1B,1
; 0000 003C         PORTA.2 = 1;
	SBI  0x1B,2
; 0000 003D         if (PINA.3 == 0)    //Returns number Two
	SBIC 0x19,3
	RJMP _0x22
; 0000 003E             {
; 0000 003F             while (PINA.3 == 0);
_0x23:
	SBIS 0x19,3
	RJMP _0x23
; 0000 0040             return 2;
	LDI  R30,LOW(2)
	RET
; 0000 0041             }
; 0000 0042         if (PINA.4 == 0)   //Returns number five
_0x22:
	SBIC 0x19,4
	RJMP _0x26
; 0000 0043             {
; 0000 0044             while (PINA.4 == 0);
_0x27:
	SBIS 0x19,4
	RJMP _0x27
; 0000 0045             return 5;
	LDI  R30,LOW(5)
	RET
; 0000 0046             }
; 0000 0047         if (PINA.5 == 0)    //Returns number eight
_0x26:
	SBIC 0x19,5
	RJMP _0x2A
; 0000 0048             {
; 0000 0049             while (PINA.5 == 0);
_0x2B:
	SBIS 0x19,5
	RJMP _0x2B
; 0000 004A             return 8;
	LDI  R30,LOW(8)
	RET
; 0000 004B             }
; 0000 004C         if (PINA.6 == 0)    //Returns number zero
_0x2A:
	SBIC 0x19,6
	RJMP _0x2E
; 0000 004D             {
; 0000 004E             while (PINA.6 == 0);
_0x2F:
	SBIS 0x19,6
	RJMP _0x2F
; 0000 004F             return 0;
	LDI  R30,LOW(0)
	RET
; 0000 0050             }
; 0000 0051         PORTA.0 = 1;
_0x2E:
	SBI  0x1B,0
; 0000 0052         PORTA.1 = 1;
	SBI  0x1B,1
; 0000 0053         PORTA.2 = 0;
	CBI  0x1B,2
; 0000 0054         if (PINA.3 == 0)    //Returns number three
	SBIC 0x19,3
	RJMP _0x38
; 0000 0055             {
; 0000 0056             while (PINA.3 == 0);
_0x39:
	SBIS 0x19,3
	RJMP _0x39
; 0000 0057             return 3;
	LDI  R30,LOW(3)
	RET
; 0000 0058             }
; 0000 0059         if (PINA.4 == 0)   //Returns number six
_0x38:
	SBIC 0x19,4
	RJMP _0x3C
; 0000 005A             {
; 0000 005B             while (PINA.4 == 0);
_0x3D:
	SBIS 0x19,4
	RJMP _0x3D
; 0000 005C             return 6;
	LDI  R30,LOW(6)
	RET
; 0000 005D             }
; 0000 005E         if (PINA.5 == 0)    //Returns number nine
_0x3C:
	SBIC 0x19,5
	RJMP _0x40
; 0000 005F             {
; 0000 0060             while (PINA.5 == 0);
_0x41:
	SBIS 0x19,5
	RJMP _0x41
; 0000 0061             return 9;
	LDI  R30,LOW(9)
	RET
; 0000 0062             }
; 0000 0063         if (PINA.6 == 0)    //Returns #
_0x40:
	SBIC 0x19,6
	RJMP _0x44
; 0000 0064             {
; 0000 0065             while (PINA.6 == 0);
_0x45:
	SBIS 0x19,6
	RJMP _0x45
; 0000 0066             return '#';
	LDI  R30,LOW(35)
	RET
; 0000 0067             }
; 0000 0068 
; 0000 0069 
; 0000 006A         }
_0x44:
	RJMP _0x3
; 0000 006B }
; .FEND
;//EEPROM WRITE fuction
;void WriteInEEPROM (int EEaddress, char data)
; 0000 006E {
_WriteInEEPROM:
; .FSTART _WriteInEEPROM
; 0000 006F     while (EECR.1 == 1);
	RCALL __SAVELOCR4
	MOV  R17,R26
	__GETWRS 18,19,4
;	EEaddress -> R18,R19
;	data -> R17
_0x48:
	SBIC 0x1C,1
	RJMP _0x48
; 0000 0070     EEAR = EEaddress;
	__OUTWR 18,19,30
; 0000 0071     EEDR = data;
	OUT  0x1D,R17
; 0000 0072     EECR.2 = 1;
	SBI  0x1C,2
; 0000 0073     EECR.1 = 1;
	SBI  0x1C,1
; 0000 0074 }
	RCALL __LOADLOCR4
	ADIW R28,6
	RET
; .FEND
;//EEPROM READ Function
;char ReadFromEEPROM (int address)
; 0000 0077 {
_ReadFromEEPROM:
; .FSTART _ReadFromEEPROM
; 0000 0078     while (EECR.1 == 1);
	ST   -Y,R17
	ST   -Y,R16
	MOVW R16,R26
;	address -> R16,R17
_0x4F:
	SBIC 0x1C,1
	RJMP _0x4F
; 0000 0079     EEAR = address;
	__OUTWR 16,17,30
; 0000 007A     EECR.0 = 1;
	SBI  0x1C,0
; 0000 007B     return EEDR;
	IN   R30,0x1D
	LD   R16,Y+
	LD   R17,Y+
	RET
; 0000 007C }
; .FEND
;//entered number function
;char threedigitnumber ()
; 0000 007F {
_threedigitnumber:
; .FSTART _threedigitnumber
; 0000 0080     hundreds = getnumberKP();
	RCALL SUBOPT_0x0
; 0000 0081     lcd_clear();
; 0000 0082     lcd_printf("You Entered: %d", hundreds);
; 0000 0083     delay_ms(250);
	RCALL SUBOPT_0x1
; 0000 0084     lcd_clear();
; 0000 0085     lcd_printf("You Entered: *");
	__POINTW1FN _0x0,16
	RCALL SUBOPT_0x2
; 0000 0086     tens = getnumberKP();
	MOV  R8,R30
; 0000 0087     lcd_clear();
	RCALL _lcd_clear
; 0000 0088     lcd_printf("You Entered: *%d", tens);
	__POINTW1FN _0x0,31
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x4
; 0000 0089     delay_ms(250);
; 0000 008A     lcd_clear();
; 0000 008B     lcd_printf("You Entered: **");
	__POINTW1FN _0x0,48
	RCALL SUBOPT_0x2
; 0000 008C     units = getnumberKP();
	MOV  R11,R30
; 0000 008D     lcd_clear();
	RCALL _lcd_clear
; 0000 008E     lcd_printf("You Entered: **%d", units);
	__POINTW1FN _0x0,64
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x4
; 0000 008F     delay_ms(250);
; 0000 0090     lcd_clear();
; 0000 0091     lcd_printf("You Entered: ***");
	__POINTW1FN _0x0,82
	RCALL SUBOPT_0x6
; 0000 0092     number = hundreds * 100 + tens * 10 + units;
	RJMP _0x2080002
; 0000 0093     return number, hundreds, tens, units;
; 0000 0094 }
; .FEND
;
;char withoutstar ()
; 0000 0097 {
_withoutstar:
; .FSTART _withoutstar
; 0000 0098     hundreds = getnumberKP();
	RCALL SUBOPT_0x0
; 0000 0099     lcd_clear();
; 0000 009A     lcd_printf("You Entered: %d", hundreds);
; 0000 009B     tens = getnumberKP();
	RCALL _getnumberKP
	MOV  R8,R30
; 0000 009C     lcd_clear();
	RCALL _lcd_clear
; 0000 009D     lcd_printf("You Entered: %d%d", hundreds, tens);
	__POINTW1FN _0x0,99
	RCALL SUBOPT_0x7
	LDI  R24,8
	RCALL _lcd_printf
	ADIW R28,10
; 0000 009E     units = getnumberKP();
	RCALL _getnumberKP
	MOV  R11,R30
; 0000 009F     lcd_clear();
	RCALL _lcd_clear
; 0000 00A0     lcd_printf("You Entered: %d%d%d", hundreds, tens, units);
	__POINTW1FN _0x0,117
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x5
	LDI  R24,12
	RCALL _lcd_printf
	ADIW R28,14
; 0000 00A1     delay_ms(2000);
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RCALL _delay_ms
; 0000 00A2     number = hundreds * 100 + tens * 10 + units;
_0x2080002:
	MOV  R26,R9
	LDI  R30,LOW(100)
	MUL  R30,R26
	MOVW R22,R0
	MOV  R26,R8
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOVW R26,R22
	ADD  R26,R30
	ADC  R27,R31
	MOV  R30,R11
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R6,R30
; 0000 00A3     return number, hundreds, tens, units;
	MOV  R30,R9
	MOV  R30,R8
	MOV  R30,R11
	RET
; 0000 00A4 }
; .FEND
;//to get the number in 8 bit
;
;//buzzing
;void buzzing ()
; 0000 00A9 {
_buzzing:
; .FSTART _buzzing
; 0000 00AA     PORTB.0 = 1;
	SBI  0x18,0
; 0000 00AB     PORTB.3 = 1;
	SBI  0x18,3
; 0000 00AC     delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 00AD     PORTB.0 = 0;
	CBI  0x18,0
; 0000 00AE     PORTB.3 = 0;
	CBI  0x18,3
; 0000 00AF     delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 00B0 }
	RET
; .FEND
;
;//door opening
;void dooropenning ()
; 0000 00B4 {
_dooropenning:
; .FSTART _dooropenning
; 0000 00B5     lcd_clear();
	RCALL _lcd_clear
; 0000 00B6     PORTB.2 = 1;
	SBI  0x18,2
; 0000 00B7     PORTB.1 = 1;
	SBI  0x18,1
; 0000 00B8     lcd_printfxy(0, 0, "  Door Opened");
	RCALL SUBOPT_0x8
	__POINTW1FN _0x0,137
	RCALL SUBOPT_0x9
; 0000 00B9     //lcd_printfxy(0,1,"shut the door !!");
; 0000 00BA     delay_ms(2000);
	RCALL SUBOPT_0xA
; 0000 00BB     lcd_clear();
; 0000 00BC     PORTB.1 = 0;
	CBI  0x18,1
; 0000 00BD     PORTB.2 = 0;
	CBI  0x18,2
; 0000 00BE }
	RET
; .FEND
;//main fuction
;void main(void)
; 0000 00C1 {
_main:
; .FSTART _main
; 0000 00C2     //Keypad Configuration
; 0000 00C3     DDRA = 0b00000111;
	LDI  R30,LOW(7)
	OUT  0x1A,R30
; 0000 00C4     PORTA = 0b11111000;
	LDI  R30,LOW(248)
	OUT  0x1B,R30
; 0000 00C5     //output intities configuration
; 0000 00C6     DDRB.0 = 1;       //buzzer
	SBI  0x17,0
; 0000 00C7     DDRB.1 = 1;      // solenoid lock
	SBI  0x17,1
; 0000 00C8     DDRB.3 = 1;     // alarm led
	SBI  0x17,3
; 0000 00C9     DDRB.2 = 1;    // go ahead led
	SBI  0x17,2
; 0000 00CA 
; 0000 00CB     // LCD initiation
; 0000 00CC     lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 00CD     // database
; 0000 00CE    // comment after burning it one time
; 0000 00CF 
; 0000 00D0      WriteInEEPROM(111,203%256);
	LDI  R30,LOW(111)
	LDI  R31,HIGH(111)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(203)
	RCALL _WriteInEEPROM
; 0000 00D1      WriteInEEPROM(126,123%256);
	LDI  R30,LOW(126)
	LDI  R31,HIGH(126)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(123)
	RCALL _WriteInEEPROM
; 0000 00D2      WriteInEEPROM(128,315%256);
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(59)
	RCALL _WriteInEEPROM
; 0000 00D3      WriteInEEPROM(130,223%256);
	LDI  R30,LOW(130)
	LDI  R31,HIGH(130)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(223)
	RCALL _WriteInEEPROM
; 0000 00D4      WriteInEEPROM(132,279%256);
	LDI  R30,LOW(132)
	LDI  R31,HIGH(132)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(23)
	RCALL _WriteInEEPROM
; 0000 00D5 
; 0000 00D6     //Welcome message when powered or reset
; 0000 00D7     lcd_printfxy(5, 0, "Welcome");
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	__POINTW1FN _0x0,151
	RCALL SUBOPT_0x9
; 0000 00D8     lcd_printfxy(0, 1, "Smart Lock");
	RCALL SUBOPT_0xB
	__POINTW1FN _0x0,159
	RCALL SUBOPT_0x9
; 0000 00D9     delay_ms(2000);
	RCALL SUBOPT_0xA
; 0000 00DA     lcd_clear();
; 0000 00DB     //External Interupt
; 0000 00DC     MCUCR |= (1 << 1);      // rising edge INT0
	IN   R30,0x35
	ORI  R30,2
	OUT  0x35,R30
; 0000 00DD     MCUCR |= (1 << 0);     //rising edge INT0
	IN   R30,0x35
	ORI  R30,1
	OUT  0x35,R30
; 0000 00DE     SREG.7 = 1;           // Global interupt setting
	BSET 7
; 0000 00DF     GICR |= (1 << 6);    //initiation of INT0
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
; 0000 00E0     //External Interupt 1
; 0000 00E1     MCUCR |= (1 << 2);       // rising edge INT1
	IN   R30,0x35
	ORI  R30,4
	OUT  0x35,R30
; 0000 00E2     MCUCR |= (1 << 3);      //rising edge INT1
	IN   R30,0x35
	ORI  R30,8
	OUT  0x35,R30
; 0000 00E3     SREG.7 = 1;            // Global interupt setting
	BSET 7
; 0000 00E4     GICR |= (1 << 7);     //initiation of INT0
	IN   R30,0x3B
	ORI  R30,0x80
	OUT  0x3B,R30
; 0000 00E5 
; 0000 00E6     while (1)
_0x6C:
; 0000 00E7         {
; 0000 00E8         lcd_printfxy(0, 0, "Press * to enter");
	RCALL SUBOPT_0x8
	__POINTW1FN _0x0,170
	RCALL SUBOPT_0x9
; 0000 00E9         button = getnumberKP();
	RCALL _getnumberKP
	MOV  R5,R30
; 0000 00EA 
; 0000 00EB         if (button == '*')
	LDI  R30,LOW(42)
	CP   R30,R5
	BREQ PC+2
	RJMP _0x6F
; 0000 00EC             {
; 0000 00ED             lcd_clear();
	RCALL SUBOPT_0xC
; 0000 00EE             start = 1;
; 0000 00EF             lcd_printf(" Enter your ID !");
; 0000 00F0             delay_ms(1000);
	RCALL SUBOPT_0xD
; 0000 00F1             lcd_clear();
; 0000 00F2             while (start == 1)
_0x70:
	LDI  R30,LOW(1)
	CP   R30,R4
	BREQ PC+2
	RJMP _0x72
; 0000 00F3                 {
; 0000 00F4                 threedigitnumber ();
	RCALL _threedigitnumber
; 0000 00F5                 //lcd_printfxy(0,0,"number = %d%d%d", hundreds,tens,units);
; 0000 00F6                 //lcd_printfxy(0,1,"number = %d", number);
; 0000 00F7                 //delay_ms(500);
; 0000 00F8                 switch (number)
	MOVW R30,R6
; 0000 00F9                     {
; 0000 00FA                     case 128 :
	CPI  R30,LOW(0x80)
	LDI  R26,HIGH(0x80)
	CPC  R31,R26
	BRNE _0x76
; 0000 00FB                         {
; 0000 00FC                         lcd_clear();
	RCALL _lcd_clear
; 0000 00FD                         lcd_printf("Hi, Amr.");
	__POINTW1FN _0x0,204
	RCALL SUBOPT_0x6
; 0000 00FE                         lcd_printfxy(0, 1, " Enter your PC!");
	RCALL SUBOPT_0xB
	__POINTW1FN _0x0,213
	RCALL SUBOPT_0x9
; 0000 00FF                         threedigitnumber ();
	RCALL _threedigitnumber
; 0000 0100                         EEnum = number % 256;
	MOV  R30,R6
	MOV  R10,R30
; 0000 0101                         if (EEnum ==  ReadFromEEPROM(128))
	LDI  R26,LOW(128)
	LDI  R27,0
	RCALL _ReadFromEEPROM
	CP   R30,R10
	BRNE _0x77
; 0000 0102                             {
; 0000 0103                             lcd_clear();
	RCALL SUBOPT_0xE
; 0000 0104                             lcd_printf("You may Enter.");
; 0000 0105                             delay_ms(1000);
	RCALL SUBOPT_0xF
; 0000 0106                             dooropenning ();
; 0000 0107                             delay_ms(1000);
	RJMP _0xAB
; 0000 0108                             start = 0;
; 0000 0109 
; 0000 010A                             }
; 0000 010B                         else
_0x77:
; 0000 010C                             {
; 0000 010D                             lcd_clear();
	RCALL SUBOPT_0x10
; 0000 010E                             lcd_printf(" Wrong Password ");
; 0000 010F                             buzzing ();
	RCALL _buzzing
; 0000 0110                             delay_ms(1000);
_0xAB:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 0111                             start = 0;
	CLR  R4
; 0000 0112 
; 0000 0113                             }
; 0000 0114                         }
; 0000 0115                     break;
	RJMP _0x75
; 0000 0116                     case 126 :
_0x76:
	CPI  R30,LOW(0x7E)
	LDI  R26,HIGH(0x7E)
	CPC  R31,R26
	BRNE _0x79
; 0000 0117                         {
; 0000 0118                         lcd_clear();
	RCALL _lcd_clear
; 0000 0119                         lcd_printf("Hi,Ahmed.");
	__POINTW1FN _0x0,261
	RCALL SUBOPT_0x6
; 0000 011A                         lcd_printfxy(0, 1, " Enter your PC!");
	RCALL SUBOPT_0xB
	__POINTW1FN _0x0,213
	RCALL SUBOPT_0x9
; 0000 011B                         threedigitnumber ();
	RCALL _threedigitnumber
; 0000 011C                         EEnum = number;
	MOV  R10,R6
; 0000 011D                         delay_ms(2000);
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RCALL _delay_ms
; 0000 011E 
; 0000 011F                         if (EEnum == ReadFromEEPROM(126))
	LDI  R26,LOW(126)
	LDI  R27,0
	RCALL _ReadFromEEPROM
	CP   R30,R10
	BRNE _0x7A
; 0000 0120                             {
; 0000 0121                             lcd_clear();
	RCALL SUBOPT_0xE
; 0000 0122                             lcd_printf("You may Enter.");
; 0000 0123                             delay_ms(1000);
	RCALL SUBOPT_0xF
; 0000 0124                             dooropenning ();
; 0000 0125                             delay_ms(1000);
	RJMP _0xAC
; 0000 0126                             start = 0;
; 0000 0127 
; 0000 0128                             }
; 0000 0129                         else
_0x7A:
; 0000 012A                             {
; 0000 012B                             lcd_clear();
	RCALL SUBOPT_0x10
; 0000 012C                             lcd_printf(" Wrong Password ");
; 0000 012D                             buzzing ();
	RCALL _buzzing
; 0000 012E                             delay_ms(1000);
_0xAC:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 012F                             start = 0;
	CLR  R4
; 0000 0130 
; 0000 0131                             }
; 0000 0132 
; 0000 0133                         }
; 0000 0134                     break;
	RJMP _0x75
; 0000 0135 
; 0000 0136                     case  130:
_0x79:
	CPI  R30,LOW(0x82)
	LDI  R26,HIGH(0x82)
	CPC  R31,R26
	BRNE _0x7C
; 0000 0137                         {
; 0000 0138                         lcd_clear();
	RCALL _lcd_clear
; 0000 0139                         lcd_printf("Hi, Adel.");
	__POINTW1FN _0x0,271
	RCALL SUBOPT_0x6
; 0000 013A                         lcd_printfxy(0, 1, " Enter your PC!");
	RCALL SUBOPT_0xB
	__POINTW1FN _0x0,213
	RCALL SUBOPT_0x9
; 0000 013B                         threedigitnumber ();
	RCALL _threedigitnumber
; 0000 013C                         EEnum = number % 256;
	MOV  R30,R6
	MOV  R10,R30
; 0000 013D                         if (EEnum == ReadFromEEPROM(130))
	LDI  R26,LOW(130)
	LDI  R27,0
	RCALL _ReadFromEEPROM
	CP   R30,R10
	BRNE _0x7D
; 0000 013E                             {
; 0000 013F                             lcd_clear();
	RCALL SUBOPT_0xE
; 0000 0140                             lcd_printf("You may Enter.");
; 0000 0141                             delay_ms(1000);
	RCALL SUBOPT_0xF
; 0000 0142                             dooropenning ();
; 0000 0143                             delay_ms(1000);
	RJMP _0xAD
; 0000 0144                             start = 0;
; 0000 0145 
; 0000 0146                             }
; 0000 0147                         else
_0x7D:
; 0000 0148                             {
; 0000 0149                             lcd_clear();
	RCALL SUBOPT_0x10
; 0000 014A                             lcd_printf(" Wrong Password ");
; 0000 014B                             buzzing ();
	RCALL _buzzing
; 0000 014C                             delay_ms(1000);
_0xAD:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 014D                             start = 0;
	CLR  R4
; 0000 014E 
; 0000 014F                             }
; 0000 0150                         }
; 0000 0151                     break;
	RJMP _0x75
; 0000 0152 
; 0000 0153                     case 132:
_0x7C:
	CPI  R30,LOW(0x84)
	LDI  R26,HIGH(0x84)
	CPC  R31,R26
	BRNE _0x7F
; 0000 0154                         {
; 0000 0155                         lcd_clear();
	RCALL _lcd_clear
; 0000 0156                         lcd_printf("Hi, Omar.");
	__POINTW1FN _0x0,281
	RCALL SUBOPT_0x6
; 0000 0157                         lcd_printfxy(0, 1, " Enter your PC!");
	RCALL SUBOPT_0xB
	__POINTW1FN _0x0,213
	RCALL SUBOPT_0x9
; 0000 0158                         threedigitnumber ();
	RCALL _threedigitnumber
; 0000 0159                         EEnum = number % 256;
	MOV  R30,R6
	MOV  R10,R30
; 0000 015A                         if (EEnum == ReadFromEEPROM(132))
	LDI  R26,LOW(132)
	LDI  R27,0
	RCALL _ReadFromEEPROM
	CP   R30,R10
	BRNE _0x80
; 0000 015B                             {
; 0000 015C                             lcd_clear();
	RCALL SUBOPT_0xE
; 0000 015D                             lcd_printf("You may Enter.");
; 0000 015E                             delay_ms(1000);
	RCALL SUBOPT_0xF
; 0000 015F                             dooropenning ();
; 0000 0160                             delay_ms(1000);
	RJMP _0xAE
; 0000 0161                             start = 0;
; 0000 0162 
; 0000 0163                             }
; 0000 0164                         else
_0x80:
; 0000 0165                             {
; 0000 0166                             lcd_clear();
	RCALL SUBOPT_0x10
; 0000 0167                             lcd_printf(" Wrong Password ");
; 0000 0168                             buzzing ();
	RCALL _buzzing
; 0000 0169                             buzzing ();
	RCALL _buzzing
; 0000 016A                             delay_ms(1000);
_0xAE:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 016B                             start = 0;
	CLR  R4
; 0000 016C 
; 0000 016D                             }
; 0000 016E                         }
; 0000 016F 
; 0000 0170                     break;
	RJMP _0x75
; 0000 0171 
; 0000 0172                     case 111:
_0x7F:
	CPI  R30,LOW(0x6F)
	LDI  R26,HIGH(0x6F)
	CPC  R31,R26
	BRNE _0x85
; 0000 0173                         {
; 0000 0174                         lcd_clear();
	RCALL _lcd_clear
; 0000 0175                         lcd_printf("Hi, Prof.H.");
	__POINTW1FN _0x0,291
	RCALL SUBOPT_0x6
; 0000 0176                         lcd_printfxy(0, 1, " Enter your PC!");
	RCALL SUBOPT_0xB
	__POINTW1FN _0x0,213
	RCALL SUBOPT_0x9
; 0000 0177                         threedigitnumber ();
	RCALL SUBOPT_0x11
; 0000 0178                         EEnum = number % 256;
; 0000 0179                         if (EEnum == ReadFromEEPROM(111))
	BRNE _0x83
; 0000 017A                             {
; 0000 017B                             lcd_clear();
	RCALL SUBOPT_0xE
; 0000 017C                             lcd_printf("You may Enter.");
; 0000 017D                             delay_ms(1000);
	RCALL SUBOPT_0xF
; 0000 017E                             dooropenning ();
; 0000 017F                             delay_ms(1000);
	RJMP _0xAF
; 0000 0180                             start = 0;
; 0000 0181 
; 0000 0182                             }
; 0000 0183                         else
_0x83:
; 0000 0184                             {
; 0000 0185                             lcd_clear();
	RCALL SUBOPT_0x10
; 0000 0186                             lcd_printf(" Wrong Password ");
; 0000 0187                             buzzing ();
	RCALL _buzzing
; 0000 0188                             buzzing ();
	RCALL _buzzing
; 0000 0189                             delay_ms(1000);
_0xAF:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 018A                             start = 0;
	CLR  R4
; 0000 018B 
; 0000 018C                             }
; 0000 018D                         }
; 0000 018E                     break;
	RJMP _0x75
; 0000 018F 
; 0000 0190                     default:
_0x85:
; 0000 0191                         {
; 0000 0192                      lcd_clear();
	RCALL SUBOPT_0x12
; 0000 0193                         lcd_printf(" Wrong ID ");
; 0000 0194                         buzzing ();
	RCALL _buzzing
; 0000 0195                         start = 0;
	RCALL SUBOPT_0x13
; 0000 0196                         delay_ms(1000);
; 0000 0197 
; 0000 0198                         }
; 0000 0199                     break;
; 0000 019A                     }
_0x75:
; 0000 019B 
; 0000 019C                 }
	RJMP _0x70
_0x72:
; 0000 019D             }
; 0000 019E 
; 0000 019F         else
	RJMP _0x86
_0x6F:
; 0000 01A0             {
; 0000 01A1             lcd_clear();
	RCALL _lcd_clear
; 0000 01A2             lcd_printf("Press * to start");
	__POINTW1FN _0x0,314
	RCALL SUBOPT_0x6
; 0000 01A3             buzzing ();
	RCALL _buzzing
; 0000 01A4             delay_ms(1000);
	RCALL SUBOPT_0xD
; 0000 01A5             lcd_clear();
; 0000 01A6             }
_0x86:
; 0000 01A7 
; 0000 01A8 
; 0000 01A9 
; 0000 01AA         }
	RJMP _0x6C
; 0000 01AB }
_0x87:
	RJMP _0x87
; .FEND
;interrupt [2] void Adminaccess (void)
; 0000 01AD {    int id;
_Adminaccess:
; .FSTART _Adminaccess
	RCALL SUBOPT_0x14
; 0000 01AE      lcd_clear();
	ST   -Y,R17
	ST   -Y,R16
;	id -> R16,R17
	RCALL _lcd_clear
; 0000 01AF     start = 1;
	LDI  R30,LOW(1)
	MOV  R4,R30
; 0000 01B0     lcd_printfxy(0, 0, "Admin Acess");
	RCALL SUBOPT_0x8
	__POINTW1FN _0x0,331
	RCALL SUBOPT_0x9
; 0000 01B1     lcd_printfxy(4, 1, "Requested");
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	__POINTW1FN _0x0,343
	RCALL SUBOPT_0x9
; 0000 01B2     delay_ms(2000);
	RCALL SUBOPT_0xA
; 0000 01B3     lcd_clear();
; 0000 01B4     lcd_printf(" Enter Admin PC !");
	__POINTW1FN _0x0,353
	RCALL SUBOPT_0x6
; 0000 01B5     delay_ms(1000);
	RCALL SUBOPT_0xD
; 0000 01B6     lcd_clear();
; 0000 01B7     while (start == 1)
_0x88:
	LDI  R30,LOW(1)
	CP   R30,R4
	BRNE _0x8A
; 0000 01B8         {
; 0000 01B9         threedigitnumber ();
	RCALL SUBOPT_0x11
; 0000 01BA         EEnum = number % 256;
; 0000 01BB         if (EEnum == ReadFromEEPROM(111) )
	BRNE _0x8B
; 0000 01BC             {
; 0000 01BD             lcd_clear();
	RCALL _lcd_clear
; 0000 01BE             lcd_printf("Enter Student ID");
	__POINTW1FN _0x0,371
	RCALL SUBOPT_0x6
; 0000 01BF             threedigitnumber ();
	RCALL _threedigitnumber
; 0000 01C0             id=number;
	MOVW R16,R6
; 0000 01C1             delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 01C2             switch (id)
	RCALL SUBOPT_0x15
; 0000 01C3                    {
; 0000 01C4                    case 111 :
	BREQ _0x90
; 0000 01C5                    case 126 :
	CPI  R30,LOW(0x7E)
	LDI  R26,HIGH(0x7E)
	CPC  R31,R26
	BRNE _0x91
_0x90:
; 0000 01C6                    case 128 :
	RJMP _0x92
_0x91:
	CPI  R30,LOW(0x80)
	LDI  R26,HIGH(0x80)
	CPC  R31,R26
	BRNE _0x93
_0x92:
; 0000 01C7                    case 130 :
	RJMP _0x94
_0x93:
	CPI  R30,LOW(0x82)
	LDI  R26,HIGH(0x82)
	CPC  R31,R26
	BRNE _0x95
_0x94:
; 0000 01C8                    case 132 :
	RJMP _0x96
_0x95:
	CPI  R30,LOW(0x84)
	LDI  R26,HIGH(0x84)
	CPC  R31,R26
	BRNE _0x98
_0x96:
; 0000 01C9                    { lcd_clear();
	RCALL SUBOPT_0x16
; 0000 01CA                    lcd_printf(" Enter new PC !");
; 0000 01CB                    delay_ms(1000);
	RCALL SUBOPT_0xD
; 0000 01CC                    lcd_clear();
; 0000 01CD                    withoutstar ();
	RCALL SUBOPT_0x17
; 0000 01CE                    EEnum = number % 256;
; 0000 01CF                    lcd_clear();
; 0000 01D0                    WriteInEEPROM(id, EEnum);
	RCALL SUBOPT_0x18
; 0000 01D1                    lcd_printf("PC changed !!");
; 0000 01D2                    delay_ms(1000);
	RCALL SUBOPT_0xD
; 0000 01D3                    lcd_clear();
; 0000 01D4                    start = 0;
	CLR  R4
; 0000 01D5                    lcd_clear();}
	RCALL _lcd_clear
; 0000 01D6 
; 0000 01D7                     break;
	RJMP _0x8E
; 0000 01D8                    default:
_0x98:
; 0000 01D9                         {
; 0000 01DA                         lcd_clear();
	RCALL _lcd_clear
; 0000 01DB                         lcd_printf(" Wrong PC ");
	__POINTW1FN _0x0,418
	RCALL SUBOPT_0x6
; 0000 01DC                         buzzing ();
	RCALL _buzzing
; 0000 01DD                         buzzing ();
	RCALL _buzzing
; 0000 01DE                         start = 0;
	RCALL SUBOPT_0x13
; 0000 01DF 
; 0000 01E0                         delay_ms(1000);
; 0000 01E1                         }
; 0000 01E2                     break;
; 0000 01E3                     }
_0x8E:
; 0000 01E4 
; 0000 01E5             }
; 0000 01E6             else
	RJMP _0x99
_0x8B:
; 0000 01E7             {
; 0000 01E8                lcd_clear();
	RCALL SUBOPT_0x12
; 0000 01E9                lcd_printf(" Wrong ID ");
; 0000 01EA                buzzing ();
	RCALL _buzzing
; 0000 01EB                buzzing ();
	RCALL _buzzing
; 0000 01EC                start = 0;
	RCALL SUBOPT_0x13
; 0000 01ED                delay_ms(1000);
; 0000 01EE               }
_0x99:
; 0000 01EF }
	RJMP _0x88
_0x8A:
; 0000 01F0 }
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0xB1
; .FEND
;interrupt [3] void change_pass_code (void)
; 0000 01F2 {           int ID,PC;
_change_pass_code:
; .FSTART _change_pass_code
	RCALL SUBOPT_0x14
; 0000 01F3             lcd_clear();
	RCALL __SAVELOCR4
;	ID -> R16,R17
;	PC -> R18,R19
	RCALL SUBOPT_0xC
; 0000 01F4             start = 1;
; 0000 01F5             lcd_printf(" Enter your ID !");
; 0000 01F6             delay_ms(1000);
	RCALL SUBOPT_0xD
; 0000 01F7             lcd_clear();
; 0000 01F8             threedigitnumber ();
	RCALL _threedigitnumber
; 0000 01F9             ID=number;
	MOVW R16,R6
; 0000 01FA              switch (ID)
	RCALL SUBOPT_0x15
; 0000 01FB                    {
; 0000 01FC                    case 111 :
	BREQ _0x9E
; 0000 01FD                    case 126 :
	CPI  R30,LOW(0x7E)
	LDI  R26,HIGH(0x7E)
	CPC  R31,R26
	BRNE _0x9F
_0x9E:
; 0000 01FE                    case 128 :
	RJMP _0xA0
_0x9F:
	CPI  R30,LOW(0x80)
	LDI  R26,HIGH(0x80)
	CPC  R31,R26
	BRNE _0xA1
_0xA0:
; 0000 01FF                    case 130 :
	RJMP _0xA2
_0xA1:
	CPI  R30,LOW(0x82)
	LDI  R26,HIGH(0x82)
	CPC  R31,R26
	BRNE _0xA3
_0xA2:
; 0000 0200                    case 132 :
	RJMP _0xA4
_0xA3:
	CPI  R30,LOW(0x84)
	LDI  R26,HIGH(0x84)
	CPC  R31,R26
	BRNE _0xAA
_0xA4:
; 0000 0201                    {
; 0000 0202                    EEnum = ReadFromEEPROM(ID);
	MOVW R26,R16
	RCALL _ReadFromEEPROM
	MOV  R10,R30
; 0000 0203                    lcd_clear();
	RCALL _lcd_clear
; 0000 0204                    lcd_printf(" Enter old PC !");
	__POINTW1FN _0x0,429
	RCALL SUBOPT_0x6
; 0000 0205                    delay_ms(1000);
	RCALL SUBOPT_0xD
; 0000 0206                    lcd_clear();
; 0000 0207                    withoutstar ();
	RCALL _withoutstar
; 0000 0208                    PC = number % 256;
	MOVW R30,R6
	LDI  R26,LOW(255)
	LDI  R27,HIGH(255)
	RCALL __MANDW12
	MOVW R18,R30
; 0000 0209                    lcd_clear();
	RCALL _lcd_clear
; 0000 020A                    if (PC == EEnum)
	MOV  R30,R10
	MOVW R26,R18
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0xA6
; 0000 020B                    {
; 0000 020C                             lcd_clear();
	RCALL SUBOPT_0x16
; 0000 020D                             lcd_printf(" Enter new PC !");
; 0000 020E                             delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 020F                             withoutstar ();
	RCALL SUBOPT_0x17
; 0000 0210                             EEnum = number % 256;
; 0000 0211                             lcd_clear();
; 0000 0212                             lcd_printf("Re-enter new PC !");
	__POINTW1FN _0x0,445
	RCALL SUBOPT_0x6
; 0000 0213                             delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 0214                             withoutstar ();
	RCALL _withoutstar
; 0000 0215                             re_enter_store = number % 256;
	MOV  R30,R6
	MOV  R13,R30
; 0000 0216                             lcd_clear();
	RCALL _lcd_clear
; 0000 0217                             if (re_enter_store == EEnum)
	CP   R10,R13
	BRNE _0xA7
; 0000 0218                                 {
; 0000 0219                                 WriteInEEPROM(ID,EEnum);
	RCALL SUBOPT_0x18
; 0000 021A                                 lcd_printf("PC changed !!");
; 0000 021B                                 delay_ms(1000);
	RJMP _0xB0
; 0000 021C                                 lcd_clear();
; 0000 021D                                 start = 0;
; 0000 021E                                 }
; 0000 021F                            else
_0xA7:
; 0000 0220                                 {
; 0000 0221 
; 0000 0222                                 lcd_clear();
	RCALL SUBOPT_0x19
; 0000 0223                                 lcd_printf("Contact Admin");
; 0000 0224                                 buzzing ();
	RCALL _buzzing
; 0000 0225                                 buzzing ();
	RCALL _buzzing
; 0000 0226                                 delay_ms(1000);
_0xB0:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0000 0227                                 lcd_clear();
	RCALL _lcd_clear
; 0000 0228                                 start = 0;
	CLR  R4
; 0000 0229                                 }
; 0000 022A                                 }
; 0000 022B                         else
	RJMP _0xA9
_0xA6:
; 0000 022C                             {
; 0000 022D                             lcd_clear();
	RCALL SUBOPT_0x19
; 0000 022E                             lcd_printf("Contact Admin");
; 0000 022F                             buzzing ();
	RCALL _buzzing
; 0000 0230                             buzzing ();
	RCALL _buzzing
; 0000 0231                             delay_ms(1000);
	RCALL SUBOPT_0xD
; 0000 0232                             lcd_clear();
; 0000 0233                             start = 0;
	CLR  R4
; 0000 0234                             }
_0xA9:
; 0000 0235                    }
; 0000 0236                     break;
	RJMP _0x9C
; 0000 0237 
; 0000 0238 
; 0000 0239                    default:
_0xAA:
; 0000 023A                         {
; 0000 023B                         lcd_clear();
	RCALL SUBOPT_0x12
; 0000 023C                         lcd_printf(" Wrong ID ");
; 0000 023D                         buzzing ();
	RCALL _buzzing
; 0000 023E                         buzzing ();
	RCALL _buzzing
; 0000 023F                         start = 0;
	RCALL SUBOPT_0x13
; 0000 0240 
; 0000 0241                         delay_ms(1000);
; 0000 0242                         }
; 0000 0243                     break;
; 0000 0244                     }
_0x9C:
; 0000 0245 
; 0000 0246 }
	RCALL __LOADLOCR4
	ADIW R28,4
_0xB1:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x15
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	MOV  R30,R17
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x15,R30
	__DELAY_USB 13
	SBI  0x15,2
	__DELAY_USB 13
	CBI  0x15,2
	__DELAY_USB 13
	RJMP _0x2080001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	ADIW R28,1
	RET
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
	LDD  R16,Y+2
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	ADD  R30,R16
	MOV  R26,R30
	RCALL __lcd_write_data
	MOV  R12,R16
	STS  __lcd_y,R17
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x1A
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x1A
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	MOV  R12,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R17
	MOV  R17,R26
	CPI  R17,10
	BREQ _0x2000005
	LDS  R30,__lcd_maxx
	CP   R12,R30
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	CPI  R17,10
	BREQ _0x2080001
_0x2000004:
	INC  R12
	SBI  0x15,0
	MOV  R26,R17
	RCALL __lcd_write_data
	CBI  0x15,0
	RJMP _0x2080001
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x14
	ORI  R30,LOW(0xF0)
	OUT  0x14,R30
	SBI  0x14,2
	SBI  0x14,0
	SBI  0x14,1
	CBI  0x15,2
	CBI  0x15,0
	CBI  0x15,1
	STS  __lcd_maxx,R17
	MOV  R30,R17
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	MOV  R30,R17
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1B
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080001:
	LD   R17,Y+
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
__print_G101:
; .FSTART __print_G101
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2020016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2020018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x202001C
	CPI  R18,37
	BRNE _0x202001D
	LDI  R17,LOW(1)
	RJMP _0x202001E
_0x202001D:
	RCALL SUBOPT_0x1C
_0x202001E:
	RJMP _0x202001B
_0x202001C:
	CPI  R30,LOW(0x1)
	BRNE _0x202001F
	CPI  R18,37
	BRNE _0x2020020
	RCALL SUBOPT_0x1C
	RJMP _0x20200CC
_0x2020020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2020021
	LDI  R16,LOW(1)
	RJMP _0x202001B
_0x2020021:
	CPI  R18,43
	BRNE _0x2020022
	LDI  R20,LOW(43)
	RJMP _0x202001B
_0x2020022:
	CPI  R18,32
	BRNE _0x2020023
	LDI  R20,LOW(32)
	RJMP _0x202001B
_0x2020023:
	RJMP _0x2020024
_0x202001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2020025
_0x2020024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2020026
	ORI  R16,LOW(128)
	RJMP _0x202001B
_0x2020026:
	RJMP _0x2020027
_0x2020025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x202001B
_0x2020027:
	CPI  R18,48
	BRLO _0x202002A
	CPI  R18,58
	BRLO _0x202002B
_0x202002A:
	RJMP _0x2020029
_0x202002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x202001B
_0x2020029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x202002F
	RCALL SUBOPT_0x1D
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x1E
	RJMP _0x2020030
_0x202002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2020032
	RCALL SUBOPT_0x1D
	RCALL SUBOPT_0x1F
	RCALL _strlen
	MOV  R17,R30
	RJMP _0x2020033
_0x2020032:
	CPI  R30,LOW(0x70)
	BRNE _0x2020035
	RCALL SUBOPT_0x1D
	RCALL SUBOPT_0x1F
	RCALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2020033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2020036
_0x2020035:
	CPI  R30,LOW(0x64)
	BREQ _0x2020039
	CPI  R30,LOW(0x69)
	BRNE _0x202003A
_0x2020039:
	ORI  R16,LOW(4)
	RJMP _0x202003B
_0x202003A:
	CPI  R30,LOW(0x75)
	BRNE _0x202003C
_0x202003B:
	LDI  R30,LOW(_tbl10_G101*2)
	LDI  R31,HIGH(_tbl10_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x202003D
_0x202003C:
	CPI  R30,LOW(0x58)
	BRNE _0x202003F
	ORI  R16,LOW(8)
	RJMP _0x2020040
_0x202003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2020071
_0x2020040:
	LDI  R30,LOW(_tbl16_G101*2)
	LDI  R31,HIGH(_tbl16_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x202003D:
	SBRS R16,2
	RJMP _0x2020042
	RCALL SUBOPT_0x1D
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2020043
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2020043:
	CPI  R20,0
	BREQ _0x2020044
	SUBI R17,-LOW(1)
	RJMP _0x2020045
_0x2020044:
	ANDI R16,LOW(251)
_0x2020045:
	RJMP _0x2020046
_0x2020042:
	RCALL SUBOPT_0x1D
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0x2020046:
_0x2020036:
	SBRC R16,0
	RJMP _0x2020047
_0x2020048:
	CP   R17,R21
	BRSH _0x202004A
	SBRS R16,7
	RJMP _0x202004B
	SBRS R16,2
	RJMP _0x202004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x202004D
_0x202004C:
	LDI  R18,LOW(48)
_0x202004D:
	RJMP _0x202004E
_0x202004B:
	LDI  R18,LOW(32)
_0x202004E:
	RCALL SUBOPT_0x1C
	SUBI R21,LOW(1)
	RJMP _0x2020048
_0x202004A:
_0x2020047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x202004F
_0x2020050:
	CPI  R19,0
	BREQ _0x2020052
	SBRS R16,3
	RJMP _0x2020053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2020054
_0x2020053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2020054:
	RCALL SUBOPT_0x1C
	CPI  R21,0
	BREQ _0x2020055
	SUBI R21,LOW(1)
_0x2020055:
	SUBI R19,LOW(1)
	RJMP _0x2020050
_0x2020052:
	RJMP _0x2020056
_0x202004F:
_0x2020058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x202005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x202005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x202005A
_0x202005C:
	CPI  R18,58
	BRLO _0x202005D
	SBRS R16,3
	RJMP _0x202005E
	SUBI R18,-LOW(7)
	RJMP _0x202005F
_0x202005E:
	SUBI R18,-LOW(39)
_0x202005F:
_0x202005D:
	SBRC R16,4
	RJMP _0x2020061
	CPI  R18,49
	BRSH _0x2020063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2020062
_0x2020063:
	RJMP _0x20200CD
_0x2020062:
	CP   R21,R19
	BRLO _0x2020067
	SBRS R16,0
	RJMP _0x2020068
_0x2020067:
	RJMP _0x2020066
_0x2020068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2020069
	LDI  R18,LOW(48)
_0x20200CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x202006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	RCALL SUBOPT_0x1E
	CPI  R21,0
	BREQ _0x202006B
	SUBI R21,LOW(1)
_0x202006B:
_0x202006A:
_0x2020069:
_0x2020061:
	RCALL SUBOPT_0x1C
	CPI  R21,0
	BREQ _0x202006C
	SUBI R21,LOW(1)
_0x202006C:
_0x2020066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2020059
	RJMP _0x2020058
_0x2020059:
_0x2020056:
	SBRS R16,0
	RJMP _0x202006D
_0x202006E:
	CPI  R21,0
	BREQ _0x2020070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x1E
	RJMP _0x202006E
_0x2020070:
_0x202006D:
_0x2020071:
_0x2020030:
_0x20200CC:
	LDI  R17,LOW(0)
_0x202001B:
	RJMP _0x2020016
_0x2020018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LD   R30,X+
	LD   R31,X+
	RCALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_put_lcd_G101:
; .FSTART _put_lcd_G101
	RCALL __SAVELOCR4
	MOVW R16,R26
	LDD  R19,Y+4
	MOV  R26,R19
	RCALL _lcd_putchar
	MOVW R26,R16
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RCALL __LOADLOCR4
	ADIW R28,5
	RET
; .FEND
_lcd_printf:
; .FSTART _lcd_printf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,4
	RCALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL SUBOPT_0x20
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G101
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	POP  R15
	RET
; .FEND
_lcd_printfxy:
; .FSTART _lcd_printfxy
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	RCALL __SAVELOCR4
	MOVW R30,R28
	RCALL __ADDW1R15
	LDD  R19,Z+12
	LDD  R18,Z+13
	MOVW R26,R28
	ADIW R26,6
	RCALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
	STD  Y+8,R30
	STD  Y+8+1,R30
	ST   -Y,R18
	MOV  R26,R19
	RCALL _lcd_gotoxy
	MOVW R26,R28
	ADIW R26,10
	RCALL SUBOPT_0x20
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G101
	RCALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.DSEG
__base_y_G100:
	.BYTE 0x4
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x0:
	RCALL _getnumberKP
	MOV  R9,R30
	RCALL _lcd_clear
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R9
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _lcd_printf
	ADIW R28,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1:
	LDI  R26,LOW(250)
	LDI  R27,0
	RCALL _delay_ms
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _lcd_printf
	ADIW R28,2
	RJMP _getnumberKP

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x3:
	MOV  R30,R8
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDI  R24,4
	RCALL _lcd_printf
	ADIW R28,6
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	MOV  R30,R11
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 33 TIMES, CODE SIZE REDUCTION:126 WORDS
SUBOPT_0x6:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _lcd_printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7:
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R9
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:38 WORDS
SUBOPT_0x9:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _lcd_printfxy
	ADIW R28,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	RCALL _delay_ms
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xB:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	RCALL _lcd_clear
	LDI  R30,LOW(1)
	MOV  R4,R30
	__POINTW1FN _0x0,187
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0xD:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xE:
	RCALL _lcd_clear
	__POINTW1FN _0x0,229
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xF:
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
	RJMP _dooropenning

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x10:
	RCALL _lcd_clear
	__POINTW1FN _0x0,244
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x11:
	RCALL _threedigitnumber
	MOV  R30,R6
	MOV  R10,R30
	LDI  R26,LOW(111)
	LDI  R27,0
	RCALL _ReadFromEEPROM
	CP   R30,R10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x12:
	RCALL _lcd_clear
	__POINTW1FN _0x0,303
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x13:
	CLR  R4
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x14:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x15:
	MOVW R30,R16
	CPI  R30,LOW(0x6F)
	LDI  R26,HIGH(0x6F)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	RCALL _lcd_clear
	__POINTW1FN _0x0,388
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	RCALL _withoutstar
	MOV  R30,R6
	MOV  R10,R30
	RJMP _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x18:
	ST   -Y,R17
	ST   -Y,R16
	MOV  R26,R10
	RCALL _WriteInEEPROM
	__POINTW1FN _0x0,404
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	RCALL _lcd_clear
	__POINTW1FN _0x0,463
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1B:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x1C:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x1D:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1E:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1F:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x20:
	RCALL __ADDW2R15
	LD   R30,X+
	LD   R31,X+
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_lcd_G101)
	LDI  R31,HIGH(_put_lcd_G101)
	ST   -Y,R31
	ST   -Y,R30
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ADDW1R15:
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	RET

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__MANDW12:
	CLT
	SBRS R31,7
	RJMP __MANDW121
	RCALL __ANEGW1
	SET
__MANDW121:
	AND  R30,R26
	AND  R31,R27
	BRTC __MANDW122
	RCALL __ANEGW1
__MANDW122:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
