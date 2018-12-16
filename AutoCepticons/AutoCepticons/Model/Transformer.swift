//
//  Transformer.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
enum TransformerTeam: String, Codable {
    case autobot = "A"
    case decepticon = "D"
}

class Transformer: Codable {
    let id: String?
    var name: String
    var team: TransformerTeam
    var strength: Int
    var intelligence: Int
    var speed: Int
    var endurance: Int
    var rank: Int
    var courage: Int
    var firepower: Int
    var skill: Int
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
         team: TransformerTeam,
         strength: Int,
         intelligence: Int,
         speed: Int,
         endurance: Int,
         rank: Int,
         courage: Int,
         firepower: Int,
         skill: Int,
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

    var overallRating: Int {
        return strength + intelligence + speed + endurance + rank + courage + firepower + skill
    }
}
