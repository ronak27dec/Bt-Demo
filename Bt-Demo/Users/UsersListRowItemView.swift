//
//  UsersListRowItemView.swift
//  Bt-Demo
//
//  Created by Ronak Malick on 02/02/24.
//

import SwiftUI
import URLImage

struct UsersListRowItemView: View {
    private let horizontalPadding = 16.0
    private var user: User

    init(user: User) {
        self.user = user
    }

    var body: some View {
        HStack(alignment: .center, spacing: horizontalPadding) {
            loadImage(user: user)
            VStack(alignment: .leading, spacing: 8.0) {
                Text(user.firstName + " " + user.lastName)
                    .font(.headline)
                Text(user.email)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .listRowSeparator(.hidden)
    }
    
    @ViewBuilder
    func loadImage(user: User) -> some View {
        URLImage(URL(string: user.avatar)!) { image in
            image
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .shadow(radius: 5)
        }
        
    }
}

#Preview {
    UsersListRowItemView(user:
        User(id: 1,
             email: "abc@gmail.com",
             firstName: "ronak",
             lastName: "Mallick",
             avatar: "--"))
}
