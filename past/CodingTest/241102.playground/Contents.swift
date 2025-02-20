import Foundation

/*
 MARK: 수열과 구간 쿼리 1
func solution(_ arr:[Int], _ queries:[[Int]]) -> [Int] {
    var copiedArr = arr
    for query in queries {
        for i in query[0]...query[1] {
            copiedArr[i] += 1
        }
    }
    return copiedArr
}

print(solution([0, 1, 2, 3, 4], [[0, 1],[1, 2],[2, 3]])) // [1,3,4,4,4]
*/

/*
 MARK: 빈 배열에 추가, 삭제하기
 https://school.programmers.co.kr/learn/courses/30/lessons/181860
func solution(_ arr:[Int], _ flag:[Bool]) -> [Int] {
    var answerArr: [Int] = []
    for (idx, f) in flag.enumerated() {
        if f {
            answerArr += Array(repeatElement(arr[idx], count: arr[idx] * 2))
        } else {
            answerArr = Array(answerArr.dropLast(arr[idx]))
        }
    }
    return answerArr
}

print(solution([3, 2, 4, 1, 3], [true, false, true, false, false]))
*/

/*
 MARK: 문자열이 몇 번 등장하는지 세기
 https://school.programmers.co.kr/learn/courses/30/lessons/181871
func solution(_ myString:String, _ pat:String) -> Int {
    var count: Int = 0
    let patCnt = pat.count - 1
    
    for (idx, str) in myString.enumerated() {
        if idx + patCnt < myString.count {
            if pat == String(Array(myString)[idx...idx + patCnt]) {
                count += 1
            }
        }
    }
    
    return count
}

print(solution("aaaa", "aa"))
*/

/*
 MARK: 1로 만들기
 https://school.programmers.co.kr/learn/courses/30/lessons/181880
func solution(_ num_list:[Int]) -> Int {
    var count: Int = 0
    
    for num in num_list {
        var copiedNum = num
        while copiedNum != 1 {
            if copiedNum % 2 == 0 {
                copiedNum /= 2
            } else {
                copiedNum = (copiedNum - 1) / 2
            }
            count += 1
        }
    }
    
    return count
}

print(solution([12, 4, 15, 1, 14]))
*/

