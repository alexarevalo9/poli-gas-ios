//
//  Poligas.swift
//  Poligas
//
//  Created by Alex Arevalo on 2/11/20.
//  Copyright © 2020 Quantum. All rights reserved.
//

import Foundation

public struct Poligas: Codable {

    let name: String
    let state: String?
    let country: String?
    let isCapital: Bool?
    let population: Int64?

    enum CodingKeys: String, CodingKey {
        case name
        case state
        case country
        case isCapital = "capital"
        case population
    }

}
