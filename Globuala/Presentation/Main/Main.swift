//
//  Main.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

import SwiftUI

struct MainFlowView: View {
    @StateObject private var coordinator = DI.shared.resolve(Coordinator.self)
    
    var body: some View {
        
        NavigationSplitView {
            coordinator.build(page: .cities)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.buildSheet(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                    coordinator.buildCover(cover: item)
                }
        } detail: {
            Text("Detail View")
                
        }


    }
}

#Preview {
    AppCoordinatorView()
}
