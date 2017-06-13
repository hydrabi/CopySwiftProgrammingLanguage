//
//  NestedTypes.swift
//  IsASample
//
//  Created by Hydra on 16/6/12.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation
struct NestedTypeBlackjackCard {
    //嵌套定义枚举类型Suit
    enum Suit:Character{
        case spades = "♠",hearts = "♡",diamonds = "♢",clubs = "♣"
    }
    
    //嵌套定义枚举Rank
    enum Rank:Int{
        case two = 2,three,four,five,six,seven,eight,nine,ten
        case jack,queen,king,ace
        struct Values {
            let first:Int,second:Int?
        }
        
        var values:Values{
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack,.queen,.king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    //BlackjackCard 的属性和方法
    let rank:Rank,suit:Suit
    var description:String {
        var output = "suit is \(suit.rawValue)，"
        output += "value is \(rank.values.first)"
        if let second = rank.values.second{
            output += " or \(second)"
        }
        return output
    }
}

class NestedTypes: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func start () {
        //尽管Rank和Suit嵌套在BlackjackCard中，但仍可被引用，所以在初始化实例时能够通过枚举类型中的成员名称单独引用
        let theAceOfSpades = NestedTypeBlackjackCard(rank: .ace, suit: .spades)
        
        print("theAceOfSpades:\(theAceOfSpades.description)")
    }
}
