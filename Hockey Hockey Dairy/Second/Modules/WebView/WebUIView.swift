//
//  WebUIView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 01.07.2024.
//

import SwiftUI

struct WebUIView: View {
    @State private var urlString = "https://www.google.com"

    var body: some View {
        WebView(urlString: $urlString)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    WebUIView()
}
