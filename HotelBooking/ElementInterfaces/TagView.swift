//
//  TagView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 10.09.2023.
//

import SwiftUI

struct TagView: View {
    
    private let tagCloud: TagCloud = TagCloud()
    
    var array: [String] = ["42342", "423432", "43534fs"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(tagCloud.generateCloud(array), id: \.self) { rows in
                HStack(spacing: 8) {
                    ForEach(rows) { row in
                        TagElement(text: row.text)
                    }
                }
            }
        }
    }
}

struct TagElement: View {
    
    let text: String
    
    var body: some View {
        Text(text)
        .lineLimit(1)
        .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .medium))
        .foregroundColor(.c_828796)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(Color.c_FBFBFC)
        .cornerRadius(5)
    }
}

#if DEBUG
struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView()
    }
}
#endif


