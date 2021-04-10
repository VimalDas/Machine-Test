//
//  ShowListModel.swift
//  MachineTest_vimal
//
//  Created by Vimal Das on 09/04/21.
//

import Foundation

class ShowListModel: Codable {
        
    var id: Int?
    var image: ImageDetails?
    var language: String?
    var name: String?
    var officialSite: String?
    var premiered: String?
    var rating: RatingDetails?
    var runtime: Int?

    var status: String?
    var summary: String?
    var type: String?
        
    var url: String?
    
    struct RatingDetails: Codable {
        var average: Double?
    }
    
    struct ImageDetails: Codable {
        var medium: String?
        var original: String?
    }
}
