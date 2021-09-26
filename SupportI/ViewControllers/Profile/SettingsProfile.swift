//
//  Settings.swift
//  SupportI
//
//  Created by Adam on 9/26/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class SettingsProfile: BaseController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailverify: UIButton!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var phoneverify: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordverify: UIButton!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var locationverify: UIButton!
    @IBOutlet weak var languagetxt: UILabel!
    @IBOutlet weak var language: UIView!
    @IBOutlet weak var notification: UIView!
    @IBOutlet weak var notificationtxt: UILabel!
    @IBOutlet weak var darkmode: UIView!
    @IBOutlet weak var darkmodetxt: UILabel!
    @IBOutlet weak var darkmodeswitch: UISwitch!
    @IBOutlet weak var notificatinswitch: UISwitch!
    
    @IBOutlet weak var reasontxt: UILabel!
    @IBOutlet weak var reason: UIView!
    @IBOutlet weak var accountswitch: UISwitch!
    @IBOutlet weak var accounttxt: UILabel!
    @IBOutlet weak var accountactive: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteaccount(_ sender: Any) {
    }
    @IBAction func save(_ sender: Any) {
    }
    @IBAction func accountactive(_ sender: Any) {
    }
    @IBAction func darkmode(_ sender: Any) {
    }
    @IBAction func notifiy(_ sender: Any) {
    }
    @IBAction func locationverify(_ sender: Any) {
    }
    @IBAction func phoneverify(_ sender: Any) {
    }
    @IBAction func emailverify(_ sender: Any) {
    }
    
    @IBAction func passwordverify(_ sender: Any) {
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
