//
//  APICall.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 02/05/25.
//

import Foundation
import Alamofire
import Common

struct API {
    
    static let baseUrl = "https://api.myanimelist.net/v2/"
    static let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(keyEncoding: .useDefaultKeys))
    static var headers: HTTPHeaders {
        let apiKey = AppConfigMain.API_KEY
        return ["X-MAL-CLIENT-ID": apiKey]
    }
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case detail
        case ranking
        case search
        
        public var url: String {
            switch self {
            case .detail: return "\(API.baseUrl)anime"
            case .ranking: return "\(API.baseUrl)anime/ranking"
            case .search: return "\(API.baseUrl)anime"
            }
        }
    }
    
}
