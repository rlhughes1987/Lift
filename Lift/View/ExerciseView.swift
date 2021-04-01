//
//  ChallengesView.swift
//  Lift
//
//  Created by Richard Hughes on 04/07/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI

struct ExerciseView: View {
    
    @State var exercise: Exercise
    
    var body: some View {
        Content(exercise:$exercise,someAction: someFunction)
    }
    
    func someFunction(){
        //do nothing
    }
}

extension ExerciseView {
    
    struct Content : View {
        
        @Binding var exercise: Exercise
        let someAction: () -> Void
        
        var body: some View {
            VStack {
                Text(exercise.bodyRegion)
                Text(exercise.movement)
                Text(exercise.muscleCategory)
                Text(exercise.muscleSpecific)
                Text(exercise.action)
                Text(exercise.equipment)
                Text(String(exercise.handCount))
                Text(exercise.grip)
                Text(exercise.position)
            }
            
        }
        
    }
    
}
