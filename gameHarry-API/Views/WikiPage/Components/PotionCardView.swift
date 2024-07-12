//
//  PotionCardView.swift
//  gameHarry-API
//
//  Created by Luciana Adrião on 11/07/24.
//

import SwiftUI
import Combine

struct PotionCardView: View {
    let potion: Potion
    @StateObject private var viewModel = PotionImageViewModel()

    var potionsFromPotterDB: [ItemData] // Passamos as poções carregadas do banco de dados

    var body: some View {
            CardView(cardImage: "",
                     imageURL: viewModel.imageURL,
                     name: potion.name,
                     subname: potion.effect ?? "No Effect Found")
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
        .task {
            await viewModel.fetchPotionImage(potion.name, potionsFromPotterDB: potionsFromPotterDB)
        }
    }
}

class PotionImageViewModel: ObservableObject {
    @Published var imageURL: String = "default-image-url"

    func fetchPotionImage(_ itemName: String, potionsFromPotterDB: [ItemData]) async {
        let slug = convertToSlug(itemName)
        if let potion = potionsFromPotterDB.first(where: { $0.attributes.slug == slug }) {
            DispatchQueue.main.async {
                self.imageURL = potion.attributes.image ?? "default-image-url"
            }
        } else {
            DispatchQueue.main.async {
                self.imageURL = "default-image-url"
            }
        }
    }

    private func convertToSlug(_ name: String) -> String {
        let regex = try! NSRegularExpression(pattern: "(?i)([a-z]+(?:\\s+[a-z]+)*)(?=\\s+em\\s+([a-z]+(?:-[a-z]+)*))", options: [])
        let range = NSRange(location: 0, length: name.utf16.count)
        var slug = regex.stringByReplacingMatches(in: name, options: [], range: range, withTemplate: "")
        slug = slug.replacingOccurrences(of: "'", with: "-")
        slug = slug.replacingOccurrences(of: " ", with: "-")
        return slug.lowercased()
    }
}

#Preview {
    PotionCardView(potion: Potion(id: "",
                                  name: "Ageing Potion",
                                  difficulty: "Advanced",
                                  effect: "Ages the user",
                                  ingredients: []),
                   potionsFromPotterDB: [
                    ItemData(id: "",
                         type: .potion,
                         attributes: .init(slug: "",
                                           characteristics: "",
                                           difficulty: "",
                                           effect: "",
                                           image: "",
                                           inventors: "",
                                           ingredients: "",
                                           manufacturers: "", name: "", sideEffects: "", time: "", wiki: ""))])
}
