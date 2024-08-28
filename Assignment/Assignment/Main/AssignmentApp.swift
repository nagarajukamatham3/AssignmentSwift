//
//  AssignmentApp.swift
//  Assignment
//
//  Created by Raju on 28/08/24.
//

import SwiftUI

@main
struct AssignmentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AssignmentView(viewModel: AssignmentViewModel(model: AssignmentModel()))
        }
    }
}
