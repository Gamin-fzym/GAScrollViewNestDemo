//
//  GAListVC.swift
//  GAScrollViewNestDemo
//
//  Created by MaciOS on 2022/5/5.
//

import Foundation
import UIKit

class GAListVC: UIViewController {
    
    @IBOutlet weak var scrollView: NestScrollView!
    @IBOutlet weak var bgHConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!
    private var canScroll: Bool = true

    private lazy var headerView: UIView = {
        let view = Bundle.main.loadNibNamed("GAHeaderView", owner: nil, options: nil)![0] as! GAHeaderView
        return view
    }()
    
    private lazy var contentVC: GAContentVC = {
        let vc = GAContentVC()
        return vc
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(ScrollViewCanScroll(_:)), name: NSNotification.Name("ScrollViewCanScroll"), object: nil)
    }
    
    @objc private func ScrollViewCanScroll(_ notifi: Notification) {
        canScroll = true
    }
 
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        if #available(iOS 11.0, *){
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        let headerHeigth: CGFloat = GAHeaderView.calculateCellHeight()
        headerView.frame = CGRect(x: 0, y: 0, width: UIDevice.screenWidth(), height: headerHeigth)
        bgView.addSubview(headerView)
        
        let contentHeight: CGFloat = UIDevice.screenHeight() - UIDevice.statusBarHeight()
        contentVC.view.frame = CGRect(x: 0, y: headerHeigth, width: UIDevice.screenWidth(), height: contentHeight)
        bgView.addSubview(contentVC.view)
        contentVC.startReloadVC()
        
        let bgHeight: CGFloat = headerHeigth + contentHeight
        bgHConstraint.constant = bgHeight
        
        setupScrollReload()
    }
    
    @IBAction func tapReturnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func anewReloadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.scrollView.mj_header?.endRefreshing()
        }
    }
    
    private func setupScrollReload() {
        let mjheader = MJRefreshNormalHeader { [weak self] in
            self?.anewReloadData()
        }
        mjheader.stateLabel?.textColor = .gray
        mjheader.lastUpdatedTimeLabel?.isHidden = true
        scrollView.mj_header = mjheader
    }
    
}

extension GAListVC: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topOffset = floatViewY()
        if self.canScroll == false {
            // canScroll???false????????????contentOffset?????????????????????
            scrollView.contentOffset = CGPoint(x: 0, y: topOffset)
        } else if (scrollView.contentOffset.y >= topOffset) {
            scrollView.contentOffset = CGPoint(x: 0, y: topOffset)
            self.canScroll = false
            // ??????????????????????????????tableView??????tableCanScroll?????????
            NotificationCenter.default.post(name: NSNotification.Name("TableViewCanScroll"), object: nil, userInfo: nil)
        }
    }
    
    /// ????????????y??????
    private func floatViewY() -> CGFloat {
        var fy = GAHeaderView.calculateCellHeight() - UIDevice.statusBarHeight()
        if fy < 0 {
            fy = 0
        }
        return CGFloat(fy)
    }
    
}
