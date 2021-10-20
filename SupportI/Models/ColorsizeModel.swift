//
//  ColorsizeModel.swift
//  Wndo
//
//  Created by Adam on 20/10/2021.
//  Copyright © 2021 MohamedAbdu. All rights reserved.
//

import Foundation

class ColorsizeModel {
    var colorid: Int = 0
    var sizeid: Int = 0
    var quantity: String = ""
    var colortxt: String = ""
    var sizetxt: String = ""
    var iscolor: Bool = false
    var issize: Bool = false
    var colors: [SectionItem] = []
    var sizes: [SectionItem] = []
}
