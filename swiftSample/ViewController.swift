//
//  ViewController.swift
//  swiftSample
//
//  Created by 毕志锋 on 15/2/25.
//  Copyright (c) 2015年 毕志锋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sample()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    func sample(){

        
        colectionType.sample()
//        ControlFlow.start()
        
//        let demo = FunctionDemo()
//        demo.sample()
        
//        let demo = ClosureSample()
//        demo.start()
        
//        let demo = EnumSample()
//        demo.start()
//        demo.toRawValue()
        
//        let demo = ClassAndStruct()
//        demo.arrayCopyAction()
//        let test = InitializationSample()
//        test.start()
        
//        let test = ARCSample()
//        test.start()
//        let demo = ErrorHandling()
//        demo.start()
//        let demo = NestedTypes()
//        demo.start()
//        let demo = Protocols()
//        demo.start ()
//        let demo = StringAndCharacter()
//        demo.next()
        
        let demo = ClosureSample2()
        demo.autoClosuresSample()
    }
    
    
    
}


