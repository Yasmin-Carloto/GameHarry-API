//
//  IngridientModel.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 09/07/24.
//

import Foundation
import SwiftUI

struct Ingredients: Codable, Transferable, Identifiable, Hashable {
    let id: String
    let name: String
    
    static var transferRepresentation: some TransferRepresentation{
        CodableRepresentation(contentType: .ingredient)
    }
}
