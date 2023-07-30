//
//  BSGameRecordModel.swift
//  BasketballScore
//
//  Created by 龚梦洋 on 2023/7/30.
//

import Foundation
import ObjectMapper

class BSGameRecordModel: BSBaseModel {
    
    var redImage: String?
    var redTeamName: String?
    var blueImage: String?
    var blueTeamName: String?
    
    override func mapping(map: Map) {
        
        redTeamName     <- map["redTeamName"]
        redImage        <- map["redImage"]
        blueTeamName    <- map["blueTeamName"]
        blueImage       <- map["blueImage"]
    }
}
