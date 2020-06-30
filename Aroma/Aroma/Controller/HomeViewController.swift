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
    
    var data = [[
        "imageUrl": "https://www.google.com/url?sa=i&url=https%3A%2F%2Frecipes.timesofindia.com%2Frecipes%2Fmuradabadi-chicken-biryani%2Frs69038542.cms&psig=AOvVaw1Q3X6QUozI-qIPRZPVhTDO&ust=1593535385608000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIjSiIe8p-oCFQAAAAAdAAAAABAH",
        "recipeName": "Biriyani",
        "postedBy": "Vishnu Divakar",
        "postedDate": 1593449045810,
        "likes": 102,
        "dislikes": 10
    ], [
        "imageUrl": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fskinnyms.com%2Frestaurant-style-chicken-fried-rice%2F&psig=AOvVaw2F5oHK67N_uhl_NekyZOAE&ust=1593536185045000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPCxm4q_p-oCFQAAAAAdAAAAABAD",
        "recipeName": "Fried Rice",
        "postedBy": "Tripti Tiwari",
        "postedDate": 1593449046810,
        "likes": 313,
        "dislikes": 24
    ]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designPage()
        // tableView.rowHeight = 200
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.HomePage.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
        return cell
    }
    
    
}
