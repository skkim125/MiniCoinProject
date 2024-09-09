//
//  NavigationWrapper.swift
//  MiniCoinProject
//
//  Created by 김상규 on 9/9/24.
//

import SwiftUI

struct NavigationWrapper<Content: View>: View {
    
    let closure: () -> Content
    
    var body: some View {
        closure()
    }
    
    init(_ closure: @autoclosure @escaping () -> Content) {
        self.closure = closure
        
    }
}
