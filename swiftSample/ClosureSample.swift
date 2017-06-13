//
//  ClosureSample.swift
//  IsASample
//
//  Created by Hydra on 16/3/29.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation
class ClosureSample : ViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let names = ["Chris","Alex","Ewa","Barry","Daniella"]
        var reversed = names.sorted(by: backwards)
        reversed = names.sorted(by: {(s1:String,s2:String) -> Bool in return s1 > s2})
        //尾随闭包
        reversed = names.sorted(){
            (s1:String,s2:String) -> Bool in
            return s1 > s2
        }
        //尾随闭包可以省略括号
        reversed = names.sorted{
            (s1:String,s2:String) -> Bool in
            return s1 > s2
        }
    }
    
    func start () {
        
    }
    
    func backwards(_ s1:String,s2:String) -> Bool {
        return s1 > s2
    }
    
    //捕获值
    func makeIncrementer(forIncrement amount:Int) -> () -> Int{
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        
        return incrementer
    }
}
