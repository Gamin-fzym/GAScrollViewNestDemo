//
//  GAHeaderView.swift
//  GAScrollViewNestDemo
//
//  Created by MaciOS on 2022/5/6.
//

import Foundation
import UIKit

class GAHeaderView: UIView {
    
    @IBOutlet weak var scrollWConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollWConstraint.constant = UIDevice.screenWidth()*2
    }
    
    static func calculateCellHeight() -> CGFloat {
        return 200.0
    }
    
}
