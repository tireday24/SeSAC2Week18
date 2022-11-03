//
//  Network.swift
//  SeSAC2Week18
//
//  Created by 권민서 on 2022/11/03.
//

import Foundation
import Alamofire

final class Network {
    
    static let shared = Network()
    
    private init() {}
    
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
