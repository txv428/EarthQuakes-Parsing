//
//  EarthquakeDetailViewController.swift
//  EarthQuakesParsing
//
//  Created by tejasree vangapalli on 6/1/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import UIKit
import MapKit

class EarthquakeDetailViewController: UIViewController, MKMapViewDelegate {
    
    var earthquakes : Features?

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var magnitudeLabel: UILabel!
    @IBOutlet weak var viewInBrowserButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mapView.delegate = self
        setupMap()
    }
    
    @IBAction func viewInBrowserTouched(_ sender: UIButton) {
        if let url = URL(string: (earthquakes?.properties?.url)!) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - UI Setup
    func setupUI() {
        titleLabel.text = earthquakes?.properties?.title
        placeLabel.text = earthquakes?.properties?.place
        depthLabel.text = "\(earthquakes?.geometry?.coordinates?[2] ?? 0)"
        dateLabel.text = (earthquakes?.properties?.date?.dateToString())!+", "+(earthquakes?.properties?.date?.timeToString())!
        magnitudeLabel.text = "\(earthquakes?.properties?.mag ?? 0)  Magnitude"
        viewInBrowserButton.layer.cornerRadius = 15
    }
    
    // MARK: - Map annotation for every coordinates
    func setupMap() {
        addPin()
        focusMapView()
    }
    func addPin() {
        let annotation = MKPointAnnotation()
        guard let coordinates = earthquakes?.geometry?.coordinates else { return }
        let centerCoordinate = CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
        annotation.coordinate = centerCoordinate
        mapView.addAnnotation(annotation)
    }

    func focusMapView() {
        guard let coordinates = earthquakes?.geometry?.coordinates else { return }
        let mapCenter = CLLocationCoordinate2DMake(coordinates[1], coordinates[0])
        let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        let region = MKCoordinateRegion(center: mapCenter, span: span)
        mapView.region = region
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}
