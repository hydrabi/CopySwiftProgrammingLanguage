//
//  Generics.swift
//  IsASample
//
//  Created by Hydra on 16/6/28.
//  Copyright © 2016年 毕志锋. All rights reserved.
//  泛型

import Foundation

//泛型类型
//创建一个名为items的属性，使用空的T类型值数组对其进行初始化
//指定一个包含一个参数名为item的push方法，改参数必须是T类型
//指定一个pop方法的返回值，该返回值将是一个T类型值
//生成遵循Container协议的泛型Stack类型
struct GenericsIntStack<T>:GenericsContainer{
    var items = [T]()
    mutating func push(_ item:T){
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    mutating func append(_ item: T) {
        self.push(item)
    }
    
    var count:Int{
        return items.count
    }
    
    subscript(i:Int) -> T {
        return items[i]
    }
}

//关联类型行为
//Container协议定义了三个任何容器必须支持的兼容要求：
//
//必须可能通过append方法添加一个新item到容器里；
//必须可能通过使用count属性获取容器里items的数量，并返回一个Int值；
//必须可能通过容器的Int索引值下标可以检索到每一个item。
//尽管如此，ItemType别名支持一种方法识别在一个容器里的items类型，以及定义一种使用在append方法和下标中的类型，以便保证任何期望的Container的行为是强制性的。
protocol GenericsContainer {
    associatedtype ItemType
    mutating func append(_ item:ItemType)
    var count:Int{
        get
    }
    subscript(i:Int) -> ItemType{
        get
    }
}

class Generics:ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //这里是一个标准的，非泛型函数swapTwoInts,用来交换两个Int值：
    func GenericsSwapTwoInts(_ a:inout Int,b:inout Int){
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    //泛型函数可以工作于任何类型，这里是一个上面swapTwoInts函数的泛型版本，用于交换两个值
    //这个函数的泛型版本使用了占位类型名字（通常此情况下用字母T来表示）来代替实际类型名（如Int、String或Double）。
    //占位类型名没有提示T必须是什么类型，但是它提示了a和b必须是同一类型T，而不管T表示什么类型。
    //只有swapTwoValues函数在每次调用时所传入的实际类型才能决定T所代表的类型
    
    //另外一个不同之处在于这个泛型函数名后面跟着的展位类型名字（T）是用尖括号括起来的（）。
    //这个尖括号告诉 Swift 那个T是swapTwoValues函数所定义的一个类型。
    //因为T是一个占位命名类型，Swift 不会去查找命名为T的实际类型
    
    //在上面的swapTwoValues例子中，占位类型T是一种类型参数的示例。
    //类型参数指定并命名为一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来,例如<T>
    //你可支持多个类型参数，命名在尖括号中，用逗号分开。
    
    //注意 请始终使用大写字母开头的驼峰式命名法（例如T和KeyType）来给类型参数命名，以表明它们是类型的占位符，而非类型值。
    func GenericsSwapTwoValues<T>(_ a:inout T,_ b:inout T){
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    //栈
    //    struct GenericsIntStack{
    //        var items = [Int]()
    //        mutating func push(item:Int){
    //            items.append(item)
    //        }
    //
    //        mutating func pop() -> Int{
    //            return items.removeLast()
    //        }
    //    }
    
    //类型约束语法 让其是某种类的子类或者遵循某种协议
    //你可以写一个在一个类型参数名后面的类型约束，通过冒号分割，来作为类型参数链的一部分。这种作用于泛型函数的类型约束的基础语法如下所示（和泛型类型的语法相同）：
    //func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
       // function body goes here
    //}
    
    //findIndex中这个单个类型参数写做：T: Equatable，也就意味着“任何T类型都遵循Equatable协议”。Swift 标准库中定义了一个Equatable协议，该协议要求任何遵循的类型实现等式符（==）和不等符（!=）对任何两个该类型进行比较。
    func GenericsFindIndex<T:Equatable>(_ array:[T],valueToFind:T) -> Int?{
        for (index,value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
    //这两个容器可以被检查出是否是相同类型的容器（虽然它们可以是），但他们确实拥有相同类型的元素。这个需求通过一个类型约束和where语句结合来表示：
    
    /*C1必须遵循Container协议 (写作 C1: Container)。
    C2必须遵循Container协议 (写作 C2: Container)。
    C1的ItemType同样是C2的ItemType（写作 C1.ItemType == C2.ItemType）。
    C1的ItemType必须遵循Equatable协议 (写作 C1.ItemType: Equatable)。
    第三个和第四个要求被定义为一个where语句的一部分，写在关键字where后面，作为函数类型参数链的一部分*/

    func GenericsAllItemsMatch<C1:GenericsContainer,C2:GenericsContainer
        where C1.ItemType == C2.ItemType,C1.ItemType:Equatable> (_ someContainer:C1,anotherContainer:C2) -> Bool{
        if(someContainer.count != anotherContainer.count){
            return false
        }
        
        for i in 0..<someContainer.count {
            if (someContainer[i] != anotherContainer[i]){
                return false
            }
        }
        
        return true
    }
    
    func start () {
        var someInt = 3
        var anotherInt = 107
        GenericsSwapTwoInts(&someInt, b: &anotherInt)
        print("someInt is now \(someInt),and the anotherInt is now \(anotherInt)")
        
        var someString = "hello"
        var ahotherString = "world"
        GenericsSwapTwoValues(&someString, &ahotherString)
        
        var statckOfString = GenericsIntStack<String>()
        statckOfString.push("uno")
        statckOfString.push("dos")
        statckOfString.push("tres")
        statckOfString.push("cuatro")
        
        let doubleIndex = GenericsFindIndex([3.114159,0.1,0.25], valueToFind: 9.3)
        // doubleIndex is an optional Int with no value, because 9.3 is not in the array
        let stringIndex = GenericsFindIndex(["Mike","Malcolm","Andrea"], valueToFind: "Andrea")
        // stringIndex is an optional Int containing a value of 2
        
    }
}
