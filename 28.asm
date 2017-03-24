include 'emu8086.inc'
;read array and make calculations
ORG 100h
   
   LEA SI,x ;stores pointer to first element in the array
   MOV BX,1  ;stores 1 in BX for multiplying (ex: 12 = 1*10 + 2)
   MOV AX,10  ;stores 10 in AX for multiplying
   
   MUL BX    ;multiply BX with AX, AX stores the product (we got the MSD (most significant digit) of first operand)
   
   INC SI ;move to next char in the array
   MOV AX,[SI]  ;store value of pointer ,the elem in array in AX for adding
   ADD BX,AX  ; we add the last digit to get full nr
   
   ADD SI,2  ; move to the 4th char in array skipping the operator
   
   MOV AX,10 ;same as for the first nr (5*10 + 6)
   MOV CX,1
   MUL CX
   
   INC SI
   MOV AX,[SI]
   ADD CX,BX
   
   LEA SI,x  ; store again theposition of first elem of array in SI 
   ADD SI,2  ; move to the position of the operator in the array
   
   CMP SI,43 ; check if it's the ascii code for '+'
   JE adding
       SUB CX,BX ;if not we interprate as ' - '
       MOV AX,CX ;move the result in AX for printing
       CALL PRINT_NUM
   adding: 
        ADD CX,BX  ;perform the adding between the two nr stored in BX and CX
        MOV AX,CX ; move in AX for printing
        CALL PRINT_NUM 
        
   CMP SI,42 ; check if it's the ascii code for ' * '
   JE multiply
         PRINT ' ' 
      multiply:
         MOV AX,BX ;move bx in ax for multiplying the 2 operands
         MUL CX ; multiply them, product stored in ax
         CALL PRINT_NUM ;print result
    CMP SI,47
	JE divide
		PRINT ' '
	divide:
		MOV AX,BX;store bx in ax 
		DIV CX;divide cx with ax(bx value)
		CALL PRINT_NUM;print result
RET

 x DW 1,2,'+',5,6
 DEFINE_PRINT_NUM
 DEFINE_PRINT_NUM_UNS

END