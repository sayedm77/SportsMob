//
//  NetworkManager.swift
//  SportsMob
//
//  Created by sayed mansour on 24/08/2024.
//

import Foundation
import Alamofire

class NetworkManager{
  
    static let manager = NetworkManager()
  
    //Generic func:
        func fetchData<T: Codable>(url: URL?, model: T.Type, completion: @escaping (T?,Error?)->Void) {
            guard let url = url else {
                let error = NSError(domain: "URL error", code: 0, userInfo: [NSLocalizedDescriptionKey : "URL is nil"])
                completion(nil,error)
                return
            }
            AF.request(url).validate().responseDecodable(of: model.self) { response in
                switch response.result{
                case .success(let decodedResult):
                    completion(decodedResult,nil)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil,error)
                }
            }
        }
    

}

enum SportType: String {
    case football = "/football"
    case basketball = "/basketball"
    case cricket = "/cricket"
    case tennis = "/tennis"
    
    init?(from rawValue: String) {
        switch rawValue {
        case "/football":
            self = .football
        case "/basketball":
            self = .basketball
        case "/cricket":
            self = .cricket
        case "/tennis":
            self = .tennis
        default:
            return nil
        }
    }
    
    var stringValue: String {
        return self.rawValue
    }
}
