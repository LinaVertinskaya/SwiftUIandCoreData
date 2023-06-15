//
//  OrderSwiftUICoreDataApp.swift
//  OrderSwiftUICoreData
//
//  Created by Лина Вертинская on 2.08.22.
//

import SwiftUI

@main
struct OrderSwiftUICoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
