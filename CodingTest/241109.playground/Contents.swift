import UIKit

/*
 MARK: 최대공약수와 최소공배수
 https://school.programmers.co.kr/learn/courses/30/lessons/12940
func choidae(_ n: Int, _ m: Int) -> Int {
    let rest = n % m
    if rest == 0 {
        return m
    } else {
        return choidae(m, rest)
    }
}

func choiso(_ n: Int, _ m: Int) -> Int {
    return n * m / choidae(n, m)
}

func solution(_ n:Int, _ m:Int) -> [Int] {
    return [choidae(n, m), choiso(n, m)]
}

print(solution(2, 5))
*/

/*
 MARK: 삼총사
 https://school.programmers.co.kr/learn/courses/30/lessons/131705?language=swift
func solution(_ number:[Int]) -> Int {
    var result: Int = 0
    
    for firstIdx in 0..<number.count {
        for secondIdx in firstIdx + 1..<number.count {
            for thirdIdx in secondIdx + 1..<number.count {
                if number[firstIdx] + number[secondIdx] + number[thirdIdx] == 0 {
                    result += 1
                }
            }
        }
    }
    
    return result
}

print(solution([-3, -2, -1, 0, 1, 2, 3]))
*/
