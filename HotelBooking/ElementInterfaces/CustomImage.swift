//
//  CustomImage.swift
//  HotelBooking
//
//  Created by Steven Kirke on 09.09.2023.
//

import SwiftUI

import SwiftUI

struct CustomImage: View {
    
    let image: String
    
    var body: some View {
        
        AsyncImage(url: URL(string: image)) { phase in
            switch phase {
                case .empty:
                    ProgressView()
                        .tint(.black)
                case .success(let image):
                    image
                        .resizable()
                case .failure(_):
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.black.opacity(0.2))
                        .background(Color.black.opacity(0.1))
                @unknown default:
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.black.opacity(0.2))
            }
        }
    }
}

