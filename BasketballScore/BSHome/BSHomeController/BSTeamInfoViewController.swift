//
//  BSTeamInfoViewController.swift
//  BasketballScore
//
//  Created by 龚梦洋 on 2023/7/29.
//

import Foundation
import UIKit
import SnapKit

class BSTeamInfoViewController: UIViewController {
    
    private var isRed: Bool = true
    private var redImage: UIImage?
    private var blueImage: UIImage?
    
    private lazy var naviView: BSBaseNavigationView = {
        let view = BSBaseNavigationView()
        return view
    }()
    
    private lazy var redTeam: BSTeamInfoView = {
        let view = BSTeamInfoView()
        view.teamImage = "redTeam"
        return view
    }()
    
    private lazy var vsImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "vs"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var blueTeam: BSTeamInfoView = {
        let view = BSTeamInfoView()
        view.teamImage = "blueTeam"
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let button = BSToolsManager.commonButton(title: "Save")
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
        
        view.addSubview(redTeam)
        redTeam.snp.makeConstraints { make in
            make.top.equalTo(kNavigationBarHeight + 24)
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.height.equalTo(180)
        }
        redTeam.addBlock = { [weak self] in
            guard let `self` = self else { return }
            self.isRed = true
            self.addPhoto()
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(-kTabbarHeight)
            make.width.equalTo(145)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        saveButton.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        
        view.addSubview(blueTeam)
        blueTeam.snp.makeConstraints { make in
            make.bottom.equalTo(saveButton.snp.top).offset(-32)
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.height.equalTo(180)
        }
        blueTeam.addBlock = { [weak self] in
            guard let `self` = self else { return }
            self.isRed = false
            self.addPhoto()
        }
        
        view.addSubview(vsImageView)
        vsImageView.snp.makeConstraints { make in
            make.top.equalTo(redTeam.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(152)
            make.bottom.equalTo(blueTeam.snp.top).offset(-24)
        }
    }
    
    @objc func saveEvent() {
        let model = BSGameRecordModel()
        model.redTeamName = redTeam.teamNameTextField.text
        model.blueTeamName = blueTeam.teamNameTextField.text
        model.redImage = redImage?.jpegData(compressionQuality: 0.1)?.base64EncodedString()
        model.blueImage = blueImage?.jpegData(compressionQuality: 0.1)?.base64EncodedString()
        BSGameRecordsManager.shared.saveGameInfo(model)
        navigationController?.popViewController(animated: true)
    }
    
    private func addPhoto() {
        let vc = UIImagePickerController()
        self.present(vc, animated: true)
        vc.delegate = self
    }
}

extension BSTeamInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if isRed {
            redTeam.buttonImage = image
            redImage = image
        } else {
            blueTeam.buttonImage = image
            blueImage = image
        }
    }
}
