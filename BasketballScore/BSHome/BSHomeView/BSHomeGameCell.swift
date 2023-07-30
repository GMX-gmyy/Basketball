//
//  BSHomeGameCell.swift
//  BasketballScore
//
//  Created by 龚梦洋 on 2023/7/30.
//

import Foundation
import UIKit
import SnapKit

class BSHomeGameCell: UITableViewCell {
    
    var startBlock: (() -> ())?
    
    private lazy var addGameView: UIView = {
        let view = UIView()
        view.backgroundColor = kColor(r: 1, g: 6, b: 84, 0.6)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var gameContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var firstTeamView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var firstTeamName: UILabel = {
        let label = UILabel()
        label.text = "A队"
        label.textAlignment = .center
        label.textColor = kColor(r: 56, g: 56, b: 56)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var secondTeamView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var secondTeamName: UILabel = {
        let label = UILabel()
        label.text = "B队"
        label.textAlignment = .center
        label.textColor = kColor(r: 56, g: 56, b: 56)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var vsLabel: UILabel = {
        let label = UILabel()
        label.text = "VS"
        label.textColor = kColor(r: 212, g: 48, b: 48)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = kColor(r: 22, g: 130, b: 37)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(startEvent), for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(addGameView)
        addGameView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(12)
            make.bottom.equalTo(-12)
        }
        
        addGameView.addSubview(gameContentView)
        gameContentView.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.left.equalTo(24)
            make.bottom.equalTo(-12)
            make.right.equalTo(-24)
        }
        
        gameContentView.addSubview(vsLabel)
        vsLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-15)
        }
        
        gameContentView.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(26)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(13 + 16)
        }
        
        gameContentView.addSubview(firstTeamView)
        firstTeamView.snp.makeConstraints { make in
            make.centerY.equalTo(vsLabel.snp.centerY)
            make.centerX.equalToSuperview().offset(-(15 + 20 + 60))
            make.width.height.equalTo(40)
        }
        
        gameContentView.addSubview(firstTeamName)
        firstTeamName.snp.makeConstraints { make in
            make.centerX.equalTo(firstTeamView.snp.centerX)
            make.centerY.equalTo(startButton.snp.centerY).offset(4)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        gameContentView.addSubview(secondTeamView)
        secondTeamView.snp.makeConstraints { make in
            make.centerY.equalTo(vsLabel.snp.centerY)
            make.centerX.equalToSuperview().offset(15 + 20 + 60)
            make.width.height.equalTo(40)
        }
        
        gameContentView.addSubview(secondTeamName)
        secondTeamName.snp.makeConstraints { make in
            make.centerX.equalTo(secondTeamView.snp.centerX)
            make.centerY.equalTo(startButton.snp.centerY).offset(4)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
    
    var record: BSGameRecordModel? {
        didSet {
            if let record = record {
                firstTeamName.text = record.redTeamName
                secondTeamName.text = record.blueTeamName
                if let firstImage = record.redImage, firstImage.count > 0 {
                    let data = Data(base64Encoded: firstImage)
                    let image = UIImage(data: data!)
                    firstTeamView.image = image
                } else {
                    firstTeamView.image = UIImage(named: "")
                }
                if let secondImage = record.blueImage, secondImage.count > 0 {
                    let data = Data(base64Encoded: secondImage)
                    let image = UIImage(data: data!)
                    secondTeamView.image = image
                } else {
                    firstTeamView.image = UIImage(named: "")
                }
            }
        }
    }
    
    @objc func startEvent() {
        startBlock?()
    }
}
