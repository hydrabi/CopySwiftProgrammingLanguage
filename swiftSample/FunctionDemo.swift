//
//  FunctionDemo.swift
//  IsASample
//
//  Created by Hydra on 16/3/21.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation
class FunctionDemo:ViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sample()
        
        FunctionDemo.sayHello("sayHello")
        FunctionDemo.sayHelloWorld()
        FunctionDemo.sayGoodbye("Dave")
        FunctionDemo.printAndCount("hello,world")
        
        if let bounds = FunctionDemo.minMax([8,-6,2,109,3,71]){
            print("min is \(bounds.min) and max is \(bounds.max)")
        }
        
        FunctionDemo.sayHello(to: "Bill", and: "Ted")
        FunctionDemo.someFunction(1, 2)
        FunctionDemo.someFunction(6)
        FunctionDemo.someFunction()
        FunctionDemo.arithemticMean(1,2,3,4,5)
        FunctionDemo.arithemticMean(3,8.25,18.75)
        var someInt = 3
        var anotherInt = 107
        FunctionDemo.swapTwoInts(&someInt, &anotherInt)
        
        //使用函数类型作为参数
        var mathFunction:(Int,Int) -> Int = addTwoInts
        print("Result:\(mathFunction(2,3))")
        mathFunction = multiplyTwoInts
        print("Result:\(mathFunction(2,3))")
        let anotherMathFunction = addTwoInts
        
        //使用函数类型作为返回值
        var currentValue = 3
        let moveNearerToZero = self.chooseStepFunction(currentValue > 0)
        
    }
    
    override func sample() {

    }
    
    //func前缀 ->返回类型
    class func sayHello (_ personName:String) -> String {
        let greeting = "Hello, " + personName + "!"
        return greeting
    }
    
    //无参数，仍然需要括号
    class func sayHelloWorld() -> String {
        return "hello ,world"
    }
    
    //多个参数
    class func sayHello(_ personaName:String,alreadyGreeted:Bool) -> String {
        if alreadyGreeted{
            return sayHello(personaName)
        }
        else{
            return sayHello(personaName)
        }
    }
    
    //无返回值
    class func sayGoodbye(_ personName:String) {
        print("Goodbye,\(personName)!")
    }
    
    //可以无视返回值
    class func printAndCount(_ stringToPring:String) -> Int{
        print(stringToPring)
        return stringToPring.characters.count
    }
    
    class func printWithoutCounting(_ stringToPring:String) {
        FunctionDemo.printAndCount(stringToPring)
    }
    
    //返回值为元组
    
    class func minMax(_ array:[Int]) ->(min:Int,max:Int)? {
        if (array.isEmpty){
            return nil
        }
        
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1 ..< array.count]{
            if value < currentMin {
                currentMin = value
            }
            else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin,currentMax)
    }
    
    //external parameter 外部参数
    class func sayHello (to person:String,and anotherPerson:String) ->String{
        return "Hello \(person) and \(anotherPerson)!"
    }
    
    //省略外部参数,用下划线_代替省略的外部参数
    class func someFunction(_ firstParameter:Int,_ secondParameterName:Int){
        
    }
    
    //分配一个默认的参数，调用函数的时候可以的时候可以忽略参数
    class func someFunction(_ parameterWithDefault:Int = 12, anotherDefautlValue:Int = 13){
        
    }
    
    //可变参数，添加 ... 可以往参数里面添加可变数目的参数 注意：参数至少要有一个
    class func arithemticMean(_ numbers:Double ...)-> Double{
        var total:Double = 0
        for number in numbers{
            total += number
        }
        return total/Double(numbers.count)
    }
    
    //in-out 参数，参数本身不可以改变参数的值，想改变参数的值需要使用keyWord "inout" 放在参数的前面，且不能传送literal字面值，恒量constant
    class func swapTwoInts(_ a:inout Int,_ b:inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    //函数类型为 （Int,Int）-> Int
    func addTwoInts (_ a:Int, _ b:Int) -> Int{
        return a + b
    }
    
    func multiplyTwoInts(_ a:Int,_ b:Int) ->Int {
        return a * b
    }
    
    func stepForward(_ input:Int) -> Int {
        return input + 1
    }
    
    func stepBackward(_ input:Int) -> Int {
        return input - 1
    }
    
    //使用函数类型作为返回值
    func chooseStepFunction(_ backwards:Bool) -> (Int) -> Int {
        return backwards ? stepBackward : stepForward
    }
    
    //内嵌函数
    func nestedChooseStepFunction(_ backwards:Bool) -> (Int) -> Int{
        func stepForward(_ input:Int) -> Int {
            return input + 1
        }
        
        func  stepBackward(_ input:Int) -> Int {
            return input - 1
        }
        
        return backwards ? stepBackward : stepForward 
    }
}
