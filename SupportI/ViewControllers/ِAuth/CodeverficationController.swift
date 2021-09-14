//
//  CodeverficationController.swift
//  SupportI
//
//  Created by Adam on 9/13/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class CodeverficationController: BaseController {
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var code1: UITextField!
    @IBOutlet weak var code2: UITextField!
    @IBOutlet weak var code3: UITextField!
    @IBOutlet weak var code4: UITextField!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var resend: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

        // Do any additional setup after loading the view.
    }
    @IBAction func confirm(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
