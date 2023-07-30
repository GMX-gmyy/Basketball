//
//  BSHomeViewController.swift
//  BasketballScore
//
//  Created by 龚梦洋 on 2023/7/29.
//

import Foundation
import UIKit
import SnapKit

class BSHomeViewController: UIViewController {
    
    private var dataSource: [BSGameRecordModel] = []
    
    public lazy var basketballImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "basketballImage"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var gameTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BSHomeGameCell.self, forCellReuseIdentifier: "BSHomeGameCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var nullCellLabel: UILabel = {
        let label = UILabel()
        label.text = "There is no competition yet, \nplease add it~"
        label.font = .systemFont(ofSize: 20)
        label.textColor = kColor(r: 45, g: 45, b: 45, 0.25)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var addGameButton: UIButton = {
        let button = BSToolsManager.commonButton(title: "Add Game")
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global().async {
            self.dataSource = BSGameRecordsManager.shared.getGameInfo()
            DispatchQueue.main.async {
                self.gameTableView.reloadData()
                if self.dataSource.count == 0 {
                    self.nullCellLabel.isHidden = false
                    self.gameTableView.isHidden = true
                } else {
                    self.nullCellLabel.isHidden = true
                    self.gameTableView.isHidden = false
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(basketballImageView)
        basketballImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(kNavigationBarHeight + 32)
            make.width.equalTo(166)
            make.height.equalTo(142)
        }
        
        view.addSubview(nullCellLabel)
        nullCellLabel.snp.makeConstraints { make in
            make.top.equalTo(basketballImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(addGameButton)
        addGameButton.snp.makeConstraints { make in
            make.bottom.equalTo(-kTabbarHeight)
            make.width.equalTo(145)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(gameTableView)
        gameTableView.snp.makeConstraints { make in
            make.top.equalTo(basketballImageView.snp.bottom).offset(12)
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.bottom.equalTo(addGameButton.snp.top).offset(-24)
        }
        
        addGameButton.addTarget(self, action: #selector(addGameEvent), for: .touchUpInside)
    }
    
    @objc func addGameEvent() {
        let vc = BSTeamInfoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BSHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BSHomeGameCell", for: indexPath) as? BSHomeGameCell
        cell?.record = dataSource[indexPath.row]
        cell?.startBlock = { [weak self] in
            let vc = BSStartRecordViewController()
            vc.model = self?.dataSource[indexPath.row]
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell ?? BSHomeGameCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122 + 24
    }
}
