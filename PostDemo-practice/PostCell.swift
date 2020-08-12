//
//  PostCell.swift
//  PostDemo-practice
//
//  Created by Tuanqi Liu on 2020/7/1.
//  Copyright © 2020 Tuanqi Liu. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    let post:Post
    
    var bindingPost: Post {
        userData.post(forID: post.id)! //这条微博一定存在，所以可以加！
    }
    
    @State var presentComment: Bool = false
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        var post = bindingPost //局部变量post，覆盖原来的变量
        return VStack{
            HStack(spacing:5){
                       Image(uiImage: UIImage(named:post.avatar)!)//因为返回值是可选类型，加！要小心
                           .resizable()
                           .scaledToFill()
                           .frame(width:50,height: 50)
                           .clipShape(Circle())
                           .overlay(
                               PostVIPBadge(vip:post.vip)
                                   .offset(x:16,y:16)
                       )
                       VStack(alignment: .leading, spacing:5){//左对齐，行间距
                           Text(post.name)
                               .font(Font.system(size: 16))//使用系统字体，16号字
                               .foregroundColor(Color(red: 242 / 255, green: 99 / 255, blue: 4 / 255))//颜色
                               .lineLimit(1)
                           Text(post.date)
                               .font(.system(size: 11))//和上边对比，省略了Font
                               .foregroundColor(Color.gray)
                       }
                           .padding(.leading,10)//左侧间距
                       
                       if !post.isFollowed{
                           Spacer()//占位view，看不到，无法选中
                           
                           Button(action:{//按钮功能
                                post.isFollowed = true
                                self.userData.update(post)
                           }){
                               Text("关注")
                                   .font(.system(size: 14))
                                   .foregroundColor(.orange)
                                   .frame(width: 50,height: 26)//设置圆角矩形半径参考、增大按钮面积
                                   .overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.orange, lineWidth: 1))//叠加一个圆角矩形、描边
                           }
                       .buttonStyle(BorderlessButtonStyle())
                       }
                   }
            
            //显示文字部分
            Text(post.text)
                .font(.system(size:17))
            
            //显示图片
            if !post.images.isEmpty{
                PostImageCell(images: post.images, width: UIScreen.main.bounds.width - 30)
            }
            Divider()
            
            HStack(spacing:0){
                Spacer()
                PostCellToolbarButton(image:"message",
                                      text:post.commentCountText,
                                      color:.black){
                                    self.presentComment = true
                }
                .sheet(isPresented: $presentComment) { //模态推出页面
                    CommentInputView(post: post).environmentObject(self.userData)
                }
                Spacer()
                PostCellToolbarButton(image: post.isLiked ? "heart.fill" : "heart",
                                      text:post.likeCountText,
                                      color: post.isLiked ? .red : .black){
                                        if post.isLiked{
                                            post.isLiked = false
                                            post.likeCount -= 1
                                        }else{
                                            post.isLiked = true
                                            post.likeCount += 1
                                        }
                                        self.userData.update(post)
                }
                Spacer()
            }
            Rectangle()//矩形分隔线
                .padding(.horizontal, -15)//因为所在的矩形设置了15的padding，所以需设置为-15
                .frame(height: 10)//高度
                .foregroundColor(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))//灰色
        }
        .padding(.horizontal,15)
        .padding(.top, 15)
    }
    
    
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return PostCell(post: userData.recommendPostList.list[0]).environmentObject(userData)
    }
}
