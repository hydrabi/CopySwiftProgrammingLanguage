//
//  FunctionSample2.swift
//  IsASample
//
//  Created by Hydra on 16/8/3.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation
class FunctionSample:ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let bounds = minMax1([8,-6,2,109,3,7]) {
            print("min is \(bounds.min)")
        }
        
        print(sayHello(to: "Bill", and: "Ted"))
        //忽略外部参数名
        omitFunction(1, 2)
        //函数类型
        var mathFunction: (Int,Int) -> Int = addTwoInts
        printMathResult(addTwoInts, 3, 5)
        
        //嵌套函数使用
        var currentValue = -4
        let moveNearToZero = chooseStepFunction1(currentValue > 0)
        
        while currentValue != 0 {
            print("\(currentValue)...")
            currentValue = moveNearToZero(currentValue)
        }
        
    }
    
    //返回元组
    func minMax (_ array:[Int]) -> (min:Int,max:Int) {
        
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count]{
            if value < currentMin {
                currentMin = value
            }
            else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin,currentMax)
    }
    
    //可选元组返回类型
    func minMax1(_ array:[Int]) -> (min:Int,max:Int)?{
        if array.isEmpty {
            return nil
        }
        
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count]{
            if value < currentMin {
                currentMin = value
            }
            else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin,currentMax)
    }
    
    //外部参数名：在内部参数名前面加上外部参数名，用空格隔开
    func sayHello(to person:String,and anotherPerson:String) -> String {
        return "Hello \(person) and \(anotherPerson)!"
    }
    
    //忽略外部参数名
    func omitFunction(_ firstParameterName:Int,_ secondParameterName:Int) {
        
    }
    
    //默认函数参数
    func defParameterFunction(_ paraWithDefault:Int = 12) {
        
    }
    
    //可变参数,最多只可以有一个可变参数
    func arithmeticMean(_ numbers:Double...) -> Double {
        var total:Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    //in-out参数
    func swapTwoInts1(_ a: inout Int, b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func addTwoInts(_ a:Int,_ b:Int) -> Int{
        return a + b
    }
    
    //函数类型作为参数类型
    func printMathResult(_ mathFunction:(Int,Int) -> Int,_ a :Int,_ b:Int){
        print("Result:\(mathFunction(a,b))")
    }
    
    //函数类型作为返回类型
    func stepForward(_ input:Int) -> Int {
        return input + 1
    }
    
    func stepBackward(_ input:Int) -> Int {
        return input - 1
    }
    
    func chooseStepFunction(_ backwards:Bool) -> (Int) -> Int {
        return backwards ? stepBackward : stepForward
    }
    
    //嵌套函数
    func chooseStepFunction1(_ backwards:Bool) -> (Int) -> Int {
        func stepForward1(_ input:Int) -> Int {
            return input + 1
        }
        
        func stepBackward1(_ input:Int) -> Int {
            return input - 1
        }
        
        return backwards ? stepBackward1 : stepForward1
    }
}
