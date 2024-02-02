//
//  UsersView.swift
//  Bt-Demo
//
//  Created by Ronak Malick on 02/02/24.
//

import SwiftUI

struct UsersView: View {
    @StateObject var vm = UsersViewModel()
    @State private var pageCount: UInt = 1
    
    private let loadMoreButtonText = "Load More"
    private let usersViewNavigationTitle = "Users"
    
    var body: some View {
        NavigationView {
            VStack {
                loadUsersList()
                    .listStyle(.plain)
                    .onAppear { vm.fetchUsers(pageCount: pageCount) }
                
                Button(loadMoreButtonText) {
                    pageCount += 1
                    vm.fetchUsers(pageCount: pageCount)
                }
            }
            .navigationTitle(usersViewNavigationTitle)
            .navigationBarTitleDisplayMode(.large)
        }
    }

    @ViewBuilder
    private func loadUsersList() -> some View {
        List(vm.user, id: \.id) { user in
            UsersListRowItemView(user: user)
            Divider().background(Color.gray)
        }
    }
}

#Preview {
    UsersView()
}
