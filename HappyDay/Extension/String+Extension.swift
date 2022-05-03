//
//  String+Extension.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/03.
//

import Foundation

extension String {
    func getFirstChar() -> String{
        guard self.first != nil else { return "" }
        let hangul = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        let pattern = "^[가-힣]*"
        
        if (try? NSRegularExpression(pattern: pattern, options: [])) != nil {
            let octal = self.unicodeScalars[self.unicodeScalars.startIndex].value
            if octal < 44032 {
                return self.first!.description
            }
            let index = (octal - 0xac00) / 28 / 21
            return hangul[Int(index)]
        }
        return self.first!.description
    }
}
