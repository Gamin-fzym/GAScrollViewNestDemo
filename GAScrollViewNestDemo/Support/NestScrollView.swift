//
//  BaseScrollView.swift
//  GAScrollViewNestDemo
//
//  Created by MaciOS on 2022/5/5.
//

import Foundation
import UIKit

class NestScrollView: UIScrollView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func reload() {

    }

}

extension NestScrollView: UIGestureRecognizerDelegate {
    
    /// 这是实现手势穿透的关键代码
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

