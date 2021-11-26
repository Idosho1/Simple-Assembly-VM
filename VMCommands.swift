extension VM {
  func runProgram() {

        var command = memory[rPC]
        
        while Command.fromInt(command) != .halt {
                
                switch Command.fromInt(command) {
                    
                case .halt: print("End Program!")
                
                case .clrr:
                    registers[memory[rPC+1]] = 0
                    rPC += 2

                case .clrx:
                    memory[registers[memory[rPC+1]]] = 0
                    rPC += 2

                case .clrm:
                    memory[memory[rPC+1]] = 0
                    rPC += 2
                    
                case .clrb:
                    for n in registers[memory[rPC+1]]..<registers[memory[rPC+1]]+registers[memory[rPC+2]] {
                        memory[n] = 0
                    }
                    rPC += 3
                    
                case .movir:
                    registers[memory[rPC+2]] = memory[rPC+1]
                    rPC += 3
                
                case .movrr:
                    registers[memory[rPC+2]] = registers[memory[rPC+1]]
                    rPC += 3
                
                case .movrm:
                    memory[memory[rPC+2]] = registers[memory[rPC+1]]
                    rPC += 3

                case .movmr:
                    //Move the contents of memory location label1 to register r1
                    registers[memory[rPC+2]] = memory[memory[rPC+1]]
                    rPC += 3

                case .movxr:
                    registers[memory[rPC+2]] = memory[registers[memory[rPC+1]]]
                    rPC += 3
                    
                case .movar: // DOUBLE CHECK
                    //LJALKJFKLDJK:JSDJK:LJSDKLJ:SDKLJK:SKDJLKFJKLSJDOKFJPEJI OJWIEOJFSPDFK SJDFKLJSDFKLJKL
                    registers[memory[rPC+2]] = memory[rPC+1]
                    rPC += 3

                case .movb:
                    for n in 0..<registers[memory[rPC+3]] {
                        memory[registers[memory[rPC+2]] + n] = memory[registers[memory[rPC+1]] + n]
                    }
                    rPC += 4

                case .addir:
                    registers[memory[rPC+2]] += memory[rPC+1]
                    rPC += 3

                case .addrr:
                    registers[memory[rPC+2]] += registers[memory[rPC+1]]
                    rPC += 3

                case .addmr:
                    registers[memory[rPC+2]] += memory[memory[rPC+1]]
                    rPC += 3

                case .addxr:
                    registers[memory[rPC+2]] += memory[registers[memory[rPC+1]]]
                    rPC += 3

                case .subir:
                    registers[memory[rPC+2]] -= memory[rPC+1]
                    rPC += 3
                
                case .subrr:
                    registers[memory[rPC+2]] -= registers[memory[rPC+1]]
                    rPC += 3
                
                case .submr:
                    registers[memory[rPC+2]] -= memory[memory[rPC+1]]
                    rPC += 3
                
                case .subxr:
                    registers[memory[rPC+2]] -= memory[registers[memory[rPC+1]]]
                    rPC += 3
                
                case .mulir:
                    registers[memory[rPC+2]] *= memory[rPC+1]
                    rPC += 3
                
                case .mulrr:
                    registers[memory[rPC+2]] *= registers[memory[rPC+1]]
                    rPC += 3
                
                case .mulmr:
                    registers[memory[rPC+2]] *= memory[memory[rPC+1]]
                    rPC += 3
                
                case .mulxr:
                    registers[memory[rPC+2]] *= memory[registers[memory[rPC+1]]]
                    rPC += 3
                
                case .divir:
                    registers[memory[rPC+2]] /= memory[rPC+1]
                    rPC += 3
                
                case .divrr:
                    registers[memory[rPC+2]] /= registers[memory[rPC+1]]
                    rPC += 3
                
                case .divmr:
                    registers[memory[rPC+2]] /= memory[memory[rPC+1]]
                    rPC += 3
                
                case .divxr:
                    registers[memory[rPC+2]] /= memory[registers[memory[rPC+1]]]
                    rPC += 3
                
                case .jmp:
                    rPC = memory[rPC+1]
                
                case .sojz:
                    registers[memory[rPC+1]] -= 1
                    if(registers[memory[rPC+1]] == 0) {
                        rPC = memory[rPC+2]
                    } else {
                        rPC += 3
                    }
                
                case .sojnz:
                    registers[memory[rPC+1]] -= 1
                    if(registers[memory[rPC+1]] != 0) {
                        rPC = memory[rPC+2]
                    } else {
                        rPC += 3
                    }
                
                case .aojz:
                    registers[memory[rPC+1]] += 1
                    if(registers[memory[rPC+1]] == 0) {
                        rPC = memory[rPC+2]
                    } else {
                        rPC += 3
                    }
                
                case .aojnz:
                    registers[memory[rPC+1]] += 1
                    if(registers[memory[rPC+1]] != 0) {
                        rPC = memory[rPC+2]
                    } else {
                        rPC += 3
                    }
                
                case .cmpir:
                    rCP = memory[rPC+1] - registers[memory[rPC+2]]
                    rPC += 3
                
                case .cmprr:
                    rCP = registers[memory[rPC+1]] - registers[memory[rPC+2]] //ask pal later for order
                    rPC += 3
                
                case .cmpmr:
                    rCP = memory[memory[rPC+1]] - registers[memory[rPC+2]]
                    rPC += 3
                
                case .jmpn:
                    if rCP < 0 {
                      rPC = memory[rPC+1]
                    } else {
                    rPC += 2
                    }

                case .jmpz:
                    if rCP == 0 {
                      rPC = memory[rPC+1]
                    } else {
                    rPC += 2
                    }
                
                case .jmpp:
                    if rCP > 0 {
                      rPC = memory[rPC+1]
                    } else {
                    rPC += 2
                    }
                
                case .jsr: //stack
                    rPCstack.push(rPC + 2)
                    rPC = memory[rPC+1]
                    for n in 5...9 {
                        rST = stack.push(registers[n])
                    }
                    
                
                case .ret: //stack
                    rPC = rPCstack.pop()! //if empty will crash
                    for n in 0...4 {
                        registers[9-n] = stack.pop() ?? 0 // ask
                    }


                case .push://stack
                    rST = stack.push(registers[memory[rPC+1]])
                    rPC += 2

                case .pop://stack
                    
                    if let st = stack.pop() {
                        registers[memory[rPC+1]] = st
                        rST = 0
                    } else {
                        rST = 2
                    }
                    rPC += 2

                case .stackc://stack
                    registers[memory[rPC+1]] = rST
                    rPC += 2

                case .outci:
                    print(numberToLetter(memory[rPC+1]), terminator:"")
                    rPC += 2
                    
                case .outcr:
                    print(numberToLetter(registers[memory[rPC+1]]),terminator: "")
                    rPC += 2

                case .outcx:
                    print(numberToLetter(memory[registers[memory[rPC+1]]]), terminator:"")
                    rPC += 2

                case .outcb:
                    
                    for n in 0..<registers[memory[rPC+2]] {
                      print(numberToLetter(memory[registers[memory[rPC+1]]+n]), terminator:"")
                    }
                    rPC += 3
      
                case .readi:
                //Read an integer from the console to r1, error code in r2.
                    print("Input:", terminator: " ")
                    var input = readLine()!

                    if let i = Int(input) {
                        registers[memory[rPC+1]] = i
                    } else {
                      //error code in r2
                    }
          

                    
                case .printi:
                    print(registers[memory[rPC+1]], terminator:"")
                    rPC += 2
                    
                case .readc:
                //Read a character from the console to r1
                    print("Input:", terminator: " ")
                    var input = readLine()!

                    registers[memory[rPC+1]] = stringToNumber(input)


                case .readln:
                    //<#code#>
                    break
                    
                case .brk: // Debugger. Dont finish yet
                    break
                    
                case .movrx:
                    memory[registers[memory[rPC+2]]] = registers[memory[rPC+1]]
                    rPC += 3

                case .movxx:
                    memory[registers[memory[rPC+2]]] = memory[registers[memory[rPC+2]]]
                    rPC += 3

                case .outs:
                    for i in (memory[rPC+1]+1)..<(memory[rPC+1]+1+memory[memory[rPC+1]]) {
                        print(numberToLetter(memory[i]), terminator: "")
                    }
                    rPC += 2

                case .nop:
                    rPC += 1

                case .jmpne:
                    if rCP != 0 {
                        rPC = memory[rPC+1]
                    }
                    else {
                      rPC += 2
                    }

            }

                command = memory[rPC]
                
        }
                
    }
}