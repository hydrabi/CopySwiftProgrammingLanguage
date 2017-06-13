//
//  EnumSample.swift
//  IsASample
//
//  Created by Hydra on 16/5/10.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

//case关键词表明新的一行成员将被定义，swift的枚举成员被创建时不会被馥郁一个默认的整数值
enum CompassPoint {
    case north
    case south
    case east
    case west
}

//多个成员值可以出现在同一行上，用逗号隔开：
//enum Planet {
//    case Mercury,Venus,Earth,Mars,Jupiter,Saturn,Uranus,Nepturn
//}

//下面的枚举是对之前Planet这个枚举的一个细化，利用原始整型值来表示每个 planet 在太阳系中的顺序,自动递增，planet.venus的值是2，以此类推
//无分配的话第一个初始值为0
enum Planet : Int{
    case mercury = 1,venus,earth,mars,jupiter,saturn,uranus,nepturn
}

//你可以定义 Swift 的枚举存储任何类型的实例值，如果需要的话，每个成员的数据类型可以是各不相同的。
//定义一个名为Barcode的枚举类型，它可以是UPCA的一个实例值，或者是qrcode的一个字符串类型的实例值
enum Barcode{
    case upca(Int,Int,Int)
    case qrCorde(String)
}

//原始值
//作为实例值的替代，枚举成员可以被默认值（原始值）预先填充，其中这些原始值具有相同的类型
//注意，原始值和实例值是不相同的。当你开始在你的代码中定义枚举的时候原始值是被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终是相同的。实例值是当你在创建一个基于枚举成员的新常量或变量时才会被设置，并且每次当你这么做得时候，它的值可以是不同的。
enum ASCIIControlCharacter:Character{
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//递归枚举
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression,ArithmeticExpression)
    case multiplication(ArithmeticExpression,ArithmeticExpression)
}

//枚举必须以大写字母开头
class EnumSample : ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start () {
        //一旦被声明为一个枚举，你可以用更短的点（.） 将其设置为该枚举的其它值
        var directionToHead = CompassPoint.west
        //当类型已知时，当设定它的值时，你可以不再写类型名
        directionToHead = .east
        //使用显示类型的枚举值可以让代码具有更好的可读性
        directionToHead = CompassPoint.north
        
        switch directionToHead {
        case .north:
            print("north")
        case .south:
            print("sourth")
        case .east:
            print("east")
        case .west:
            print("west")
        default:
            print("default")
        }
    }
    
    //实例值
    func associatedValue (){
        //创建了一个名为productBarcode的新变量，并且付给他一个barcode.upca的实例元组值
        var productBarcode = Barcode.upca(8, 85909_51226, 3);
        //同一个商品可以被分配给一个不用类型的条形码
        productBarcode = .qrCorde("ABCDEFGHIJKLMNOP")
        //然而这次实例值可以被提取作为 switch 语句的一部分,使用let或者var前缀
        switch productBarcode{
        case .upca(let numberSystem, let identifier, let check):
            print("UPCA value of \(numberSystem),\(identifier),\(check)")
        case .qrCorde(let productCode):
            print("QR code with value of \(productCode).")
        }
    }
    
    
    func toRawValue() {
        //使用枚举成员的toRaw方法可以访问该枚举成员的原始值
        let earthsOrder = Planet.earth.rawValue
        print("rawValue = \(earthsOrder)")
        //返回的是可选类型
        let possiblePlanet = Planet(rawValue : 7)
        if(possiblePlanet != nil){
            print("possiblePlanet = \(possiblePlanet)")
        }
    }
    
    func findPlanet () {
        let positionToFind = 9
        if let somePlanet = Planet(rawValue : positionToFind){
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not save place for humans")
            }
        }
        else{
            print("There isn't a planet at position \(positionToFind)")
        }
    }
    
    func evaluate(_ expression:ArithmeticExpression) -> Int {
        switch expression {
        case .number(let value):
            return value
        case .addition(let left, let right):
            return evaluate(left) + evaluate(right)
        case .multiplication(let left, let right):
            return evaluate(left) * evaluate(right)
        }
    }
    
    func recursive () {
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        print(evaluate(product))
    }
}
