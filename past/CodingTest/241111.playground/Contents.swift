import UIKit

/*
 MARK: 최소직사각형
 https://school.programmers.co.kr/learn/courses/30/lessons/86491?language=swift
func solution(_ sizes:[[Int]]) -> Int {
    var maxLengths: [Int] = []
    var minLengths: [Int] = []
    
    for size in sizes {
        maxLengths.append(max(size[0], size[1]))
        minLengths.append(min(size[0], size[1]))
    }
    
    return maxLengths.max()! * minLengths.max()!
}

print(solution([[14, 4], [19, 6], [6, 16], [18, 7], [7, 11]]))
*/
