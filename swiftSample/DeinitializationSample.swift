//
//  DeinitializationSample.swift
//  IsASample
//
//  Created by Hydra on 16/5/19.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

//在一个类的实例被释放之前，析构函数被立即调用。用关键字deinit来标示析构函数，类似于初始化函数用init来标示。析构函数只适用于类类型。
//子类继承了父类的析构函数，并且在子类析构函数实现的最后，父类的析构函数被自动调用。即使子类没有提供自己的析构函数，父类的析构函数也总是被调用。
struct DeinitializationBank{
    static var coinsInBank = 10_000
    static func vendCoins(_ numberOfCoinsToVend:Int) -> Int {
        var numberOfCoinsToVend = numberOfCoinsToVend
        numberOfCoinsToVend = min(numberOfCoinsToVend,coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receiveCoins(_ coins:Int){
        coinsInBank += coins
    }
}

class DeinitializationPlayer{
    var coinsInPurse:Int
    init(coins:Int){
        coinsInPurse = DeinitializationBank.vendCoins(coins)
    }
    
    func winCoins(_ coins:Int){
        coinsInPurse += DeinitializationBank.vendCoins(coins)
    }
    
    deinit {
        DeinitializationBank.receiveCoins(coinsInPurse)
    }
}

class subclassPlayer:DeinitializationPlayer{
    deinit {
        
    }
}

class DeinitializationSample:ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
