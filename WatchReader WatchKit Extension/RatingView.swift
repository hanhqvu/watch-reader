//
//  RatingView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int?
    
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        VStack {
            if rating == nil {
                Text("Rate this book: ")
            } else {
                Text("Your rating: ")
            }
            HStack{
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    image(for: number)
                        .foregroundColor(number > rating ?? 0 ? offColor : onColor)
                        .onTapGesture {
                        rating = number
                    }
                }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating ?? 0 {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
