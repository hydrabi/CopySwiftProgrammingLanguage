//
//  InitializationSample.swift
//  IsASample
//
//  Created by Hydra on 16/5/18.
//  Copyright © 2016年 毕志锋. All rights reserved.
//  

import Foundation

//与 Objective-C 中的构造器不同，Swift 的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化
//存储型属性的初始复制
//类和结构体在实例创建时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
struct Fahrenheit {
    var temperature:Double
    init () {
        temperature = 32.0
    }
}

//使用默认值
struct Default {
    var temperature = 32.0
}

//可以在定义构造器时提供构造参数，为其提供定制化构造所需值得类型和名字
struct Celsius {
    var temperatureInCelsius:Double = 0.0
    init (fromFahrenheit fahrenheit:Double){
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init (fromKelvin kelvin:Double){
        temperatureInCelsius = kelvin - 273.15
    }
    
}

//如果你在定义构造器是没有提供参数的外部名字，swift会为每个构造器的参数自动生成一个跟内部名字相同的外部名
//如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线_来显示它的外部名，以覆盖上述的默认行为
//调用时必须使用参数名，否则报错
struct Color {
    let red , green ,blue :Double
    init (red:Double,green:Double,blue:Double){
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    
    init (white:Double){
        red   = white
        green = white
        blue  = white
    }
}

//可选属性类型：允许取值为空的存储型属性，不管是因为它无法再初始化时赋值，还是因为它可以在之后某个时间点可以赋值为空，需要将它定义为可选类型optional type
//只要在构造过程结束前常量的值能确定，你可以在构造过程中的任意时间点修改常量属性的值
//对某个类实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。
class SurveyQuestion{
//    var text:String
    let text:String
    var response:String?
    init(text:String){
        self.text = text
    }
    
    func ask(){
        print(text)
    }
}

//默认构造器:所有属性已提供默认值的且自身没有定义任何构造器的结构体或基类，提供一个默认的构造器
//ShoppingListItem()
class ShoppingListItem{
    var name:String?
    var quantity  = 1
    var purchased = false
}

//结构体的逐一成员构造器L：如果结构体对所有存储型属性提供了默认值且自身没有提供定制的构造器，它们能自动获得一个逐一成员构造器
//InitialSize(width: 1, height: 1)
struct InitialSize {
    var width = 0.0, height = 0.0
}

struct InitialPoint {
    var x = 0.0,y = 0.0
}

//值类型的构造器代理：你可以使用self.init在自定义的构造器中引用其它的属于相同值类型的构造器。并且你只能在构造器内部调用self.init
//如果你为某个值类型定义了一个定制的构造器，你将无法访问到默认构造器（如果是结构体，则无法访问逐一对象构造器）
//假如你想通过默认构造器、逐一对象构造器以及你自己定制的构造器为值类型创建实例，我们建议你将自己定制的构造器写到扩展（extension）中，而不是跟值类型定义混在一起
struct InitialRect {
    var origin = InitialPoint()
    var size   = InitialSize()
    
    //跟默认构造器一样，是一个空函数，创建后返回一个rect实例，origin和size都是用默认值
    init () {
        
    }
    
    //其实就是逐一构造器
    init (origin:InitialPoint,size:InitialSize){
        self.origin = origin
        self.size   = size
    }
    
    init (center:InitialPoint,size:InitialSize){
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin:InitialPoint(x: originX, y: originY),size:size)
    }
}

//类里面所有的存储型属性，包括所有继承自父类的属性，都必须在构造过程中设置初始值
//Swift 提供了两种类型的类构造器来确保所有类实例中存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。
//指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。每一个类都必须拥有至少一个指定构造器
//你可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入的实例
//指定构造器和便利构造器
//规则 1
//指定构造器必须调用其直接父类的的指定构造器。
//规则 2
//便利构造器必须调用同一类中定义的其它构造器。
//规则 3
//便利构造器必须最终以调用一个指定构造器结束

class Food {
    var name:String
    
    //指定构造器，确保所有实例中存储属性都被初始化
    init(name:String){
        self.name = name
    }
    
    //便利构造器
    convenience init() {
        self.init(name:"[Unnamed]")
    }
}

class RecipeIngredient : Food {
    var quantity:Int
    init(name:String,quantity:Int){
        //符合安全检查1，先初始化原来属性，才能将其它构造任务向上代理给父类中的构造器
        self.quantity = quantity
        super.init(name: name)
        self.name = ""
    }
    
