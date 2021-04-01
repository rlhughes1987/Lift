//
//  TestData.swift
//  Lift
//
//  Created by Richard Hughes on 06/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import Foundation

struct TestData {
    
    static let evidenceJSON = """
    [
        {
            "userId": 1,
            "groupId": 1,
            "challengeRef": "1-1",
            "uploadDate": "2020-08-23 17:00:00",
            "filePath": "http://127.0.0.1:8000/rob1.mp4",
            "evidenceType": "video",
            "likeCount": 11
        },
        {
            "userId": 1,
            "groupId": 1,
            "challengeRef": "2-1",
            "uploadDate": "2020-08-23 17:00:30",
            "filePath": "http://127.0.0.1:8000/rob2.mp4",
            "evidenceType": "video",
            "likeCount": 22
        },
        {
            "userId": 1,
            "groupId": 1,
            "challengeRef: "2-2",
            "uploadDate": "2020-08-23 17:01:00",
            "filePath": "http://127.0.0.1:8000/rob3.mp4",
            "evidenceType": "video",
            "likeCount": 33
        }
    ]
    """.data(using: .utf8)!
    
    static let programJSON = """
    [
        {
           "ref": "1",
           "title": "Shoulders and Back",
           "description": "Work your shoulders and back..",
           "cost": 5,
           "challenges": [
             {
                 "ref": "1-1",
                 "description": "Front raise and Face Pull",
                 "challengeType": "progression",
                 "pointsReward": 15,
                 "exercises": [
                   {
                       "bodyRegion": "Upper",
                       "movement": "Push",
                       "muscleCategory": "Shoulders",
                       "muscleSpecific": "Front Deltoids",
                       "action": "Front raise",
                       "equipment": "Dumbell",
                       "handCount": 1,
                       "grip": "Neutral",
                       "position": "Standing"
                   },
                   {
                       "bodyRegion": "Upper",
                       "movement": "Pull",
                       "muscleCategory": "Shoulders",
                       "muscleSpecific": "Rear Deltoids",
                       "action": "Face Pull",
                       "equipment": "Cable",
                       "handCount": 2,
                       "grip": "Overhand",
                       "position": "Seated"
                   }
                 ]
             }
           ]
        },
        {
           "ref": "2",
           "title": "Shoulders and Back continued",
           "description": "Dumbells and stuff..",
           "cost": 5,
           "challenges": [
             {
                 "ref": "2-1",
                 "description": "blah blah",
                 "challengeType": "progression",
                 "pointsReward": 35,
                 "exercises": [
                   {
                       "bodyRegion": "Upper",
                       "movement": "Push",
                       "muscleCategory": "Shoulders",
                       "muscleSpecific": "Front Deltoids",
                       "action": "Front raise",
                       "equipment": "Dumbell",
                       "handCount": 1,
                       "grip": "Neutral",
                       "position": "Standing"
                   },
                   {
                       "bodyRegion": "Upper",
                       "movement": "Pull",
                       "muscleCategory": "Shoulders",
                       "muscleSpecific": "Upper Trapezius",
                       "action": "Shrug",
                       "equipment": "Barbell",
                       "handCount": 2,
                       "grip": "Pronated",
                       "position": "Standing"
                   }
                 ]
             },
             {
                 "ref": "2-2",
                 "description": "Overhead squat & close grip press ",
                 "challengeType": "progression",
                 "pointsReward": 45,
                 "exercises": [
                   {
                       "bodyRegion": "Compound",
                       "movement": "LegsPushPull",
                       "muscleCategory": "Olympic",
                       "muscleSpecific": "Multiple",
                       "action": "Overhead Squat",
                       "equipment": "Barbell",
                       "handCount": 2,
                       "grip": "Pronated",
                       "position": "Standing"
                   },
                   {
                       "bodyRegion": "Upper",
                       "movement": "Push",
                       "muscleCategory": "Arms",
                       "muscleSpecific": "Triceps",
                       "action": "Close grip press",
                       "equipment": "Dumbell",
                       "handCount": 2,
                       "grip": "Neutral",
                       "position": "Flat Bench"
                   }
                 ]
             }

           ]
        }
    ]
    """.data(using: .utf8)!
    
    
    static let groupJSON = """
    [{
        "id" : 100,
        "name" : "LadsLadsLads",
        "program" : {
            "ref": "2",
            "title": "Shoulders and Back continued",
            "description": "Dumbells and stuff..",
            "cost": 5,
            "challenges": [
              {
                  "ref": "2-1",
                  "description": "blah blah",
                  "challengeType": "progression",
                  "pointsReward": 35,
                  "exercises": [
                    {
                        "bodyRegion": "Upper",
                        "movement": "Push",
                        "muscleCategory": "Shoulders",
                        "muscleSpecific": "Front Deltoids",
                        "action": "Front raise",
                        "equipment": "Dumbell",
                        "handCount": 1,
                        "grip": "Neutral",
                        "position": "Standing"
                    },
                    {
                        "bodyRegion": "Upper",
                        "movement": "Pull",
                        "muscleCategory": "Shoulders",
                        "muscleSpecific": "Upper Trapezius",
                        "action": "Shrug",
                        "equipment": "Barbell",
                        "handCount": 2,
                        "grip": "Pronated",
                        "position": "Standing"
                    }
                  ]
              },
              {
                  "ref": "2-2",
                  "description": "Overhead squat & close grip press ",
                  "challengeType": "progression",
                  "pointsReward": 45,
                  "exercises": [
                    {
                        "bodyRegion": "Compound",
                        "movement": "LegsPushPull",
                        "muscleCategory": "Olympic",
                        "muscleSpecific": "Multiple",
                        "action": "Overhead Squat",
                        "equipment": "Barbell",
                        "handCount": 2,
                        "grip": "Pronated",
                        "position": "Standing"
                    },
                    {
                        "bodyRegion": "Upper",
                        "movement": "Push",
                        "muscleCategory": "Arms",
                        "muscleSpecific": "Triceps",
                        "action": "Close grip press",
                        "equipment": "Dumbell",
                        "handCount": 2,
                        "grip": "Neutral",
                        "position": "Flat Bench"
                    }]
                }]
              },
        "users" : [{
                        "id" : 1,
                        "region" : {
                            "longitude" : -3.39383,
                            "latitude" : 53.32826,
                            "span" : 0.5,
                            "name" : "North Wales"
                        },
                        "completedChallengeRefs" : ["1-1","1-2","1-3","2-1"],
                        "pictureRef" : "richard.jpg",
                        "name" : "Richard Hughes",
                        "regDate" : "2020-06-29 15:00:00"
                    },
                    {
                        "id" : 2,
                        "region" : {
                            "longitude" : -3.39383,
                            "latitude" : 53.32826,
                            "span" : 0.5,
                            "name" : "North Wales"
                        },
                        "completedChallengeRefs" : ["1-1","1-2"],
                        "pictureRef" : "rob.jpg",
                        "name" : "Rob Williams",
                        "regDate" : "2020-06-30 15:00:00"
                    },
                    {
                        "id" : 3,
                        "region" : {
                            "longitude" : -3.39383,
                            "latitude" : 53.32826,
                            "span" : 0.5,
                            "name" : "North Wales"
                        },
                        "completedChallengeRefs" : ["1-1"],
                        "pictureRef" : "dave.jpg",
                        "name" : "Dave Grahams",
                        "regDate" : "2020-07-01 15:05:30"
                    },
                    {
                        "id" : 4,
                        "region" : {
                            "longitude" : -3.39383,
                            "latitude" : 53.32826,
                            "span" : 0.5,
                            "name" : "North Wales"
                        },
                        "completedChallengeRefs" : ["1-1","1-2","2-1","2-2"],
                        "pictureRef" : "veronika.jpg",
                        "name" : "Veronika Orgonova",
                        "regDate" : "2020-06-30 15:00:00"
                    }],
            "pictureRef" : "veronandrich.jpg"
    }]
    """.data(using: .utf8)!
    
