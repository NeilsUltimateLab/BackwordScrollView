//
//  ContentView.swift
//  HorizontalBackwordScrollView
//
//  Created by Neil Jain on 12/3/20.
//  Copyright © 2020 NeilsUltimateLab. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BackwardScrollView(.horizontal, leadingInset: 50) {
            ForEach((1...8).reversed(), id: \.self) { item in
                Text("Hello \(item)")
                    .frame(maxHeight: .infinity)
                Divider()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct BackwardScrollView<V: View>: View {
    var axis: Axis.Set = .horizontal
    var content: ()->V
    var leadingInset: CGFloat
    
    init(_ axis: Axis.Set = .horizontal, leadingInset: CGFloat = 10, content: @escaping ()->V) {
        self.axis = axis
        self.content = content
        self.leadingInset = leadingInset
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(axis) {
                Stack(axis) {
                    Spacer(minLength: leadingInset)
                    content()
                }
                .padding()
                .frame(minWidth: proxy.size.width)
            }
        }
    }
}

struct Stack<V: View>: View {
    var axis: Axis.Set = .horizontal
    var content: V
    init(_ axis: Axis.Set = .horizontal, @ViewBuilder buider: ()->V) {
        self.axis = axis
        self.content = buider()
    }
    
    var body: some View {
        switch axis {
        case .horizontal:
            HStack {
                content
            }
        case .vertical:
            VStack {
                content
            }
        default:
            VStack {
                content
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
