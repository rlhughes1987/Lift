//
//  ExercisesList.swift
//  Lift
//
//  Created by Richard Hughes on 05/07/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI

struct ExercisesListView: View {
    
    @State var exercises: [Exercise]?
    
    var body: some View {
        Content(exercises: $exercises, someAction: someFunction)
    }
    
    func someFunction(){
        //does nothing
    }
}

extension ExercisesListView {
    
    struct Content : View {
        
        @Binding var exercises: [Exercise]?
        
        var someAction: () -> Void
        
        var body: some View {
            VStack{
                if (self.exercises != nil) {
                    List {
                        
                        ForEach(0..<self.exercises!.count, id: \.self){ row in
                            
                            NavigationLink(
                                
                                destination: ExerciseView(exercise: self.exercises![row])
                                
                            ) {
                                HStack{
                                    
                                    Text(" \(self.exercises![row].muscleCategory)")
                                    Spacer()
                                    Text("\(self.exercises![row].muscleSpecific)")
                                    
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

