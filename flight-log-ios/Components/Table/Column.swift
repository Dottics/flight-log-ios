//
//  Column.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2023/01/14.
//

import SwiftUI

struct Column<T: View>: View {
    @ViewBuilder var content: T
    var width: CGFloat
    var alignment: Alignment?
    
    init(_ content: T, width: CGFloat, alignment: Alignment? = nil) {
        self.content = content
        self.width = width
        self.alignment = alignment
    }
    
    init(width: CGFloat, alignment: Alignment? = nil, _ content: () -> T) {
        self.content = content()
        self.width = width
        self.alignment = alignment
    }
    
    init(@ViewBuilder _ content: () -> T, width: CGFloat, alignment: Alignment? = nil) {
        self.content = content()
        self.width = width
        self.alignment = alignment
    }
    
    var body: some View {
        content
            .frame(width: width, alignment: alignment ?? .leading)
    }
}

struct Column_Previews: PreviewProvider {
    static var previews: some View {
        Column(width: 100) {
            Text("column")
        }
    }
}
