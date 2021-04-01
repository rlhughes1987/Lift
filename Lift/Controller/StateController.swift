//
//  StateController.swift
//  Lift
//
//  Created by Richard Hughes on 06/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import Foundation
import Combine
import UIKit

class StateController : ObservableObject {
    
    
    @Published var programInScope: Program?
    @Published var groupInScope: UserGroup?
    @Published var userInView: User?
    
    init(){
        
    }
    
    //var anyCancellable: AnyCancellable? = nil
    
    func completeStage(user: User, challenge: Challenge) { //
        
        if groupInScope != nil {
            guard let index = self.groupInScope!.users.firstIndex(where: { $0.id == user.id })
                else { return }   //finds index user is at in competitors data
            
            self.groupInScope!.users[index].completeChallenge(challenge: challenge)
        } else {
            print("Error: No group in scope")
        }
        
        
    }
    
    func removeGroupUser(user: User){
        if groupInScope != nil {
            self.groupInScope!.removeUser(user)
        } else
        {
            print("Error: No group in scope")
        }
        
    }

}
