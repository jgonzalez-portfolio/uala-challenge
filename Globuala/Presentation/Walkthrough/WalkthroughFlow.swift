//
//  WalkthroughFlow.swift
//  Globuala
//
//  Created by Joni Gonzalez on 19/05/2025.
//

import SwiftUI

struct WalkthroughFlow: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .walkthrough)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.buildSheet(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                    coordinator.buildCover(cover: item)
                }
        }
    }
}

#Preview {
    WalkthroughFlow()
}
