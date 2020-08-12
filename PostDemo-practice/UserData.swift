//
//  UserData.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/7.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//

import Combine

enum PostListCategory {
    case recommend, hot
}


class UserData: ObservableObject {
    @Published var recommendPostList: PostList = loadPostListData("PostListData_recommend_1.json")
    @Published var hotPostList: PostList = loadPostListData("PostListData_hot_1.json")
    
    private var recommendPostDic: [Int:Int] = [:]//id:index，字典，用于存储某条微博的id、在列表中的下标
    private var hotPostDic: [Int:Int] = [:]//id:index
    init(){
        for  i in 0..<recommendPostList.list.count {
            let post = recommendPostList.list[i]
            recommendPostDic[post.id] = i
        }
        for  i in 0..<hotPostList.list.count {
            let post = hotPostList.list[i]
            hotPostDic[post.id] = i
        }
    }
    
}


extension UserData{
    func postList(for category: PostListCategory) ->PostList{
        switch category {
        case .recommend:
            return recommendPostList
        case .hot:
            return hotPostList
        }
    }
    
    func post(forID id:Int) -> Post? {
        if let index = recommendPostDic[id]{   //let关键字，指：如果存在index，就执行花括号内的代码
            return recommendPostList.list[index]
        }
        if let index = hotPostDic[id]{
            return hotPostList.list[index] //如果找到了某条微博，就从列表中取出微博，并返回
        }
        return nil  //如果不存在index，返回nil
    }
    
    func update(_ post:Post)  {  //外部参数为空，用下划线，内部参数post
        if let index = recommendPostDic[post.id]{
            recommendPostList.list[index] = post  //给数组的某个元素赋值，即更新它
        }
        if let index = hotPostDic[post.id]{
            hotPostList.list[index] = post
        }
    }
}
