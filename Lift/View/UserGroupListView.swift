//
//  GroupListView.swift
//  Lift
//
//  Created by Richard Hughes on 14/07/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import Combine

struct UserGroupListView: View {
    
    @ObservedObject var groupInfoService = GroupInfoService()
    
    var body: some View {
       Content(groups: $groupInfoService.groupData, someAction: makeURLRequest)
    }
    
    func makeURLRequest() {
        //TBD
    }
}


extension UserGroupListView {
    
    struct Content : View {
        
        @Binding var groups: [UserGroup]?
        
        var someAction: () -> Void
        
        var body: some View {
            VStack{
                if (self.groups != nil) {
                    List {
                        
                        ForEach(0..<self.groups!.count, id: \.self){ row in
                            
                            NavigationLink(
                                
                                destination: UserGroupView(group: self.groups![row], inListForm: false)
                                
                            ) {
                                UserGroupView(group:self.groups![row], inListForm: true)
                                /*
                                HStack{
                                    
                                    Text(" \(self.groups![row].name)")
                                    Spacer()
                                    Text("\(self.groups![row].users.count)")
                                    
                                }.padding(8).background(Color.gray).cornerRadius(5).foregroundColor(.white)
 */
                                
                            }
                        }
                        
                    }
                } else {
                    Text("Error with Group Data")
                }
            }
        }
    }
}

