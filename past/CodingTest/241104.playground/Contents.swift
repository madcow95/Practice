import UIKit

/*
 MARK: 배열 만들기 4
 https://school.programmers.co.kr/learn/courses/30/lessons/181918
func solution(_ arr:[Int]) -> [Int] {
    var answer: [Int] = []
    var idx = 0
    
    while idx < arr.count {
        if answer.isEmpty {
            answer.append(arr[idx])
            idx += 1
            continue
        } else {
            if let last = answer.last {
                if last < arr[idx] {
                    answer.append(arr[idx])
                    idx += 1
                    continue
                } else {
                    answer.removeLast()
                }
            }
        }
    }
    
    return answer
}

print(solution([1, 4, 2, 5, 3]))
*/

/*
 MARK: 배열 만들기 6
 https://school.programmers.co.kr/learn/courses/30/lessons/181859
func solution(_ arr:[Int]) -> [Int] {
    var answer: [Int] = []
    var i = 0
    
    while i < arr.count {
        if answer.isEmpty {
            answer.append(arr[i])
            i += 1
        } else {
            if let last = answer.last {
                if last == arr[i] {
                    answer.removeLast()
                    i += 1
                } else {
                    answer.append(arr[i])
                    i += 1
                }
            }
        }
    }
    
    return answer.isEmpty ? [-1] : answer
}

print(solution([0, 1, 1, 0]))
*/

/*
 MARK: 문자열 여러 번 뒤집기
 https://school.programmers.co.kr/learn/courses/30/lessons/181913
func solution(_ my_string:String, _ queries:[[Int]]) -> String {
    var strArr = Array(my_string)
    
    for query in queries {
        let target = Array(strArr[query[0]...query[1]].reversed())
        for (idx, num) in (query[0]...query[1]).enumerated() {
            strArr[num] = target[idx]
        }
    }
    
    return String(strArr)
}

print(solution("rermgorpsam", [[2, 3], [0, 7], [5, 9], [6, 10]]))
*/

/*
 MARK: 수열과 구간 쿼리 2
 https://school.programmers.co.kr/learn/courses/30/lessons/181923
func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    var answer: [Int] = []
    
    for (idx, query) in queries.enumerated() {
        let s = query[0]
        let e = query[1]
        let k = query[2]
        
        let min = arr[s...e].filter { $0 > k }.min() ?? -1
        answer.append(min)
    }
    
    return answer
}

print(solution([0, 1, 2, 4, 3], [[0, 4, 2],[0, 3, 2],[0, 2, 2]]))
*/


func solution(_ arr:[[Int]]) -> [[Int]] {
    return []
}

solution([[57, 192, 534, 2], [9, 345, 192, 999]])
