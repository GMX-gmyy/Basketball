//
//  BSTeamScoreView.swift
//  BasketballScore
//
//  Created by 龚梦洋 on 2023/7/30.
//

import Foundation
import UIKit
import SnapKit

class BSTeamScoreView: UIView {
    
    var score: Int = 0
    var addBlock: ((_ score: Int) -> ())?
    
    private lazy var teamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var scoreInfoView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = kColor(r: 255, g: 255, b: 255, 0.5)
        return imageView
    }()
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var teamScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.backgroundColor = kColor(r: 255, g: 255, b: 255, 0.5)
        label.text = "0"
        label.textColor = .black
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var scoreView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var oneScoreView: UIView = {
        let view = BSToolsManager.commonAddScoreView(score: "+1")
        return view
    }()
    
    private lazy var twoScoreView: UIView = {
        let view = BSToolsManager.commonAddScoreView(score: "+2")
        return view
    }()
    
    private lazy var threeScoreView: UIView = {
        let view = BSToolsManager.commonAddScoreView(score: "+3")
        return view
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
        
        teamImageView.addSubview(scoreInfoView)
        scoreInfoView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(91)
            make.top.equalTo(24)
        }
        
        scoreInfoView.addSubview(badgeImageView)
        badgeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview().offset(-(30 + 60))
            make.width.height.equalTo(60)
        }
        
        scoreInfoView.addSubview(badgeLabel)
        badgeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(15)
            make.centerX.equalTo(badgeImageView.snp.centerX)
            make.width.equalTo(96)
            make.height.equalTo(30)
        }
        
        scoreInfoView.addSubview(teamScoreLabel)
        teamScoreLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview().offset(30 + 60)
            make.width.equalTo(66)
            make.height.equalTo(46)
        }
        
        scoreInfoView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalTo(teamScoreLabel.snp.centerX)
            make.centerY.equalTo(badgeLabel.snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(29)
        }
        
        teamImageView.addSubview(scoreView)
        scoreView.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalToSuperview()
            make.bottom.equalTo(-21)
        }
        
        let twoTap = UITapGestureRecognizer(target: self, action: #selector(twoTap))
        twoScoreView.addGestureRecognizer(twoTap)
                
        scoreView.addSubview(twoScoreView)
        twoScoreView.snp.makeConstraints { make in
            make.width.equalTo(74)
            make.height.equalTo(38)
            make.centerX.equalToSuperview()
        }
        
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(oneTap))
        oneScoreView.addGestureRecognizer(oneTap)
        
        scoreView.addSubview(oneScoreView)
        oneScoreView.snp.makeConstraints { make in
            make.width.equalTo(74)
            make.height.equalTo(38)
            make.right.equalTo(twoScoreView.snp.left).offset(-24)
        }
        
        let threeTap = UITapGestureRecognizer(target: self, action: #selector(threeTap))
        threeScoreView.addGestureRecognizer(threeTap)
        
        scoreView.addSubview(threeScoreView)
        threeScoreView.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(74)
            make.left.equalTo(twoScoreView.snp.right).offset(24)
        }
    }
    
    var teamScoreImage: String? {
        didSet {
            if let teamScoreImage = teamScoreImage {
                teamImageView.image = UIImage(named: teamScoreImage)
            }
        }
    }
    
    var isRed: Bool?
    var model: BSGameRecordModel? {
        didSet {
            if let model = model {
                DispatchQueue.global().async {
                    let image = UIImage(data: Data(base64Encoded: self.isRed == true ? (model.redImage ?? "") : (model.blueImage ?? "")) ?? Data())
                    DispatchQueue.main.async {
                        self.badgeImageView.image = image
                    }
                }
                badgeLabel.text = isRed == true ? model.redTeamName : model.blueTeamName
            }
        }
    }
    
    @objc func oneTap() {
        score += 1
        refreshScore()
        addBlock?(1)
    }
    
    @objc func twoTap() {
        score += 2
        refreshScore()
        addBlock?(2)
    }
    
    @objc func threeTap() {
        score += 3
        refreshScore()
        addBlock?(3)
    }
    
    private func refreshScore() {
        teamScoreLabel.text = "\(score)"
    }
}
