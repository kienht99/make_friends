//
//  LikesView.swift
//  DatingApp
//
//  Created by Radley Hoang on 22/11/2021.
//

import SwiftUI

struct LikesView: View {
    @StateObject var viewModel = LikesViewModel()
    var body: some View {
        VStack {
            switch viewModel.viewType {
            case .Empty:
                LikesEmptyView {
                    viewModel.reloadData()
                }
                
            case .HasUserLikeMe:
                ListUsersLikeMeView(viewModel: viewModel)
                
            case .LoadingData:
                ProgressView()
            }
        }
        .setBackgroundColor(K.Constants.DefaultColor)
    }
    
    // MARK: - ListUsersLikeMeView
    struct ListUsersLikeMeView: View {
        @ObservedObject var viewModel: LikesViewModel
        
        let columns = [
            GridItem(.flexible(minimum: 100), spacing: 10),
            GridItem(.flexible(minimum: 100), spacing: 0)
        ]
        
        var body: some View {
            VStack {
                ScrollView(showsIndicators: false) {
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        viewModel.reloadData()
                    }
                    
                    HStack {
                        Text("Ai đã thích bạn:")
                            .style(font: .lexendBold, size: 24, color: Asset.Colors.Global.black100.color)
                            .padding(.vertical, 8)
                        
                        Spacer()
                    }
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.likingUsers, id: \.id) { user in
                            let cellViewModel = LikesCellViewModel(user: user)
                            LikesCellView(cellViewModel: cellViewModel)
                                // TODO: Show/dismiss Detail Profile View
                                .fullScreenCover(isPresented: $viewModel.isPresentDetailProfileView) {
                                    let viewModel = DetailProfileViewModel(user: viewModel.selectedUser)
                                    DetailProfileView(viewModel: viewModel)
                                        .hiddenNavigationBar()
                                        .navigationView()
                                }
                                .onReceive(.DismissDetailProfileView) { _ in
                                    viewModel.isPresentDetailProfileView = false
                                }
                                .onTapGesture {
                                    viewModel.showDetailProfile(ofUser: user)
                                }
                                .onReceive(.DidLikeOrDislikeSuccess) { notification in
                                    guard let removedUserId = notification.object as? String else { return }
                                    viewModel.removeUser(userId: removedUserId)
                                }
                        }
                    }
                }
                .coordinateSpace(name: "pullToRefresh")
            }
            .padding([.leading, .trailing], 20)
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView()
    }
}
