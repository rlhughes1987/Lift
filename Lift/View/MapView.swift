//
//  MapView.swift
//  Lift
//
//  Created by Richard Hughes on 20/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import MapKit

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
