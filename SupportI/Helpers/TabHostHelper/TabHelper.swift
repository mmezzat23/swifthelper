//
//  TabHelper.swift
//  homeCheif
//
//  Created by Algazzar on 3/29/18.
//  Copyright © 2018 Atiaf. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class TabHelper: BaseController,IndicatorInfoProvider {
    
    var tabTitle:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: tabTitle)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
