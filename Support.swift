import Foundation

extension String {

  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }

  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, count) ..< count]
  }

  func substring(toIndex: Int) -> String {
    return self[0 ..< max(0, toIndex)]
  }

  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                        upper: min(count, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }

}

 func splitStringIntoParts(_ expression: String) -> [String] {
    return expression.split{$0 == " "}.map{ String($0) }
  }


  func splitStringIntoLines(_ expression: String) -> [String] {
    return expression.split{$0 == "\n"}.map{ String($0) }
  }


    func numberToLetter(_ i: Int) -> String {
        return String(UnicodeScalar(UInt8(i)))
    }

    func stringToNumber(_ s: String) -> Int {
      //let s = String(c)
      return Int(s.unicodeScalars[s.unicodeScalars.startIndex].value)
    }



func readTextFile(_ path: String) -> (message: String?, fileText: String?) {
    let text: String
    do {
        text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
    }
    catch {
        return ("\(error)", nil)
    }
    return(nil, text)
}

/*
func writeTextFile(_ path: String, data: String) -> String? {
    let url = NSURL.fileURL(withPath: path)
    do {
        try data.write(to: url, atomically: true, encoding: String.Encoding.utf8)
    } catch let error as NSError {
        return "Failed writing to URL: \(url), Error: " + error.localizedDescription
    }
    return nil
}
*/

extension String {
    func characterAtIndex(_ index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur += 1
        }
        return nil
    }
}