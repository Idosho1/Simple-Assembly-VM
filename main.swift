import Foundation


var turing = """
  .Start begin
currentState: .Integer #0
head: .Integer #0
inputChar: .Integer #49
tape: .String "_010101_"

StartMess: .String "Welcome to Turing!"
TuplesMess: .String "Tuples:"
InitialStateMess: .String "Initial State: "
InitialTapeHeadMess: .String "Initial Tape Head: "
InitialTapeMess: .String "Initial Tape: "
FinalMess: .String "Turing run complete"
FinalTapeMess: .String "Final Tape: "
StepsMess: .String "That took "
StepsMessEnd: .String " steps"



startTuple: .tuple 0 _ 0 _ r
t2:         .tuple 0 1 1 0 r
t3:         .tuple 0 0 1 1 r
t4:         .tuple 1 0 1 1 r
endTuple:   .tuple 1 1 1 0 r



;;;;;;  r0 = Number Tuples      r3 = number of steps

;; This is where the program starts
begin: outs startMess
       outci #10
       outci #10
       outs TuplesMess
       outci #10
       jsr printTuples
       outci #10
       outci #10
       outs InitialStateMess
       movmr currentState r9
       printi r9
       outci #10
       outs InitialTapeHeadMess
       movmr head r9
       printi r9
       outci #10
       outs InitialTapeMess
       outs tape
       clrr r9
       outci #10
       outci #10

    loop: nop
       jsr findTuple
       
       jmp loop

       jsr finalMessage
       halt


;; Final Message
finalMessage: nop
      outci #10
      outci #10
      outs FinalMess
      outci #10
      outs FinalTapeMess
      outs tape
      outci #10
      outs StepsMess
      printi r3
      outs StepsMessEnd
      ret



findTuple: movrr r0 r1 ;; Moves number tuples to r1
      movar startTuple r2 ;; Moves firstTuple index to r2
      addir #1 r1
      ;; r8 is current state and r9 is input char
      movmr currentState r8 ;; current state in r8

      clrr r7
      clrr r6
      movar tape r7 ;; get the index of tape
      addir #1 r7 ;; do not want to access the size
      addmr head r7 ;; find the index in the string
      movxr r7 r6
      movrm r6 inputChar

      movmr inputChar r9  
      clrr r6
      clrr r7
      
findStart: nop
      clrr r5
      clrr r6
      clrr r7
      subir #1 r1
      cmpir #0 r1
      jmpz stop
      ;;outci #10 ;; New Line
      
      
      clrr r5
      addxr r2 r5 ;; Stores current state in r5
      ;;printi r5 ;;output 
      ;;outci #32
      cmprr r8 r5 ;; Sets compare to 0 if states match
      
      addir #5 r2 ;; Goes to next tuple
      jmpne findStart ;; jump if cs is not equal
      subir #4 r2 ;; Go back to current tuple (input char)
      
      clrr r5
      addxr r2 r5 ;; Stores input character in r5
      ;;outcr r5 ;;output
      ;;outci #32
      ;;printi r5
      ;;outci #32
      ;;printi r9

      cmprr r9 r5 ;; Sets compare to 0 if character codes match
      
      addir #4 r2 ;; Goes to next tuple
      jmpne findStart ;; jump if ic is not equal
      subir #3 r2 ;; Go back to current tuple (new state)
      
      movxr r2 r8 ;; Move new state to r8
      ;;printi r8
      ;;outci #32
      movrm r8 currentState ;; Move new state to the label
      addir #1 r2 ;; Move to output character

      movxr r2 r9 ;; move output character to r9
      ;;outcr r9
      ;;outci #32
      clrr r7
      movar tape r7 ;; get the index of tape
      addir #1 r7 ;; do not want to access the size
      addmr head r7 ;; find the index in the string
      movrx r9 r7 ;; replace with output character
      addir #1 r2 ;; Move to direction 
    
      clrr r5
      movxr r2 r5 ;; Move direction to r5 (r=1 l=0)
      addir #1 r2
      cmpir #1 r5
      ;;outci #78
      jsr moveHead  ;; Run moveHead function 

    

    ;;;;;; PRINTS TAPE
    outci #10
    addir #1 r3 ;; add one more step


       jsr printTape



       subir #5 r2
       outci #32
       outci #32
       outci #32
       outci #32
       outci #32
       jsr printTuple  

    ret

    stop: nop
    jsr finalMessage
    halt


;; prints tape with tracing
printTape: nop


    movmr head r5
    movar tape r6
    movxr r6 r7
    subrr r5 r7 ;; r7 is now the count
    outcb r6 r5
    outci #91

    addrr r5 r6 ;; r6 is now the new start
    outcx r6
    
    outci #93
    addir #1 r6
    
    outcb r6 r7
    



    ret

;; Subr to move the head based on direction
moveHead: nop
    clrr r5
    ;;cmpir #1 r5 moved to before moveHead is run
    movmr head r6
    jmpz rightHead

    leftHead: nop
    cmpir #0 r6
    jmpne moveHeadLeft
    jsr finalMessage
    halt


    rightHead: nop
    movmr tape r7
    subir #1 r7
    cmprr r6 r7
    jmpne moveHeadRight
    jsr finalMessage
    halt
    
    
    moveHeadLeft: nop
    subir #1 r6 ;; subtract 1 to the head
    movrm r6 head ;; put the head back
    ret

    moveHeadRight: nop
    addir #1 r6 ;; add 1 to the head
    movrm r6 head ;; put the head back
    ret


;; Use register r0 and r1
;; r0 will contain the number of tuples
;; r1 will be a temporary register
printTuples: movar endTuple r0
      movar startTuple r1
      subrr r1 r0
      clrr r1
      divir #5 r0
      addir #1 r0
      ;;printi r0 number of tuples

      movrr r0 r1
      movar startTuple r2
      ;;both contain number of tuples right now
      
      tupleLoop: jsr printTuple
            outci #10
            sojnz r1 tupleLoop
      outci #10
      ret
        
;;end minus start div 5 + 1


;; Prints a single tuple
;; Registers r2 and r5 are used as temporary registers
;; r2 is the index and r5 is the actual value
printTuple: clrr r5
      
      addxr r2 r5
      printi r5   ;; Current State
      outci #32
      clrr r5
      addir #1 r2 

      outcx r2    ;; Input Character
      outci #32
      addir #1 r2
    
      addxr r2 r5
      printi r5   ;; New State
      outci #32
      clrr r5
      addir #1 r2

      outcx r2    ;; Output Character
      outci #32
      addir #1 r2

      addxr r2 r5
      cmpir #1 r5
      addir #1 r2
      jmpz right 

      outci #108 ;;LEFT
      outci #32 
      ret

right: outci #114   
  outci #32
  ret


.end
"""


//var userInterface = UI()
//userInterface.run()



var asm = Assembler()

asm.readFile(turing)
asm.assemble()
asm.run()