    //EXERCISES
    //static let exercise1 : Exercise = Exercise(bodyRegion: "Upper", movement: "Push", muscleCategory: "Shoulders", muscleSpecific: "Front Deltoids", action: "Front raise", equipment: "Dumbell" , handCount: 1, grip: "Neutral" , position: "Standing" )
    
    
    // REGIONS
    static let London = Region(longitude: -0.075450, latitude: 51.549790, name: "London")
    static let Earth = Region(longitude: -0.075450, latitude: 51.549790, name: "Earth")
    static let Wales = Region(longitude: -3.39383, latitude: 53.32826, name: "North Wales")
    
    // USERS
    
    static let Rich : User = User(id: 1, region: TestData.London, completedChallengeRefs: ["1-1","1-2","1-3"], pictureRef: "richard.jpg", name: "Richard Hughes", regDate: "2020-06-29 15:00:00")
    static let Veronika : User = User(id: 2, region: TestData.London, completedChallengeRefs: ["1-1","1-2"], pictureRef: "veronika.jpg", name: "Veronika Orgonova", regDate: "2020-06-29 15:00:00")
    static let Rob : User = User(id: 3, region: TestData.Wales, completedChallengeRefs: ["1-1","1-2","1-3"], pictureRef: "rob.jpg", name: "Rob Williams", regDate: "2020-06-29 15:00:00")
    static let Dave : User = User(id: 4, region: TestData.Wales, completedChallengeRefs: ["1-1","1-2","1-3"], pictureRef: "dave.jpg", name: "Graham Davies", regDate: "2020-06-29 15:00:00")
    
    // GROUPS
    //static var DalstonGroup : UserGroup = UserGroup(id: 5, name: "Dalston Crew", region: TestData.London, users: [TestData.Rich, TestData.Veronika] )
    //static var LadsGroup : UserGroup = UserGroup(id: 6, name: "Lads Lads Lads", region: TestData.Wales, users: [TestData.Dave, TestData.Rob] )
    
    
    
    
    
    
    
    

    

}
