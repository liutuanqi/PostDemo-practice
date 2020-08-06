//
//  PostVIPBadge.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/1.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//

import SwiftUI

struct PostVIPBadge: View {
    let vip:Bool//根据是否vip，决定是否显示徽章
    
    var body: some View {
        Group{//实现显示与否
            if vip{
                Text("V")
                    .bold()
                    .font(.system(size: 11))
                    .frame(width:15,height: 15)
                    .foregroundColor(.yellow)
                    .background(Color.red)
                    .clipShape(Circle())
                    .overlay(RoundedRectangle(cornerRadius: 7.5).stroke(Color.white,lineWidth: 1)
                )
            }
        }
    }
}

struct PostVIPBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostVIPBadge(vip:true)
    }
}
