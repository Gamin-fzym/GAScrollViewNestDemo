//
//  GACategoryModel.swift
//  GAScrollViewNestDemo
//
//  Created by MaciOS on 2022/5/6.
//

import Foundation

struct GACategoryModel {
    var id: String = ""
    var title: String = ""
    var list: [GAListModel] = []

    var isSelect: Bool = false
    var isNull: Bool = false
    var isSelectFront: Bool = false
    var isSelectNext: Bool = false
}

struct GAListModel {
    var id: String = ""
    var title: String = ""
    var subtitle: String = ""
    var isNull: Bool = false
}
