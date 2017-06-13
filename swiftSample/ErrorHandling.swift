//
//  ErrorHandling.swift
//  IsASample
//
//  Created by Hydra on 16/5/30.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

enum VendingMachineError:Error{
    case invalidSelection
    case insufficientFunds(coinsNeeded:Int)
    case outOfStock
}

struct Item {
    var price:Int
    var count:Int
}

class VendingMachine{
    var inventory = [
        "Candy Bar":Item(price: 12, count: 7),
        "Chips":Item(price: 10, count: 4),
        "Pretzels":Item(price: 7, count: 11)
    ]
    
    let favoriteSnacks = [
        "Alice":"Chips",
        "Bob":"Licorice",
        "Eve":"Pretzels",
    ]
    
    var coinsDeposited = 0
    
    func dispenseSnack(_ snack:String){
        print("Dispensing \(snack)")
    }
    
    //通过在函数或方法声明的参数后面加上throws关键字，表明这个函数或方法可以抛出错误。如果指定一个返回值，可以把throws关键字放在返回箭头(->)的前面。
    //要么直接使用do-catch，try处理，或者继续传播错误
    func vend(itemNamed name:String) throws{
        //guard语句判断其后的表达式布尔值为false时，才会执行之后代码块里的代码，如果为true，则跳过整个guard语句
        guard let item = inventory[name] else  {
            throw
            VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw
            VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else{
            throw
            VendingMachineError.insufficientFunds(coinsNeeded:item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        dispenseSnack(name)
    }
    
    //当调用一个抛出函数的时候，在调用前面加上try。这个关键字表明函数可以抛出错误。
    func buyFavoriteSnack(_ person:String,vendingMachine:VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try  vendingMachine.vend(itemNamed: snackName)
    }
    
    //必须要匹配所有错误的情况
    func start () {
        let vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        //如果在do的范围内出现错误
        do{
            try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
        }
        //在catch后面添加参数指出那种错误能够处理，如果catch没有参数，可以匹配所有的错误
        catch VendingMachineError.invalidSelection{
            print("Invalid Selection")
        }
        catch VendingMachineError.outOfStock {
            print("Out of stock.")
        }
        catch VendingMachineError.insufficientFunds( let coinsNeeded){
            print("Insufficient funds.Please insert an additional \(coinsNeeded )")
        }
        catch {
            
        }
    }
}

class ErrorHandling:ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.start()
    }
    
    func someThrowintFunction() throws -> Int {
        let a = 2
        let b = 3
        guard a > b else {
            throw
            VendingMachineError.outOfStock
        }
        return 1;
    }
    
    func deferSample (_ a :Int,b:Int) {
        if(a > b){
            
        }
        //函数结束后执行以下代码
        defer {
            print("defer finish")
        }
        
        print("deferSample scope end!")
    }
    
    func start () {
        //若函数抛出错误，则x为nil
        let x = try?someThrowintFunction()
        //上下两者写法等价
        let y:Int?
        do{
            y = try someThrowintFunction()
        }
        catch {
            y = nil
        }
        
        //有时候你知道抛出错误函数或者方法不会再运行时抛出错误，在那种场合，在禁止传播错误和包裹断言没有错误会被抛出之前，你不能使用try！
//        let photo = try! loadimage("path")
        
        deferSample(1, b: 2)
    }
    
    //
    
}
