//
//  WebView.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 01.07.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var urlString: String
    let lastVisitedKey = "lastVisitedURL"

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator

        // Загрузка сохраненных cookie
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
            }
        }

        // Загрузка последнего открытого URL
        if let savedURL = UserDefaults.standard.string(forKey: lastVisitedKey), let url = URL(string: savedURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Сохранение cookie после загрузки страницы
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                for cookie in cookies {
                    HTTPCookieStorage.shared.setCookie(cookie)
                }
            }

            // Сохранение последнего открытого URL
            if let url = webView.url?.absoluteString {
                UserDefaults.standard.set(url, forKey: parent.lastVisitedKey)
            }
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}
