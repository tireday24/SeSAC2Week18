//
//  ProfileViewModel.swift
//  SeSAC2Week18
//
//  Created by 권민서 on 2022/11/03.
//

import Foundation
import RxCocoa
import RxSwift

class ProfileViewModel {
    
    let profile = PublishSubject<Profile>()
    
    func getProfile() {
        
        let api = SeSACAPI.profile
        Network.shared.requestSeSAC(type: Profile.self ,url: api.url, headers: api.header) { [weak self] response in
            
            switch response {
                
            case .success(let success):
                self?.profile.onNext(success)
            case .failure(let failure):
                self?.profile.onError(failure)
            }
        }
        
        
    }
    
    
}
