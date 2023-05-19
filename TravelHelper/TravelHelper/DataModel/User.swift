//
//  User.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/16/23.
//

import Foundation

struct User: Codable {
    var name: String
    var bio: String
    var date: Date
    
    init?(entity: ProfileEntity) {
        guard let name = entity.name, let bio = entity.bio,
              let date = entity.date else {
            return nil
        }
        
        self.name = name
        self.bio = bio
        self.date = date
    }
    
    init(name: String, bio: String, date: Date) {
        self.name = name
        self.bio = bio
        self.date = date
    }
}
