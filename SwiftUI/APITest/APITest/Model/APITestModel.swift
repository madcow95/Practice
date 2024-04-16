//
//  APITestModel.swift
//  APITest
//
//  Created by MadCow on 2024/4/16.
//

import Foundation

class APITestModel {
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
    let resultCode: Int
    let resultMsg: String
    
    init(numOfRows: Int, pageNo: Int, totalCount: Int, resultCode: Int, resultMsg: String) {
        self.numOfRows = numOfRows
        self.pageNo = pageNo
        self.totalCount = totalCount
        self.resultCode = resultCode
        self.resultMsg = resultMsg
    }
}
