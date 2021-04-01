//
//  User.swift
//  Lift
//
//  Created by Richard Hughes on 06/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

// IDEA - App originally intended for Weight lifting social competition making. Then made generic to be applicable to any development area, the concept being a user can upload a video of themselves performing a task, and this is then verified by an expert user or peer group. Groups run Programs, users peer review each other and give approvals, users gain points.

import Foundation

protocol Competable : Decodable {
    
    var id: Int { get }
    var name : String { get }
    var pictureRef : String? { get }
    func getScore(_ program: Program) -> Int
    
}


struct User : Competable, Decodable, Identifiable {
    
    //var uid = UUID()   //THIS BREAKS JSON DECODING
    
    let id : Int
    let region : Region
    var completedChallengeRefs : [String]?
    var pictureRef : String?
    let name : String
    let regDate : String
    
    //var myGroupMembershipGroup : UserGroup? //contains a group of groups a user is in.
    //var personalProgram : Program?
    
    func getScore(_ program: Program) -> Int {
        var score = 0
        for challenge in program.challenges {
            for completedchallengeRef in completedChallengeRefs! {
                if completedchallengeRef.isEqual(challenge.ref) {
                    score += challenge.pointsReward
                }
            }
        }
        return score
    }
    
    mutating func completeChallenge(challenge: Challenge){
        completedChallengeRefs!.append(challenge.ref)
        
        print("Adding \(challenge.pointsReward) points to user id \(id)")
    }

}

struct Region : Decodable {
    
    let longitude : Double
    let latitude : Double
    var span: Double = 0.5 //fixed span
    let name: String
    
}

struct UserGroup : Competable, Decodable, Identifiable {

    //var uid = UUID()
    let id : Int
    let name : String
    //let region: Region?
    var program: Program?
    
    var users : [User]
    //var members : [Competable]    NEED TO READ UP ON GENERICS with DECODABLE
    var pictureRef : String?
    
    func getScore(_ program: Program) -> Int {
        var score = 0
        
        for user in self.users {
            score += user.getScore(program)
        }
        return score
    }
    
    mutating func addMember(_ user: User) {  //these should be making web/db requests.
        
            users.append(user)
        
    }
    
    mutating func removeUser(_ user: User) {   //these should be making web/db requests
        print("Starting remove / Members data: \(self.users)")
        guard let index = users.firstIndex(where: { $0.id == user.id })
                  else { return }
        print("Removing member id:\(user.id) from group id:\(id) at index:\(index)")
        self.users.remove(at: index)
    }
    
    func size() -> Int {
        return users.count
    }

}

extension UserGroup {
    enum Kind: String, Codable, CaseIterable {
        case regional
        case custom
    }
}

//PROGRAM STUFF
struct Program : Decodable {
    
    //Static
    let ref : String
    let title : String
    let description : String
    let cost: Int
    let challenges: [Challenge]
    
    //Methods
    func length() -> Int {
        return challenges.count
    }
}

struct Challenge : Decodable {
    
    //Static
    let ref : String
    let description : String
    let challengeType : ChallengeType
    let pointsReward : Int
    let exercises: [Exercise]
    
    //Variable
    //var markedComplete : Bool = false
    
    //Optionals
    //var demoPath : String?
    //var evidence : Evidence?
    
    //Methods
    //func qualifiesForReward() -> Bool {
    //    return markedComplete //&& evidence != nil //no reward unless evidence provided.
    //}
    
    //mutating func markComplete() {
     //   self.markedComplete = true
    //}
    
}
extension Challenge {
    enum ChallengeType: String, Codable, CaseIterable {
        case progression //just meet the challenge criteria
        case highestMetric  //furthest ran in 5 minutes, highest weight

    }
}

//EVIDENCE
struct Evidence : Decodable {
    let userId: Int
    let groupId: Int
    let challengeRef: String
    let uploadDate: String
    let filePath: String
    let evidenceType: EvidenceType
    var likeCount: Int
}
extension Evidence {
    enum EvidenceType: String, Codable, CaseIterable {
        case video
        case image
        case groupWitnessed
    }
}

//EXERCISES
struct Exercise : Decodable{
    
    // body region
    let bodyRegion: String  //Upper,Lower
    // movement
    let movement: String    //Push,Pull
    // muscle category
    let muscleCategory: String     //Shoulders
    // muscle specific
    let muscleSpecific: String   //Front Deltoids
    // action
    let action: String    //Front raise
    // equipment
    let equipment: String    //Dumbells (DB), Kettlebells (KB)
    // hand count
    let handCount: Int    // 1
    // grip
    let grip: String   //Neutral, Supinated, Pronated
    // position
    let position: String    //Standing, Seated,
  
    // e.g. Upper,Push,Shoulders,Front Deltoids,Front raise,DB,1,Neutral,Standing
}




