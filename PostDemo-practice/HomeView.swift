//
//  HomeView.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/7.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var leftPercent: CGFloat = 0
    
    init(){
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView{
            
            //滑动效果
//            ScrollView(.horizontal, showsIndicators: false) {
            
            //使用另一种方式实现：UIkit
            GeometryReader{ geometry in
                HScrollViewController(pageWidth: geometry.size.width, contentSize: CGSize(width: geometry.size.width * 2, height: geometry.size.height),leftPercent: self.$leftPercent){
                    HStack{
                        PostListView(category: .recommend)
                            .frame(width: UIScreen.main.bounds.width)
                        PostListView(category: .hot)
                                .frame(width: UIScreen.main.bounds.width)
                    }
                }
            }
                //去除顶部空白
            .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent))
            .navigationBarTitle("首页", displayMode: .inline)

            //去除底部空白
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserData())
    }
}
