//
//  PostCellToolbarButton.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/4.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//

import SwiftUI

struct PostCellToolbarButton: View {
    let image: String
    let text: String
    let color: Color
    let action: () -> Void
    
    
    
    var body: some View {
        Button(action:action){
            HStack(spacing:5){
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width:18,height: 18)
                Text(text)
                    .font(.system(size: 15))
            }
        }
        .foregroundColor(color)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct PostCellToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToolbarButton(image: "heart", text: "点赞吧", color: .red) {
            print("点赞了啊")
        }
    }
}
