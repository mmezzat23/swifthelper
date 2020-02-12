//
//  ViewController.swift
//  SupportI
//
//  Created by mohamed abdo on 5/31/18.
//  Copyright © 2018 MohamedAbdu. All rights reserved.
//

import UIKit

class ViewController: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
        write()
    }
    func write() {
        let path = Bundle.main.path(forResource: "en.lproj/Main", ofType: "strings") // file path for file "data.txt"
        let string = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        path?.write("\(string) test")
        
        Bundle.main.
        print(string) // prints the content of data.txt
//        let path = NSBundle.mainBundle().pathForResource("FileName", ofType: "txt")
//        var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
//        println(text)
        
    }
    
}

