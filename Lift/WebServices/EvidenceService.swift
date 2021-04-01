//
//  GroupInfoService.swift
//  Lift
//
//  Created by Richard Hughes on 14/07/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import Combine

class EvidenceService : ObservableObject {
    
    @Published var evidenceData : [Evidence]?
    
    init(){
        let decoder = JSONDecoder()
        self.evidenceData = try? decoder.decode([Evidence].self, from: TestData.evidenceJSON)
        
    }
    
}
