//
//  Activity.swift
//  TravelHelper
//
//  Created by Qin Geng on 5/10/23.
//

import Foundation

// Structs are value types
// - Bool, Int, Double

struct Activity: Codable {
    var title: String
    var date: Date
    var isDone: Bool
    
    init?(entity: ActivityEntity) {
        guard let title = entity.title,
            let date = entity.date else {
            return nil
        }

        self.title = title
        self.date = date
        self.isDone = entity.isDone
    }
    
    init(title: String, date: Date, isDone: Bool) {
        self.title = title
        self.date = date
        self.isDone = isDone
    }
}
