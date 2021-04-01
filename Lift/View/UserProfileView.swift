//
//  UserProfileView.swift
//  Lift
//
//  Created by Richard Hughes on 20/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import Combine
import MapKit

struct UserProfileView: View {
    
    //@EnvironmentObject private var stateController: StateController
    
    @ObservedObject var userInfoRequest: UserInfoRequest = UserInfoRequest()
    
    let userID: Int
    
    var body: some View {
        //Content(user: $stateController.userInView, success: $userInfoRequest.success, appearAction: sendUserInfoRequest)
        Content(user: $userInfoRequest.user, success: $userInfoRequest.success, appearAction: sendUserInfoRequest)
    }
    
    func sendUserInfoRequest() {
        self.userInfoRequest.send(id: self.userID)
    }
    
}

extension UserProfileView {
    
    struct Content : View {
        
        @Binding var user: User
        @Binding var success: Bool
        
        var appearAction: () -> Void
        
        var body: some View {
            NavigationView {
                
                
                VStack{
                    Group {
                        if (self.success && self.user.id != 0) { //Don't load views unless we've got the data
                            ZStack{
                                //MAP
                                MapView(latitude: self.user.region.latitude, longitude: self.user.region.longitude, span: self.user.region.span).frame(height: 400).edgesIgnoringSafeArea(.top)
                                
                                //GIF
                                //CircleImage(imageName: self.user.pictureRef).offset(y:-300).frame(height: 240).padding(.bottom,-350)
                                CircleImage(imageName: self.user.pictureRef).frame(height: 300).padding(.bottom,-100)
                            }
                            
                            //INFO
                            VStack(alignment: .leading) {
                                Text(self.user.name).font(.title)
                                
                                HStack {
                                    
                                    Text(self.user.region.name).font(.subheadline)
                                    Spacer()
                                }
                                
                            }.padding(.horizontal,5)
                            
                            //PUSH EVERTHING TO TOP
                            Spacer()
                            ProfileNavigationLinks().foregroundColor(Color.black)
                        } else {
                            VStack(alignment: .leading){
                                Text("Loading Profile").onAppear {
                                    self.appearAction() //kicks off the data request.
                                }
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }
}

struct ProfileNavigationLinks: View {
    
    var body: some View {
        
        HStack(alignment: .bottom){
                NavigationLink( destination: ProgramsListView() ) {
                    VStack {
                        Image(systemName: "flowchart.fill")
                        Text("Programs")
                    }
                   
                }.padding([.leading,.trailing],2)
                NavigationLink( destination: EvidenceListView() ) {
                    VStack {
                          Image(systemName: "video.fill")
                          Text("Videos")
                      }
                }.padding(.trailing,2)
                NavigationLink( destination: UserGroupListView() ) {
                    VStack {
                        Image(systemName: "person.3.fill")
                        Text("Groups")
                    }
                }.padding(.leading,2)
                NavigationLink( destination: ProgramsListView() ) {
                    VStack {
                        Image(systemName: "chart.bar.fill")
                        Text("Leaderboards")
                    }
                  
                }.padding([.leading,.trailing],2)
        }
        
    }
}

struct CircleImage: View {
    
    var imageName:String?
    
    init(imageName: String?){
        self.imageName = imageName
        
        if self.imageName != nil {
            print("ImageName provided:"+imageName!)
        }
    }
    
    var body: some View {
        Group {
            if imageName == nil {
                AsyncImageView(
                    url: URL(string: "http://127.0.0.1:8000/missing.jpg")!,
                    placeholder: Image(systemName: "person.crop.circle.fill.badge.plus")
                ).aspectRatio(contentMode: .fit).clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2)).padding(20).shadow(radius: 8)
            } else {
                AsyncImageView(
                    url: URL(string: "http://127.0.0.1:8000/"+self.imageName!)!,
                    placeholder: Image(systemName: "person.crop.circle.fill.badge.plus")
                ).aspectRatio(contentMode: .fit).clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2)).padding(20).shadow(radius: 8)
            }
        }
         
    }
}

struct MapView: UIViewRepresentable {
    
    var latitude:Double
    var longitude:Double
    var span:Double
    
    func makeUIView(context:
        UIViewRepresentableContext<MapView>) -> some MKMapView {
        
        MKMapView()
    }
    
    func updateUIView(_ uiView: MapView.UIViewType, context: UIViewRepresentableContext<MapView>) {
        
        let coordinate = CLLocationCoordinate2D(
            latitude: self.latitude,
            longitude: self.longitude )
        let deltaspan = MKCoordinateSpan(latitudeDelta: self.span, longitudeDelta: self.span)
        let region = MKCoordinateRegion(center: coordinate, span: deltaspan)
        uiView.setRegion(region, animated:true)
        
    }

}
