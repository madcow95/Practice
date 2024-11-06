import Foundation

/*
 MARK: 순서 바꾸기
 https://school.programmers.co.kr/learn/courses/30/lessons/181891
func solution(_ num_list:[Int], _ n:Int) -> [Int] {
    let first = num_list[n...]
    let second = num_list[..<n]
    
    return Array(first + second)
}

print(solution([1, 2], 1))
*/

/*
 MARK: 날짜 비교하기
 https://school.programmers.co.kr/learn/courses/30/lessons/181838
func solution(_ date1:[Int], _ date2:[Int]) -> Int {
    let firstYear = date1[0]
    let secondYear = date2[0]
    
    if firstYear > secondYear {
        return 0
    } else if firstYear < secondYear {
        return 1
    }
    
    let firstMonth = date1[1]
    let secondMonth = date2[1]
    
    if firstMonth > secondMonth {
        return 0
    } else if firstMonth < secondMonth {
        return 1
    }
    
    let firstDay = date1[2]
    let secondDay = date2[2]
    
    if firstDay > secondDay {
        return 0
    } else if firstDay < secondDay {
        return 1
    }
    
    return 0
}

print(solution([1024, 10, 24], [1024, 10, 24]))
*/

/*
 MARK: 배열의 길이를 2의 거듭제곱으로 만들기
 https://school.programmers.co.kr/learn/courses/30/lessons/181857
func isTwoMultiple(_ n: Int) -> Bool {
    return n > 0 && (n & (n - 1)) == 0
}

func solution(_ arr:[Int]) -> [Int] {
    var copiedArr = arr
    if !isTwoMultiple(copiedArr.count) {
        while !isTwoMultiple(copiedArr.count) {
            copiedArr.append(0)
        }
    }
    return copiedArr
}

print(solution([58, 172, 746, 89]))
*/

/*
 MARK: 수열과 구간 쿼리 3
 https://school.programmers.co.kr/learn/courses/30/lessons/181924
func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    var copiedArr = arr
    
    for query in queries {
        let first = copiedArr[query[0]]
        let second = copiedArr[query[1]]
        
        copiedArr[query[0]] = second
        copiedArr[query[1]] = first
    }
    
    return copiedArr
}

print(solution([0, 1, 2, 3, 4], [[0, 3],[1, 2],[1, 4]]))
*/

/*
 MARK: 왼쪽 오른쪽
 https://school.programmers.co.kr/learn/courses/30/lessons/181890
func solution(_ str_list:[String]) -> [String] {
    if let lIdx = str_list.firstIndex(of: "l") {
        if let rIdx = str_list.firstIndex(of: "r") {
            return lIdx < rIdx ? Array(str_list[..<lIdx]) : Array(str_list[(rIdx + 1)...])
        }
        
        return Array(str_list[..<lIdx])
    } else if let rIdx = str_list.firstIndex(of: "r") {
        
        return Array(str_list[(rIdx + 1)...])
    }
    return []
}

print(solution(["u", "u", "r", "l"]))
*/


/*
 MARK: 공 던지기
 https://school.programmers.co.kr/learn/courses/30/lessons/120843?language=swift
func solution(_ numbers:[Int], _ k:Int) -> Int {
    let index = ((k-1) * 2) % numbers.count
    
    return numbers[index]
}

print(solution([1, 2, 3], 3))
*/


