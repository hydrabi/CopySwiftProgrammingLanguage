//
//  MethodsSample.swift
//  IsASample
//
//  Created by Hydra on 16/5/17.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation
//方法就是某些特定类型相关联的函数
//不使用self，swift会猜测你正在使用当前实例的属性或者方法;主要例外就是当参数名与实例的属性名相同;在这种情况，参数名优先
class Counter {
    var count = 0
    
    func increment () {
        self.count += 1
    }
    
    func incrementBy (_ amount:Int){
        count += amount
    }
    
    func incrementBy (_ amount:Int,numberOfTimes:Int){
        count += amount * numberOfTimes
    }
    
    func reset () {
        count = 0
    }
}

//在实例方法内修改值类型
//方法还能完全提供一个新的实例给self，这个新的实例当方法结束后会取代已经存在的实例
//结构体和枚举常量不能使用mutating方法，因为常量的属性不能被改变
struct MethodsPoint {
    var x = 0.0,y = 0.0
    //其中structure和enumeration是值类型(value type),class是引用类型(reference type)
    //但是与objective-c不同的是，structure和enumeration也可以拥有方法(method)，其中方法可以为实例方法(instance method)，也可以为类方法(type method)，实例方法是和类型的一个实例绑定的
    //虽然结构体和枚举可以定义自己的方法，但是默认情况下，实例方法中是不可以修改值类型的属性
    
    //在实例中修改值类型，在方法前面添加mutating 然后方法可以从方法内部改变它的属性，并且它的改变在方法结束时还会保留在原始结构中
    //常量不能调用变异方法，因为常量的的属性不能改变
    mutating func moveByX(_ deltaX:Double,y deltaY:Double){
        x += deltaX
        y += deltaY
    }
    
    //变异方法能够赋给隐含属性self一个全新的实例
    mutating func anotherMoveByX(_ deltaX:Double,y deltaY:Double){
        self = MethodsPoint(x:x + deltaX,y:y + deltaY)
    }
    
    func isToTheRightOfX(_ x:Double) -> Bool {
        return self.x > x
    }
}

enum TriStateSwitch {
    case off,low,high
    mutating func next () {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}


class MethodsSomeClass {
    //类型方法,通过在函数前面加上关键词static；如果类加上class关键词，则可以被子类继承
    //self指向这个类型本身，而不是类型的某个实例，这意味着可以用self来消除静态属性和静态方法参数之间的歧义
    static func someTypeMethod () {
        
    }
}

struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(_ level:Int) {
        if (level > highestUnlockedLevel ){
            highestUnlockedLevel = level
        }
    }
    
    static func levelIsUnlocked (_ level:Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1
    mutating func advanceToLevel(_ level:Int) -> Bool {
        if(LevelTracker.levelIsUnlocked(level)){
            currentLevel = level
            return true
        }
        else{
            return false
        }
    }
}

class MethodsSample : ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start () {
        //创建实例
        let counter = Counter()
        //调用实例方法
        counter.increment()
        counter.incrementBy(5)
        counter.reset()
        //amount是内部参数，numberOfTimes既是内部参数又是外部参数
        counter.incrementBy(5, numberOfTimes: 3)
        
        //实例方法修改值类型
        var somePoint = MethodsPoint(x:1.0,y:1.0)
        somePoint.moveByX(2.0,y:3.0)
        
        //在变异方法中给self赋值
        var ovenLight = TriStateSwitch.low
        ovenLight.next()
        // ovenLight 现在等于 .High
        ovenLight.next()
        // ovenLight 现在等于 .Off
    }
    
    func typeMethods () {
        
    }
}
