//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var age = 25;

var lat = 34.12313

"\(str), I am using string interpolation \(age * 2) \(lat)";


///ARRAYS///

//Heterogenous arrays - can story any types!
var songs : [Any] = ["Shake it off", "Bad Blood", 3, 23.45, "Bang bang"];

//Merging arrays with a simple operator
var song2 : [Any] = ["BPT", "Bickin back being bool"];

var both = songs + song2;

both += ["YG 4 HUNNIT"];


///DICTIONARIES///

var artist = [ "name" : "YG",
               "song" : "BPT"
]

///Loops///

//Closed range operator///

for i in 1...10{
    print(i);
}

//Index not used//

for _ in 1...10{
    print("HEY");
}

//Exclusive range operator

for i in 1..<5{
    print(i);
}

for song in songs {
    print(song);
}

///Switch Statements//
let studioAlbums = 5


//Breaks aren't needed in Swift!

switch studioAlbums{
case 0...1:
    print("Beginner")
    
case 2...3:
    print("Getting there")
    
case 4...5:
    print("Hot damn")
    
default:
    print("What are you doing with your life")
    
}

///////////////
///FUNCTIONS///
///////////////


//Regular declaration
func countLettersInString(string: String) {
    print("The string \(string) has \(string.characters.count) letters.")
}

//External/Internal parameters

//Here myString is what the function caller sees(EXTERNAL), while str is what the function sees(INTERNAL)
func countLettersInString(myString str:String){
    print("The string \(str) has \(str.characters.count) letters.")
}

//Can also use no external name at all
func countLettersInString(_ str:String){
    print("The string \(str) has \(str.characters.count) letters.")
}

//Use Swift to write more meaningful/concise functions! Make it read like natural English :)

func countLetters(in str:String){
    print("The string \(str) has \(str.characters.count) letters.")
}

countLettersInString(myString: "BOB")
countLettersInString("BOB")
countLetters(in: "BOB")


///////////////
///OPTIONALS///
///////////////


//An optional is something that might have a value or not

//This function MIGHT return a String or it might not
func getStatus(weather: String) -> String? {
    if weather == "sunny" {
        return "YAY"
    }else{
        return nil;
    }
}

//When dealing with optionals, Swift requires you to be super safe even when you know your value will have something
var status: String?
status = getStatus(weather: "rain")//Does not work since we return a String?

func takeAction(status: String){
    if status == "YAY" {
        print("PARTAYYYY")
    }
}

//SAFELY UNWRAPPING OPTIONALS - When we know we're going to be dealing with an optional, ALWAYS use this to:
//1. Check if the optional has a value 
//2. Unwrap and use the value if it exists

//If not unwrapped, the value return will be 'Optional(value)'

if let status = getStatus(weather: "boring"){
    takeAction(status: status)
}else{
    print("invalid status")
}

//FORCE UNWRAPPING (!) - Only when YOU'RE SURE there's going to be a value

func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }
    
    return nil
}

var year = yearAlbumReleased(name: "Red")

if year == nil {
    print("There was an error")
} else {
    //We know the year isn't nil so we don't have worry about force unwrapping a nil value - CAUSES CODE TO CRASH!!!
    print("It was released in \(year)")//No unwrap
    print("It was released in \(year!)")
}


//Implicity Unwrapped Optionals

var regString : String = "" //Must contain a non-nil value ALWAYS

var optString : String? //Might or might not contain a value. HAS to be UNWRAPPED before use

var impUnwrapped: String! //Might or might not contain a value, AND will return unwrapped value (w.o unwrapping safety) if there is one, but if it's nil, CODE WILL CRASH. USE THESE WISELY WHEN YOU KNOW YOU'LL HAVE A VALID VALUE

/* Two frequent uses of implicity unwrapped optionals
 
 1. Apple's APIs or other external frameworks you have no control over
 
 2. Working with UIKit elements - We can rely on storyboards and ourselves to always initialize these elements before the compiler catches them. If not, the compiler will throw a VERY CLEAR error as to why we haven't initialized them yet.

 3. When you have a property you KNOW will be populated during initializtion or shortly after. (e.g. init method, or a method called after init like awakeFromNib() when we are able to get properties of the UI element)
 
 **ANY OTHER INSTANCE, YOU SHOULD ALWAYS OPT FOR OPTIONALS OR SOMETHING ELSE!!!
 
*/


