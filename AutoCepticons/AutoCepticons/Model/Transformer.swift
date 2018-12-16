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
    var name: String
    var team: String
    var strength: String
    var intelligence: String
    var speed: String
    var endurance: String
    var rank: String
    var courage: String
    var firepower: String
    var skill: String
    var teamIconURLString: String?
    var teamIconURL: URL? {
        return URL(string: teamIconURLString ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case team = "team"
        case strength = "strength"
        case intelligence = "intelligence"
        case speed = "speed"
        case endurance = "endurance"
        case rank = "rank"
        case courage = "courage"
        case firepower = "firepower"
        case skill = "skill"
        case teamIconURLString = "team_icon"
    }

    init(id: String? = nil,
         name: String,
         team: String,
         strength: String,
         intelligence: String,
         speed: String,
         endurance: String,
         rank: String,
         courage: String,
         firepower: String,
         skill: String,
         teamIconURLString: String? = nil) {
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
        self.teamIconURLString = teamIconURLString
    }
}
