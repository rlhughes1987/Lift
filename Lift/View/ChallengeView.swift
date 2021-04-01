//
//  ChallengesView.swift
//  Lift
//
//  Created by Richard Hughes on 04/07/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI

struct ChallengeView: View {
    
    @State var challenge: Challenge
    
    var body: some View {
        Content(challenge:$challenge,someAction: someFunction)
    }
    
    func someFunction(){
        //do nothing
    }
}

extension ChallengeView {
    
    struct Content : View {
        
        @Binding var challenge: Challenge
        let someAction: () -> Void
        
        var body: some View {
            VStack {
                ExercisesListView(exercises: challenge.exercises )
            }
            
        }
        
    }
    
}

