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


///FUNCTIONS///

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

///OPTIONALS///

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










