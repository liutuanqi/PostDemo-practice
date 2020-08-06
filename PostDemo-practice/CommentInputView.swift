//
//  CommentInputView.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/11.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//

import SwiftUI

struct CommentInputView: View {
    let post: Post
    
    @State private var text: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userData: UserData
    
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        VStack(spacing:0){
            CommentTextView(text: $text) //文本输入框
            
            HStack(spacing:0){
                Button(action:{
                    self.presentationMode.wrappedValue.dismiss() //让模态页面消失
                }){
                    Text("取消").padding()
                    
                }
                
                Spacer()
                
                Button(action:{
                    print(self.text)
                    var post = self.post
                    post.commentCount += 1 //因为本来post不可改变，创建一个局部变量，就可以修改
                    self.userData.update(post)
                    self.presentationMode.wrappedValue.dismiss()
                    
                }){
                    Text("发送").padding()
                    
                }
            }
            .font(.system(size:18))
            .foregroundColor(.black)

        }
        .padding(.bottom, keyboardResponder.keyboardHeight)
        
    }
}

struct CommentInputView_Previews: PreviewProvider {
    static var previews: some View {
        CommentInputView(post: UserData().recommendPostList.list[0])
    }
}
