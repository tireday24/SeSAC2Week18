//
//  SubscriptExample.swift
//  SeSAC2Week18
//
//  Created by 권민서 on 2022/11/03.
//

import Foundation

extension String {
    
    //jack >>> [1] >>> a
    
    //옵셔널? -> 범위를 몰라서
    subscript(idx: Int) -> String? {
        
        //idx 받았을 때 포함이 안된다면 nil 반환해라
        guard (0..<count).contains(idx) else {
            return nil
        }
        
        //startIndex: 0, offsetBy 얼마나 떨어져 있나
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
        
    }
    
}

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}

//let a = [Phone(), Phone()]
//Phone[1]

struct Phone {
    
    var numbers = ["1234", "5679", "3353", "2222"]
    
    //구조체 내에서 확장해서 사용
    //인덱스를 가져올 때 numbers 가져옴
    subscript(idx: Int) -> String {
        get {
            return self.numbers[idx]
        }
        set {
            self.numbers[idx] = newValue
        }
    }
    
    
}


