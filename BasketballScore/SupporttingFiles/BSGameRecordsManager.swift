//
//  BSGameRecordsManager.swift
//  BasketballScore
//
//  Created by 龚梦洋 on 2023/7/30.
//

import Foundation

let kBsRecord = "BsRecord"
class BSGameRecordsManager: NSObject {
    
    static let shared = BSGameRecordsManager()
    
    func saveGameInfo(_ model: BSGameRecordModel) {
        var models = getGameInfo()
        models.append(model)
        UserDefaults.standard.setValue(models.toJSONString(), forKey: kBsRecord)
        UserDefaults.standard.synchronize()
    }
    
    func getGameInfo() -> [BSGameRecordModel] {
        let modelString = (UserDefaults.standard.value(forKey: kBsRecord) as? String) ?? ""
        let models = Array<BSGameRecordModel>(JSONString: modelString)
        return models ?? []
    }
}
