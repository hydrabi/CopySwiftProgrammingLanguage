//
//  InheritanceSample.swift
//  IsASample
//
//  Created by Hydra on 16/5/17.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

class Vehicle {
    var currentSpeed = 0.0
    var description:String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise () {
        
    }
}

//建立一个新的类bicycle，继承vehicle的特性
class Bicycle:Vehicle{
    var hasBasket = false
}

//双人自行车
class Tandem:Bicycle{
    var currentNumberOfPassengers = 0
}

//重写方法,在某个需要重写的特性前面加上override关键词
class Train:Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

//通过super访问父类版本的方法，属性，下标
//重写属性：你可以将一个继承来的只读属性重写为一个读写属性，只需要你在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性。
//你在重写一个属性时，必需将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类型的属性相匹配的。
//如果你在重写属性中提供了setter，那么你也一定要提供getter
class Car:Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
    
    override var currentSpeed : Double {
        get{
            return super.currentSpeed
        }
        set{
            self.currentSpeed = newValue
        }
    }
}

//重写属性观察器：你可以在属性重写中为一个继承来的属性添加属性观察器，但你不可以为继承来的常量存储型属性或者继承来的只读计算型属性添加属性观察器，这些属性的值是不可以设置的
//可以为类中继承来的属性添加属性观察器，这样一来，当属性值改变时，类就会被通知到，可以为任何属性添加属性观察器，无论原本是存储型属性还是计算型属性；此外，你不可以同时提供重写的setter和重写的属性观察器 ，如果你已经为那个属性提供了定制的setter，那么你在setter中就可以观察到任何值变化了
class AutomaticCar:Car {
    override var currentSpeed : Double{
        didSet {
            gear = Int(currentSpeed/10.0) + 1
        }
    }
}

//防止重写：你可以通过把方法，属性或附属脚本标记为final来防止它们被重写，只需要在声明关键字前加上@final特性即可

class Inheritance:ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func start () {
            let someVehicle = Vehicle()
            //自动获得所有属性和方法
            let bicycle = Bicycle()
            bicycle.hasBasket = true
            bicycle.currentSpeed = 15.0
            print("Bicycle:\(bicycle.description)")
            
            let tandem = Tandem()
            tandem.hasBasket = true
            tandem.currentNumberOfPassengers = 2
            tandem.currentSpeed = 22.0
            print("Tandem:\(tandem.description)")
            
            let train = Train()
            train.makeNoise()
            
            let car = Car()
            car.currentSpeed = 25.0
            car.gear = 3
            
            let automatic = AutomaticCar()
            automatic.currentSpeed = 35.0
            print("AutomaticCar: \(automatic.description)")
        }
        
    }
}