//Optional Chaining

func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    case 2010: return "Speak Now"
    case 2012: return "Red"
    case 2014: return "1989"
    default: return nil
    }
}

//When dealing with optionals, we can string a bunch of properites & methods with '?'. This ensure that every method and/or property after each '?' is only retrieved/ran IF the optional HAS A VALUE. If at any time in the chain, which is checked from LEFT to RIGHT, '?' finds a nil value, the chain will break and return nil, otherwise an OPTIONAL value is returned. Keep in mind: THIS STILL RETURNS AN OPTIONAL!

let album = albumReleased(year: 2006)?.uppercased()
print("The album is \(album)")


//Nil Coalescing Operator - simple, but powerful


//All the '??' does is check for an optional's value. If it exits, UNWRAP and set it to our variable. If it doesn't, use whatever value is given after the '??'. 
//The reason why Swift unwraps the optional for us is because it knows that either way we'll have a valid value!

let album2 = albumReleased(year: 2006) ?? "unknown"
let album3 = albumReleased(year: 2309) ?? "invalid album"

print("The album is \(album2)")



///////////
///ENUMS///
///////////

enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed:Int) //We can even add extra values to our enums!
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil;
    case .wind(let speed) where speed < 10: //let declares a constant name of the value we can reference, while where checks for condition. NOTE: Be careful with ordering of cases when using extra values! (Don't want general case above specific ones)
        return "meh"
    case .cloud, .wind://Swift uses type inference here (inferredType).ENUM.
        return "dislike"
    case .rain:
        return "hate"
    case.snow:
        return "snowy"
    }
}

getHaterStatus(weather: .cloud)


///////////
//STRUCTS//
///////////

//Structs are complex data types which means they are made up of multiple values.

//struct Person {
//    var clothes: String
//    var shoes: String
//}
//
//let taylor = Person(clothes: "T-shirts", shoes: "sneakers")//These memberwise initializers are automatically generated
//let other = Person(clothes: "short skirts", shoes: "high heels")


///////////
//CLASSES//
///////////

/* Similar syntax to structs, but have a number of difference in Swift:
    
 1.You don't get an automatic memberwise initializer for your classes; you need to write your own.
 2.You can define a class as being based off another class, adding any new things you want.
 3.If you copy an object, both copies point at the same data by default.
 
*/

class Singer {
    
    /* Since classes don't have a memberwise initializer automatically created for them, we have 3 options:
        1. Make properties optionals - Ugly
        
        2. Set default values - Ok solution
 
        3. Create a custom constructor which guarantees properties will be set - BEST
 
    */
    
    var name: String
    var age: Int
    
    //Have to declare your own constructors and make sure every non-optional property is SET!
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    //Note: A function INSIDE a class is called a method!
    func sing() {
        print("La la la la")
    }
}


//Inheritance

class CountrySinger: Singer {
    var noiseLevel: Int
    
    //Swift has a particular way of adding derived class properties: We have to create a custom init method which will set the non-optional properties of the derived class AS WELL AS the base class!
    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)//ALL super calls must be made AFTER we've initialized all our non-optional properties! (The super usually comes first in other languages)
    }
    
    override func sing() {
        print("Trucks, guitars, and liquor")
    }
}


//When to use structs vs classes?! - VALUE VS REFERENCE

