//
//  Extensions.swift
//  IsASample
//
//  Created by Hydra on 16/6/13.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

//扩展
/*添加计算型属性和计算静态属性
定义实例方法和类型方法
提供新的构造器
定义下标
定义和使用新的嵌套类型
使一个已有类型符合某个接口
使某个类型采用一个或者多个协议*/


//计算型属性
extension Double{
    var km:Double {
        return self * 1_000.0
    }
    
    var m:Double{
        return self
    }
    
    var cm:Double{
        return self / 100.0
    }
    
    var mm:Double{
        return self / 1_000.0
    }
    
    var ft:Double {
        return self / 3.28084
    }
}



//扩展可以向已有类型添加新的构造器。这可以让你扩展其它类型，将你自己的定制类型作为构造器参数，或者提供该类型的原始实现中没有包含的额外初始化选项
//扩展能够添加新的便利构造器，但不能添加新的指定构造器和析构函数
struct ExtensionsSize {
    var width = 0.0, height = 0.0
}

struct ExtensionsPoint {
    var x = 0.0,y = 0.0
}

struct ExtensionsRect{
    var origin = ExtensionsPoint()
    var size = ExtensionsSize()
}

//扩展的构造器
extension ExtensionsRect{
    init(center:ExtensionsPoint,size:ExtensionsSize){
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin:ExtensionsPoint(x: originX, y: originY),size:size)
    }
}

//扩展可以向已有类型添加新的实例方法和类型方法
extension Int{
    func repetitions(_ task:() -> ()) {
        for _ in 0..<self {
            task()
        }
    }
}

//通过扩展添加的实例方法也可以修改该实例本身。
//结构体和枚举类型中修改self或其属性的方法必须将该实例方法标注为mutating，正如来自原始实现的修改方法一样
extension Int{
    mutating func square() {
        self = self * self
    }
}

//扩展可以向一个已有类型添加新下标
extension Int{
    subscript(digitIndex:Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

//扩展可以向已有的类，结构体和枚举添加新的嵌套类型
extension Int {
    enum ExtensionsKind {
        case negative,zero,positive
    }
    
    var kind:ExtensionsKind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

class Extensions:ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start () {
        let oneInch = 25.4.mm
        print("One inch is \(oneInch) meters")
        let threeFeet = 3.ft
        print("Three feet is \(threeFeet) meters")
        //这些属性是只读的计算型属性，所有从简考虑它们不用get关键字表示。它们的返回值是Double型，而且可以用于所有接受Double的数学计算中
        let aMarathon = 42.km + 195.m
        print("A marathon is \(aMarathon) meters long")
        //扩展可以添加新的计算属性，但是不可以添加存储属性，也不可以向已有属性添加属性观测器
        //因为结构体Rect提供了其所有属性的默认值，所以正如默认构造器中描述的，它可以自动接受一个默认的构造器和一个成员级构造器
        let defaultRect = ExtensionsRect()
        let numberwiseRect = ExtensionsRect(origin: ExtensionsPoint(x: 2.0,y: 2.0), size: ExtensionsSize(width: 5.0, height: 5.0))
        //如果你使用扩展提供了一个新的构造器，你依旧有责任保证构造过程能够让所有实例完全初始化
        let centerRect = ExtensionsRect(center: ExtensionsPoint(x: 4.0,y: 4.0), size: ExtensionsSize(width: 3.0, height: 3.0))
        
        //你就可以对任意整数调用repetitions方法,实现的功能则是多次执行某任务
        3.repetitions({
            print("Hello")
            // Hello!
            // Hello!
            // Hello!
        })
        
        //trailing闭包
        3.repetitions{
            print("Goodbye")
        }
        
        var someInt = 3
        //someInt现在的值是9
        someInt.square()
        
        746381295[0]
        //返回5
        746381295[1]
        //返回9
        
        printIntegerKinds([3,19,-27,0,-6,0,7])
    }
    
    func printIntegerKinds(_ numbers:[Int]){
        for number in numbers {
            switch number.kind {
            case .negative:
                //print(items, separator: String, terminator: String)
                //items：要打印的变量，或常量
                //separator：多个item参数之间的间隔符
                //terminator：打印的末尾可以增加一个字符串
                print("- ",terminator:"a")
            case .zero:
                print("0 ",terminator:"a")
            case .positive:
                print("+ ",terminator:"a")
            }
        }
        print("")
        //+ + - 0 - 0 +
    }
    
}
