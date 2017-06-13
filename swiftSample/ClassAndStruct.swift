//
//  ClassAndStruct.swift
//  IsASample
//
//  Created by Hydra on 16/5/12.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

// 类和结构体
// 定义属性存储值
// 定义方法提供功能
// 下标语法
// 初始化
// 可以使用扩展
// 可以使用协议

// 可以继承父类特性
// 类型转换允许你检查和解析类的类型
// 析构允许你释放资源
// 引用计数允许多余一个指向实例的引用

// 指针 指向引用类型的常量或者变量相似与c的指针，但不是直接指向地址的内存，也不需要你填写*指出你正在创建一个引用

// 符合以下条件可以考虑使用结构体
// 1 主要是为了封装一些相关的简单的数据类型
// 2 当你分配或者传递封装的值将会被复制而不是引用
// 3 任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用。
// 4 结构体不需要从其他已经存在的类型中继承属性或者行为
// 在所有其它案例中，定义一个类，生成一个它的实例，并通过引用来管理和传递。实际中，这意味着绝大部分的自定义数据构造都应该是类，而非结构体。
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name:String?
}

class ClassAndStruct:ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start () {
        let someReasolution = Resolution()
        let someVideoMode = VideoMode()
        //通过点语法访问子属性
        print("The width of someVideoMode is \(someVideoMode.resolution.width)")
        //通过点语法为属性变量赋值
        someVideoMode.resolution.width = 12880
        print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
        //所有的结构体都会自动生成成员逐一构造器，用于初始化新结构体实例成员的属性；类实例没有默认的成员逐一构造器
        _ = Resolution(width: 640,height: 480)
        
        
    }
    
    func classDemo () {
        //结构体和枚举都是值类型，值类型被赋值给一个变量，常数或者本身被传递给一个函数的时候，实际上操作的是其的拷贝
        //所有的基本类型，如整数，浮点，字符串，数组，字典都是值类型
        let hd = Resolution(width:1920,height: 1080)
        var cinema = hd
        //hd 和 cinema是两个完全不同的实例
        cinema.width = 2048
        print("hd is still \(hd.width)")
        print("cinema is now \(cinema.width)")
        
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        //因为类是引用类型，所以两者实际上引用的是相同的videoMode实例
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        print("The frameRate property of tenEight is now \(tenEighty.frameRate)")
        // 等价于 ===
        // 不等价于 !== 
        // 等价于 表示两个类类型的常量或者变量引用同一个类实例
        if(tenEighty === alsoTenEighty){
            print("tenTighty and alsoTenEighty refer to the same Resolution instance")
        }
    }
    
    //字符串，队列，字典都是值类型，被分配到常量或者变量或者被传递到函数中的的时候实际上是被复制
    //字典类型的赋值和拷贝行为
    func dicCopyAction () {
        var age = ["Peter":23,"Wei":35,"Anish":65,"Katya":19]
        var copiedAges = age
        copiedAges["Peter"] = 24
        print(age["Peter"])
    }
    
    func arrayCopyAction () {
        var a = [1,2,3]
        var b = a
        var c = a
        
        print(a[0])
        print(b[0])
        print(c[0])
        
        a[0] = 42
        print(a[0])
        print(b[0])
        print(c[0])
        
        a.append(4)
        a[0] = 777
        print(a[0])
        print(b[0])
        print(c[0])
        
        
        
        class ExampleClass { var value = 10 }
        var array = [ExampleClass(), ExampleClass()]
        var arrayCopy = array
        
        // Changing the class instance effects it in both places
        array[0].value = 100
        // arrayCopy[0].value is also 100
        
        // Changing the elements of the array effects only one place
        array[0] = ExampleClass()
        // array[0].value is 10
        // arrayCopy[0].value is 100
        
        print(arrayCopy[0].value)
    }
}