//
//  ChallengesView.swift
//  Lift
//
//  Created by Richard Hughes on 04/07/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI

struct UserGroupView: View {
    
    @State var group: UserGroup
    
    var inListForm : Bool

    var body: some View {
        Group {
            if self.inListForm {
                ListFormContent(group:$group,someAction: someFunction)
            } else {
                Content(group:$group,someAction: someFunction)
            }
        }
    }
    
    func someFunction(){
        //do nothing
    }
}

extension UserGroupView {
    
    struct Content : View {
        
        @Binding var group: UserGroup
        let someAction: () -> Void
        
        var body: some View {
            VStack {
                Text(group.name).font(.title)
                ProgressChartView()
                Spacer()
                LeaderboardView(competitors: group.users, program: group.program)
                
            }
                
        }
        
    }

    struct ListFormContent : View {
        
        @Binding var group: UserGroup
        
        let someAction: () -> Void
        
        var body: some View {
            
            HStack(alignment: .center){
                CircleImage(imageName: self.group.pictureRef)
                Text(" \(self.group.name)")
                Spacer()
                Text("\(self.group.size())")
                
            }.padding([.trailing],50).background(Color.gray).cornerRadius(5).foregroundColor(.white)
                
        }
    }
}
