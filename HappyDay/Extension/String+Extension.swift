//
//  String+Extension.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/03.
//

import Foundation

extension String {
    func getFirstChar() -> String{
        let hangul = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        let pattern = "[가-힣]"
        if (try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)) != nil {
            return self.first!.description
        }
        let octal = self.unicodeScalars[self.unicodeScalars.startIndex].value
        let index = (octal - 0xac00) / 28 / 21
        return hangul[Int(index)]
    }
}
