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
    
    func call(type: RequestItemsType, params: Parameters? = nil, handler: @escaping (Swift.Result<Data, AlertModel>) -> Void) -> DataRequest? {

        let request = self.sessionManager.request(type.url,
                                                  method: type.httpMethod,
                                                  parameters: params,
                                                  encoding: type.encoding,
                                                  headers: nil).validate().responseJSON { (responseData) in
                                                    print("responseData.response:::::",responseData.response as Any)
                                                    print("Response::::::",responseData.result)

                                                    switch responseData.result {

                                                    case .success(_):
                                                        if responseData.response != nil &&
                                                            responseData.value != nil &&
                                                            (responseData.response?.statusCode == 200) {

                                                            handler(.success(responseData.data!))

                                                        }else{
                                                            if responseData.response != nil {
                                                                if let _ = responseData.response?.statusCode {
                                                                    handler(.failure(AlertModel(title: "Error", body: "No data")))
                                                                }else {
                                                                    handler(.failure(AlertModel(title: "Error", body: "No data")))
                                                                }
                                                            }
                                                        }
                                                        break

                                                    case .failure(_):
                                                        handler(.failure(AlertModel(title: "Error", body: "No data")))
                                                        break
                                                    }
                                                  }
        return request


    }
    
    private func parseApi<T>(data: Data?) -> T? where T: Codable{
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

extension ApiManager {
    
    @discardableResult
    func showList(completion: @escaping (Swift.Result<[ShowListModel], AlertModel>) -> Void) -> DataRequest? {
        let request = call(type: .showList) { (result) in
            switch result {
            case .success(let data):
                if let showListModel: [ShowListModel] = self.parseApi(data: data) {
                    completion(.success(showListModel))
                } else {
                    completion(.failure(AlertModel(title: "Error", body: "decoding error")))
                }

                break
            case .failure(_):
                completion(.failure(AlertModel(title: "Error", body: "decoding error")))
                break
            }
        }
        return request
    }
    
    @discardableResult
    func searchShow(completion: @escaping (Swift.Result<[ShowListModel], AlertModel>) -> Void) -> DataRequest? {
        let request = call(type: .showList) { (result) in
            switch result {
            case .success(let data):
                if let showListModel: [ShowListModel] = self.parseApi(data: data) {
                    completion(.success(showListModel))
                } else {
                    completion(.failure(AlertModel(title: "Error", body: "decoding error")))
                }

                break
            case .failure(_):
                completion(.failure(AlertModel(title: "Error", body: "decoding error")))
                break
            }
        }
        return request
    }
    
    @discardableResult
    func singleShow(completion: @escaping (Swift.Result<[ShowListModel], AlertModel>) -> Void) -> DataRequest? {
        let request = call(type: .showList) { (result) in
            switch result {
            case .success(let data):
                if let showListModel: [ShowListModel] = self.parseApi(data: data) {
                    completion(.success(showListModel))
                } else {
                    completion(.failure(AlertModel(title: "Error", body: "decoding error")))
                }

                break
            case .failure(_):
                completion(.failure(AlertModel(title: "Error", body: "decoding error")))
                break
            }
        }
        return request
    }
}
