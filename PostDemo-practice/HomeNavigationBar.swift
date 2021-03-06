//
//  HomeNavigationBar.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/5.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//
//  写一个view，用来显示首页上的NavigationBar
//
import SwiftUI

private let kLabelWidth: CGFloat = 60
private let kButtonHeight:CGFloat = 24
struct HomeNavigationBar: View {
    //想要更新某个属性，需要加@state标识符，表示当前view的某个属性发生变化之后，view会随之更新，即body之后{}中的代码会再执行一次
    @Binding var leftPercent: CGFloat // 0 for left,1 for right
    
    var body: some View {
        HStack(alignment: .top, spacing: 0){
           
            Button(action:{
                print("Click camara button")
            }){
                Image(systemName: "camera")
                .resizable()
                .scaledToFit()
                    .frame(width:kButtonHeight,height: kButtonHeight)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            VStack(spacing:3){
                HStack(spacing: 0){
                    Text("推荐")
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top,5)
                        .opacity(Double(1 - leftPercent * 0.5)) //两个字的透明度
                        .onTapGesture {
                            withAnimation{ //滑条的动画
                                 self.leftPercent = 0
                            }
                    }
                    Spacer()
                    
                    Text("热门")
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top,5)
                        .opacity(Double(0.5 + leftPercent * 0.5)) //两个字的透明度
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 1
                            }
                    }
                }
                .font(.system(size:20))
                
                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(.orange)
                    .frame(width: 30, height: 4)
                    .offset(x: UIScreen.main.bounds.width * 0.5 * CGFloat(self.leftPercent - 0.5) + kLabelWidth * (0.5 - self.leftPercent))
            }
            .frame(width:UIScreen.main.bounds.width * 0.5)
            
            Spacer()

            Button(action:{
                print("Click add button")
            }){
                Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                    .frame(width:kButtonHeight,height: kButtonHeight)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                    .foregroundColor(.orange)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar(leftPercent: .constant(0))
    }
}
