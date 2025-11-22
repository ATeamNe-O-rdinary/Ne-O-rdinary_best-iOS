//
//  R.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/22/25.
//

import Foundation
import UIKit

class R {
    static let bundle = Bundle(for: R.self)
}

extension R {
    enum Images {
        @R_Image
        static var snsTipView = "sns_comment"
        
        @R_Image
        static var check = "check"
        
        @R_Image
        static var link = "link1"
        
        @R_Image
        static var linkIcon = "link_icon"
        
        @R_Image
        static var mail = "mail"
        
        @R_Image
        static var myImage = "my_image"
        
        @R_Image
        static var kakao = "kakao"
        
        @R_Image
        static var downArrow = "down_arrow"
      
      @R_Image
      static var linkCompany = "link_company"
      
      @R_Image
      static var linkTalk = "link_talk"
      
      @R_Image
      static var linko = "linko"
    }
}

@propertyWrapper
struct R_Image {
    var wrappedValue: String
    var projectedValue: UIImage
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
        self.projectedValue = UIImage.load(name: wrappedValue)
    }
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: R.bundle, compatibleWith: nil) else {
            assertionFailure("이미지 불러오기 실패: \(name)")
            return UIImage()
        }
        return image
    }
}

