//
//  NSAttributeStringBuilder.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/22/25.
//

import Foundation
import UIKit

extension String {
    var ns: NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
}

extension NSAttributedString {
    @discardableResult
    func applyAttribute(forText targetText: String, key: NSAttributedString.Key, value: Any) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        
        var searchRange = NSRange(location: 0, length: string.utf16.count)
        while searchRange.location < string.utf16.count {
            let range = (string as NSString).range(of: targetText, options: [], range: searchRange)
            if range.location != NSNotFound {
                attributedString.addAttribute(key, value: value, range: range)
                
                searchRange.location = range.location + range.length
                searchRange.length = string.utf16.count - searchRange.location
            } else {
                break
            }
        }
        
        return attributedString
    }
    
    // 특정 텍스트에 폰트 적용
    @discardableResult
    func applyFont(_ font: UIFont, forText targetText: String) -> NSMutableAttributedString {
        return applyAttribute(forText: targetText, key: .font, value: font)
    }
    
    @discardableResult
    func applyColor(_ color: UIColor, forText targetText: String) -> NSMutableAttributedString {
        return applyAttribute(forText: targetText, key: .foregroundColor, value: color)
    }
    
    @discardableResult
     func applyAttributes(_ attributes: [NSAttributedString.Key: Any], forText targetText: String) -> NSMutableAttributedString {
         let attributedString = NSMutableAttributedString(attributedString: self)
         
         // targetText가 있는 모든 범위 찾기
         var searchRange = NSRange(location: 0, length: string.utf16.count)
         while searchRange.location < string.utf16.count {
             let range = (string as NSString).range(of: targetText, options: [], range: searchRange)
             if range.location != NSNotFound {
                 // 찾은 부분에 모든 속성 적용
                 attributedString.addAttributes(attributes, range: range)
                 
                 // 다음 검색 범위 업데이트
                 searchRange.location = range.location + range.length
                 searchRange.length = string.utf16.count - searchRange.location
             } else {
                 break
             }
         }
         
         return attributedString
     }
    
    @discardableResult
    func attribute(forKey key: NSAttributedString.Key, value: Any) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttribute(key, value: value, range: NSRange(location: 0, length: string.utf16.count))
        return attributedString
    }
    
    @discardableResult
    func setFont(_ font: UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let attributesTexts = string.enumerated().map { index, character in
            let attributes = attributedString.attributes(at: index, effectiveRange: nil)
            if character.description.isEmpty {
                return NSAttributedString(string: String(character), attributes: attributes)
            } else {
                return NSAttributedString(string: String(character), attributes: attributes)
                    .attribute(forKey: .font, value: font)
            }
        }
        return NSMutableAttributedString(attributedString: NSAttributedStringBuilder.buildArray(attributesTexts))
    }
    
    @discardableResult
    func setTextColor(_ textColor: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let attributesTexts = string.enumerated().map { index, character in
            let attributes = attributedString.attributes(at: index, effectiveRange: nil)
            if character.description.isEmpty {
                return NSAttributedString(string: String(character), attributes: attributes)
            } else {
                return NSAttributedString(string: String(character), attributes: attributes)
                    .attribute(forKey: .foregroundColor, value: textColor)
            }
        }
        return NSMutableAttributedString(attributedString: NSAttributedStringBuilder.buildArray(attributesTexts))
    }
}

@resultBuilder
struct NSAttributedStringBuilder {
    static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "")
        components.forEach({
            attributedString.append($0)
        })
        return attributedString
    }
    
    static func buildOptional(_ component: NSAttributedString?) -> NSAttributedString {
        return component ?? NSMutableAttributedString(string: "")
    }
    
    static func buildEither(first component: NSAttributedString) -> NSAttributedString {
        return component
    }
    
    static func buildEither(second component: NSAttributedString) -> NSAttributedString {
        return component
    }
    
    static func buildArray(_ components: [NSAttributedString]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "")
        components.forEach({
            attributedString.append($0)
        })
        return attributedString
    }
}
