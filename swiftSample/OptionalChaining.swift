//
//  OptionalChaining.swift
//  IsASample
//
//  Created by Hydra on 16/5/20.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

//为了反映可选链可以调用空（nil），不论你调用的属性、方法、子脚本等返回的值是不是可选值，它的返回结果都是一个可选值。你可以利用这个返回值来检测你的可选链是否调用成功，有返回值即成功，返回nil则失败。
//调用可选链的返回结果与原本的返回结果具有相同的类型，但是原本的返回结果被包装成了一个可选值，当可选链调用成功时，一个应该返回Int的属性将会返回Int?。

import Foundation

class OptPersong{
    var residence:OptResidence?
}

class OptResidence{
    var rooms = [OptRoom]()
    var numberOfRooms : Int {
        return rooms.count
    }
    
    subscript(i:Int) -> OptRoom? {
        get{
            if(i >= rooms.count){
                return nil
            }
            
            return rooms[i]
        }
        set{
           rooms[i] = newValue!
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address:OptAddress?
}

class OptRoom {
    let name:String
    init(name:String){
        self.name = name
    }
}

class OptAddress {
    var buildingName:String?
    var buildingNumber:String?
    var street:String?
    func buildingIdentifier () -> String? {
        if(buildingName != nil){
            return buildingName
        }
        else if(buildingNumber != nil){
            return buildingNumber
        }
        else{
            return nil
        }
    }
}



//你可以利用可选链的可选值获取属性，并且检查属性是否获取成功。然而，你不能使用可选链为属性赋值。
class OptionalChaining:ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start () {
        let john = OptPersong()
        john.residence = OptResidence()
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) rooms.")
        }
        else{
            print("Unable to retrieve the number of rooms")
        }
        
        //通过可选链调用方法
        //你可以使用可选链的来调用可选值的方法并检查方法调用是否成功。即使这个方法没有返回值，你依然可以使用可选链来达成这一目的。
        //但是，没有返回值类型的函数和方法有一个隐式的返回值类型Void（参见Function Without Return Values）。
        
        // 如果你利用可选链调用此方法，这个方法的返回值类型将是Void?，而不是Void，因为当通过可选链调用方法时返回值总是可选类型（optional type）。，即使是这个方法本是没有定义返回值，你也可以使用if语句来检查是否能成功调用printNumberOfRooms方法：如果方法通过可选链调用成功，printNumberOfRooms的隐式返回值将会是Void，如果没有成功，将返回nil：
        if(john.residence?.printNumberOfRooms() != nil){
            print("It was possible to print the number of rooms.")
        }
        else{
            print("It was not possible to print the number of rooms")
        }
        
        
        let johnsHouse = OptResidence()
        johnsHouse.rooms.append(OptRoom(name: "Living Room"))
        johnsHouse.rooms.append(OptRoom(name: "Kitchen"))
        john.residence = johnsHouse
        
        //使用可选链调用子脚本
        //你可以使用可选链来尝试从子脚本获取值并检查子脚本的调用是否成功，然而，你不能通过可选链来设置子代码。
        //注意： 当你使用可选链来获取子脚本的时候，你应该将问号放在子脚本括号的前面而不是后面。可选链的问号一般直接跟在自判断表达语句的后面。
        //在子代码调用中可选链的问号直接跟在john.residence的后面，在子脚本括号的前面，因为john.residence是可选链试图获得的可选值
        let firstRoomName = john.residence?[0]?.name
        if(firstRoomName != nil){
            print("The first room name is \(firstRoomName).")
        }
        else{
            print("Unable to retrieve the first room name")
        }
        
        //连接多层链接
        //你可以将多层可选链连接在一起，可以掘取模型内更下层的属性方法和子脚本。然而多层可选链不能再添加比已经返回的可选值更多的层。 也就是说：
        //如果你试图获得的类型不是可选类型，由于使用了可选链它将变成可选类型。 如果你试图获得的类型已经是可选类型，由于可选链它也不会提高自判断性。
        //因此：
        //如果你试图通过可选链获得Int值，不论使用了多少层链接返回的总是Int?。 相似的，如果你试图通过可选链获得Int?值，不论使用了多少层链接返回的总是Int?。
        //下面的例子试图获取john的residence属性里的address的street属性。这里使用了两层可选链来联系residence和address属性，他们两者都是可选类型
        
        let johnsAddress = OptAddress()
        johnsAddress.buildingName = "The Larches"
        johnsAddress.street = "Laurel Street"
        john.residence!.address = johnsAddress
        
        let johnsStreet = john.residence?.address?.street
        if(johnsStreet != nil){
            print("John's street name is \(johnsStreet).")
        }
        else{
            print("Unable to retrieve the address")
        }
        
        //链接自判断返回值的方法
        let buildingIdentifier = john.residence?.address?.buildingIdentifier()
        if(buildingIdentifier != nil){
            print("Identifier is \(buildingIdentifier)")
        }
        
        if let upper = john.residence?.address?.buildingIdentifier()?.uppercased() {
            print("John's uppercase building identifier is \(upper)")
        }
        
        
        
    }
}
