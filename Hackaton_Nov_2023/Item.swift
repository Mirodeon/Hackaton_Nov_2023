//
//  Item.swift
//  Hackaton_Nov_2023
//
//  Created by Student07 on 07/11/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
