//
//  MyTableViewController.swift
//  NaviBarWithSearchBar
//
//  Created by Tom Lee on 28/11/2017.
//  Copyright © 2017 IOI. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController,UISearchResultsUpdating {
    var songs = ["為愛往前飛", "我愛你這樣深", "難以抗拒你容顏", "流言", "你那麼愛她", "我還是愛你到老", "我是多麼認真對你", "體會", "怎麼開始忘了", "藏經閣", "白天不懂夜的黑"]
    var searchSongs = [String]()
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        searchSongs = songs.filter { (name) -> Bool in
            return name.contains(searchString)
        }
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationController?.navigationBar.prefersLargeTitles = false
        
        //let uiSearchBar = UISearchBar()
        //navigationItem.titleView = uiSearchBar
        //let searchController = UISearchController(searchResultsController: nil)
        //searchController.searchResultsUpdater = self
        //searchController.dimsBackgroundDuringPresentation = false
        
        //navigationItem.searchController = searchController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
/*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if navigationItem.searchController?.isActive == true {
            return searchSongs.count
        } else {
            return songs.count
        }
    }
*/
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        // Configure the cell...

        let cell = tableView.dequeueReusableCell(withIdentifier: "loveSongCell", for: indexPath)
        // Configure the cell…
        if navigationItem.searchController?.isActive == true {
            cell.textLabel?.text = searchSongs[indexPath.row]
        } else {
            cell.textLabel?.text = songs[indexPath.row]
        }
        return cell
 
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
