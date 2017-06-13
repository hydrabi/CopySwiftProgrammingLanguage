//
//  Protocols.swift
//  IsASample
//
//  Created by Hydra on 16/6/16.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

//Protocol(协议)用于统一方法和属性的名称，而不实现任何功能。协议能够被类，枚举，结构体实现，满足协议要求的类，枚举，结构体被称为协议的遵循者

//遵循者需要提供协议指定的成员，如属性，方法，操作符，下标等
//protocol SomeProtocol {
    // 协议内容
//}

//在类，结构体，枚举的名称后加上协议名称，中间以冒号:分隔即可实现协议；实现多个协议时，各协议之间用逗号,分隔
//struct SomeStructure: FirstProtocol, AnotherProtocol {
    // 结构体内容
//}

//当某个类含有父类的同时并实现了协议，应当把父类放在所有的协议之前
//class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
    // 类的内容
//}

//协议能够要求其遵循者必须含有一些特定名称和类型的实例属性(instance property)或类属性 (type property)，也能够要求属性的(设置权限)settable 和(访问权限)gettable，但它不要求属性是存储型属性(stored property)还是计算型属性(calculate property)。
// 通常前置var关键字将属性声明为变量。在属性声明后写上{ get set }表示属性为可读写的。{ get }用来表示属性为可读的。即使你为可读的属性实现了setter方法，它也不会出错
protocol FirstSomeProtocol {
    var musBeSettable:Int {get set}
    var doesNotNeedToBeSettable:Int {get}
}


//用类来实现协议时，使用class关键字来表示该属性为类成员；用结构体或枚举实现协议时，则使用static关键字来表示
protocol SecondProtocol{
    static var someTypeProperty:Int {get set}
}

struct ProtocolSub:SecondProtocol{
    static var someTypeProperty: Int  {
        get {
            return self.someTypeProperty
        }
        
        set {
            self.someTypeProperty = newValue
        }
        
    }
}

protocol FullNamed {
    var fullName:String{get}
}

struct ProtocolsPerson:FullNamed {
    var fullName: String
}

