import Cocoa
//review notes
//let var
//print("\(myvar)")
//emoji supported in strings
//""" for multiple lined strings
//hasPrefix() hasSuffix() etc.
// += with Int
// 3.1 vs. 3 Double vs. Int inferred.
// isSaved.toggle() flips bool.
// arrays var colors = ["red", "Green"]
// var readings = [0.1, 0.2] etc.
//  append(), remove, contains, etc.
// Dictionaries: let employee = [ "name": "Joe", ...]
// Set: var numbers = Set([1,2,3]) with insert, contains. Set's contains method runs instantly
// Enum: enum Weekday { case monday, tuesday, wed...}
// var score: Double = 1 to ensure type.
//var albumbs: Array<String> = ["blah", ...
//OR var albums: [String] = ...
//var users: Dictionary<String, String> = ["...
//OR var users: [String: String] = ...
//Empty array of String: var teams: [String] = [String]()
// OR var clues = [String]()
// if age < 12 { ... } else if age < 18 {...}
// switch variable { case .sun: print() case .rain print() default
// ternary:   let canvote = age >= 18 ? "yes" : "no"
//let platforms = ["ios", "macos"]
//for os in platforms {
//    //...
//}
//for i in 0...7{
//    
//}
//
//for _ in 1...5{
//    //ignore the i here and just do something 5 times
//}
////continue will skip iteration of loop
////break skips out of entire loop
//
//func printTimesTable(number: Int){
//    for i in 1...12 {
//        //do work
//    }
//}
//printTimesTable(number: 8)
//func rollDice() -> Int{
//    return 0
//}
//
////Tuples
////don't need name
//func isUppercased(_ passedIn: String) -> Bool {
//    return passedIn == passedIn.uppercased()
//}
//
////External vs. internal names:
//func doWork(externalName internalName: Int) -> Bool{
//    print(internalName)
//    return true;
//}
//
//let myBool: Bool = doWork(externalName: 55)
//
////Handy when you use the word do, for, etc.
//
////default values
//func greet(_ person: String, formal: Bool = false)
//{
//    if formal {
//        print ("yoeth.")
//    }
//    else
//    {
//        print("yo.")
//    }
//}
//
////Errors
//enum PasswordError: Error {
//     case short, obviousError
//    }
//
//func checkPassword(_ password: String) throws -> String {
//    if password.count < 5 {
//        throw PasswordError.short
//    }
//    return "good"
//}
//
////do {...
//// } catch mySpecificError {
//// } catch{ } //generic catch must exist
//
////closures
//let sayHello = { print("hey.")}
//sayHello()
////sayHello can be passed like a param
//
////closure params
//let sayHi = { (name: String) -> String in
//    "Hi \(name)"
//    //The above line can also be
//    //return "Hi \(name)"
//}
//
////closure may let you remove parameters and return type. Even variables can be numbered $0 etc.
//
////structs
//struct Joe {
//    let name: String
//    let hair: String
//    var tired: Bool
//    mutating func setTired(passedIn: Bool){
//        tired = passedIn
//    }
//    
//    var thirstLevel: Int
//    
//    var thirsty: Int{
//        get{
//            return thirstLevel
//        }
//        set{
//            thirstLevel = newValue
//        }
//    }
//}
//
////Property observers
//struct Game{
//    var score = 0 {
//        didSet{
//            
//        }
//        willSet{}
//    }
//}
//
////init is the initializer, if you provide one, swift will not. init doesn't need func keyword
//
////access modifiers, private, private set, file private (current file), public
//// vars default to public, to make something private say private(set) prior to declaration
//
////static properties and methods
//struct AppData {
//    static let version = "1.3"
//}
//
////classes
//class Employee {
//    let hours: Int
//    
//    init(hours: Int){
//        self.hours = hours
//    }
//}
//class Developer: Employee{
//    func work(){
//        print("working...")
//    }
//}
//
//let joe = Developer(hours: 8)
//
////override is a thing
////Swift doesn't make default initializers for classes.
////initializers have to call parent's init, and all fields need to be instantiated in init
//
////structs copy all data, classes are pass by reference.
//
////classes have deinitializers
////    deinit{}
//
////classes don't need mutating keyword
//
////protocol (interface)
//protocol Vehicle {
//    func estimateTime(for distance: Int) -> Int
//    var doorCount: Int { get set }
//}
//
////subclass goes first, then protocols
//
////extensions
//extension String{
//    func trimmed() -> String {
//        self.trimmingCharacters(in: .whitespacesAndNewlines)
//    }
//    
//    mutating func trim()
//    {
//        self = self.trimmed()
//    }
//}
//let trimmed = "    hello world    ".trimmed()
//
//var lyrics = "    huh?     "
//print(lyrics)
//lyrics.trim()
//print (lyrics)
//
////optionals (nullable types)
//
//var nullValue: String? = nil
//
////unwrap optional
//if let nullValue = nullValue?.trimmed(){
//    //do stuff if it is not nil
//}
//else {
//    //it is nil
//}
//
////guard  another unwrap optionals option
//func printSquare(of number: Int?){
//    guard let number = number else{
//        print("missing input")
//        return //this is required
//    }
//    //do stuff here because it is not nil
//}
//
//
//// nil coalessing operator (elvis operator)
//
//let tvShows = ["archer", "bablylon 5"]
//let favorite = tvShows.randomElement() ?? "None" //if the random element is nil, will return "None"
//
//enum UserError: Error{
//    case badID, networkFailed
//}
//func getUser(id: Int) throws -> String{
//    throw UserError.networkFailed
//}
//
//if let user = try? getUser(id: 23){
//    print("User: \(user)")
//}
//
//
print("\(112 % 64)")
print("\(112 / 64)")



