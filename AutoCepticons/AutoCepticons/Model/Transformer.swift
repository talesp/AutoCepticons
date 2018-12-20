//
//  Transformer.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import CoreData

enum TransformerTeam: String, Codable {
    case autobot = "A"
    case decepticon = "D"
}

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

@objc(Transformer)
final class Transformer: NSManagedObject, Codable {
    @NSManaged var id: String?
    @NSManaged var name: String
    @NSManaged var teamString: String
    var team: TransformerTeam {
        get {
            return TransformerTeam(rawValue: self.teamString)!
        }
        set {
            self.teamString = newValue.rawValue
        }
    }
    @NSManaged var strength: Int32
    @NSManaged var intelligence: Int32
    @NSManaged var speed: Int32
    @NSManaged var endurance: Int32
    @NSManaged var rank: Int32
    @NSManaged var courage: Int32
    @NSManaged var firepower: Int32
    @NSManaged var skill: Int32
    @NSManaged var teamIconURLString: String?
    @NSManaged var teamIcon: Data?

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

    convenience init(id: String? = nil,
         name: String,
         team: TransformerTeam,
         strength: Int32,
         intelligence: Int32,
         speed: Int32,
         endurance: Int32,
         rank: Int32,
         courage: Int32,
         firepower: Int32,
         skill: Int32,
         teamIconURLString: String? = nil,
         managedObjectContext: NSManagedObjectContext) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Transformer", in: managedObjectContext) else {
                fatalError("Failed to create Transformer")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        self.id = id
        self.name = name
        self.team = team
        self.strength = strength
        self.intelligence = intelligence
        self.speed = speed
        self.endurance = endurance
        self.rank = rank
        self.courage = courage
        self.firepower = firepower
        self.skill = skill
        self.teamIconURLString = teamIconURLString
    }

    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Transformer", in: managedObjectContext) else {
                fatalError("Failed to decode Transformer")
        }

        self.init(entity: entity, insertInto: nil)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.team = try container.decode(TransformerTeam.self, forKey: .team)
        self.strength = try container.decode(Int32.self, forKey: .strength)
        self.intelligence = try container.decode(Int32.self, forKey: .intelligence)
        self.speed = try container.decode(Int32.self, forKey: .speed)
        self.endurance = try container.decode(Int32.self, forKey: .endurance)
        self.rank = try container.decode(Int32.self, forKey: .rank)
        self.courage = try container.decode(Int32.self, forKey: .courage)
        self.firepower = try container.decode(Int32.self, forKey: .firepower)
        self.skill = try container.decode(Int32.self, forKey: .skill)
        self.teamIconURLString = try container.decodeIfPresent(String.self, forKey: .teamIconURLString)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(team, forKey: .team)
        try container.encode(strength, forKey: .strength)
        try container.encode(intelligence, forKey: .intelligence)
        try container.encode(speed, forKey: .speed)
        try container.encode(endurance, forKey: .endurance)
        try container.encode(rank, forKey: .rank)
        try container.encode(courage, forKey: .courage)
        try container.encode(firepower, forKey: .firepower)
        try container.encode(skill, forKey: .skill)
        try container.encode(teamIconURLString, forKey: .teamIconURLString)
}

    var overallRating: Int {
        return Int(strength + intelligence + speed + endurance + firepower)
    }
}

extension Transformer {
    @nonobjc public class func fr() -> NSFetchRequest<Transformer> {
        return NSFetchRequest<Transformer>(entityName: "Transformer")
    }
}
