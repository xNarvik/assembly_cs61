; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 04
; Lab Section: 023
; TA: Aditya Tammewar
;
; I herby certify that the contents of this file are ENTIRELY my own original
; work.
; =======================================================================
; -----------------------------------------------------------------------
; Subroutine:    SUB_MAIN_30000
; Input:         None.
; Postcondition: None.
; Return Value:  None.
; -----------------------------------------------------------------------
                         .ORIG x3000          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_30000
; -----------------------------------------------------------------------
                         LD  R0, DATA_PTR         ;R0 <-- DATA_PTR
                         LD  R1, TWO_ZERO         ;R1 <-- TWO_ZERO
                         LD  R3, COUNT            ;R3 <-- COUNT
STORE                         
                         STR R1, R0, #0           ;R0 <-- mem[R1]
                         ADD R0, R0, #1           ;R0 <-- R0 + #1
                         ADD R1, R1, R1           ;R1 <-- R1 + R1
                         ADD R3, R3, #-1          ;R3 <-- R3 + #-1
                         BRp STORE                ;if(R3 > 0) STORE
                         
                         LD  R0, DATA_PTR         ;R0 <-- DATA_PTR
                         LD  R3, COUNT            ;R3 <-- COUNT
                  
PRINT                         
                         LDR R2, R0, #0           ;R2 <-- mem[R0]
                         LEA R6, subroutine       ;R6 <-- subroutine 
                         JMP R6                   ;PC <-- mem[R6]
return_point:                         
                         ADD R0, R0, #1           ;R0 <-- R0 + #1
                         ADD R3, R3, #-1          ;R3 <-- R3 + #-1
                         BRp PRINT                ;if(R3 > 0) PRINT

                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------

TWO_ZERO                 .FILL #1
DATA_PTR                 .FILL x4000
COUNT                    .FILL #10
                         .ORIG x4000
                         .BLKW #10
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
                         
                         
; -----------------------------------------------------------------------
;Subroutine:    Print binary
;Input (R2):    The value to convert to binary in dec
;
;Poscondition:  display the binary representation of the value in R2 
;               onto console
;Return  ():    none
; -----------------------------------------------------------------------
                         .ORIG x3020
; -----------------------------------------------------------------------
;INSTRUCTION BLOCK FOR SUB_3200
; -----------------------------------------------------------------------                         
subroutine:
                         ST  R0, BACKUP_R0       
                         ST  R3, BACKUP_R3       
                         LD  R1, COUNTER          ;R2 <-- MEM[COUNTER]
                         LD  R3, SPACE_COUNT      ;R3 <-- MEM[SPACE_COUNT]
                         ;FIRST CHECK
                         ADD R2, R2, #0           ;CHECK R1
                         BRn PRINT_1
                         BR  PRINT_0
;AFTER 1ST CHECK, SHIFT THE BITS                         
SHIFT
                         ADD R1, R1, #-1          ;R2 <-- R2 + #-1
                         BRz END                  ;if(R2 == 0) END
                         
                         ADD R2, R2, R2           ;R1 <-- R1 + R1 //LEFT SHIFT
                         BRn PRINT_1              ;if(R1 < 0) PRINT_1
                         BR  PRINT_0              ;else PRINT_0
PRINT_0
                         LD  R0, ZERO_CHAR        ;R0 <-- MEM[ZERO_CHAR]
                         OUT                      ;CONSOLE <-- MEM[R0]
                         ADD R3, R3, #-1          ;R3 <-- R3 + #-1
                         BRz PRINT_SPACE          ;if(R3 == 0) PRINT_SPACE
                         BR  SHIFT                ;else SHIFT
PRINT_1
                         LD  R0, ONE_CHAR         ;R0 <-- MEM[ONE_CHAR]
                         OUT                      ;CONSOLE <-- MEM[R0]
                         ADD R3, R3, #-1          ;;R3 <-- R3 + #-1
                         BRz PRINT_SPACE          ;if(R3 == 0) PRINT_SPACE
                         BR  SHIFT                ;else SHIFT
                         
PRINT_SPACE
                         LD  R3, SPACE_COUNT      ;R3 <-- MEM[SPACE_COUNT]
                         LD  R0, SPACE_CHAR       ;R0 <-- MEM[SPACE_CHAR] 
                         OUT                      ;CONSOLE <-- MEM[R0]
                         BR  SHIFT                ;JUMP TO SHIFT
END                         
                         LD  R0, NEW_LINE         ;R0 <-- MEM[NEW_LINE]
                         OUT                      ;CONSOLE <-- MEM[R0]
                         
                         LD  R0, BACKUP_R0
                         LD  R3, BACKUP_R3
                         
                         LEA R6, return_point
                         JMP R6
; -----------------------------------------------------------------------
;Data Block for SUB_3200
; -----------------------------------------------------------------------                         
BACKUP_R0                .BLKW #1
BACKUP_R3                .BLKW #1
COUNTER                  .FILL #16
SPACE_CHAR               .FILL x20
SPACE_COUNT              .FILL #4
ZERO_CHAR                .FILL x30
ONE_CHAR                 .FILL x31
NEW_LINE                 .FILL xA
; -----------------------------------------------------------------------
;End Subroutin: SUB_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
                         
