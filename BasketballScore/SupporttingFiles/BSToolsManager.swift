//
//  BSToolsManager.swift
//  BasketballScore
//
//  Created by 龚梦洋 on 2023/7/29.
//

import Foundation
import UIKit

class BSToolsManager: NSObject {
    
    var commonBlock: (() -> ())?
    
    static func getWindows() -> [UIWindow] {
        var windows: [UIWindow] = []
        if #available(iOS 15.0, *) {
            windows = UIApplication.shared.connectedScenes.flatMap({
                ($0 as? UIWindowScene)?.windows ?? []
            })
        } else {
            windows = UIApplication.shared.windows
        }
        return windows
    }
    
    static func getKeyWindow() -> UIWindow? {
        return BSToolsManager.getWindows().filter { window in
            return window.isKeyWindow
        }.first
    }
    
    static func commonButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = commonButtonColor
        button.layer.cornerRadius = 6
        button.layer.shadowColor = kColor(r: 0, g: 0, b: 0, 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }
    
    static func commonAddScoreView(score: String) -> UIView {
        let view = UIView()
        
        let ballImage = UIImageView(image: UIImage(named: "basketball"))
        ballImage.contentMode = .scaleAspectFill
        
        let scoreLabel = UILabel()
        scoreLabel.backgroundColor = .white
        scoreLabel.layer.cornerRadius = 6
        scoreLabel.layer.masksToBounds = true
        scoreLabel.textAlignment = .center
        scoreLabel.text = score
        scoreLabel.font = .systemFont(ofSize: 20)
        scoreLabel.textColor = .black
        
        view.addSubview(ballImage)
        ballImage.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.width.equalTo(34)
            make.height.equalTo(38)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        return view
    }
}
