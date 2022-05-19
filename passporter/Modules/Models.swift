//
//  PlaceModel.swift
//  passporter
//
//  Created by dgonzbal on 10/5/22.
//

import Foundation

struct DataResults: Codable {
    let results: [PlaceModel]?
}

struct PlaceModel: Codable {
    let type: String?
    let name: String?
    let location: Location?
    let address: String?
    let cover: String?
}

struct Location: Codable {
    let latitude: Double?
    let longitude: Double?
}
