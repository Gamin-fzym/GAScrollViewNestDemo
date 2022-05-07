//
//  GAHomeVC.swift
//  GAScrollViewNestDemo
//
//  Created by MaciOS on 2022/5/5.
//

import Foundation
import UIKit

class GAHomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tapEnterOneList(_ sender: Any) {
        self.navigationController?.pushViewController(GAListVC(), animated: true)
    }
    
}
