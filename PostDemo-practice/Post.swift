//
//  Post.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/1.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//

import SwiftUI

//定义此结构体，为了和JSON数据保持结构一致
struct  PostList:Codable {
    var list: [Post]
}


//Data Model，一条微博的数据模型，不可见(数据模型，所以不可见)
struct Post: Codable{//实现了Codable协议，支持JSON
    let id:Int
    let avatar: String // 头像、图片名称
    let vip: Bool// 是否vip
    let name: String
    let date: String
    var isFollowed: Bool
    let text: String
    let images: [String]
    var commentCount: Int
    var likeCount: Int
    var isLiked: Bool
    //不确定属性是否可变时，可先试用let，编辑器提示错误时再改为var
   
    
}

//和view显示的相关只读属性放在扩展中
extension Post {
    var commentCountText:String{
           if commentCount <= 0 {return "评论"}
            if commentCount < 1000 {return "\(commentCount)"}
           return String(format:"%.1fk",Double(commentCount)/1000)
    }
       
    var likeCountText:String{
       if likeCount <= 0 {return "点赞"}
        if likeCount < 1000 {return "\(likeCount)"}
       return String(format:"%.1fk",Double(likeCount)/1000)
    }
}

//并未在某个花括号中，所以这是一个全局变量，后来已经没用了，注释掉
//let postList = loadPostListData("PostListData_hot_1.json")

func loadPostListData(_ fileName: String) -> PostList {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else{
        fatalError("Can not find \(fileName) in main bundle!")
    }
    guard let data = try? Data(contentsOf: url) else{
        fatalError("Can not load \(fileName) !")
    }
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else{
        fatalError("Can not parse post list json data!")
    }
    return list
}

func loadImage(name:String) -> Image{
    return Image(uiImage: UIImage(named: name)!)
}
