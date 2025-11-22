//
//  Fontty.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/22/25.
//

import Foundation
import UIKit

extension UIFont {
    static func pretendard(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let fontName = pretendardFontName(for: weight)
        return UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size, weight: weight)
    }
    
    private static func pretendardFontName(for weight: UIFont.Weight) -> String {
        switch weight {
        case .thin:
            return "Pretendard-Thin"
        case .light:
            return "Pretendard-Light"
        case .regular:
            return "Pretendard-Regular"
        case .medium:
            return "Pretendard-Medium"
        case .semibold:
            return "Pretendard-SemiBold"
        case .bold:
            return "Pretendard-Bold"
        case .heavy:
            return "Pretendard-ExtraBold"
        default:
            return "Pretendard-Regular"
        }
    }
}

