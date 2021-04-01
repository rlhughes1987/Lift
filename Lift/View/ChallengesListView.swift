//
//  ChallengesList.swift
//  Lift
//
//  Created by Richard Hughes on 05/07/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI

struct ChallengesListView: View {
    
    @State var challenges: [Challenge]?
    
    var body: some View {
        Content(challenges: $challenges, someAction: someFunction)
    }
    
    func someFunction(){
        //does nothing
    }
}

extension ChallengesListView {
    
    struct Content : View {
        
        @Binding var challenges: [Challenge]?
        
        var someAction: () -> Void
        
        var body: some View {
            VStack{
                if (self.challenges != nil) {
                    List {
                        
                        ForEach(0..<self.challenges!.count, id: \.self){ row in
                            
                            NavigationLink(
                                
                                destination: ChallengeView(challenge: self.challenges![row])
                                
                            ) {
                                HStack{
                                    
                                    Text(" \(self.challenges![row].description)")
                                    Spacer()
                                    Text("\(self.challenges![row].pointsReward)")
                                    
                                }.padding(8).background(Color.gray).cornerRadius(5).foregroundColor(.white)
                            }
                        }
                        
                    }
                } else {
                    Text("Error with Challenge Data")
                }
            }
        }
    }
}

