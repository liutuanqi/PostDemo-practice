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
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: HScrollViewController
        var scrollView: UIScrollView!
        var host: UIHostingController<Content>!
        
        init(_ parent: HScrollViewController) {
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation {
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
