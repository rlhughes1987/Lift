//
//  ContentView.swift
//  Lift
//
//  Created by Richard Hughes on 06/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject private var stateController: StateController

    var body: some View {
        
        NewStageCompletedButton(title: "Complete Stage: 1-3", action: newCompletedStage)
    }
}

extension ContentView  {
    
    let competitors : [Competable]
    let newCompletedStage: () -> Void  //method will be passed in by State Controller
    
    struct Content: View {
        var body: some View {
            VStack{
                Text("ContentView")
            }
        }
    }
    
    mutating func rankMembers(_ program: Program) {

        self.members = members.sorted(by: { $0.getScore(program) < $1.getScore(program)})
    }
    
}

struct NewStageCompletedButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text(title)
                }
                .font(.headline)
            }
            .padding(.trailing, 20.0)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
