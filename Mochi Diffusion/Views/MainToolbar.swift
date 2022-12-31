//
//  MainToolbar.swift
//  Mochi Diffusion
//
//  Created by Joshua Park on 12/19/22.
//

import SwiftUI

struct MainToolbar: View {
    @EnvironmentObject var store: Store
    @State private var isInfoPopoverShown = false

    var body: some View {
        if let sdi = store.getSelectedImage(), let img = sdi.image {
            let imageView = Image(img, scale: 1, label: Text("generated"))
            
            Button(action: { store.removeCurrentImage() }) {
                Label("Remove", systemImage: "trash")
                    .help("Remove")
            }
            Button(action: { store.upscaleCurrentImage() }) {
                Label("Convert to High Resolution", systemImage: "wand.and.stars")
                    .help("Convert to High Resolution")
            }
            
            Spacer()
            
            Button(action: { self.isInfoPopoverShown.toggle() }) {
                Label("Get Info", systemImage: "info.circle")
                    .help("Get Info")
            }
            .popover(isPresented: self.$isInfoPopoverShown, arrowEdge: .top) {
                InspectorView().padding()
            }
            Button(action: sdi.save) {
                Label("Save Image...", systemImage: "square.and.arrow.down")
                    .help("Save Image")
            }
            ShareLink(item: imageView, preview: SharePreview(sdi.prompt, image: imageView))
                .help("Share Image")
        }
        else {
            Button(action: {}) {
                Label("Remove", systemImage: "trash")
            }
            .disabled(true)
            Button(action: {}) {
                Label("Convert to High Resolution", systemImage: "wand.and.stars")
            }
            .disabled(true)

            Spacer()
            
            Button(action: {}) {
                Label("Get Info", systemImage: "info.circle")
            }
            .disabled(true)
            Button(action: {}) {
                Label("Save Image...", systemImage: "square.and.arrow.down")
            }
            .disabled(true)
            Button(action: {}) {
                Label("Share...", systemImage: "square.and.arrow.up")
            }
            .disabled(true)
        }
    }
}

struct MainToolbar_Previews: PreviewProvider {
    static var previews: some View {
        MainToolbar()
    }
}
