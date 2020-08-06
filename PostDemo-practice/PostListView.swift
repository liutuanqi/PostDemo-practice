//
//  PostListView.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/4.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    let category: PostListCategory
    
//    var postList: PostList{
//        switch category {
//        case .recommend:
//            return loadPostListData("PostListData_recommend_1.json")
//        case .hot:
//            return loadPostListData("PostListData_hot_1.json")
//        }
//    }
    
    @EnvironmentObject var userData: UserData
    
    
    var body: some View {
        List{
            ForEach(userData.postList(for: category).list, id:\.id){
                post in
                ZStack{
                    PostCell(post:post)
                    NavigationLink(destination: PostDetailView(post: post)){
                        EmptyView()
                    }
                    .hidden()
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PostListView(category: .recommend)
            .navigationBarTitle("Title")
            .navigationBarHidden(true)
        }
    .environmentObject(UserData())
    }
}
