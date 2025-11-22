//
//  PageTabButton.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import Foundation
import UIKit
import SnapKit

enum PageTab {
    case linker
    case recommend

    var name: String {
        switch self {
        case .linker:
            return "링커 찾기"
        case .recommend:
            return "추천"
        }
    }
    
    var font: UIFont {
        return UIFont.pretendard(size: 16, weight: .medium)
    }
}

final class PageTabButton: UIButton {
    let tab: PageTab
    
    var selectedObserver: NSKeyValueObservation?
    
    private let bottomLine = UIView()
    
    private var selectedBackgroundColor: UIColor { UIColor(hexString: "#FF704D") }
    
    private var unselectedBackgroundColor: UIColor { UIColor(hexString: "#EBEBEB") }
    
    deinit { selectedObserver = nil }
    
    init(tab: PageTab) {
        self.tab = tab
        super.init(frame: .zero)
        let normalAttributedTitle = tab.name.ns.setFont(tab.font).setTextColor(UIColor(hexString: "#878787"))
        let selectedAttributedTitle = tab.name.ns.setFont(tab.font).setTextColor(UIColor(hexString: "#222222"))
        setAttributedTitle(normalAttributedTitle, for: .normal)
        setAttributedTitle(selectedAttributedTitle, for: .selected)
        bottomLine.backgroundColor = unselectedBackgroundColor
        
        selectedObserver = observe(\.isSelected, options: [.old, .new]) { [weak self] button, change in
            guard let self,
                  let newValue = change.newValue else { return }
            asyncOnMain(with: self) {
                $0.bottomLine.backgroundColor = newValue ? $0.selectedBackgroundColor : $0.unselectedBackgroundColor
            }
        }
        
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func asyncOnMain<Context: AnyObject>(with context: Context, _ block: @escaping (Context) -> Void) {
        DispatchQueue.main.async { [weak context] in
            guard let context else { return }
            block(context)
        }
    }
}
