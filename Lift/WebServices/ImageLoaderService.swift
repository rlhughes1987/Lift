//
//  ImageLoader.swift
//  Lift
//
//  Created by Richard Hughes on 21/06/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class ImageLoaderService: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
    }

    init(url: URL) {
        self.url = url
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
        .map { UIImage(data: $0.data) }
        .replaceError(with: nil)
        .receive(on: DispatchQueue.main)
        .assign(to: \.image, on: self)
        
    }

    func cancel() {}
}
