//
//  ScrollableTabBar.swift
//  CalmPets
//
//  Created by Aarón Cervantes Álvarez on 17/06/21.
//

import SwiftUI

struct ScrollableTabBar<Content: View>: UIViewRepresentable {
    
    // Store our SwiftUI Views
    var content: Content
    
    // Getting Rect to Calculate Width and Height of ScrollView
    var rect: CGRect
    
    // Content Offset
    @Binding var offset: CGFloat
    
    // TABS
    var tabs: [Any]
    
    // ScrollView. AKA Scrollable Tabs
    let scrollView = UIScrollView()
    
    init( tabs: [Any], rect: CGRect, offset: Binding<CGFloat>, @ViewBuilder content: () -> Content ) {
        self.content = content()
        self._offset = offset
        self.rect = rect
        self.tabs = tabs
    }
    
    func makeCoordinator() -> Coordinator {
        return ScrollableTabBar.Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        setUpScrollView()
        
        // Setting Content Size
        scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
        
        scrollView.contentOffset.x = offset
        
        scrollView.addSubview( extractView() )
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {

    }
    
    // Setting Up ScrollView
    func setUpScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    
    func extractView() -> UIView {
        // It depends on tabs, we need to get tabs also on this struct
        let controller = UIHostingController(rootView: HStack(spacing: 0) {
            content
        }.ignoresSafeArea() )
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        return controller.view!
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollableTabBar
        
        init( parent: ScrollableTabBar ) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}

//struct ScrollableTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollableTabBar()
//    }
//}
