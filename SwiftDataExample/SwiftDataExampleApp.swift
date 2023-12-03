//
//  SwiftDataExampleApp.swift
//  SwiftDataExample
//
//  Created by Eugene Demenko on 03.12.2023.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataExampleApp: App {
//    let container: ModelContainer = {
//        let scheme = Schema([Expense.self])
//        let container = try! ModelContainer(for: scheme, configurations: [])
//        return container
//    }()
    
   
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Expense.self])
    }
}
