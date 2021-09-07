//
//  RadioView.swift
//  Tafran2
//
//  Created by mohamed abdo on 5/24/18.
//  Copyright © 2018 AtiafApps. All rights reserved.
//

import UIKit

@IBDesignable class RadioView: UIView {

    @IBOutlet var container: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }

    func initNib() {
        let bundle = Bundle(for: RadioView.self)
        bundle.loadNibNamed("RadioView", owner: self, options: nil)
        addSubview(container)
        container.frame = bounds
        container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
