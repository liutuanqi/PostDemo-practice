//
//  PostImageCell.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/5.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//

import SwiftUI

private let kImageSpace: CGFloat = 6

struct PostImageCell: View {
    
    let images: [String]
    let width: CGFloat
    
    var body: some View {
        Group{//照片显示规则设置
            if images.count == 1 {
                    loadImage(name: images[0])
                                         .resizable()
                                         .scaledToFill()
                                         .frame(width:width,height: width*0.75)
                                         .clipped()
                }else if images.count == 2{
                    PostImageCellRow(images:images,width: width)
                }else if images.count == 3{
                    PostImageCellRow(images:images,width: width)
                }else if images.count == 4{
                VStack(spacing:kImageSpace){
                    PostImageCellRow(images:Array(images[0...1]),width: width)
                    PostImageCellRow(images:Array(images[2...3]),width: width)
                }
                    
                }else if images.count == 5{
                VStack(spacing:kImageSpace){
                    PostImageCellRow(images:Array(images[0...1]),width: width)
                    PostImageCellRow(images:Array(images[2...4]),width: width)
                }
                   
                }else if images.count == 6{
                VStack(spacing:kImageSpace){
                    PostImageCellRow(images:Array(images[0...2]),width: width)
                    PostImageCellRow(images:Array(images[3...5]),width: width)
                    }
                }
                    
        }
    }
}

struct PostImageCellRow: View{//写了一个view，即一行
    let images: [String]
    let width: CGFloat
    var body: some View{
        HStack(spacing: kImageSpace){
            ForEach(images, id: \.self){
                image in loadImage(name: image)
                .resizable()
                .scaledToFill()
                .frame(width:(self.width - kImageSpace * CGFloat(self.images.count - 1))/CGFloat(self.images.count),
                           height: (self.width - kImageSpace * CGFloat(self.images.count - 1))/CGFloat(self.images.count))//闭包里边访问属性要加self
                .clipped()
                
            }
        }
    }
}
struct PostImageCell_Previews: PreviewProvider {
    static var previews: some View {
         let userData = UserData()
        return PostImageCell(images: userData.recommendPostList.list[4].images,width: UIScreen.main.bounds.width - 30).environmentObject(userData)
    }
}
