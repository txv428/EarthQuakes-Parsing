//
//  EarthquakesManager.swift
//  EarthQuakesParsing
//
//  Created by tejasree vangapalli on 6/1/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import Foundation
import UIKit

let date: String = Date().dateString30DaysFromNow()

struct EarthquakesManager {
    
    typealias RecordCompletion = ((Result<[Features], NetworkError>) -> Void)
    
    func fetchLatestEarthQuakes(pageNumber page: Int, completion: @escaping (RecordCompletion)) {
        
        let url = URL(string: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=\(date)&limit=50&offset=\(page*50+1)")!
        
        
        NetworkManager.performRequest(for: url) { (data, error) in
            
            if let error = error {
                print("Error performing Network Request \(error) \(#file) \(#function)")
                completion(.failure(.forwarded(error))); return
            }
            guard let date = data else { completion(.failure(.noDataReturned)); return }
            
            do {
                
                let results = try JSONDecoder().decode(EarthquakeModel.self, from: date).features
                completion(.success(results!))
            } catch let e {
                print("Error with JsonDecoder \(e) \(e.localizedDescription)")
                completion(.failure(.dataNotDecodable)); return
            }
        }
    }
}