struct ProtocolsStarship:FullNamed {
    var prefix:String?
    var name:String
    init(name:String,prefix:String? = nil){
        self.name = name
        self.prefix = prefix
    }
    //Starship类将fullName实现为可读的计算型属性。它的每一个实例都有一个名为name的必备属性和一个名为prefix的可选属性。 当prefix存在时，将prefix插入到name之前来为Starship构建fullName
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

//协议方法支持变长参数(variadic parameter)，不支持默认参数(default parameter)
//前置class关键字表示协议中的成员为类成员；当协议用于被枚举或结构体遵循时，则使用static关键字
//protocol someProtocol1 {
//    static func someTypeMethod()
//}

//RandomNumberGenerator协议要求其遵循者必须拥有一个名为random， 返回值类型为Double的实例方法
protocol ProtocolsRandomNumberGenerator {
    func random() -> Double
}

class LinearCOngruentialGenerator:ProtocolsRandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

//类中的成员为引用类型(Reference Type)，可以方便的修改实例及其属性的值而无需改变类型；而结构体和枚举中的成员均为值类型(Value Type)，修改变量的值就相当于修改变量的类型，而Swift默认不允许修改类型，因此需要前置mutating关键字用来表示该函数中能够修改类型
//用class实现协议中的mutating方法时，不用写mutating关键字；用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字
//如下所示，Togglable协议含有toggle函数。根据函数名称推测，toggle可能用于切换或恢复某个属性的状态。mutating关键字表示它为突变方法
protocol ProtocolsTogglable {
    mutating func toggle ()
}

enum ProtocolsOnOffSwitch:ProtocolsTogglable{
    case off,on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

//协议类型
//协议本身不实现任何功能，但你可以将它当做类型来使用:
//作为函数，方法或构造器中的参数类型，返回值类型
//作为常量，变量，属性的类型
//作为数组，字典或其他容器中的元素类型

//作为参数类型
class ProtocolsDice {
    let sides:Int
    let generator:ProtocolsRandomNumberGenerator
    init(sides:Int,generator:ProtocolsRandomNumberGenerator){
        self.sides = sides
        //由于后者为RandomNumberGenerator的协议类型。所以它能够被赋值为任意遵循该协议的类型
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

//委托
protocol ProtocolDiceGame {
    var dice:ProtocolsDice{
        get
    }
    
    func play()
}

protocol ProtocolDiceGameDelegate {
    func gameDidStart(_ game:ProtocolDiceGame)
    func game(_ game:ProtocolDiceGame,didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(_ game:ProtocolDiceGame)
}

class ProtocolSnakeAndLadders:ProtocolDiceGame{
    let finalSquare = 25
    let dice = ProtocolsDice(sides: 6, generator: LinearCOngruentialGenerator())
    var square = 0
    var board:[Int]
    init() {
        board = [Int](repeating: 0,count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate:ProtocolDiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop:while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

//在扩展中添加协议成员
extension ProtocolSnakeAndLadders:ProtocolPrettyTextRepresentable{
    func asPrettyText() -> String {
        var output = asText() + ":\n"
        for index in 1...finalSquare{
            switch board[index] {
            case let ladder where ladder > 0:
                output += "up"
            case let snake where snake < 0:
                output += "down"
            default:
                output += "stop"
            }
        }
        return output
    }
}

//game在方法中被当做DiceGame类型而不是SnakeAndLadders类型，所以方法中只能访问DiceGame协议中的成员
class DiceGameTracker:ProtocolDiceGameDelegate{
    var numberOfTurns = 0
    func gameDidStart(_ game: ProtocolDiceGame) {
        numberOfTurns = 0
        if game is ProtocolSnakeAndLadders {
            print("The game is using a \(game.dice.sides) - sided dice")
        }
    }
    
    func game(_ game: ProtocolDiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: ProtocolDiceGame) {
        print("The game lasted for \(numberOfTurns) tunrs")
    }
}

//在扩展中添加协议成员
protocol ProtocolsTextRepresentabel{
    func asText() -> String
}

extension ProtocolsDice:ProtocolsTextRepresentabel {
    func asText() -> String {
        return "A \(sides) - sided dice"
    }
}

extension ProtocolSnakeAndLadders:ProtocolsTextRepresentabel {
    func asText() -> String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

//通过扩展补充协议声明
//当一个类型已经实现了协议中的所有要求，却没有声明时，可以通过扩展来补充协议声明
//即时满足了协议的所有要求，类型也不会自动转变，因此你必须为它做出明显的协议声明
struct PtorocolHamster{
    var name:String
    func asText() -> String {
        return "A hamster named \(name)"
    }
}
extension PtorocolHamster:ProtocolsTextRepresentabel{}

//协议能够继承一到多个其他协议。语法与类的继承相似，多个协议间用逗号,分隔
/*protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 协议定义
}*/

protocol ProtocolPrettyTextRepresentable:ProtocolsTextRepresentabel {
    func asPrettyText() -> String
}

//只有类才能使用的协议，在协议名称后面紧跟着关键词class
protocol someClassOnlyProtocol:class,ProtocolsTextRepresentabel{
    
}

//添加约束到协议扩展
extension Collection where Iterator.Element:ProtocolsTextRepresentabel{
    var textualDescription:String {
        let itemsAsText = self.map{
            $0.asText()
        }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

protocol ProtocolNamed {
    var name:String {
        get
    }
}

protocol ProtocolAged {
    var age:Int {
        get
    }
}

struct ProtocolPerson:ProtocolNamed,ProtocolAged {
    var name:String
    var age:Int
}

//一个协议可由多个协议采用protocol<SomeProtocol, AnotherProtocol>这样的格式进行组合，称为协议合成(protocol composition)
//wishHappyBirthday函数的形参celebrator的类型为protocol<Named,Aged>。可以传入任意遵循这两个协议的类型的实例
func wishHappyBirthday(_ celebrator:ProtocolNamed & ProtocolAged) {
    print("Happy birthday \(celebrator.name) - your're \(celebrator.age)!")
}

//使用is检验协议一致性，使用as将协议类型向下转换(downcast)为的其他协议类型
//is操作符用来检查实例是否遵循了某个协议
//as?返回一个可选值，当实例遵循协议时，返回该协议类型；否则返回nil
//as用以强制向下转换型
//@objc用来表示协议是可选的，也可以用来表示暴露给Objective-C的代码，此外，@objc型协议只对类有效，因此只能在类中检查协议的一致性
@objc protocol ProtocolHasArea{
    @objc optional var area:Double {
        get
    }
}

class ProtocolCircle:ProtocolHasArea {
    let pi = 3.1415927
    var radius:Double
    @objc var area:Double {
        return pi * radius * radius
    }
    
    init (radius:Double) {
        self.radius = radius
    }
}

class ProtocolCountry:ProtocolHasArea{
    @objc var area: Double
    init(area:Double){
        self.area = area
    }
}

class ProtocolAnimal{
    var legs:Int
    init(legs:Int) {
        self.legs = legs
    }
}

//可选协议含有可选成员，其遵循者可以选择是否实现这些成员。在协议中使用@optional关键字作为前缀来定义可选成员
//可选协议只能在含有@objc前缀的协议中生效。且@objc的协议只能被类遵循。
//CounterDataSource中的属性和方法都是可选的，因此可以在类中声明但不实现这些成员，尽管技术上允许这样做，不过最好不要这样写
@objc protocol ProtocolCounterDataSource {
    @objc optional func incrementForCount (_ count:Int) -> Int
    @objc optional var fixedIncrement:Int {
        get
    }
}

class ProtocolCounter {
    var count = 0
    var dataSource:ProtocolCounterDataSource?
    func increment () {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        }
        else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ProtocolThreeSource:ProtocolCounterDataSource {
     @objc let fixedIncrement = 3
}

class ProtocolTowardsZeroSource:ProtocolCounterDataSource {
    @objc func incrementForCount(_ count: Int) -> Int {
        if (count == 0) {
            return 0
        }
        else if count < 0 {
            return 1
        }
        else {
            return -1
        }
    }
}



class Protocols: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func start () {
        //Person结构体含有一个名为fullName的存储型属性，完整的遵循了协议。(若协议未被完整遵循，编译时则会报错)。
        let john = ProtocolsPerson(fullName: "John Appleseed")
        
        var ncc1701 = ProtocolsStarship(name: "Enterprise", prefix: "USS")
        
        var lightSwitch = ProtocolsOnOffSwitch.off
        lightSwitch.toggle()
        
        var d6 = ProtocolsDice(sides: 6, generator:LinearCOngruentialGenerator())
        for _ in 1...5 {
            print("Random dice roll is \(d6.roll())")
        }
        
        let d12 = ProtocolsDice(sides: 12, generator: LinearCOngruentialGenerator())
        print(d12.asText())
        
        let simonTheHamster = PtorocolHamster(name: "Simon")
        let somethingTextRepresentable:ProtocolsTextRepresentabel = simonTheHamster
        print(somethingTextRepresentable.asText())
        
        //协议类型可以被集合使用，表示集合中的元素均为协议类型
        //thing被当做是TextRepresentable类型而不是Dice，DiceGame，Hamster等类型。因此能且仅能调用asText方法
        let things:[ProtocolsTextRepresentabel] = [d12,simonTheHamster]
        for thing in things {
            print(thing.asText())
        }
        
        let objects:[AnyObject] = [
            ProtocolCircle(radius: 2.0),
            ProtocolCountry(area: 243_610),
            ProtocolAnimal(legs: 4)
        ]
        
        //当数组中的元素遵循HasArea协议时，通过as?操作符将其可选绑定(optional binding)到objectWithArea常量上
        for object in objects {
            if let objectWithArea = object as? ProtocolHasArea {
                print("Area is \(objectWithArea.area)")
            }
            else{
                print("Something that doesn't have an area")
            }
        }
        // Area is 12.5663708
        // Area is 243610.0
        // Something that doesn't have an area
        
        var counter = ProtocolCounter()
        counter.dataSource = ProtocolThreeSource()
        for _ in 1...4 {
            counter.increment()
            print(counter.count)
        }
        // 3
        // 6
        // 9
        // 12
        
        counter.count = -4
        counter.dataSource = ProtocolTowardsZeroSource()
        for _ in 1...5 {
            counter.increment()
            print(counter.count)
        }
        // -3
        // -2
        // -1
        // 0
        // 0
    }
}
