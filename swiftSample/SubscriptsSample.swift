//
//  SubscriptsSample.swift
//  IsASample
//
//  Created by Hydra on 16/5/17.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

struct TimesTable {
    let multiplier : Int
    //使用subscirpt关键字，显式申明参数和返回类型，与实例方法不同的是附属脚本可以设定为读写或只读
    subscript (index:Int) -> Int{
        return multiplier * index
    }
}

//下标可以读写和只读，和计算属性一样的getter，setter方式
//与只读计算型属性一样，可以直接将原本应该写在get代码块中的代码写在subscript中
struct Matrix {
    //附属脚本允许任意数量的入参索引，并且每个入参类型也没有限制，不能使用inout，不能设置默认值
    let rows:Int,columns:Int
    var grid:[Double]
    init(rows:Int,columns:Int){
        self.rows    = rows
        self.columns = columns
        grid = Array(repeating: 0.0,count: rows * columns)
    }
    
    func indexIsValidForRow(_ row:Int,column:Int) -> Bool{
        return rows >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row:Int,column:Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column),"Index out of range")
            return grid[(row * columns) + column]
        }
        set{
            assert(indexIsValidForRow(row, column: column),"Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

struct stringRetriveTable {
    var list:[String]
    
    subscript(key:String) -> AnyObject {
        if !list.isEmpty {
            return list[0] as AnyObject
        }
        else {
            return "" as AnyObject
        }
        
    }
    
}

//附属脚本允许你通过在实例后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值
class SubscriptsSample:ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start () {
        let threeTimesTable = TimesTable(multiplier:3)
        print("\(threeTimesTable[6])")
        let fourTimesTable = TimesTable(multiplier: 2)
        print(fourTimesTable)
        
        var matrix = Matrix(rows: 2, columns: 2)
        matrix[0,1] = 1.5
        matrix[1,0] = 3.2
        
        var list = ["aa","bb"]
        var stringTable = stringRetriveTable(list: list)
        let temp = stringTable["any"]
        print(temp)
    }
    
}
