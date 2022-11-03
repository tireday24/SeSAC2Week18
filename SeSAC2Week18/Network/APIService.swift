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

//Error -> Protocol(Sendable)
enum SeSACError: Int, Error {
    
    case invalidAuthorization = 401
    case takenEmail = 406
    case emptyParameters = 501
}

extension SeSACError: LocalizedError {
    
    var errorDescription: String? {
        switch self  {
            
        case .invalidAuthorization:
            return "토큰이 만료되었습니다. 다시 로그인 해주세요"
        case .takenEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요."
        case .emptyParameters:
            return "입력된 값이 없습니다"
        }
    }
    
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
    
    //타입이 왜 필요한가?
    //사용할 때 어떤 타입이 들어가야할지 작성해서 넣어줄 곳이 없다 그래서 타입 명시를 위해 넣어줌
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod = .get, parameters: [String: String]? = nil,  headers: HTTPHeaders, completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, method: method, parameters: parameters, headers: headers).responseDecodable(of: T.self) { response in
            
            switch response.result {
                
            case .success(let data):
                completionHandler(.success(data)) // 탈출 클로저, Result, 연관값
            case .failure(_):
                
                guard let statusCode = response.response?.statusCode else { return}
                guard let error = SeSACError(rawValue: statusCode) else { return }
                
                completionHandler(.failure(error))
            }
            
        }
        
    }
    
}
