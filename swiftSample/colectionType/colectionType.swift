//
//  colectionType.swift
//  IsASample
//
//  Created by 毕志锋 on 15/11/13.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

import UIKit
class colectionType : NSObject {
    
    class func sample (){
        
//         colectionType.arrSample()
//         colectionType.dictionarySameple()
        colectionType.SetDemo()
    }
    
    /************************ Array *********************************/
    class func arrSample (){
        //用字面量构造数组,逐个元素创建数组
        var anotherShoppingList : [String] = ["Eggs","Milk"]
        //可以省略类型
        var shoppingList = ["Eggs","Milk"]
        //获取数组中的数据项数量
        print("\(shoppingList.count)\n")
        //判断是否为空
        if(shoppingList.isEmpty){
            print("empty")
        }
        //为数组添加项目
        shoppingList.append("Flour")
        //添加额外的数组,直接在数组后面添加一个或者多个拥有相同类型的数据项
        shoppingList += ["Baking Powder"]
        shoppingList += ["Chocolate Spread","Cheese","Butter"]
        //通过下标检索值
        var firstItem = shoppingList[0]
        //通过下标语法修改指定索引的已经存在的值
        shoppingList[0] = "Six eggs"
        //通过下标语法一次过修改某个范围的值
        shoppingList[4...6] = ["Bananas","Apples","Peach"];
        //在指定索引处插入一个值，在某个具体索引值之前添加数据项
        shoppingList.insert("Maple Syrup", at: 0)
        //删除指定索引的值
        let mapleSyrup = shoppingList.remove(at: 0)
        //删除最后一个值
        let apples = shoppingList.removeLast()
        
        //for in 迭代整个队列
        for item in shoppingList {
            print(item)
        }
        //通过枚举方法迭代队列，获得索引和值
        for (index,value) in shoppingList.enumerated(){
            print("Item \(index + 1) : \(value)")
        }
        print(shoppingList)
        
        
        //创建一个空的数组,通过构造函数的类型，someInts的值类型被推断为[Int]
        var someInts = [Int]()
        //如果代码上下文中已经提供了类型信息，例如一个函数参数或者一个已经定义好的类型常量或者变量，我们可以使用空数组语句创建一个空数组
        //写法：[] （一对空方括号）
        someInts.append(3)
        someInts = []
        print("\(someInts.count)")
        
        //Swift 中的Array类型还提供一个可以创建特定大小并且所有数据都被默认的构造方法。我们可以把准备加入新数组的数据项数量（count）和适当类型的初始值（repeatedValue）传入数组构造函数：
        //anotherThreeDoubles 被推断为 [Double]，等价于 [2.5, 2.5, 2.5]
        let threeDoubles = [Double](repeating: 0.0, count: 3)
        let anotherThreeDOubles = [Double](repeating: 2.5, count: 3)
        // sixDoubles 被推断为 [Double]，等价于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
        let sixDoubles = threeDoubles + anotherThreeDOubles
        print(sixDoubles)
    }
    
    /*************************** Set *******************************/
    //和数组不同的是，集合没有等价的简化形式。
    //set 存储无序的集合，每个值都是唯一不相同的，当你不需要序列的时候，或者你需要集合里面的每个值都是唯一的时候，可以取代array
    class func SetDemo () {
        //set 类型语法应该要被写为 Set<Element>
        var letters = Set<Character> ()
        print("letters is of type Set<Character> with \(letters.count) items.")
        //如果上下文已经提供了Set的类型，你可以创建空的set然后像array那样逐个字地添加值
        letters.insert("a")
        //比如作为函数的参数或者已知类型的变量或常量，我们可以通过一个空的数组字面量创建一个空的Set
        letters = []
        letters = ["b","c","d"]
        print(letters)
        //逐个字添加创建set
        var favoriteGenres : Set<String> = ["Rock","Classical","Hip hop"]
        //类型推断,不需要添加类型
        var anotherFavoriteGenres : Set = ["Rock","Classical","Hip hop"]
        //元素的数量，使用属性count
        print("I have \(favoriteGenres.count) favorite music genres.")
        //判断是否为空
        if(favoriteGenres.isEmpty){
            print("As far as music goes,I'm not picky")
        }
        else{
            print("Have particular music preferences")
        }
        //添加值
        favoriteGenres.insert("Jazz")
        //删除一个指定的值
        favoriteGenres.remove("Rock")
        //判断是否包含一个值
        if(favoriteGenres.contains("Funk")){
            print("Have funk")
        }
        else{
            print("Have no funk")
        }
        //迭代set
        for gener in favoriteGenres {
            print("\(gener)")
        }
        
