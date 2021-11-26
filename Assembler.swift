import Foundation


enum inputType {
  case i
  case l
  case r
  case null
}

enum directiveType: String {
  case string
  case tuple
  case integer
  case allocate
}







class Assembler {

  var program = [String]() //program in lines
  var binProgram = [Int]()
  var symTable = [String:Int]() // replace int with tuple (Int,directiveType)
  var virtualMachine = VM(memLength: 10000)
  var file = ""


  init() {
        var commandInputs = [Command:(inputType,inputType,inputType)]()
       
    commandInputs[.halt] = (.null ,.null , .null) //0
    commandInputs[.clrr] = (.r ,.null , .null) //1
    commandInputs[.clrx] = (.r ,.null , .null) //2
    commandInputs[.clrm] = (.l ,.null , .null) //3
    commandInputs[.clrb] = (.r ,.r , .null) //4
    commandInputs[.movir] = (.i ,.r , .null) //5
    commandInputs[.movrr] = (.r ,.r , .null) //6
    commandInputs[.movrm] = (.r ,.l , .null) //7
    commandInputs[.movmr] = (.l ,.r , .null) //8
    commandInputs[.movxr] = (.r ,.r , .null) //9
    commandInputs[.movar] = (.l ,.r , .null) //10
    commandInputs[.movb] =  (.r ,.r , .r) //11
    commandInputs[.addir] = (.i ,.r , .null) //12
    commandInputs[.addrr] = (.r ,.r , .null) //13
    commandInputs[.addmr] = (.l ,.r , .null) //14
    commandInputs[.addxr] = (.r ,.r , .null) //15
    commandInputs[.subir] = (.i ,.r , .null) //16
    commandInputs[.subrr] = (.r ,.r , .null) //17
    commandInputs[.submr] = (.l ,.r , .null) //18
    commandInputs[.subxr] = (.r ,.r , .null) //19
    commandInputs[.mulir] = (.i ,.r , .null) //20
    commandInputs[.mulrr] = (.r ,.r , .null) //21
    commandInputs[.mulmr] = (.l ,.r , .null) //22
    commandInputs[.mulxr] = (.r ,.r , .null) //23
    commandInputs[.divir] = (.i ,.r , .null) //24
    commandInputs[.divrr] = (.r ,.r , .null) //25
    commandInputs[.divmr] = (.l ,.r , .null) //26
    commandInputs[.divxr] = (.r ,.r , .null) //27
    commandInputs[.jmp] = (.l ,.null , .null) //28
    commandInputs[.sojz] = (.r ,.l , .null) //29
    commandInputs[.sojnz] = (.r ,.l , .null) //30
    commandInputs[.aojz] = (.r ,.l , .null) //31
    commandInputs[.aojnz] = (.r ,.l , .null) //32
    commandInputs[.cmpir] = (.i ,.r , .null) //33
    commandInputs[.cmprr] = (.r ,.r , .null) //34
    commandInputs[.cmpmr] = (.l ,.r , .null) //35
    commandInputs[.jmpn] = (.l ,.null , .null) //36
    commandInputs[.jmpz] = (.l ,.null , .null) //37
    commandInputs[.jmpp] = (.l ,.null , .null) //38
    commandInputs[.jsr] = (.l ,.null , .null) //39
    commandInputs[.ret] = (.null ,.null , .null) //40
    commandInputs[.push] = (.r ,.null , .null) //41
    commandInputs[.pop] = (.r ,.null , .null) //42
    commandInputs[.stackc] = (.r ,.null , .null) //43
    commandInputs[.outci] = (.i ,.null , .null) //44
    commandInputs[.outcr] = (.r ,.null , .null) //45
    commandInputs[.outcx] = (.r ,.null , .null) //46
    commandInputs[.outcb] = (.r ,.r , .null) //47
    commandInputs[.readi] = (.r ,.r , .null) //48
    commandInputs[.printi] = (.r ,.null , .null) //49
    commandInputs[.readc] = (.r ,.null , .null) //50
    commandInputs[.readln] = (.l ,.r , .null) //51
    commandInputs[.brk] = (.null ,.null , .null) //52
    commandInputs[.movrx] = (.r ,.r , .null) //53
    commandInputs[.movxx] = (.r ,.r , .null) //54
    commandInputs[.outs] = (.l ,.null , .null) //55
    commandInputs[.nop] = (.null ,.null , .null) //56
    commandInputs[.jmpne] = (.l ,.null , .null) //57


  }


