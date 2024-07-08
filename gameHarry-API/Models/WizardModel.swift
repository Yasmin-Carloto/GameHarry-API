//
//  WizardModel.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 08/07/24.
//

import Foundation

struct Wizard: Decodable, Identifiable {
    let id: String
    let firstName: String?
    let lastName: String
}
