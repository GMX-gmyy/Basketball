//
//  BSTeamInfoView.swift
//  BasketballScore
//
//  Created by 龚梦洋 on 2023/7/29.
//

import Foundation
import UIKit
import SnapKit

class BSTeamInfoView: UIView {
    
    var addBlock: (() -> ())?
    
    private lazy var teamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var teamImageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "add"), for: .normal)
        button.backgroundColor = kColor(r: 255, g: 255, b: 255, 0.5)
        button.addTarget(self, action: #selector(addTeamEvent), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.text = "队徽"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    public lazy var teamNameTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 20)
        textField.layer.cornerRadius = 6
        textField.layer.masksToBounds = true
        textField.backgroundColor = kColor(r: 255, g: 255, b: 255, 0.5)
        return textField
    }()
    
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "队名"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(teamImageView)
        teamImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(teamImageButton)
        teamImageButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview().offset(-100)
            make.width.height.equalTo(60)
        }
        
        addSubview(badgeLabel)
        badgeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(30)
            make.centerX.equalTo(teamImageButton.snp.centerX)
            make.width.equalTo(teamImageButton.snp.width)
            make.height.equalTo(20)
        }
        
        addSubview(teamNameTextField)
        teamNameTextField.snp.makeConstraints { make in
            make.centerY.equalTo(teamImageButton.snp.centerY)
            make.centerX.equalToSuperview().offset(70)
            make.width.equalTo(110)
            make.height.equalTo(40)
        }
        
        addSubview(teamNameLabel)
        teamNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(badgeLabel.snp.centerY)
            make.centerX.equalTo(teamNameTextField.snp.centerX)
            make.width.equalTo(teamNameTextField.snp.width)
            make.height.equalTo(20)
        }
    }
    
    var teamImage: String? {
        didSet {
            if let teamImage = teamImage {
                teamImageView.image = UIImage(named: teamImage)
            }
        }
    }
    
    var buttonImage: UIImage? {
        didSet {
            if let buttonImage = buttonImage {
                teamImageButton.setBackgroundImage(buttonImage, for: .normal)
                teamImageButton.setImage(nil, for: .normal)
            }
        }
    }
    
    @objc func addTeamEvent() {
        addBlock?()
    }
}
