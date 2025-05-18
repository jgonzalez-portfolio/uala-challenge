//
//  ContentView.swift
//  Globuala
//
//  Created by Joni Gonzalez on 16/05/2025.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            let networking = NetworkManager()
            Task {
                let cities =  await networking.requestCities()
                print(cities)
            }
        }
    }
}

#Preview {
    ContentView()
}
