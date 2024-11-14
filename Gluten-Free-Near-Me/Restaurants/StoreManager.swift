//
//  StoreManager.swift
//  Gluten-Free-Near-Me
//
//  Created by Daniel S. on 11/4/24.
//

import SwiftData

//https://www.hackingwithswift.com/quick-start/swiftdata/how-to-read-the-contents-of-a-swiftdata-database-store

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
