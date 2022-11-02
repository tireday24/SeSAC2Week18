//
//  APIService.swift
//  SeSAC2Week18
//
//  Created by 권민서 on 2022/11/02.
//

import Foundation
import Alamofire

struct Login: Codable {
    let token: String
}

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

class APIService {
    
    func signup() {
        let api = SeSACAPI.signup(userName: "testDaniel", email: "testDainel@testDainel.com", password: "12345678")
      
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header).responseString { response in
            
            print(response)
            print(response.response?.statusCode)
            
//            switch response.result {
//
//            case .success(_):
//                <#code#>
//            case .failure(_):
//                <#code#>
//            }
            
        }
        
    }
    
    func login() {
        let api = SeSACAPI.login(email: "testDainel@testDainel.com", password: "12345678")
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.header).validate(statusCode: 200...299).responseDecodable(of: Login.self) { response in
            
            switch response.result {
                
            case .success(let data):
                print(data.token) //로그인 쪽에다가 디코딩을 했기 때문에
                UserDefaults.standard.set(data.token, forKey: "token")//토큰 값을 저장하는 이유 -> 프로필에서 토큰 값을 넣어주어야 하기 때문에
                
            case .failure(_):
                print(response.response?.statusCode)
            }
            
        }
        
        
    }
    
    
    func profile() {
        let api = SeSACAPI.profile
        
        AF.request(api.url, method: .get, headers: api.header).responseDecodable(of: Profile.self) { response in
            
            switch response.result {
                
            case .success(let data):
                print(data)
                
            case .failure(_):
                print(response.response?.statusCode)
            }
            
        }
    }
    
}
