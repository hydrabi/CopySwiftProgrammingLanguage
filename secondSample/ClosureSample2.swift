//
//  ClosureSample.swift
//  IsASample
//
//  Created by Hydra on 16/8/1.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

class ClosureSample2:ViewController {
    
    let names = ["a","b","c","d"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func greetPeople(_ people:String) -> String{
        return "Hello \(people)"
    }
    
    var peopleList = [
        "Ted",
        "Ted",
        "Ted"
    ]

    //捕获上下文的常量或者变量,即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
    func makeIncrementor(forIncrement amount:Int) -> () -> Int {
        var runningTotal = 0
        func incrementor() -> Int {
            //捕获了runningTotal和amount这两个值
            runningTotal += amount
            return runningTotal
        }
        return incrementor
    }
    
    func start() {
       let fullGreetings = peopleList.map(greetPeople)
        print(fullGreetings)
        //闭包表达式（匿名函数）。对于greetPeople这个全局函数来说，其实只需要使用一次，所以我们没必要单独定义这个函数。我们可以直接使用闭包表达式来处理
        var anotherFullGreetings = peopleList.map({(people:String) in return "Hello \(people)"})
        //有类型推断特性，可以取掉参数类型
        anotherFullGreetings = peopleList.map({(people) in return "Hello \(people)"})
        //像我们示例中的这种单一闭包表达式，编译器可以根据in之前的返回值类型和return之后的返回数据类型自动判断，所以我们可以省略返回值和return关键字：
        anotherFullGreetings = peopleList.map({people in "Hello \(people)"})
        //$0代表第一个参数，$1代表第二个参数，以此类推，我们可以将参数名称省略
        anotherFullGreetings = peopleList.map({"Hello \($0)"})
        //当最后一个参数是闭包时，可以将闭包写在（）之外，这也是swift的一个特性
        anotherFullGreetings = peopleList.map() {"Hello \($0)"}
        //当函数有且仅有一个参数，并且该参数是闭包时，不但可以将闭包写在（）外，还可以省略（）
        anotherFullGreetings = peopleList.map {"Hello \($0)"}
    }
    
    //ibook内的内容
    //闭包不能使用默认值参数
    func next() {
        var reversed = names.sorted(by: {(s1:String,s2:String) -> Bool in
            return s1 > s2
        })
        
        //作为sort函数的参数，swift能自动推导出参数和返回值的类型，所以参数类型，->,返回类型都可以省略
        //当闭包作为函数或者方法的参数，你不需要写完整的格式
        reversed = names.sorted(by: { s1,s2 in return s1 > s2 })
        //单一闭包表达式可以省略return关键词
        reversed = names.sorted(by: { s1,s2 in s1 > s2})
        //$0代表第一个参数，$1代表第二个参数，以此类推，我们可以将参数名称省略
        reversed = names.sorted(by: { $0 > $1})
        //最后一个参数是闭包，可以将闭包写在（）外
        //只有一个参数，可以将（）省略
        reversed = names.sorted{ $0 > $1 }
    }
    
    func tripule() {
        let incrementByTen = makeIncrementer1(forIncrement: 10)
        incrementByTen()
        incrementByTen()
        
        let incrementBySeven = makeIncrementer1(forIncrement: 7)
        incrementBySeven()
        incrementBySeven()
    }
    
    //捕获值
    //即使原有范围的常量和变量已经不再存在都可以捕获；最简单的捕获方式为嵌套函数，能够捕获外部的函数的参数
    //increment能够捕获amount和runningTotal两个参数
    //创建不同的函数，会存储一个新的，分开的runningTotal参数
    func makeIncrementer1(forIncrement amount:Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            print("\(runningTotal)")
            return runningTotal
        }
        
        return incrementer
    }
    
    //闭包是引用类型 @noescape使用
    //函数如果有一个一个参数是closure的话，可以在前面加一个关键字@noescape表示在函数return前closure生命周期结束
    
    var completionHandles:[() -> Void] = []
    var x = 10
    func someFunctionWithEscapingClosure(_ completionHandler:@escaping () -> Void){
        completionHandles.append(completionHandler)
    }
    
    func someFunctionWithNonescapingClosure( _ handler: () -> Void) {
        handler()
        print("x = \(x)")
    }
    
    //@noescape 还有个特性就是标记了 @noescape的closure可以免去写引用self
    func doSomething() {
        someFunctionWithNonescapingClosure{ x = 200 }
        someFunctionWithEscapingClosure({ self.x = 200 })
    }
    
    //@Autoclosures
    //简单说，@autoclosure 做的事情就是把一句表达式自动地封装成一个闭包 (closure)。
    //最后要提一句的是，@autoclosure 并不支持带有输入参数的写法，也就是说只有形如 () -> T 的参数才能使用这个特性进行简化。
    //http://www.cnblogs.com/xilifeng/p/5215606.html
    func autoClosuresSample() {
        var customersInLine = ["Chris","Alex","Ewa","Barry","Daniella"]
        print(customersInLine.count)
        let customerProvider = {
            customersInLine.remove(at: 0)
        }
        
        print("Now serving \(customerProvider())!")
        print("\(customersInLine.count)")
        
        //未使用Autoclosures前闭包的写法
        func serveCustom(_ customerProvider:() -> String){
            print("Now serving \(customerProvider())")
        }
        serveCustom({customersInLine.remove(at: 0)})
        
        //使用Autoclosures后闭包的写法
        func autoServeCustom( _ customerProvider:@autoclosure () -> String){
            print("Now serving \(customerProvider())")
        }
        autoServeCustom(customersInLine.remove(at: 0))
    }
}

