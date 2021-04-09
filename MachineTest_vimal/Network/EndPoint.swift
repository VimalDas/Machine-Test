//
//  EndPoint.swift
//  MachineTest_vimal
//
//  Created by Vimal Das on 09/04/21.
//

import Foundation
import Alamofire

protocol EndPointType {
    var baseURL         : String            { get }
    var path            : String            { get }
    var httpMethod      : HTTPMethod        { get }
    var url             : URL               { get }
    var encoding        : ParameterEncoding { get }
}
