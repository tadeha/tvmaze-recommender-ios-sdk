//
//  ViewController.swift
//  Test
//
//  Created by Alireza on 11/12/21.
//
import TVShowRecommender
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    var shows: [TVShow] = [] {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    var isTrends: Bool = false
    
    @IBAction func searchButtonDidTap(_ sender: UIButton) {
        if let showId = Int(searchTextField.text ?? "") {
            search(for: showId)
            view.endEditing(true)
        } else {
            print("Invalid Show ID!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        searchButton.layer.cornerRadius = 10
    }
    
    func search(for showId: Int) {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        TVShowRecommender.shared.getRecommendation(for: showId, numberOfRecs: 10) { shows, isTrends  in
            self.isTrends = isTrends
            self.shows = shows ?? []
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTableViewCell", for: indexPath) as! ShowTableViewCell
        let cellData = shows[indexPath.row]
        cell.nameLabel.text = cellData.name
        cell.idLabel.text = cellData.id.description
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isTrends {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
            label.textAlignment = .center
            label.textColor = .systemRed
            label.text = "No result, These are trending shows!!"
            return label
        }
        return nil
    }
}
