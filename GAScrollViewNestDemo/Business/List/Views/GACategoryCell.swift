//
//  GACategoryCell.swift
//  GAScrollViewNestDemo
//
//  Created by MaciOS on 2022/5/6.
//

import Foundation
import UIKit

class GACategoryCell: UITableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    
    var model: GACategoryModel? {
        didSet {
            guard let vo = model else { return }
            if vo.isNull {
                titleLab.isHidden = true
                return
            } else {
                titleLab.isHidden = false
            }
            if vo.isSelect {
                titleLab.backgroundColor = .lightGray
                titleLab.font = UIFont.boldSystemFont(ofSize: 13)
            } else {
                titleLab.backgroundColor = .white
                titleLab.font = UIFont.systemFont(ofSize: 13)
            }
            titleLab.text = vo.title
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
        return 60.0
    }
    
}
