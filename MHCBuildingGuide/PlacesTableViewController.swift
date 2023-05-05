//
//  PlacesTableViewController.swift
//  MHCBuildingGuide
//
//  Created by Joeun Park on 5/2/23.
//

import UIKit

class PlacesTableViewController: UITableViewController {
    
    private let places = ["Dorms", "Academic Buildings", "Other Buildings"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = (self.tableView.indexPathForSelectedRow)!
        let place = self.places[indexPath.row]
        
        let vc = segue.destination as! ViewController
        vc.place = place
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.places[indexPath.row]
        return cell
    }

}
