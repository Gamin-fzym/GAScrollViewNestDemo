//
//  GAListCell.swift
//  GAScrollViewNestDemo
//
//  Created by MaciOS on 2022/5/5.
//

import Foundation
import UIKit

class GAListCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgHConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subtitleLab: UILabel!
    
    var model: GAListModel? {
        didSet {
            guard let vo = model else { return }
            if vo.isNull {
                bgView.isHidden = true
                return
            } else {
                bgView.isHidden = false
            }
            titleLab.text = vo.title
            subtitleLab.text = vo.subtitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    static func calculateCellHeight() -> CGFloat {
        return 108.0
    }
    
}
