//
//  StartView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 26.06.2024.
//

import SwiftUI


struct StartView: View {
    @State private var apiResponse: ApiResponse?
    @State private var errorMessage: String?
    private let apiService = ApiService()

    var body: some View {
        
        Group {
            if let response = apiResponse {
                if !response.nonreloadable {
                    LoadingUserUIView()
                } else {
                    LoadingUIView()
                }
            } else {
                Text("")
            }
        }.onAppear {
            apiService.fetchData { result in
                switch result {
                case .success(let data):
                    self.apiResponse = data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
#Preview {
    StartView()
}
