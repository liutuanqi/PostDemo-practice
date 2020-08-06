//
//  CommentTextView.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/12.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//

import SwiftUI

struct CommentTextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
         Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.backgroundColor = .systemGray6
        view.font = .systemFont(ofSize: 18)
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.delegate = context.coordinator
        view.text = text
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    //Coordinator首字母写成了小写，悲催，这低级错误
    class Coordinator: NSObject, UITextViewDelegate{
        let parent: CommentTextView
        init(_ view: CommentTextView) {
            parent = view
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

struct CommentTextView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextView(text: .constant(""))
    }
}
