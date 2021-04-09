//
//  AlertModel.swift
//  MachineTest_vimal
//
//  Created by Vimal Das on 09/04/21.
//

import Foundation

class AlertModel: Error {
    
    var title = ""
    var body = ""
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
    init() { }
}
