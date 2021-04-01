//
//  GroupInfoService.swift
//  Lift
//
//  Created by Richard Hughes on 14/07/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import Combine

class GroupInfoService : ObservableObject {
    
    @Published var groupData : [UserGroup]?
    
    init(){
        let decoder = JSONDecoder()
        self.groupData = try? decoder.decode([UserGroup].self, from: TestData.groupJSON)
        
    }
    
}
