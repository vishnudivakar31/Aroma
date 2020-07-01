//
//  HomeViewController.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/29/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var postARecipeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private let homeModel = HomeModel()
    
    var data = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designPage()
        homeModel.delegate = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.HomePage.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        homeModel.addSnapshotListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        homeModel.listener?.remove()
    }
    
    func designPage() {
        postARecipeView.layer.borderWidth = 1.0
        postARecipeView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        postARecipeView.layer.cornerRadius = 5.0
        postARecipeView.layer.shadowColor = UIColor.lightGray.cgColor
        postARecipeView.layer.shadowOpacity = 1
        postARecipeView.layer.shadowOffset = .zero
        postARecipeView.layer.shadowRadius = 5

    }
    
    func loadImageFromUrl(_ url: String) -> UIImage? {
        if let safeurl = URL(string: url), let data = try? Data(contentsOf: safeurl) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
    func convertTimeIntervalToDateTime(_ timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: date)
    }
    
    @IBAction func postAReceipeTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: Constants.PostReceipe.segueIdentifier, sender: self)
    }
}

// MARK:- Tableview delegate and datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.HomePage.cellIdentifier, for: indexPath) as! HomeTableViewCell
        let recipe = data[indexPath.row]
        cell.recipeName.text = recipe.name
        cell.uiImageView.image = loadImageFromUrl(recipe.imageUrl ?? "") ?? UIImage(named: "sampleRecipeImage")
        cell.likesLabel.text = String(recipe.likes)
        cell.dislikesLabel.text = String(recipe.dislikes)
        cell.postedByLabel.text = "Posted by \(recipe.postedBy!.lowercased())"
        cell.postedDate.text = convertTimeIntervalToDateTime(recipe.postedOn)
        return cell
    }
}

// MARK:- HomeModel Protocol
extension HomeViewController: HomeModelProtocol {
    func recipeListUpdated(recipeList: [Recipe]) {
        data = recipeList
        data.sort {$0.postedOn > $1.postedOn}
        tableView.reloadData()
    }
    
    func homeModelErrorRaised(errorMessage: String) {
        let alertController = UIAlertController(title: "Warning", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}