  func run() {
    virtualMachine.readString(binProgram.reduce("", {$0 + "\($1)\n"}))
    virtualMachine.runProgram()
  }

  func readFile(_ str: String) {
    // Reads a text file and sets it to programString
    // Split programString into lines and store each line in program array
    file = str
    program = splitStringIntoLines(str)
    //print(program)
  }




  func commandToInt(command: String) -> Int {
    return Command(rawValue: command)!.asInt()
  }

  func programString() -> String {
    var result = ""
    for n in binProgram {
      result += String(n) + "\n"
    }

    return result
  }



  func assemble() {

    
    var numLines = 0
    var programStart = 0
    var startLabel = ""

    var n = 0
    for line in program {

        //Removes Tabs
        var newLine = line.replacingOccurrences(of:"\t", with: " ")


        //Checks that its not only a comment
        if newLine[0] == ";" {
            continue
        }
        //print(newLine)

        //Makes an array of parts
        var lineArray = splitStringIntoParts(newLine)
        //print(lineArray)
        
        if lineArray.count == 0 {
            continue
        }

        
        if lineArray[0].lowercased() == ".start" {
          startLabel = lineArray[1]
          continue
        }
        
        //assembler directives
        if lineArray[0][lineArray[0].count-1] == ":" && lineArray[1][0] == "." {
            
            
            var type: String = lineArray[1].lowercased()
            symTable[lineArray[0][0..<lineArray[0].count-1].lowercased()] = binProgram.count


            switch type {
              case ".integer":
                binProgram.append(Int(lineArray[2][1..<lineArray[2].count])!)
                n += 1

              case ".allocate":
                var memoryCount = Int(lineArray[2][1..<lineArray[2].count])!
                //binProgram.append(memoryCount)
                //n += 1

                //I don't think we actually append the memoryCount

                for i in 0..<memoryCount {
                    binProgram.append(0)
                    n += 1
                }

              case ".string":
                var firstIndex = newLine.firstIndex(of: "\"")!.encodedOffset
                var i: Int = firstIndex
                var size = 0
                
                i += 1
                while newLine[i] != "\"" {
                    binProgram.append(stringToNumber(newLine[i]))
                    size += 1
                    i += 1
                    n += 1
                }

                binProgram.insert(size, at:binProgram.count-size)
                n += 1
              
              case ".tuple":
                binProgram.append(Int(lineArray[2])!) // Current State
                binProgram.append(stringToNumber(lineArray[3])) // Input Character
                binProgram.append(Int(lineArray[4])!) // New State
                binProgram.append(stringToNumber(lineArray[5])) // Output Character


                // Direction
                if lineArray[6] == "r" {
                    binProgram.append(1)
                } else if lineArray[6] == "l" {
                    binProgram.append(0)
                }

                n += 5
                break

              default:
                break

            }

        } else if lineArray[0][lineArray[0].count-1] == ":" && lineArray[1][0] != "." { // Label with command not directive
            symTable[lineArray[0][0..<lineArray[0].count-1].lowercased()] = n

          for i in lineArray[1..<lineArray.count] {
              if i[0] == ";" {
                  break
              } else {
                  n += 1
              }
          }
        } else { // No label. Simple command
            for i in lineArray {
                if i[0] == ";" {
                  break
                } else {
                  n += 1
              }
            }
        }
        
    }

    //print(symTable)

    for line in program {

      var newLine = line.replacingOccurrences(of:"\t", with: " ")


      //Checks that its not only a comment
        if newLine[0] == ";" {
            continue
        }

        var lineArray = splitStringIntoParts(newLine)

        for part in lineArray {
          if part[0] == ";" || part[0] == "." {
              break
          }

            if Command(rawValue: part) != nil { //check if command
              binProgram.append(Command(rawValue: part)!.asInt())
            } else if let num = Int(part[1..<part.count]) { //check if int or register
                binProgram.append(num)
            } else if let labelNum = symTable[part.lowercased()] {
                binProgram.append(labelNum)
            }
          
        }




    }



    programStart = symTable[startLabel.lowercased()]!
    numLines = binProgram.count
    binProgram.insert(numLines, at: 0)
    binProgram.insert(programStart, at: 1)
  }

}
