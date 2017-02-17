//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var GHTableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GHTableView.delegate = self
        GHTableView.dataSource = self
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repos != nil {
            return repos!.count
        }
        else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GHTableView.dequeueReusableCell(withIdentifier: "GHTableViewCell", for: indexPath) as! GHTableViewCell
        
        cell.nameLabel.text = repos[indexPath.row].name
        cell.ownerLabel.text = repos[indexPath.row].ownerHandle
        cell.starsLabel.text = "\(repos[indexPath.row].stars)"
        cell.forksLabel.text = "\(repos[indexPath.row].forks)"
        cell.descriptionLabel.text = repos[indexPath.row].desc
        let imageRequest = URL(string: repos[indexPath.row].ownerAvatarURL!)
        cell.avatarImage.setImageWith(imageRequest!)
        cell.starsIcon.image = UIImage(named: "star")
        cell.forksIcon.image = UIImage(named: "fork")
        
        return cell
    }
    
    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            self.repos = newRepos
            
            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            self.GHTableView.reloadData()

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error!)
        })
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
