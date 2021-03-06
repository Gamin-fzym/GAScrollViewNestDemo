//
//  GAContentVC.swift
//  GAScrollViewNestDemo
//
//  Created by MaciOS on 2022/5/5.
//

import Foundation
import UIKit

class GAContentVC: UIViewController {
    
    @IBOutlet weak var cateTableView: UITableView!
    @IBOutlet weak var listTableView: UITableView!
    private var dataArray: [GACategoryModel] = []
    private var tableCanScroll: Bool = false
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableCanScroll = false
        NotificationCenter.default.addObserver(self, selector: #selector(tableViewCanScroll(_:)), name: NSNotification.Name("TableViewCanScroll"), object: nil)
    }
    
    @objc private func tableViewCanScroll(_ notifi: Notification) {
        tableCanScroll = true
    }
    
    private func setupUI() {
        if #available(iOS 11.0, *){
            cateTableView.contentInsetAdjustmentBehavior = .never
            listTableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        cateTableView.separatorStyle = .none
        cateTableView.estimatedRowHeight = GACategoryCell.calculateCellHeight()
        cateTableView.rowHeight = UITableView.automaticDimension
        cateTableView.register(UINib(nibName: "GACategoryCell", bundle: nil), forCellReuseIdentifier: "GACategoryCell")
        if #available(iOS 15.0, *) { cateTableView.sectionHeaderTopPadding = 0 }
        
        listTableView.separatorStyle = .none
        listTableView.estimatedRowHeight = GAListCell.calculateCellHeight()
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.register(UINib(nibName: "GAListCell", bundle: nil), forCellReuseIdentifier: "GAListCell")
        if #available(iOS 15.0, *) { listTableView.sectionHeaderTopPadding = 0 }
    }
       
    func startReloadVC() {
        moniData()
    }
    
}

extension GAContentVC {
    
    private func moniData() {
        dataArray.removeAll()
        var data: [GACategoryModel] = []
        for i in 0...1 {
            var cModel = GACategoryModel()
            cModel.title = "??????\(i)"
            for j in 0...3 {
                var lModel = GAListModel()
                lModel.title = "??????\(i)?????????\(j)"
                lModel.subtitle = "??????\(i)?????????\(j)"
                cModel.list.append(lModel)
            }
            data.append(cModel)
        }
        if data.count > 0 {
            data[0].isSelect = true
        }
        dataArray = data
        handleDataAction()
    }
    
    /// ??????????????????????????????????????????
    private func handleDataAction() {
        let count = dataArray.count
        
        let contentH = UIDevice.screenHeight() - UIDevice.statusBarHeight()
        let cateCellH = GACategoryCell.calculateCellHeight()
        let curCateTVH = cateCellH*CGFloat(count)
        if curCateTVH < contentH {
            let dev = contentH - curCateTVH
            let num = ceil(Double(dev / cateCellH))
            let numInt = Int(num)
            for i in 0..<numInt {
                var model = GACategoryModel()
                model.isNull = true
                if dataArray.count == 0 && i == 0 {
                    model.isSelect = true
                }
                dataArray.append(model)
            }
        }
        
        let listCellH = GAListCell.calculateCellHeight()
        for (index, item) in dataArray.enumerated() {
            if item.isSelect || item.isNull == false {
                var tempList = item.list
                let listCount = tempList.count
                let curListTVH = listCellH*CGFloat(listCount)
                if curListTVH < contentH {
                    let dev = contentH - curListTVH
                    let num = ceil(Double(dev / listCellH))
                    let numInt = Int(num)
                    for _ in 0...numInt {
                        var model = GAListModel()
                        model.isNull = true
                        tempList.append(model)
                    }
                    dataArray[index].list = tempList
                }
            }
        }

        cateTableView.reloadData()
        listTableView.reloadData()
    }
    
    private func gainSelectModel() -> GACategoryModel? {
        for item in dataArray {
            if item.isSelect {
               return item
            }
        }
        return nil
    }
    
}

extension GAContentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == cateTableView {
            return dataArray.count
        } else {
            if let selModel = gainSelectModel() {
                return selModel.list.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == cateTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GACategoryCell", for: indexPath) as! GACategoryCell
            cell.model = dataArray[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GAListCell", for: indexPath) as! GAListCell
            if let selModel = gainSelectModel() {
                cell.model = selModel.list[indexPath.row]
            } else {
                cell.model = nil
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == cateTableView {
            guard let cell = tableView.cellForRow(at: indexPath) as? GACategoryCell, let model = cell.model, !model.isNull else {
                return
            }
            for (index, _) in dataArray.enumerated() {
                if index == indexPath.row {
                    dataArray[index].isSelect = true
                } else {
                    dataArray[index].isSelect = false
                }
            }
            cateTableView.reloadData()
            listTableView.contentOffset = CGPoint(x: 0, y: 0)
            listTableView.reloadData()
        } else {
            guard let cell = tableView.cellForRow(at: indexPath) as? GAListCell, let model = cell.model, !model.isNull else {
                return
            }
            // ????????????
        }
    }
    
}

extension GAContentVC: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableCanScroll == false {
            scrollView.contentOffset = CGPoint.zero
        } else if (scrollView.contentOffset.y <= 0) {
            tableCanScroll = false
            // ??????ScrollView??????CanScroll?????????
            NotificationCenter.default.post(name: NSNotification.Name("ScrollViewCanScroll"), object: nil, userInfo: nil)
        }
    }
    
    /// ???????????????????????????1???y?????????0????????????????????????2?????????????????????????????????1???????????????1??????????????????
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView == cateTableView {
            let listOffset = listTableView.contentOffset
            if listOffset.y == 0 {
                let scrEnabled = listTableView.isScrollEnabled
                listTableView.isScrollEnabled = false
                listTableView.contentOffset = CGPoint(x: listOffset.x, y: 1)
                listTableView.isScrollEnabled = scrEnabled
            }
        } else {
            let cateOffset = cateTableView.contentOffset
            if cateOffset.y == 0 {
                let scrEnabled = cateTableView.isScrollEnabled
                cateTableView.isScrollEnabled = false
                cateTableView.contentOffset = CGPoint(x: cateOffset.x, y: 1)
                cateTableView.isScrollEnabled = scrEnabled
            }
        }
    }
    
}

