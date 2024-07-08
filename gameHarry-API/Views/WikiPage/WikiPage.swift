//
//  WikiPage.swift
//  gameHarry-API
//
//  Created by User on 05/07/24.
//

import SwiftUI

struct WikiPage<T: Decodable & Identifiable>: View {
    var endpoint: Endpoint
    @State private var items:[T] = []
    
    var body: some View {
        NavigationStack {
            List(items) { item in
                Text(String(describing: item))
            }
            .navigationTitle("Wiki")
        }
        .task {
            do {
                try await fetchData()
            } catch {
                print("Error fetching data")
            }
        }
    }
    private func fetchData() async throws {
        do {
            items = try await ApiServices.shared.fetchData(from: endpoint)
            print(items)
        } catch {
            print("Error fetching data: \(error)")

        }
    }
}

//#Preview {
//    WikiPage()
//}
