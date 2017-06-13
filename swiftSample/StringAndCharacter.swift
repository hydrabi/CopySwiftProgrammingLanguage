//
//  StringAndCharacter.swift
//  IsASample
//
//  Created by Hydra on 16/7/28.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

class StringAndCharacter:ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.start()
    }
    
    func start () {
        
    }
    
    //初始化字符串
    func initilizerString () {
        //空字符串
        var emptyString = ""
        //初始化
        var anotherEmptyString = String()
        //判断是否为空
        if emptyString.isEmpty{
            print("Nothing to see here")
        }
        //var 可以修改字符串
        var variableString = "Horse"
        variableString += " and carriage"
        
        let constantString = "Highlander"
        //编译错误
        //constantString += " and another Higlander"
    }
    
    func next () {
        //字符串是值类型
        //如果你创建了一个新的字符串，那么当其进行常量、变量赋值或在函数、方法中传递时，会进行值拷贝。任何情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值操作。
        
        //遍历字符串的字符
        for character in "Dog!".characters {
            print(character)
        }
        
        //字符串由字符构成
        let catCharacters:[Character] = ["c","a","t","!","🐶"]
        let catString = String(catCharacters)
        print(catString)
        
        //字符串连接,用+连接
        let string1 = "hello"
        let string2 = "there"
        var welcome = string1 + string2
        //用+=连接
        var instruction = "look over"
        instruction += string2
        //append连接
        let exclamationMask:Character = "!"
        welcome.append(exclamationMask)
        
        //字符串 插入字面量
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        
        //计算字符串
        var unusualMenagerie = "Koala🐶🐌🐧"
        unusualMenagerie += "🐧"
        unusualMenagerie += "\u{301}"
        print("unusualMenagerie has \(unusualMenagerie.characters.count)")
        
        //字符串可能存储内存数目不同的字符，所以不能通过整数编入索引
        let greeting = "Guten Tag!"
        print("\(greeting[greeting.startIndex])")
        //会报错,字符为空
        //print("\(greeting[greeting.endIndex])")
        print("\(greeting[greeting.characters.index(before: greeting.endIndex)])")
        print("\(greeting[greeting.characters.index(after: greeting.startIndex)])")
        print("\(greeting[greeting.characters.index(greeting.startIndex, offsetBy: 7)])")
        //用indices来遍历characters
        for index in greeting.characters.indices {
            print("\(greeting[index])",terminator:"")
        }
        //插入和删除
        welcome = "hello"
        welcome.insert("!", at: welcome.endIndex)
        //插入其他字符串
        welcome.insert(contentsOf: " there".characters, at: welcome.characters.index(before: welcome.endIndex))
        //hello there！
        //删除字符
        welcome.remove(at: welcome.characters.index(before: welcome.endIndex))
        //按照range删除字符
        let range = welcome.characters.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(range)
        
        //字符串比较
        let quotation = "We're a lot alike,you and I."
        let sameQuotation = "We're a lot alike,you and I."
        if(quotation == sameQuotation){
            print("These two strings are considered equal")
        }
        
        //前缀
        let romeoAndJuliet = [
            "Act 1 Scene 1: Verona, A public place",
            "Act 1 Scene 2: Capulet's mansion",
            "Act 1 Scene 3: A room in Capulet's mansion",
            "Act 1 Scene 4: A street outside Capulet's mansion",
            "Act 1 Scene 5: The Great Hall in Capulet's mansion",
            "Act 2 Scene 1: Outside Capulet's mansion",
            "Act 2 Scene 2: Capulet's orchard",
            "Act 2 Scene 3: Outside Friar Lawrence's cell",
            "Act 2 Scene 4: A street in Verona",
            "Act 2 Scene 5: Capulet's mansion",
            "Act 2 Scene 6: Friar Lawrence's cell"
        ]
        var act1SceneCount = 0
        for scene in romeoAndJuliet {
            if scene.hasPrefix("Act 1 "){
                act1SceneCount += 1
            }
        }
        print("There are \(act1SceneCount) scenes in Act 1")
        
        //后缀
        var mansionCount = 0
        var cellCount = 0
        for scene in romeoAndJuliet {
            if scene.hasSuffix("Capulet's mansion"){
                mansionCount += 1
            }
            else if scene.hasSuffix("Friar Lawrence's cell"){
                cellCount += 1
            }
        }
        print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
    }
}
