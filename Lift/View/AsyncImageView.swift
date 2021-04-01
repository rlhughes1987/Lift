//
//  AsyncImage.swift
//  Lift
//
//  Created by Richard Hughes on 21/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//
import SwiftUI
import Combine
import Foundation

struct AsyncImageView<Placeholder: View>: View {
    
    @ObservedObject private var loader: ImageLoaderService
    private let placeholder: Placeholder?
    
    init(url: URL, placeholder: Placeholder? = nil) {
        loader = ImageLoaderService(url: url)
        self.placeholder = placeholder
        
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
    
    private var image: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}
