//
//  HScrollViewController.swift
//  PostDemo
//
//  Created by xiaoyouxinqing on 1/10/20.
//  Copyright © 2020 xiaoyouxinqing. All rights reserved.
//

import SwiftUI
                         //尖括号里边表示“泛型”，遵循view协议
struct HScrollViewController<Content: View>: UIViewControllerRepresentable {
    let pageWidth: CGFloat
    let contentSize: CGSize
    let content: Content
    @Binding var leftPercent: CGFloat
    //@state通常修饰自己使用的属性，当属性发生了变化，SwiftUI会根据新的属性值重新创建视图，刷新
    //或者将属性传给子View，和子view的属性绑定在一块，子view需要使用@binding
    //视图的属性传至子节点中，但是又不能直接的传递给子节点，因为在 Swift 中值的传递形式是值类型传递方式，也就是传递给子节点的是一个拷贝过的值，@Binding 修饰器修饰后，属性变成了一个引用类型，传递变成了引用传递，这样父子视图的状态就能关联起来了
    
    init(pageWidth: CGFloat,
         contentSize: CGSize,
         leftPercent: Binding<CGFloat>,
         @ViewBuilder content: () -> Content) {
        
        self.pageWidth = pageWidth
        self.contentSize = contentSize
        self.content = content()
        self._leftPercent = leftPercent
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    func makeUIViewController(context: Context) -> UIViewController {
        let scrollView = UIScrollView() //生成一个scrollview
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        context.coordinator.scrollView = scrollView
        
        let vc = UIViewController()
        vc.view.addSubview(scrollView)
        
        let host = UIHostingController(rootView: content)
        vc.addChild(host) //添加孩子，两个uiview建立层级关系
        scrollView.addSubview(host.view)
        host.didMove(toParent: vc)
        context.coordinator.host = host
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let scrollView = context.coordinator.scrollView!
        scrollView.frame = CGRect(x: 0, y: 0, width: pageWidth, height: contentSize.height)
        scrollView.contentSize = contentSize
        scrollView.setContentOffset(CGPoint(x: leftPercent * (contentSize.width - pageWidth), y: 0), animated: true)
        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)
    }
    
            //基本上所有uikit的类都继承自NSobject
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: HScrollViewController
        var scrollView: UIScrollView!
        var host: UIHostingController<Content>!
        
        init(_ parent: HScrollViewController) {
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation { //橙色小条的动画
                parent.leftPercent = scrollView.contentOffset.x < parent.pageWidth * 0.5 ? 0 : 1
            }
        }
    }
}

//struct HScrollViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        HScrollViewController(pageWidth: UIScreen.main.bounds.width,
//                    contentSize: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height),
//                    leftPercent: .constant(0))
//        {
//            Text("ASD")
//        }
//    }
//}
