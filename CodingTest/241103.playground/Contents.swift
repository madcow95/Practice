import Foundation

/*
 MARK: 문자열 뒤집기
 https://school.programmers.co.kr/learn/courses/30/lessons/181905
func solution(_ my_string:String, _ s:Int, _ e:Int) -> String {
    var copiedStr = Array(my_string)
    
    let reversedStr = Array(Array(copiedStr)[s...e].reversed())
    for (idx, i) in (s...e).enumerated() {
        copiedStr[i] = reversedStr[idx]
    }
    
    return String(copiedStr)
}

print(solution("Stanley1yelnatS", 4, 10))
*/

/*
 MARK: 세 개의 구분자
 https://school.programmers.co.kr/learn/courses/30/lessons/181862
func solution(_ myStr:String) -> [String] {
    var answer: [String] = []
    var tempStr: String = ""
    
    for str in myStr {
        if ["a", "b", "c"].contains(str) {
            if tempStr.count > 0 {
                answer.append(tempStr)
                tempStr = ""
            }
            continue
        }
        tempStr += String(str)
    }
    if !tempStr.isEmpty {
        answer.append(tempStr)
    }
    return answer.count > 0 ? answer : ["EMPTY"]
}

print(solution("baconlettucetomato"))
*/

/*
 MARK: 간단한 논리 연산
 https://school.programmers.co.kr/learn/courses/30/lessons/181917
func solution(_ x1:Bool, _ x2:Bool, _ x3:Bool, _ x4:Bool) -> Bool {
    let first = under(x1, x2)
    let second = under(x3, x4)
    
    return upper(first, second)
}

func under(_ x1: Bool, _ x2: Bool) -> Bool {
    if x1 && x2 {
        return true
    } else if x1 && !x2 {
        return true
    } else if !x1 && x2 {
        return true
    } else {
        return false
    }
}

func upper(_ x1: Bool, _ x2: Bool) -> Bool {
    if x1 && x2 {
        return true
    } else if x1 && !x2 {
        return false
    } else if !x1 && x2 {
        return false
    } else {
        return false
    }
}

print(solution(false, true, true, true))
*/

/*
 MARK: 조건에 맞게 수열 변환하기 2
 https://school.programmers.co.kr/learn/courses/30/lessons/181881
func solution(_ arr:[Int]) -> Int {
    var copiedArr = arr
    var count: Int = 0
    
    while true {
        let prevArr = copiedArr
        for (idx, num) in copiedArr.enumerated() {
            if num >= 50 && num % 2 == 0 {
                copiedArr[idx] = num / 2
            } else if num < 50 && num % 2 == 1 {
                copiedArr[idx] = num * 2 + 1
            }
        }
        if prevArr == copiedArr {
            break
        }
        count += 1
    }
    
    return count
}

print(solution([1, 2, 3, 100, 99, 98]))
*/

/*
 MARK: 리스트 자르기
 https://school.programmers.co.kr/learn/courses/30/lessons/181897
func solution(_ n:Int, _ slicer:[Int], _ num_list:[Int]) -> [Int] {
    switch n {
    case 1:
        return Array(num_list[0...slicer[1]])
    case 2:
        return Array(num_list[slicer[0]...num_list.count - 1])
    case 3:
        return Array(num_list[slicer[0]...slicer[1]])
    case 4:
        var result: [Int] = []
        Array(num_list[slicer[0]...slicer[1]]).enumerated().forEach { (idx, num) in
            if idx % slicer[2] == 0 {
                result.append(num)
            }
        }
        return result
    default:
        return []
    }
}

print(solution(4, [1, 5, 2], [1, 2, 3, 4, 5, 6, 7, 8, 9]))
*/

/*
 MARK: qr code
 https://school.programmers.co.kr/learn/courses/30/lessons/181903
func solution(_ q:Int, _ r:Int, _ code:String) -> String {
    var answer: String = ""
    for (idx, str) in code.enumerated() {
        if idx % q == r {
            answer += String(str)
        }
    }
    return answer
}

print(solution(3, 1, "qjnwezgrpirldywt"))
*/

/*
 MARK: 수열과 구간 쿼리 4
 https://school.programmers.co.kr/learn/courses/30/lessons/181922
func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    var copiedArr = arr
    
    for query in queries {
        for n in query[0]...query[1] {
            if n % query[2] == 0 {
                copiedArr[n] += 1
            }
        }
    }
    
    return copiedArr
}

print(solution([0, 1, 2, 4, 3], [[0, 4, 1],[0, 3, 2],[0, 3, 3]]))
*/


