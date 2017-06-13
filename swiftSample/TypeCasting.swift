//
//  TypeCasting.swift
//  IsASample
//
//  Created by Hydra on 16/6/7.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

class MediaItem{
    var name:String
    init(name:String){
        self.name = name
    }
}

class Movie:MediaItem{
    var director:String
    init(name:String,director:String){
        self.director = director
        super.init(name: name)
    }
}

class Song:MediaItem{
    var artist:String
    init(name:String,artist:String){
        self.artist = artist
        super.init(name: name)
    }
}

class TypeCasting: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func start() {
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elivis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        
        var movieCount = 0
        var songCount = 0
        
        // 用类型检查操作符(is)来检查一个实例是否属于特定子类型。类型检查操作符返回 true 若实例属于那个子类型，若不属于返回 false
        for item in library {
            if(item is Movie){
                movieCount += 1
            }
            else if (item is Song){
                songCount += 1
            }
        }
        
        //你可以尝试向下转到它的子类型，用类型检查操作符(as)
        //因为向下转型可能会失败，类型检查操作符带有两种不同形式。可选形式（ optional form） as? 返回一个你试图下转成的类型的可选值（optional value）。强制形式 as 把试图向下转型和强制解包（force-unwraps）结果作为一个混合动作。
        //当你不确定下转可以成功时，用类型检查的可选形式(as?)。可选形式的类型检查总是返回一个可选值（optional value），并且若下转是不可能的，可选值将是 nil 。这使你能够检查下转是否成功。
        
        for item in library {
            if let movie = item as? Movie {
                print("Movie:'\(movie.name)',dir.\(movie.director)")
            }
            else if let song = item as? Song {
                print("Song:'\(song.name)',by \(song.artist)")
            }
        }
        
        //AnyObject可以代表任何class类型的实例。
        //Any可以表示任何类型，除了方法类型（function types）
        let someObjects:[AnyObject] = [
            Movie(name: "2001:A Space Odyssey", director: "Stanley Kubrick"),
            Movie(name: "Moon", director: "Duncan Jones"),
            Movie(name: "Alien", director: "Ridley Scott")
        ]
        
        //因为知道这个数组只包含 Movie 实例，你可以直接用(as)下转并解包到不可选的Movie类型（ps：其实就是我们常用的正常类型，这里是为了和可选类型相对比）
        for object in someObjects {
            let movie = object as! Movie
            print("Movie:'\(movie.name)',dir.\(movie.director)")
        }
        
        //下转someObjects数组为Movie[]类型来代替下转每一项方式
        for movie in someObjects as! [Movie]{
            print("Movie:'\(movie.name)',dir.\(movie.director)")
        }
        
        //使用 Any 类型来和混合的不同类型一起工作，包括非class类型。它创建了一个可以存储Any类型的数组 things
        var things = [Any]()
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
//        things.append((3.0,5.0))
        things.append("hello")
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({
            (name:String) -> String in "Hello,\(name)"
        })
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDoule as Double where someDoule > 0:
                print("a positive double value of \(someDoule)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x,y) as (Double,Double):
                print("an (x,y) point at \(x),\(y)")
            case let movie as Movie:
                print("a movie called '\(movie.name)',dir.\(movie.director)")
            case let stirngConverter as (String) -> String:
                print(stirngConverter("Michael"))
            default:
                print("something else")
            }
        }
    }
}
