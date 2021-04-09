//
//  RequestItem.swift
//  MachineTest_vimal
//
//  Created by Vimal Das on 09/04/21.
//

import Foundation
import Alamofire

// MARK: - Enums

enum RequestItemsType {
    case showList
    case showSearch(String)
    case singleShow(String)
    case showSeason(String)
}

// MARK: - Extensions
// MARK: - EndPointType

extension RequestItemsType: EndPointType {
    
    var baseURL: String {
        return "https://api.tvmaze.com/"
    }
    
    private struct ApiEndPoints {
        static let showList     = "shows?page=1"
        static let showSearch   = "search/shows?q="
        static let singleShow   = "shows/"
        static let showSeason   = "shows/"
    }
    
    var path: String {
        switch self {
            
        case .showList:
            return ApiEndPoints.showList
            
        case .showSearch(let searchKey):
            return ApiEndPoints.showSearch + searchKey
            
        case .singleShow(let showId):
            return ApiEndPoints.singleShow + showId
            
        case .showSeason(let showId):
            return ApiEndPoints.showSeason + "\(showId)/seasons"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var url: URL {
        switch self {
        default:
            do{
                return URL(string: self.baseURL + self.path) ?? URL(string: (self.baseURL + self.path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
            }
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}
