//
//  TempDatas.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/25.
//

import Foundation

class TempDatas {
    var workOuts: [WorkOut] = [
        WorkOut(key: 1, name: "하체"),
        WorkOut(key: 2, name: "가슴"),
        WorkOut(key: 3, name: "등"),
        WorkOut(key: 4, name: "이두"),
        WorkOut(key: 5, name: "삼두"),
        WorkOut(key: 6, name: "어깨")
    ]
    
    var workOutDetails: [WorkOutDetail] = [
        WorkOutDetail(key: 1, subKey: 1, name: "스쿼트"),
        WorkOutDetail(key: 1, subKey: 2, name: "레그 프레스"),
        WorkOutDetail(key: 1, subKey: 3, name: "레그 컬"),
        WorkOutDetail(key: 1, subKey: 4, name: "힙 쓰러스트"),
        
        WorkOutDetail(key: 2, subKey: 1, name: "벤치 프레스"),
        WorkOutDetail(key: 2, subKey: 2, name: "체스트 플라이"),
        WorkOutDetail(key: 2, subKey: 3, name: "인클라인 벤치프레스"),
        WorkOutDetail(key: 2, subKey: 4, name: "덤벨 프레스"),
        
        WorkOutDetail(key: 3, subKey: 1, name: "랫 풀 다운"),
        WorkOutDetail(key: 3, subKey: 2, name: "시티드 로우"),
        WorkOutDetail(key: 3, subKey: 3, name: "원 암 덤벨 로우"),
        WorkOutDetail(key: 3, subKey: 4, name: "바벨 로우"),
        
        WorkOutDetail(key: 4, subKey: 1, name: "덤벨 컬"),
        WorkOutDetail(key: 4, subKey: 2, name: "바벨 컬"),
        WorkOutDetail(key: 4, subKey: 3, name: "이두 운동 1"),
        WorkOutDetail(key: 4, subKey: 4, name: "이두 운동 2"),
        
        WorkOutDetail(key: 5, subKey: 1, name: "삼두 운동 1"),
        WorkOutDetail(key: 5, subKey: 2, name: "삼두 운동 2"),
        WorkOutDetail(key: 5, subKey: 3, name: "삼두 운동 3"),
        WorkOutDetail(key: 5, subKey: 4, name: "삼두 운동 4"),
        
        WorkOutDetail(key: 6, subKey: 1, name: "밀리터리 프레스"),
        WorkOutDetail(key: 6, subKey: 2, name: "숄더 프레스"),
        WorkOutDetail(key: 6, subKey: 3, name: "어깨 운동 1"),
        WorkOutDetail(key: 6, subKey: 4, name: "어깨 운동 2")
    ]
}
