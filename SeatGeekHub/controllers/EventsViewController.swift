//
//  ViewController.swift
//  SeatGeekHub
//
//  Created by elliott on 2/15/22.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SGManagerDelegate, UISearchResultsUpdating, UISearchBarDelegate, BookmarkDelegate {

    @IBOutlet weak var tableview: UITableView!
    
    var sgManager = SeatGeekManager()
    var events = [Events]()
    var searchedEvents = [Events]()
    let df = DateFormatter()
    var searchController: UISearchController!
    var filtered = false
    var isBookmarked = false
    var userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sgManager.delegate = self
        sgManager.fetchData()
        tableview.delegate = self
        tableview.dataSource = self
        
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: K.cellIdentifier)
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        createSearchController()
        setTitle()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    
    func setTitle() {
        self.title = "SeatGeek Events"
    }
    
    func didUpdateEvent(data: SGData) {
        events = data.events
        events.sort(by: {$0.datetime_local < $1.datetime_local})
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func createSearchController() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Events"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        tableview.tableHeaderView = searchController.searchBar
        
        self.navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filtered = true
        tableview.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filtered = false
        tableview.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !filtered {
            filtered = true
            tableview.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchedEvents = events.filter({
            $0.performers[0].name.contains(searchController.searchBar.text!)
        })
        searchedEvents.sort(by: {$0.datetime_local < $1.datetime_local})
        self.tableview.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtered {
            return searchedEvents.count
        } else {
            return events.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.detailSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.detailSegue {
            if let indexPath = self.tableview.indexPathForSelectedRow {
                let vc = segue.destination as! DetailViewController
                vc.event = [events[indexPath.row]]
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! EventTableViewCell
        
        if filtered {
            
            cell.eventName.text = searchedEvents[indexPath.row].performers[0].name
            

            var dateFromString: Date?
            dateFromString = df.date(from: searchedEvents[indexPath.row].datetime_local)
            if let unwrappedDate = dateFromString {
                let df = DateFormatter()
                df.dateFormat = "MMM d, h:mm a"
                var stringDate: String = df.string(from: unwrappedDate)
                if stringDate.contains("3:30 AM") {
                    stringDate = "Time TBD"
                    cell.eventDate.text = stringDate
                } else {
                    cell.eventDate.text = stringDate
                }
            }
            
            cell.eventLocation.text = searchedEvents[indexPath.row].venue.city
            
            if let data = try? Data(contentsOf: searchedEvents[indexPath.row].performers[0].image) {
                cell.eventImage.image = UIImage(data: data)
            } else {
                cell.eventImage.image = (UIImage(named: "defaultImage"))
            }
        } else {
            //unfiltered
            cell.eventName.text = events[indexPath.row].performers[0].name
            
            var dateFromString: Date?
            dateFromString = df.date(from: events[indexPath.row].datetime_local)
            if let unwrappedDate = dateFromString {
                let df = DateFormatter()
                df.dateFormat = "MMM d, h:mm a"
                var stringDate: String = df.string(from: unwrappedDate)
                if stringDate.contains("3:30 AM") {
                    stringDate = "Time TBD"
                    cell.eventDate.text = stringDate
                } else {
                    cell.eventDate.text = stringDate
                }
            }
            
            cell.eventLocation.text = events[indexPath.row].venue.city
            
            if let data = try? Data(contentsOf: events[indexPath.row].performers[0].image) {
                cell.eventImage.image = UIImage(data: data)
            } else {
                cell.eventImage.image = (UIImage(named: "defaultImage"))
            }
        }
        
        return cell
    }
    
}
