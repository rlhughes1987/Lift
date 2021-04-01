//
//  LoginView.swift
//  Lift
//
//  Created by Richard Hughes on 14/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import AVKit
import AVFoundation

struct LoginView: View {
    
    @State var username = ""
    @State var password = ""
    
    //@EnvironmentObject private var stateController: StateController
    
    @ObservedObject var loginRequest: LoginRequest = LoginRequest()

    var body: some View {
        Content(username: $username, password: $password, success: $loginRequest.success, loggedInID: $loginRequest.loggedInID, loginButtonAction: sendLoginRequest )
    }
    
    func sendLoginRequest() {
        //let loginRequest = LoginRequest(username: username, password: password)
        self.loginRequest.send(username: self.username, password: self.password )
        
    }
    
}


extension LoginView {
    
    struct Content: View {
        
        @Binding var username : String
        @Binding var password : String
        @Binding var success: Bool
        @Binding var loggedInID: Int
        
        let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 0.5)
        
        let loginButtonAction: () -> Void
        
        var body: some View {
            Group {
                if !(self.success) {
                    //ENTRY - LOGIN SCREEN
                    ZStack{
                        PlayerView().edgesIgnoringSafeArea(.all)
                        VStack{
                            Text("LIFT").padding([.vertical],30).foregroundColor(Color.black).font(.largeTitle)
                            HStack{
                                VStack{

                                    TextField("Username", text: $username).padding().background(lightGreyColor).cornerRadius(5.0)
                                    TextField("Password", text: $password).padding().background(lightGreyColor).cornerRadius(5.0)
                                }
                            }.padding([.leading,.trailing],25)
                            Button(action:
                                loginButtonAction
                                
                            ) {
                                LoginButtonContent()
                            }.padding([.bottom],50)
                            
                        }
                    }
                } else {
                    //EXIT - IF LOGGED IN THEN PROFILE SCREEN
                    UserProfileView(userID: self.loggedInID)
                }
            }
        }
    }
}

struct LoginButtonContent : View {
    

    var body: some View {

        Text("LOGIN").font(.headline).foregroundColor(.white).padding().frame(width: 220, height: 60).background(radialGradientRectangle()).cornerRadius(15.0)
    }
    
    func linearGradientRectangle()  -> some View {
        let gradient = Gradient(colors: [.black, .gray])
        let linearGradient = LinearGradient(gradient: gradient, startPoint: .center, endPoint: .trailing)
        return Rectangle().fill(linearGradient).frame(width: 220, height: 60)
    }
    
    func radialGradientRectangle()  -> some View {
        let gradient = Gradient(colors: [.black, .gray])
        let radialGradient = RadialGradient(gradient: gradient, center: .center, startRadius: 25, endRadius: 200)
        return Rectangle().fill(radialGradient).frame(width: 220, height: 60)
    }
}

//VIDEO BACKGROUND

struct PlayerView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
        //DONOTHING
    }

    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(frame: .zero)
    }
}

class PlayerUIView: UIView {
    
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //load assets
        let fileUrl = Bundle.main.url(forResource: "kettlebell", withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)
        
        //setup player
        let player = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        //loop
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        //start playing
        player.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
