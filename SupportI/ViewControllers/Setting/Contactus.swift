//
//  Contactus.swift
//  SupportI
//
//  Created by Adam on 9/22/21.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import UIKit

class Contactus: BaseController {

    @IBOutlet weak var orderconstant: NSLayoutConstraint!
    @IBOutlet weak var phoneconstant: NSLayoutConstraint!
    @IBOutlet weak var emailcostant: NSLayoutConstraint!
    @IBOutlet weak var phonetxthight: NSLayoutConstraint!
    @IBOutlet weak var emailtxthight: NSLayoutConstraint!
    @IBOutlet weak var ordertxthight: NSLayoutConstraint!
    @IBOutlet weak var reasontxthight: NSLayoutConstraint!
    @IBOutlet weak var messagetxt: UILabel!
    @IBOutlet weak var contact: UIView!
    @IBOutlet weak var phonetxt: UILabel!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var phonehight: NSLayoutConstraint!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var emailtxt: UILabel!
    @IBOutlet weak var emailhight: NSLayoutConstraint!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var ordertxt: UILabel!
    @IBOutlet weak var reasontxt: UILabel!
    @IBOutlet weak var orderhight: NSLayoutConstraint!
    @IBOutlet weak var order: UIView!
    @IBOutlet weak var reasonhight: NSLayoutConstraint!
    @IBOutlet weak var reason: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNav = true
        if (UserRoot.token() != nil) {
            phone.isHidden = true
            email.isHidden = true
            phonetxt.isHidden = true
            emailtxt.isHidden = true
            phonehight.constant = 0
            emailhight.constant = 0
            phonetxthight.constant = 0
            emailtxthight.constant = 0
            emailcostant.constant = 0
            phoneconstant.constant = 0
        }else{
            order.isHidden = true
            reason.isHidden = true
            ordertxt.isHidden = true
            reasontxt.isHidden = true
            orderhight.constant = 0
            reasonhight.constant = 0
            ordertxthight.constant = 0
            reasontxthight.constant = 0
            emailcostant.constant = 0
            orderconstant.constant = 0
        }
        message.setLeftPaddingPoints(10)
        message.setRightPaddingPoints(10)
        ordertxt.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        emailtxt.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        phonetxt.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        reasontxt.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        messagetxt.padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

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