/*
 When you copy a struct, the whole thing is duplicated, including all its values. This means that changing one copy of a struct doesn't change the other copies – they are all INDIVIDUAL. With classes, each copy of an object points at the same original object, so if you change one THEY ALL CHANGE. Swift calls structs "value types" because they just point at a value, and classes "reference types" because objects are just shared references to the real value.
 
 This is an important difference, and it means the choice between structs and classes is an important one:
 
 If you want to have one SHARED STATE that gets passed around and modified in place, you're looking for CLASSES. You can pass them into functions or store them in arrays, modify them in there, and have that change reflected in the rest of your program.
 
 If you want to AVOID shared state where one copy can't affect all the others, you're looking for STRUCTS. You can pass them into functions or store them in arrays, modify them in there, and they won't change wherever else they are referenced.
 
 If I were to summarize this key difference between structs and classes, I'd say this: classes offer more flexibility, whereas structs offer more safety. As a BASIC RULE, you should always use structs until you have a specific reason to use classes.
*/



///////////////
//PROPERTIES///
///////////////

//Property Observers & Computed Properties

struct Person {
    var clothes: String {
        
        //Called before the clothes property is changed - newValue is provided
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        
        //Called after the clothes property is changed - oldValue is provided
        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
    
    var age: Int
    
    //Retrieving this property will always run the code inside
    var ageInDogYears: Int {
        get {
            return age * 7
        }
    }
    
    init(clothes: String, age: Int){
        self.clothes = clothes
        self.age = age
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts", age: 5)
taylor.clothes = "short skirts"


//Static properties & methods

//Static creates properties/methods that belong to a TYPE, rather than instances of a type. Helps organize data by storing SHARED data between instances.

//As for static methods, they can only access STATIC properties from within that class.
struct TaylorFan {
    static var favoriteSong = "Shake it Off"//"All Taylor Swift fans have a name and age that belong to them, but they ALL share the same favorite song!"
    
    var name: String
    var age: Int
}

let fan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)


//Access Control (public, private, internal, etc.) - Lets us specify what data inside structs/classes should be exposed to the outside world.

/* Types:
 Public: this means everyone can read and write the property.
 
 Internal: this means only your Swift code can read and write the property. If you ship your code as a framework for others to use, they won’t be able to read the property.
 
 File Private: this means that only Swift code in the same file as the type can read and write the property.
 
 Private: this is the most restrictive option, and means the property is available only inside methods that belong to the type.
*/




////////////////
//POLYMORPHISM//
////////////////

//A derived object can work as its class and its parent classes depending on what type it is.

class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]//Since all derived classes share the same behavior/properties as the base class we can just generalize a collection type like this while still never losing the derived class type(s).

for album in allAlbums {
    print(album.getPerformance())
}


//Typecasting

/* Two main types:

Optional downcast (as?) - "I think this conversion might be true, but it might fail"

Forced downcast (as!) - "I know this conversion will be true, and am happy for my app to crash if I'm wrong!"
 
Note: Objects don't actually get converted, it just tells Swift how the object should be treated.
 
*/


//Optional downcast

for album in allAlbums {
    //print(album.studio)//But I thought Swift knew...! :---(
    
    //as? converts an type object to a type? object instead. Based on optional theory, we know the safest way to unwrap these optional is to use IF LET to get the actual value:
    
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}

//Forced downcast

var tSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearlezz = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")

var allAlbs: [Album] = [taylorSwift, fearless]

for album in allAlbs {
    let studioAlbum = album as! StudioAlbum //Here we KNOW all Album objects in the array are actually StudioAlbums so we can safely force the downcast - should just make array type [StudioAlbum] instead though
    print(studioAlbum.studio)
}

//Another way

for album in allAlbs as! [StudioAlbum] {
    print(album.studio)
}


//Converting common types with initializers
let number = 5;
let numString = String(number);
print(numString)


////////////
//CLOSURES//
////////////

//Closures are just like int, strings, bools, etc. in that they hold a value, but instead of a single value, they hold actual CODE. They also capture their environment so they take a copy of each value used within them.

let vw = UIView()


//An example of a closure being useful here is that the animate() requires UIKit to do some setup work before antimating a view. With the closure, the method can take a copy of our chunk of code we want to run (closure) and run it after it has finished setting up. This wouldn't be possible if we just ran our code directly with the method if it was possible.
UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})

//Trailing closures: Methods w/ closures as their last argument have the option of using this syntatctic sugar. Should always use this for easier readibility!
UIView.animate(withDuration: 0.5) {
    vw.alpha = 1
}






