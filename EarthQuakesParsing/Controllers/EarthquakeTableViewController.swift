//
//  EarthquakeTableViewController.swift
//  EarthQuakesParsing
//
//  Created by tejasree vangapalli on 6/1/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import UIKit

class EarthquakeTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var curentPage = 0
    var isFetching = false
    
    // MARK: - Props
    var earthquakeManager = EarthquakesManager()
    fileprivate var earthQuakes = [Features]()
    var limit = 20
    var totalEntries = 20000
    var reachability: Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Earth quakes list"
        fetchEarthquakes()
        
        reachability = try? Reachability(hostname: "www.google.com")
        try? self.reachability?.startNotifier()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachableStatus), name: NSNotification.Name(Notification.Name.reachabilityChanged.rawValue), object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // fetchs earthquakes records from the API of every page
    func fetchEarthquakesPerPage() {
        if (reachability?.connection == .unavailable) {
            self.ErrorMessage(titleStr: "No Internet Connection", messageStr: "Please try again")
            return
        }
        isFetching = true
        earthquakeManager.fetchLatestEarthQuakes(pageNumber: self.curentPage) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let earthquakes):
                self.earthQuakes += earthquakes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.isFetching = false
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.ErrorMessage(titleStr: "Error Displaying Earthquakes", messageStr: error.localizedDescription)
                }
                self.isFetching = false
            }
        }
    }
    
    // Checks the internet connection and displays records accordingly
    @objc func reachableStatus() {
        if (reachability?.connection != .unavailable) {
            fetchEarthquakesPerPage()
        } else {
            self.ErrorMessage(titleStr: "No Internet Connection", messageStr: "Please try again")
        }
    }
        
    func fetchEarthquakes() {
        fetchEarthquakesPerPage()
    }
    
    // MARK: - Initializers
    
    init(earthquakeManager: EarthquakesManager) {
        self.earthquakeManager = earthquakeManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // pagination -- checks the requests from user at 3/4th of the scroll view everytime
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollViewContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        if (scrollOffset + scrollViewHeight > ((scrollViewContentSizeHeight * 3)/4)) && !isFetching {
            self.curentPage += 1
            print(self.curentPage)
            fetchEarthquakesPerPage()
        }
    }
}

// MARK: - Table view data source
extension EarthquakeTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthQuakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? EarthquakeTableViewCell else { return UITableViewCell() }
        
        let earthquake = earthQuakes[indexPath.row]
        
        cell.placeLabel.text = earthquake.properties?.place
        cell.dateLabel.text = earthquake.properties?.date!.dateToString()
        cell.magLabel.text = "\(Double(Int(((earthquake.properties?.mag) ?? 0.0)*100))/100.0)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? EarthquakeTableViewCell else { return }
        cell.isAccessibilityElement = true
        let earthquake = self.earthQuakes[indexPath.row]
        guard let detailedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? EarthquakeDetailViewController else { return }
        detailedViewController.earthquakes = earthquake
        self.navigationController?.pushViewController(detailedViewController, animated: true)
    }
}
