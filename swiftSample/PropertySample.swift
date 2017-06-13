//
//  PropertySample.swift
//  IsASample
//
//  Created by Hydra on 16/5/13.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

//存储属性就是存储在特定类或结构体的实例黎的一个常量或变量,可以是变量存储属性var，也可以是常量存储属性
//计算属性被类，结构体，枚举提供；存储属性被类和结构体提供

struct FixedLengthRange{
    var firstValue:Int
    let length:Int
}

class DataImporter {
    //假设这个类需要大量的时间去初始化
    var fileName = "data.txt"
}

//延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性,用lazy修饰词放在前面
// 必须将延迟存储属性声明成变量（使用var关键字），因为属性的值在实例构造完成之前可能无法得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性 延迟属性很有用，当属性的值依赖于在实例的构造过程结束前无法知道具体值的外部因素时，或者当属性的值需要复杂或大量计算时，可以只在需要的时候来计算它。
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

//计算属性实际上并不存储值，而是提供了一个gettter和可选的setter去获取和设置其它属性和变量的值
struct Point {
    var x = 0.0,y = 0.0
}

struct Size {
    var width = 0.0,height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center:Point{
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point(x:centerX,y: centerY)
        }
        set (newCenter){
            origin.x = newCenter.x - (size.width/2)
            origin.y = newCenter.y - (size.height/2)
        }
        //如果没有定义新值的参数名，就可以使用默认的参数名称newValue
//        set {
//            origin.x = newValue.x - (size.width/2)
//            origin.y = newValue.y - (size.height/2)
//        }
    }
}

//只有getter没有setter的计算属性就是只读计算属性，只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值
//即使只读计算属性也必须使用var关键字，因为它们的值是不固定的
struct Cuboid {
    var width = 0.0,height = 0.0,depth = 0.0
    //只读属性的声明可以去掉get关键字和花括号
    var volume:Double{
        return width * height * depth
    }
}

//属性监视器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性监视器，甚至新的值和现在的值相同的时候也不例外
//可以为除了延迟存储属性之外的其它存储属性添加属性监视器，也可以通过重载属性的方式为继承的属性添加属性监视器
//不需要为无法重载的计算属性添加属性监视器，因为可以通过setter直接监控和响应值的变化
//willSet监视器会将新的属性值作为固定参数传入，在willSet的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称newValue表示
//类似地，didSet监视器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名oldValue
//willset和didSet监视器在属性初始化过程中不会被调用，他们只会在属性的值在初始化之外的地方呗设置时被调用
//didSet没有提供自定义名称，所以默认值oldValue表示旧值的参数名。
//如果在didset监视器里为属性赋值，这个值会替换监视器之前设置的值
class StepCounter{
    var totalSteps : Int = 0  {
        
        willSet(newTotalSteps){
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet{
            if(totalSteps > oldValue){
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

//全局和本地变量
//另外，在全局或局部范围都可以定义计算型变量和为存储型变量定义监视器，计算型变量跟计算属性一样，返回一个计算的值而不是存储值，声明格式也完全一样。
//全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要标记@lazy特性。

//类型属性
//也可以为类型本身定义属性，不管类型有多少个实例，这些属性都只有唯一一份。这种属性就是类型属性。
//类型属性通用与所有实例，想c的静态常量
//跟实例的存储属性不同，必须给存储型类型属性指定默认值，因为类型本身无法在初始化过程中使用构造器给类型属性赋值。
//定义类型属性使用static关键词，计算类型属性可以使用class关键词允许子类继承父类的实现
//类型属性是通过类型本身来获取和设置，而不是通过实例
struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty : Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty : Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty : Int {
        return 7
    }
    //允许子类覆盖父类的实现
    class var overrideableCOmputedProperty : Int {
        return 107
    }
}

struct AudioChannel{
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel : Int = 0 {
        didSet {
            if (currentLevel > AudioChannel.thresholdLevel){
                currentLevel = AudioChannel.thresholdLevel
            }
            
            if(currentLevel > AudioChannel.maxInputLevelForAllChannels){
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

class PropertySample:ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start () {
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0,length: 3)
        rangeOfThreeItems.firstValue = 6
        //结构体的实例创建后不能修改，即使它被分配给一个变量
        //rangeOfThreeItems.length = 2
        
        let rangeOfFourItems = FixedLengthRange(firstValue: 0,length: 4)
        //创建了一个结构体的实例并赋值给一个常量，则无法修改实例的任何属性
        //这里会报错
        //这种行为是由于结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。属于引用类型的类（class）则不一样，把一个引用类型的实例赋给一个常量后，仍然可以修改实例的变量属性。
//        rangeOfFourItems.firstValue = 6
        
        //    必须将延迟存储属性声明成变量（使用var关键字），因为属性的值在实例构造完成之前可能无法得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性 延迟属性很有用，当属性的值依赖于在实例的构造过程结束前无法知道具体值的外部因素时，或者当属性的值需要复杂或大量计算时，可以只在需要的时候来计算它。
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        //dataImporter实例还没有被创建,当importer属性被第一次访问
        print(manager.importer.fileName)
        //importer属性现在被创建了
        
    }
    
    func computedProperties () {
        var square = Rect(origin:Point(x: 0.0,y: 0.0),size:Size(width: 10.0,height: 10.0))
        let initialSquareCenter = square.center
        square.center = Point(x:15.0,y: 15.0)
        print("square.origin is now at (\(square.origin.x),\(square.origin.y))")
    }
    
    func typeProperties () {
        print("\(SomeClass.computedTypeProperty)")
    }
    
    func propertyObserve () {
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        stepCounter.totalSteps = 360
        stepCounter.totalSteps = 896
    }
}