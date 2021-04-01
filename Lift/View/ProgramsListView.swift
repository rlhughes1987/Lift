//
//  ProgramView.swift
//  Lift
//
//  Created by Richard Hughes on 21/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import Combine

struct ProgramsListView: View {
    
    @ObservedObject var programInfoService = ProgramInfoService()
    
    var body: some View {
       Content(programs: $programInfoService.programData, someAction: makeURLRequest)
    }
    
    func makeURLRequest() {
        //TBD
    }
}


extension ProgramsListView {
    
    struct Content : View {
        
        @Binding var programs: [Program]?
        
        var someAction: () -> Void
        
        var body: some View {
            VStack{
                if (self.programs != nil) {
                    List {
                        
                        ForEach(0..<self.programs!.count, id: \.self){ row in
                            
                            NavigationLink(
                                
                                destination: ProgramView(program: self.programs![row])
                                
                            ) {
                                HStack{
                                    
                                    Text(" \(self.programs![row].title)")
                                    Spacer()
                                    Text("\(self.programs![row].cost)")
                                    
                                }.padding(8).background(Color.gray).cornerRadius(5).foregroundColor(.white)
                            }
                        }
                        
                    }
                } else {
                    Text("Error with Program Data")
                }
            }
        }
    }
}
