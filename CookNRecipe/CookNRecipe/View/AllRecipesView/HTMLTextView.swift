//
//  HTMLView.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 9/9/2024.
//
import SwiftUI
import UIKit

struct HTMLTextView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        return textView
    }

//    func updateUIView(_ textView: UITextView, context: Context) {
//        if let attributedString = htmlContent.htmlToAttributedString {
//            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
//            
//            // Apply a system font that matches SwiftUI default Text font
//            let font = UIFont.preferredFont(forTextStyle: .body)
//            mutableAttributedString.addAttributes([.font: font], range: NSRange(location: 0, length: mutableAttributedString.length))
//            
//            textView.attributedText = mutableAttributedString
//        } else {
//            textView.text = htmlContent
//        }
//    }
    func updateUIView(_ textView: UITextView, context: Context) {
        if let attributedString = htmlContent.htmlToAttributedString {
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            
            // Apply a system font that matches SwiftUI default Text font
            let font = UIFont.preferredFont(forTextStyle: .body)
            mutableAttributedString.addAttributes([.font: font], range: NSRange(location: 0, length: mutableAttributedString.length))
            
            textView.attributedText = mutableAttributedString
        } else {
            print("Failed to convert HTML to NSAttributedString")
            textView.text = "Invalid HTML content"
        }
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("Error converting HTML to NSAttributedString: \(error)")
            return nil
        }
    }
}
