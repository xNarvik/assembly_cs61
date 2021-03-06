; =======================================================================
; Name: Kevin Hsieh
; Login: khsie003
; Assignment: Lab 07
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
                         LD  R1, STACK_ADDR
                         LD  R2, STACK_ADDR
                         LD  R3, STACK_CAP
                         
                         LD  R0, TEST_NUM
                         JSR STACK_PUSH
                         
                         HALT
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
; -----------------------------------------------------------------------                         
TEST_NUM                 .FILL #10
STACK_ADDR               .FILL x4000
STACK_CAP                .FILL #20  
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3000
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
; -----------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R1): stack_addr: A pointer to the beginning of the stack
; Parameter (R2): top: A pointer to the next place to PUSH an item
; Parameter (R3): capacity: The number of additional items the stack can hold
; Postcondition: The subroutine has pushed (R0) onto the stack. If an overflow
;                occurred, the subroutine has printed an overflow error message
;                and terminated.
; Return Value: R2 <- updated top value
;               R3 <- updated capacity value
; -----------------------------------------------------------------------
                         .ORIG x3200          ;start at memory address x3000
; -----------------------------------------------------------------------
;Instruction Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
STACK_PUSH
;BACK UP REGISTERS
                         ST  R7, BU7_STORE_SR
                         ST  R1, ST_ADDR_SR
                         
                         ADD R3, R3, #0
                         BRz STACK_OVERFLOW_ERR
                         
                         STR R0, R2, #0
                         ADD R2, R2, #1
                         ADD R3, R3, #-1
                         BR  DONE
                         
STACK_OVERFLOW_ERR
                         LEA R0, STACK_OF_MSG
                         PUTS
DONE                                                       
                         LD  R7, BU7_STORE_SR
                         
                         RET
; -----------------------------------------------------------------------
;Data Block for SUB_MAIN_3200
; -----------------------------------------------------------------------
BU7_STORE_SR             .BLKW #1
ST_ADDR_SR               .BLKW #1
STACK_OF_MSG             .STRINGZ "\nSTACK OVERFLOW!\n"
; -----------------------------------------------------------------------
;End Subroutin: SUB_MAIN_3200
; -----------------------------------------------------------------------
                         .END                 ;stop reading source code
;=========================================================================
