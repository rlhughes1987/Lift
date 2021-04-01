//
//  ProgramVIew.swift
//  Lift
//
//  Created by Richard Hughes on 04/07/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI

struct ProgramView: View {
    
    @State var program: Program
    
    var body: some View {
        Content(program: $program)
    }
}

extension ProgramView {
    
    struct Content: View {
        @Binding var program: Program
        var body: some View {
            VStack {
                //Program info
                Text(self.program.title)
                
                Spacer()
                
                //ChallengesList
                ChallengesListView(challenges: self.program.challenges)
            }
            
        }
    }
    
}



