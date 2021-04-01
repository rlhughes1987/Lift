//
//  ProgramInfoService.swift
//  Lift
//
//  Created by Richard Hughes on 21/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import Combine

class ProgramInfoService : ObservableObject {
    
    @Published var programData : [Program]?
    
    init(){
        let decoder = JSONDecoder()
        self.programData = try? decoder.decode([Program].self, from: TestData.programJSON)

    }
    
}
 

