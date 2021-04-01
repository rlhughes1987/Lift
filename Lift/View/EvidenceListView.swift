 //
 //  VideosView.swift
 //  LiftTableToProfileNavigation
 //
 //  Created by Richard Hughes on 17/05/2020.
 //  Copyright © 2020 dickieco. All rights reserved.
 //
 
 import SwiftUI
 import AVKit
 import LinkPresentation
 
 struct EvidenceListView: View {
    
    @ObservedObject var evidenceService = EvidenceService()
    
    var body: some View {
        Content(evidence: $evidenceService.evidenceData, someAction: makeURLRequest)
    }
    
    func makeURLRequest() {
        //TBD
    }
 }
 
 extension EvidenceListView {
    
    struct Content : View {
        
        @Binding var evidence: [Evidence]?
        @State var togglePreview = false
        
        var someAction: () -> Void
        
        var body: some View {
            
            VStack{
                if (self.evidence != nil) {
                    List {
                        ForEach(0..<self.evidence!.count, id: \.self) { row in
                            URLPreview(previewURL: URL(string: self.evidence![row].filePath)!, togglePreview: self.$togglePreview)
                                .aspectRatio(contentMode: .fit)
                                .padding()
                        }
                    }
                    
                } else {
                    Text("Error with Evidence Data")
                }//.environment(\.defaultMinListRowHeight, 200)
            }
        }
    }
 }
 
 struct URLPreview : UIViewRepresentable {
    var previewURL:URL
    //Add binding
    @Binding var togglePreview: Bool
    
    func makeUIView(context: Context) -> LPLinkView {
        let view = LPLinkView(url: previewURL)
        
        let provider = LPMetadataProvider()
        
        provider.startFetchingMetadata(for: previewURL) { (metadata, error) in
            if let md = metadata {
                DispatchQueue.main.async {
                    view.metadata = md
                    view.sizeToFit()
                    self.togglePreview.toggle()
                }
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: LPLinkView, context: UIViewRepresentableContext<URLPreview>) {
    }
 }
 
 
 struct player : UIViewControllerRepresentable {
    
    var urlToPlay: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<player>) -> AVPlayerViewController {
        
        let controller = AVPlayerViewController()
        let url = self.urlToPlay
        let player1 = AVPlayer(url: URL(string: url)!)
        controller.player = player1
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<player>) {
        
    }
 }
