//
//  ApiManager.swift
//  MachineTest_vimal
//
//  Created by Vimal Das on 09/04/21.
//

import Foundation
import Alamofire
import UIKit

class ApiManager: NSObject {
    
    let sessionManager = Session.default
    
    private override init() { }
    
    static let shared: ApiManager = ApiManager()
    
    func call<T>(type: RequestItemsType, model: T.Type, handler: @escaping (Swift.Result<T, AlertModel>) -> Void) where T: Codable {
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: nil,
                                    encoding: type.encoding,
                                    headers: nil).validate().responseJSON { (data) in
                                        
                                        guard let jsonData = data.data else {
                                            handler(.failure(AlertModel(title: "Error", body: "No data")))
                                            return
                                        }
                                        
                                        if let parseModel: T = self.parseApi(data: jsonData) {
                                            handler(.success(parseModel))
                                        } else {
                                            handler(.failure(AlertModel(title: "Error", body: "decoding error")))
                                        }
                                    }
    }
    
    private func parseApi<T>(data: Data?) -> T? where T: Codable {
        guard let jsonData = data else { print("No data"); return nil }
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(T.self, from: jsonData)
            return model
        } catch let error {
            print("Error Deconding \n \(error)")
        }
        return nil
        
        
    }
    
}
