//
//  ThumbnailView.swift
//  PorttoHomework
//
//  Created by Shane Li on 2023/9/14.
//

import SwiftUI

struct ThumbnailView: View {
    let imageUrl: String
    let name: String
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            Text(name)
                .bold()
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray)
        )
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(
            imageUrl: "https://i.seadn.io/gae/pWb4my976z4DWl1q5wc2GzIE7rMw-8uI9mFUNgv0X8JLUEeKx8hVb3kXU9RSps09hCNgOLAvIoR3Ram5jfYRutXfcRYn775xIunByw?auto=format&dpr=1&w=1000",
            name: "BAYC #7684"
        )
        .frame(width: 200, height: 200)
    }
}