        let oddDigits : Set = [1,3,5,7,9]
        let evenDigits : Set = [0,2,4,6,8]
        let sigleDigitPrimeNumbers : Set = [2,3,5,7]
        
        //并集 [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        print(oddDigits.union(evenDigits).sorted())
        //交集 []
        print(oddDigits.intersection(evenDigits).sorted())
        //差集 [1,2,9] oddDigits去掉与sigleDigitPrimeNumbers交集的部分
        print(oddDigits.subtracting(sigleDigitPrimeNumbers).sorted())
        //互斥  [1, 2, 9] 两者去掉交集的部分再合并
        print(oddDigits.symmetricDifference(sigleDigitPrimeNumbers).sorted())
        
        // == 判断两者是否包含相同的值
        // isSubsetOf 判断是否其所有的值都被包含在另外一个set中
        // isSupersetOf 判断其是否包含另外一个指定set的所有值
        // isStrictSubsetOf is StrictSupersetOf 精确判断以上情景，不包含等于的情况
        // isDisjointWith 两者不包含任何相同的值
    }
    
    /*************************** Dictionary *******************************/
    class func dictionarySameple (){
        //创建字典
        var airpoart:[String:String] = ["YYZ":"Toronto Pearson","DUB":"Dublin"]
        //字典键值对的数目
        print("The airports dictionary contains \(airpoart.count) items.")
        //判断是否为空
        if airpoart.isEmpty{
            print("The airports dictionary is empty.")
        }
        else{
            print("The airports dictionary is not empty")
        }
        //以下标方式添加新值
        airpoart["LHR"] = "London"
        airpoart["LHR"] = "London Heathrow"
        //通过updateValue方式替换值，返回值可选
        airpoart.updateValue("London somewhere", forKey: "LHR")
        //再次证明返回值可选
        if let oldValue = airpoart.updateValue("Dublin Airport", forKey: "DUB"){
            print("The old value for DUB was \(oldValue).")
        }
        //以下标语法获取到的值为可选值，使用前需要先判断是否为空
        if let airportName = airpoart["DUB"]{
            print("The name of the airport is \(airportName).")
        }
        else{
            print("That airport is not in the airports dictionary.")
        }
        //分配nil使指定的值为空
        airpoart["APL"] = "Apple International"
        airpoart["APL"] = nil
        //作用同上
        if let removedValue = airpoart.removeValue(forKey: "DUB"){
            print("The removed airport's name is \(removedValue).")
        }
        else{
            print("The airports dictionary does not contain a value for DUB.")
        }
        //遍历字典
        for(airpoartCode,airportName) in airpoart{
            print("\(airpoartCode):\(airportName)")
        }
        //遍历键
        for airportCode in airpoart.keys{
            print("Airport code:\(airportCode)")
        }
        //遍历值
        for airpoartName in airpoart.values{
            print("Airpoart name:\(airpoartName)")
        }
        //keys array
        _ = [String](airpoart.keys)
        //values array
        _ = [String](airpoart.values)
        
        var nameOfIntegers = [Int:String]()
        nameOfIntegers[16] = "sixteen"
        print("\(nameOfIntegers)")
        nameOfIntegers.removeAll()
        print("\(nameOfIntegers)")
        
        
    }
}

