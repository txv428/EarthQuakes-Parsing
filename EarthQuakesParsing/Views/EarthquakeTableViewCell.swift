//
//  EarthquakeTableViewCell.swift
//  EarthQuakesParsing
//
//  Created by tejasree vangapalli on 6/1/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import UIKit

class EarthquakeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var magLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    // MARK: - Props
    var properties: Properties? {
        didSet {
            placeLabel.text = properties?.place
            magLabel.text = "\(String(describing: properties!.mag))"
            dateLabel.text = "\(properties?.date ?? Date())"
        }
    }
}
