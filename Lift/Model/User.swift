//
//  User.swift
//  Lift
//
//  Created by Richard Hughes on 06/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import Foundation

protocol Competable {
    
    var name: String { get }
    func getScore() -> Int

}

struct User : Identifiable, Codable, Competable {
    let id = UUID()
    let name : String
    func getScore() -> Int {
        return 1
    }
    // let location = Location
    // let videos = Videos[]
    // let programs = Program[]
    // let currentProgramIndex
    
}

struct Group : Identifiable, Competable {
    
    let id = UUID()
    let name : String
    var members : [Competable]
    
    func getScore() -> Int {
        var score = 0
        for member in self.members {
            score += member.getScore()
        }
        return score
    }
    
    mutating func rankMembers() {

        self.members = members.sorted(by: { $0.getScore() < $1.getScore()})
    }
    
}

extension Group {
    enum Kind: String, Codable, CaseIterable {
        case custom
        case regional
    }
}


struct Program : Identifiable {
    let id = UUID()
    let name : String
    let cost : Int
    let stages : [Stage]
    //let images = Image[]
}

struct Stage : Codable {
    let id = UUID()
    let name : String
    let image_path : String
    let reward : Int
}


