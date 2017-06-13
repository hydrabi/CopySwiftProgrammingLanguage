//
//  ControlFlow.swift
//  IsASample
//
//  Created by Hydra on 15/12/16.
//  Copyright © 2015年 毕志锋. All rights reserved.
//

import Foundation
import UIKit
class ControlFlow: NSObject {
    class func start() {
//        ControlFlow.forSample()
//        ControlFlow.whileSample()
//        ControlFlow.switchSample()
//        ControlFlow.continueSample();
//        ControlFlow.breakSample()
//        ControlFlow.fallthroughSample()
//        ControlFlow.labelSample()
        ControlFlow.guardSample()
    }
    
    /************************ For *********************************/
    
    class func forSample(){
        // ... 范围 1到5
        for index in 1...5{
            print("\(index) times 5 is \(index * 5)")
        }
        // ... 范围 1到5
        for index in 1..<5{
            print("\(index) times 5 is \(index * 5)")
        }
        
        let base = 3
        let power = 10
        var answer = 1
        //不需要计量顺序，可以用下划线代替
        for _ in 1...power{
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        
        //遍历字典,返回的每一个元素都为一个元组，animalName为key，legCount为value
        let numberOfLegs = ["spider":8,"ant":6,"cat":4]
        for (animalName,legCount) in numberOfLegs{
            print("\(animalName)s have \(legCount) legs")
        }
        
        //传统c风格for循环,不需要圆括号
        for index in 0 ..< 3{
            print("index is \(index)")
        }

    }
    
    /************************ while *********************************/
    class func whileSample() {
        let finalSquare = 25
        //返回一个具有25个整数值的队列，每个值为0
        var board = [Int](repeating: 0, count: finalSquare)
        board[03] = 08
        board[06] = +11
        board[09] = 9
        board[10] = 2
        board[14] = -10
        board[19] = -11
        board[22] = -02
        board[24] = -08
        
        var square = 0
        var diceRoll = 0
        while square < finalSquare{
            diceRoll += 1
            if 7 == diceRoll {
                diceRoll = 1
            }
            
            square += diceRoll
            
            if square < board.count {
                square += board[square]
                print("diceRoll value is \(diceRoll)")
                print("square value is \(square)")
            }
        }
        
        print("Game over!")
    }
    
    /************************ switch *********************************/
    //不需要写break，case某个条件后直接返回，需要的时候可以加入fallthrough关键词使用回objc原来的规则
    class  func switchSample() {
        let someCharacter:Character = "e"
        switch someCharacter {
        case "a","e","i","o","u":
            print("\(someCharacter) is a vowel")
        case "b","c" :
            print("\(someCharacter) is a consonant")
        default:
            print("\(someCharacter) is not a vowel or a consonant")
            
        }
        
        let anotherCharacter:Character = "a"
        switch anotherCharacter {
            case "a","A":
            print("The letter A")
            print("The letter a")
        default:
            print("Not the letter A")
        }
        
        //范围匹配
        let count = 3_000_000_000_000
        let countedThings = "stas in the milky Way"
        var naturalCount:String
        switch count{
        case 0:
            naturalCount = "no"
            naturalCount = "aa"
            naturalCount = "no"
        case 1...3:
            naturalCount = "a few"
        case 4...9:
            naturalCount = "several"
        case 10...99:
            naturalCount = "tens of"
        case 100...999:
            naturalCount = "hundreds of"
        case 1000...999_999:
            naturalCount = "thousands of"
        default:
            naturalCount = "millions and millions of"
        }
        print("There are \(naturalCount) \(countedThings)")
    }
    
    /************************ tuples *********************************/
    class func tuplesSample() {
        let somePoint = (1,1)
        switch somePoint {
        case (0,0):
            print("(0,0) is at the origin")
        case (_,0):
            print("(\(somePoint.0),0) is on the x-axis")
        case (0,_):
            print("(0,\(somePoint.1)) is on the y-axis")
        case (-2...2,-2...2):
            print("\(somePoint.0),\(somePoint.1) is inside of the box")
        default:
            print("\(somePoint.0),\(somePoint.1)) is outside of the box")
        }
        
        //可存放临时值,值绑定
        let anotherPoint = (2,0)
        switch anotherPoint {
        case (let x,0):
            print("on the x-axis with an x value of \(x)")
        case (0,let y):
            print("on the y-axis with a y value of \(y)")
        case let (x,y):
            print("somewhere else at (\(x),\(y))")
        }
        
        //可以添加where额外条件
        let yetAnotherPoint = (1,-1)
        switch yetAnotherPoint{
        case let (x,y) where x == y:
            print("\(x),\(y) is on the line x == y")
        case let (x,y) where x == -y:
            print("\(x),\(y) is on the line x == -y")
        case let (x,y):
            print("\(x),\(y) is just some arbitrary point")
        }
    }
    
    class func continueSample() {
        //continue 跳过当次循环
        let puzzleInput = "great minds think alike"
        var puzzleOutput = ""
        for charater:Character in puzzleInput.characters{
            switch charater {
            case "a","e","i","o","u"," ":
                continue
            default:
                puzzleOutput.append(charater)
            }
        }
        
        print(puzzleOutput)
    }
    
    class func breakSample() {
        let numberSymbol:Character = "三"
        var possibleIntegerValue:Int?
        switch numberSymbol{
        case "1","一":
            possibleIntegerValue = 1
        case "2","二":
            possibleIntegerValue = 2
        case "3","三":
            possibleIntegerValue = 3
        case "4","四":
            possibleIntegerValue = 4
        default:
            break
        }
        
        if let integerValue = possibleIntegerValue {
            print("The integer value of \(numberSymbol) is \(integerValue)")
        }
        else{
            print("An integer value could not be found for \(numberSymbol).")
        }
    }
    
    class func fallthroughSample() {
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe{
        case 2,3,5,7,11,13,17,19:
            description += " a prime number,and also"
            fallthrough
        default:
            description += " an integer"
        }
        
        print(description)
    }
    
    class func labelSample() {
        let finalSquare = 25
        //返回一个具有25个整数值的队列，每个值为0
        var board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = 08
        board[06] = +11
        board[09] = 9
        board[10] = 2
        board[14] = -10
        board[19] = -11
        board[22] = -02
        board[24] = -08
        
        var square = 0
        var diceRoll = 0
        
        gameLoop : while square != finalSquare {
            diceRoll += 1
            if diceRoll == 7 {
                diceRoll = 1
            }
            
            switch square + diceRoll {
            case finalSquare:
                //中断while循环
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                //如果数目大于25，重新循环
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
            print("Game over!")
        }
    }
    
    //guard 保镖模式，只要不符合条件就会执行else里面的内容
    class func greet(_ person:[String:String]){
        guard let name = person["name"] else {
            return
        }
        
        print("Hello \(name)!")
        
        guard let location = person["location"] else {
            print("I hope the weather is nice near you.")
            return
        }
        
        print("I hope the weather is nice in \(location).")
        
    }
    
    class func guardSample() {
        greet(["name":"John"])
        greet(["name":"Jane","location":"Cupertino"])
    }
    
    //多版本兼容性支持
    class func availableSample(){
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: "test", message: "app", preferredStyle: .alert)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertView(title: "test", message: "app", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            
        }
    }
}
