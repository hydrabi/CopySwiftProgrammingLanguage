//
//  ARCSample.swift
//  IsASample
//
//  Created by Hydra on 16/5/19.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

//对于生命周期中会变为nil的实例使用弱引用。相反的，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。
class ARCPerson {
    let name:String
    init(name:String){
        self.name = name
        print("\(name) is being initialized")
    }
    
    var apartment:ARCApartment?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

//弱引用不会牢牢保持住引用的实例，并且不会阻止 ARC 销毁被引用的实例。这种行为阻止了引用变为循环强引用。声明属性或者变量时，在前面加上weak关键字表明这是一个弱引用
//弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。
//因为弱引用可以没有值，你必须将每一个弱引用声明为可选类型
//你可以像其他可选值一样，检查弱引用的值是否存在，你永远也不会遇到被销毁了而不存在的实例
class ARCApartment {
    let unit:String
    init(unit:String){
        self.unit = unit
    }
    weak var tenant:ARCPerson?
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

//和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（non-optional type）
//Customer先被创建
class ARCCustomer{
    let name:String
    var card:ARCCredicard?
    init(name:String){
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

//Credicard后被创建，且customer不能为空，所以初始化时需要带上customer
class ARCCredicard{
    let number :Int
    unowned let customer:ARCCustomer
    init(number:Int,customer:ARCCustomer){
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card \(number) is being deinitialized")
    }
}

//Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
//
//Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，并会潜在的产生循环强引用。这种场景最适合通过无主引用来解决。
//存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后不能为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用显示展开的可选属性。
//Country的构造函数调用了City的构造函数。然而，只有Country的实例完全初始化完后，Country的构造函数才能把self传给City的构造函数。
class ARCCountry{
    let name:String
    var capitalCity:ARCCity!
    init(name:String,capitalName:String){
        self.name = name
        self.capitalCity = ARCCity(name: capitalName, country: self)
    }
}


class ARCCity{
    let name:String
    unowned let country:ARCCountry
    init(name:String,country:ARCCountry){
        self.name = name
        self.country = country
    }
}

//占有列表定义了闭包体内占有一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个占有的引用为弱引用或无主引用，而不是强引用

//当闭包和占有的实例总是互相引用时并且总是同时销毁时，将闭包内的占有定义为无主引用。
//
//相反的，当占有引用有时可能会是nil时，将闭包内的占有定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。这使我们可以在闭包内检查他们是否存在。
//注意:
//如果占有的引用绝对不会置为nil，应该用无主引用，而不是弱引用。

class ARCHTMLElement {
    let name:String
    let text:String?
    //在默认的闭包中可以使用self,因为只有当初始化完成以及self确实存在后，才能访问lazy属性
    lazy var asHTML:(Void) -> String = {
        //占有列表中的每个元素都是由weak或者unowned关键字和实例的引用（如self或someInstance）成对组成。每一对都在花括号中，通过逗号分开。
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }
        else{
            return "<\(self.name)/>"
        }
    }
    
    init(name:String,text:String? = nil){
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

//占有列表
//let var someClosure:(Int,String) -> String {
//    [unowned self,weak delegate = self.delegate!] (index:Int,stringToProcess:String) -> String in
//}


class ARCSample:ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start () {
//        var reference1 : ARCPerson?
//        var reference2 : ARCPerson?
//        var reference3 : ARCPerson?
//        
//        reference1 = ARCPerson(name: "John Appleseed")
//        reference2 = reference1
//        reference3 = reference1
//        
//        reference1 = nil
//        reference2 = nil
//        reference3 = nil
//        
//        var john:ARCPerson?
//        var number73:ARCApartment?
//        john = ARCPerson(name: "John Applesed")
//        number73 = ARCApartment(unit: "4A")
//        //导致强引用
//        john!.apartment = number73
//        number73!.tenant = john
        
        var john1:ARCCustomer?
        john1 = ARCCustomer(name: "John1")
        john1!.card = ARCCredicard(number: 123456789, customer:john1!)
        john1 = nil
        
        var paragraph:ARCHTMLElement? = ARCHTMLElement(name: "p", text: "hello world")
        print(paragraph!.asHTML)
        
        let heading = ARCHTMLElement(name: "h1")
        let defaultText = "some default text"
        heading.asHTML = {
            return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)"
        }
        
        var country:ARCCountry?
        country = ARCCountry(name: "Canada", capitalName: "ottawa")
        print("\(country!.name)'s capital city is called \(country!.capitalCity.name)")
        country = nil
    }
}
