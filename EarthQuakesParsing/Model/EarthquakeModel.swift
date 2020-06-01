//
//  EarthquakeModel.swift
//  EarthQuakesParsing
//
//  Created by tejasree vangapalli on 6/1/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import Foundation

struct EarthquakeModel: Codable {
    var type: String?
    var features: [Features]?
}

struct Features: Codable {
    var properties: Properties?
    var geometry: Geometry?
    var id: String?
}

struct Properties: Codable {
    var mag: Double?
    var place: String?
    var time: Double?
    var title: String
    var date: Date? {
        return Date(longIntTimeIntervalSince1970: time!)
    }
    var url: String?
}

struct Geometry: Codable {
    var coordinates: [Double]?
}