    convenience override init(name: String) {
        self.init(name:name,quantity:1)
    }
}

//与方法、属性和下标不同，在重载构造器时你没有必要使用关键字override。
//子类不会默认继承父类的构造器。但是如果特定条件可以满足，父类构造器是可以被自动继承的
//规则 1
//如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
//规则 2
//如果子类提供了所有父类指定构造器的实现--不管是通过规则1继承过来的，还是通过自定义实现的--它将自动继承所有父类的便利构造器。
//即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。
class InitializationShoppingListItem:RecipeIngredient {
    //由于它为自己引入的所有属性都提供了默认值，并且自己没有定义任何构造器，shoppinglistitem讲自动继承所有父类中的指定构造器和遍历构造器
    var purchased = false
    var description:String{
        var output = "\(quantity) x \(name)"
        output += purchased ? "YES" : "NO"
        return output
    }
}

//通过闭包和函数来设置属性的默认值
//如果某个存储型属性的默认值需要特别的定制或准备，你就可以使用闭包或全局函数来为其属性提供定制的默认值。
//注意闭包结尾的大括号后面接了一对空的小括号。这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
//这意味着你不能够在闭包里访问其它的属性，就算这个属性有默认值也不允许。同样，你也不能使用隐式的self属性，或者调用其它的实例方法。
//class SomeClass {
//    let someProperty: SomeType = {
//        // 在这个闭包中给 someProperty 创建一个默认值
//        // someValue 必须和 SomeType 类型相同
//        return someValue
//    }()
//}

struct InittializationCheckerborad{
    let boardColors:[Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10{
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAtRow(_ row:Int,column:Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

//失败初始化,实例为可选类型，如果创建失败，返回空
struct Animal {
    let species : String
    init?(species:String){
        if (species.isEmpty){
            return nil
        }
        self.species = species
    }
}

//枚举失败初始化
enum TemperatureUnit {
    case kelvin,celsius,fahrenheit
    init?(symbol:Character){
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

//枚举未加工值失败初始化
enum TemperatureUnit1:Character {
    case kelvin = "K",celsius = "C",fahrenheit = "F"
}

//传播失败初始化
class Product1{
    let name:String
    init?(name:String){
        if(name.isEmpty){
            return nil
        }
        
        self.name = name
    }
}

class CartItem1:Product1 {
    let quantity:Int
    init?(name: String,quantity:Int) {
        if(quantity<1){
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

//覆盖失败初始化
class Document{
    var name:String?
    init () {}
    init? (name:String){
        self.name = name
        if(name.isEmpty){
            return nil
        }
    }
}

//以非失败初始化覆盖失败初始化方法
class AutomaticallyNamedDocument:Document {
     override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init?(name: String) {
        super.init()
        if(name.isEmpty){
            self.name = "[Untitled]"
        }
        else{
            self.name = name
        }
    }
}

class requiredClass {
    //每一个子类必须实现这个初始化方法，不需要写override
    required init() {
        
    }
}

//必须实现的初始化
//class SomeClass{
//    required init(){
//        
//    }
//}

//class SomeSubclass:SomeClass{
//    required init() {
//        
//    }
//}

//当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察器
//两段式构造过程
//第一个阶段，每个存储型属性通过引入它们的类的构造器来设置初始值。当每一个存储型属性值被确定后，第二阶段开始，它给每个类一次机会在新实例准备使用之前进一步定制它们的存储型属性。
//安全检查 1
//
//指定构造器必须保证它所在类引入的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。
//
//如上所述，一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则，指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。
//安全检查 2
//
//指定构造器必须先向上代理调用父类构造器，然后再为继承的属性设置新值。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。
//安全检查 3
//
//便利构造器必须先代理调用同一类中的其它构造器，然后再为任意属性赋新值。如果没这么做，便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。
//安全检查 4
//
//构造器在第一阶段构造完成之前，不能调用任何实例方法、不能读取任何实例属性的值，也不能引用self的值。

//阶段 1
//
//某个指定构造器或便利构造器被调用；
//完成新实例内存的分配，但此时内存还没有被初始化；
//指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化；
//指定构造器将调用父类的构造器，完成父类属性的初始化；
//这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部；
//当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段1完成。
//
//阶段 2
//
//从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
//最终，任意构造器链中的便利构造器可以有机会定制实例和使用self
class InitializationSample:ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start () {
        var f = Fahrenheit()
        print("The default temperature is \(f.temperature)")
        
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        
        let magneta = Color(red: 1.0, green: 1.0, blue: 1.0)
        let halfGray = Color(white: 0.5)
        
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        cheeseQuestion.response = "Yes,I do like cheese."
        
        var item = ShoppingListItem()
        let twoByTwo = InitialSize(width: 2.0, height: 2.0)
        
        let mysteryMeat = Food()
        let oneMysteryItem = RecipeIngredient()
        print(oneMysteryItem)
        
        
        var breakfastList          = [InitializationShoppingListItem(),
                             InitializationShoppingListItem(name:"Bacon"),
                             InitializationShoppingListItem(name: "Eggs", quantity: 6)]
        breakfastList[0].name      = "Orange juice"
        breakfastList[0].purchased = true
        for item in breakfastList{
            print(item.description)
        }
        
        let board = InittializationCheckerborad()
        print(board.squareIsBlackAtRow(0, column: 1))
        
        let someCreature = Animal(species: "Giraffe")
        if (someCreature != nil){
            print("not empty")
        }
        
        let anonymousCreture = Animal(species: "")
        if(anonymousCreture == nil){
            print("is empty")
        }
        
        let fahrenheitUnit = TemperatureUnit1(rawValue: "F")
        if(fahrenheitUnit != nil){
            print("F is define")
        }
        
        let unknowUnit = TemperatureUnit1(rawValue: "X")
        if(unknowUnit == nil){
            print("X is not defined")
        }
        
        
    }
}
