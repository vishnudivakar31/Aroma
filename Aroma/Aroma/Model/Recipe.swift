//
//  Recipe.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/30/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import Foundation

struct Recipe: Codable {
    var name: String
    var cookingTime: Int
    var ingredients: String
    var steps: String
    var imageUrl: String?
    var imageData: Data?
    var likes: Int
    var dislikes: Int
    var postedOn: TimeInterval
    var userId: String?
    var postedBy: String?
    var likedBy: [String]
    var dislikedBy: [String]
    var documentID: String?
    var averageRating: Float {
        return Float(likes + dislikes) / Float(2)
    }
    var averageRatingLabel: String {
        return String(format: "%.2f", averageRating)
    }
    var cookingTimeLabel: String {
        return "\(cookingTime) min."
    }
}
