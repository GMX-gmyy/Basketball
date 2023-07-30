//
//  BSStartRecordViewController.swift
//  BasketballScore
//
//  Created by 龚梦洋 on 2023/7/30.
//

import Foundation
import UIKit
import SnapKit

class BSStartRecordViewController: UIViewController {
    
    public var model: BSGameRecordModel?
    let naviView = BSBaseNavigationView()
    
    private lazy var redTeamScore: BSTeamScoreView = {
        let view = BSTeamScoreView()
        view.contentMode = .scaleAspectFill
        view.teamScoreImage = "redTeam"
        view.isRed = true
        view.model = model
        return view
    }()
    
    private lazy var blueTeamScore: BSTeamScoreView = {
        let view = BSTeamScoreView()
        view.contentMode = .scaleAspectFill
        view.teamScoreImage = "blueTeam"
        view.isRed = false
        view.model = model
        return view
    }()
    
    private lazy var vsImageview: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "vs"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var finishButton: UIButton = {
        let button = BSToolsManager.commonButton(title: "Finish")
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(naviView)
        naviView.snp.makeConstraints { make in
            make.top.equalTo(kTopSafeHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight)
        }
        naviView.backBlock = { [weak self] in
            guard let `self` = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(redTeamScore)
        redTeamScore.snp.makeConstraints { make in
            make.top.equalTo(kNavigationBarHeight + 24)
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.height.equalTo(179)
        }
            
        view.addSubview(finishButton)
        finishButton.snp.makeConstraints { make in
            make.bottom.equalTo(-kTabbarHeight)
            make.width.equalTo(145)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(blueTeamScore)
        blueTeamScore.snp.makeConstraints { make in
            make.bottom.equalTo(finishButton.snp.top).offset(-32)
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.height.equalTo(179)
        }
        
        view.addSubview(vsImageview)
        vsImageview.snp.makeConstraints { make in
            make.top.equalTo(redTeamScore.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(152)
            make.bottom.equalTo(blueTeamScore.snp.top).offset(-24)
        }
    }
}
