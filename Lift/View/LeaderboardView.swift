//
//  ContentView.swift
//  Lift
//
//  Created by Richard Hughes on 06/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import Combine

struct LeaderboardView: View {
    
    //@EnvironmentObject private var stateController: StateController
    
    @State var competitors : [Competable]
    @State var program : Program?
    
    var body: some View {

        Content(competitors: $competitors, program: $program, buttonAction: someCallbackFunction)
        
    }
    
    //TEST FUNCTIONS
    func someCallbackFunction() {
        //Some function that does something
    }
    
}

extension LeaderboardView  {

    struct Content: View {
        
        @Binding var competitors : [Competable]
        @Binding var program : Program?
        
        let buttonAction: () -> Void  //method will be passed in by State Controller
       
        var body: some View {
            
            //if no program, no leaderboard
            Group {
                if program != nil {
                    VStack{
                        Text("Leaderboard")
                        Text(program!.title).font(.title)
                        List {
                            
                            ForEach(0..<self.competitors.count, id: \.self){ row in
                                
                                NavigationLink(
                                    
                                    destination: CompetitorView(competitor: self.rankedCompetitors[row])
                                    
                                ) {
                                    HStack{
                                        
                                        Text(" \(self.rankedCompetitors[row].name)")
                                        Spacer()
                                        Text("\(self.rankedCompetitors[row].getScore(self.program!))")
                                        
                                    }.padding(8).background(Color.gray).cornerRadius(5).foregroundColor(.white)
                                }
                            }
                            
                        }
                        
                        Spacer()
                        NewEvidenceButton(title: "New", action: buttonAction)

                    }
                } else {
                    Text("Set a program")
                }
            }
            
        }
        
        var rankedCompetitors : [Competable] {
            competitors.sorted(by: { $0.getScore(self.program!) >= $1.getScore(self.program!) })
        }
    }
    
}

struct NewEvidenceButton: View {
    
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
                .font(.headline).foregroundColor(.black)
            }
            .padding(.trailing, 20.0)
        }
        
    }
}
