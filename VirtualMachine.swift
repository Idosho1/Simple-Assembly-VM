//
//  VirtualMachine.swift
//  SAP Systems Programming
//
//  Created by Ido Shoshani on 5/6/20.
//  Copyright © 2020 Ido Shoshani. All rights reserved.
//

import Foundation


class VM {
    
    var rPC = 0
    var rCP = 0
    var rST = 0
    var rPCstack = IntStack(size: 10)
    var stack = IntStack(size: 500) 

    var memory: [Int]
    var memLength: Int
    var length = 0
    
    
    var registers = Array(repeating: 0, count: 10)
    
    
    init(memLength : Int) {
        self.memLength = memLength
        self.memory = Array(repeating: 0, count: memLength)
    }
    
    
    func reset() {
        rPC = 0
        rCP = 0
        rST = 0
        rPCstack = IntStack(size: 10)
        stack = IntStack(size: 500) 
        registers = Array(repeating: 0, count: 10)
    }




    func readString(_ s: String) {

        reset()
        
        var stringArray = splitStringIntoLines(s)
        
        length = Int(stringArray[0])!
        rPC = Int(stringArray[1])!

        stringArray.remove(at:0)
        stringArray.remove(at:0)
        
        for i in 0..<stringArray.count {
          memory[i] = Int(stringArray[i])!
        }
    }
    
    func readFile(fileName: String) {

        reset()

        let textFile = readTextFile(fileName).fileText!
        
        var stringArray = splitStringIntoLines(textFile)
        
        length = Int(stringArray[0])!
        rPC = Int(stringArray[1])!

        stringArray.remove(at:0)
        stringArray.remove(at:0)
        
        for i in 0..<stringArray.count {
          memory[i] = Int(stringArray[i])!
        }
    }

}
    
    
    
    

    
    
    
    
