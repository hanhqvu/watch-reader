//
//  BookItemViewModel.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/23.
//

import Foundation

final class BookItemViewModel {
    let book: Book
    @Published var backDegree = -90.0
    @Published var frontDegree = 0.0
    @Published private var isFlipped = false
    
    let durationAndDelay : CGFloat = 0.2
    
    init(book: Book) {
        self.book = book
    }
    
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.easeInOut(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.easeInOut(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.easeInOut(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.easeInOut(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
}
