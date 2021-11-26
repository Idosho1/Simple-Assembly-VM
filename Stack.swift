struct IntStack: CustomStringConvertible{

    var size: Int
    var stack: [Int]
    var pointer = 0
    
    init(size: Int) {
        self.size = size
        self.stack = Array(repeating: 0, count: self.size)
    }
    
    func isEmpty() -> Bool { return pointer == 0 }

    func isFull() -> Bool { return pointer == size }

    mutating func push(_ element: Int) -> Int{
        if !self.isFull() {
            stack[pointer] = element
            pointer += 1
            return 0

        } else {
            return 1
        }
    }

    mutating func pop() -> Int? {
        if !self.isEmpty() {
            pointer -= 1    //moves pointer back one
            //pointer starts at 0 with 0 elements, so to refer to current element it has to be pointer minus 1 
            return stack[pointer]
        } else {
            print("stack size \(size) underflow")
            return nil
        }
    }

    func peek() -> Int? {
        return !self.isEmpty() ? stack[pointer - 1] : nil
    }

    //clear representation of a stack
    var description: String {
        var result = "bottom "

        if !isEmpty() {
            for i in 1...pointer {
                result += "\(stack[i - 1]) "
            }
        } else {
            result += "- "
        }
        
        return result + "top " + "\(pointer)/\(size) slots used"
    }
}