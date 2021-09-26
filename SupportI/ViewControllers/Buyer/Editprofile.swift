//
//  Editprofile.swift
//  SupportI
//
//  Created by Adam on 9/26/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Editprofile: BaseController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var bio: UITextField!
    @IBOutlet weak var reminder: UILabel!
    @IBOutlet weak var gender: UIView!
    @IBOutlet weak var gendertype: UILabel!
    @IBOutlet weak var birthdate: UILabel!
    @IBOutlet weak var banner: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editbanner(_ sender: Any) {
    }
    @IBAction func save(_ sender: Any) {
    }
    
    @IBAction func editphoto(_ sender: Any) {
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
