//
//  Vedioattachorrecord.swift
//  Wndo
//
//  Created by Adam on 14/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit
protocol VedioattachorrecordDelegate: class {
    func settypeoptin(type:String)
}
class Vedioattachorrecord: BaseController {
    var parameters : [String : Any] = [:]
    var isproduct = false
    var delegate : VedioattachorrecordDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

    }
    

    @IBAction func back(_ sender: Any) {
        if (isproduct == true){
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController()
        }
    }
    @IBAction func uploadvedio(_ sender: Any) {
        if (isproduct == true){
            delegate?.settypeoptin(type: "upload")
            self.dismiss(animated: true, completion: nil)
        }else{
        let vcc = self.controller(Vediocache.self,storyboard: .vedios)
        vcc.parameters = self.parameters
        self.pushPop(vcr: vcc)
        }
    }
    @IBAction func startrecord(_ sender: Any) {
        if (isproduct == true){
            delegate?.settypeoptin(type: "record")
            self.dismiss(animated: true, completion: nil)

        }else{
        let vcc = self.controller(Recordeing.self,storyboard: .vedios)
        vcc.parameters = self.parameters
        self.push(vcc)
        }
    }
    
}
