import UIKit

let name = "Taylor"

for letter in name {
    print("Give me a \(letter)!")
}

let letter = name[name.index(name.startIndex, offsetBy: 2)]

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

let letter2 = name[2]


// MARK: - Prefix and Suffix

let password = "12345"
password.hasPrefix("123")
password.hasSuffix("245")

extension String {
    // remove a prefix if it exists
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    // remove a suffix if it exists
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

let password2 = password.deletingPrefix("123")
let password3 = password.deletingSuffix("345")

// capitalized
let weather = "it's going to rain"
print(weather.capitalized)

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}

weather.capitalizedFirst

// contains
let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")

let input = "Swift is like Objective-C without the C"

extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }
        
        return false
    }
}

input.containsAny(of: languages)

languages.contains(where: input.contains)


// MARK: - NSAtributtedString

let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36),
    .underlineStyle: NSUnderlineStyle.single.rawValue,
    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
]

let attributedString = NSAttributedString(string: string, attributes: attributes)

let mutableString = NSMutableAttributedString(string: string)
mutableString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
mutableString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
mutableString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
mutableString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
mutableString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))


// MARK: - Challenge

let strChallenge = "challenge"

// Challenge 1

extension String {
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            return self
        }
        
        return prefix + self
    }
}

strChallenge.withPrefix("cha")
strChallenge.withPrefix("set")


// Challenge 2

let strChallenge2 = "challenge2"

extension String {
    func isNumeric() -> Bool {
        for letter in self {
            if Int(String(letter)) != nil {
                return true
            }
        }
        
        return false
    }
}

strChallenge2.isNumeric()


// Challenge 3

let strChallenge3 = "this\nis\na\ntest"

extension String {
    var lines: [String] {
        return self.components(separatedBy: "\n")
    }
}

print(strChallenge3.lines)
