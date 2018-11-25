//
//  Transformer.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

class Transformer: Codable {
    let id: String?
    let courage: String
    let endurance: String
    let firepower: String
    let intelligence: String
    let name: String
    let rank: String
    let skill: String
    let speed: String
    let strength: String
    let team: String
    let teamIcon: String

    enum CodingKeys: String, CodingKey {
        case courage = "courage"
        case endurance = "endurance"
        case firepower = "firepower"
        case id = "id"
        case intelligence = "intelligence"
        case name = "name"
        case rank = "rank"
        case skill = "skill"
        case speed = "speed"
        case strength = "strength"
        case team = "team"
        case teamIcon = "team_icon"
    }

    init(id: String?,
         courage: String,
         endurance: String,
         firepower: String,
         intelligence: String,
         name: String,
         rank: String,
         skill: String,
         speed: String,
         strength: String,
         team: String,
         teamIcon: String) {
        self.courage = courage
        self.endurance = endurance
        self.firepower = firepower
        self.id = id
        self.intelligence = intelligence
        self.name = name
        self.rank = rank
        self.skill = skill
        self.speed = speed
        self.strength = strength
        self.team = team
        self.teamIcon = teamIcon
    }
}
