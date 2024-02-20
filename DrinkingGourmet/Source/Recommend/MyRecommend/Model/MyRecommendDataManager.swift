//
//  MyRecommendDataManager.swift
//  DrinkingGourmet
//
//  Created by hee on 2/19/24.
//

import Alamofire

class MyRecommendDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    
    // MARK: - 주류추천
    func postRecommendsRequest (_ parameters: RecommendsRequestParameters) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/recommends/request",
                       method: .post,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default,
                       headers: headers).responseDecodable(of: MyRecommendModel.self) { response in
                let myRecommendModelData = MyRecommendModelData.shared
            
                switch response.result {
                case .success(let myRecommendModel):
                    myRecommendModelData.model = myRecommendModel
                    //debugPrint(myRecommendModelData.model)
                    if let duration = response.metrics?.taskInterval.duration {
                        myRecommendModelData.netWorkDuration = Double(duration)
                        print("Network Duration: \(duration)")
                    }
                    
                    
//                    let nextViewController = LoadingRecommendDrinkViewController()
//                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                case .failure(let error):
                    print("API 요청 실패: \(error)")
                }
                
            }
        } catch {
            print("Failed to get access token")
        }
    }
}
// Network Duration: 18.543894052505493
// DrinkingGourmet.MyRecommendModel(isSuccess: true, code: "COMMON200", message: "성공입니다.", result: Optional(DrinkingGourmet.RecommendResult(recommendID: 114, foodName: "깐풍기", drinkName: "막걸리", recommendReason: "깐풍기와 잘 어울리는 술은 막걸리입니다. 막걸리는 부드럽고 달콤한 맛이 깐풍기의 간을 잡아주고, 가벼운 맛과 5도의 적당한 도수로 소주를 좋아하는 사용자에게 적합합니다. 또한, 우울하고 스트레스 받은 마음을 해소해주고 화창한 날씨에 어울리는 상쾌한 분위기를 연출해줄 것입니다.", imageUrl: "https://drink-gourmet-bucket.s3.ap-northeast-2.amazonaws.com/bf37cb45-aab4-430c-a938-9c8cfb93c4e9.png")))
