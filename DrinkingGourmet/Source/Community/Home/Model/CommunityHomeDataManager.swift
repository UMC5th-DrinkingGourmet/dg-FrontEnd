//
//  CommunityHomeDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/4/24.
//

import UIKit

class CommunityHomeDataManager {

    let communityDataArray: [CommunityHome] = [
        CommunityHome(communityImage: UIImage(named: "img_community_home_combination")),
        CommunityHome(communityImage: UIImage(named: "img_community_home_weeklybest")),
        CommunityHome(communityImage: UIImage(named: "img_community_home_recipebook"))
    ]
    
    func getCommunityData() -> [CommunityHome] {
        return communityDataArray
    }
}
