class UI {

  var virtualMachine = VM(memLength: 10000)
  var assembler = Assembler()

  var file = ""


  func runVM() {

  }

  func runAssembler() {

  }


  func printHelpMessage() {
    var msg = "SAP Help:\n"
    msg += "  asm <program name> - assemble the specified program\n"
    msg += "  run <program name> - run the specified program\n"
    msg += "  input - allows user to paste the file code\n"
    msg += "  printlst <program name> - print listing file for the specified program\n"
    msg += "  printbin <program name> - print binary file for the specified program\n"
    msg += "  printsym <program name> - print symbol table for the specified program\n"
    msg += "  quit - terminate SAP program\n"
    msg += "  help - print help table\n"
    print(msg)
  }


  func run() {

    print("Welcome to SAP!")
    printHelpMessage()


  }





}