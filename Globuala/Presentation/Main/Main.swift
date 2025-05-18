//
//  Main.swift
//  Globuala
//
//  Created by Joni Gonzalez on 18/05/2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        VStack {
            Spacer()
            Button {
                coordinator.push(page: .login)
            } label: {
                Text("Comencemos")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(16)
            }
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .clipShape(.buttonBorder)
        }
        .padding(16)
    }
}

#Preview {
    CoordinatorView()
}
