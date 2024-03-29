//
//  DetailView.swift
//  WatchReader WatchKit Extension
//
//  Created by Hanh Vu on 2022/08/26.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @Binding var showDetail: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/olid/\(viewModel.book.imageKey!)-L.jpg"))  { image in
                    image
                        .resizable()
                        .scaledToFit()
                    } placeholder: {
                        ProgressView()
                            .frame(width: 60, height: 120, alignment: .leading)
                    }
                    .frame(maxWidth: 60, maxHeight: 120, alignment: .leading)
                Text(viewModel.book.title!)
                    .font(.custom("Baskerville", size: 20, relativeTo: .headline))
                    .frame(alignment: .leading)
                ForEach(viewModel.book.authorArray, id: \.self) { author in
                    //force unwrap as name is a required attributes
                    Text(author.name!)
                }
                .font(.custom("Baskerville", size: 16, relativeTo: .subheadline))
                Slider(
                    value: $viewModel.book.progress,
                    in: 0...100,
                    step: 5
                ) {
                    Text("Progress")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("100")
                }
                Text("Progress: \(viewModel.book.progress, specifier: "%.0f")")
                    .font(.custom("Baskerville", size: 20, relativeTo: .body))
                    .frame(alignment: .leading)
                RatingView(rating: $viewModel.book.ratingInt)
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    viewModel.complete()
                    showDetail.toggle()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Discard") {
                    showDetail.toggle()
                }
            }
        }
    }
}
