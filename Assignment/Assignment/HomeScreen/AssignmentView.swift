//
//  AssignmentView.swift
//  Assignment
//
//  Created by Raju on 28/08/24.
//

import SwiftUI
import Kingfisher

struct AssignmentView: View {
  
    @StateObject var viewModel: AssignmentViewModel
    
    var body: some View {
        NavigationView {
            mainView
                .navigationTitle(Text(StringConstants.screenTitle))
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                     viewModel.getUsers(perPage: 12)
                }
        }

    }
    
    var mainView: some View {
        CustomLoadingView(isShowing: $viewModel.isLoading, loadingMessage: $viewModel.loadingMessage) {
            VStack(spacing: 0) {
               Divider()
               userList
               Spacer()
           }
        }
    }
    
    var userList: some View {
        List {
            if !(viewModel.userData?.users?.isEmpty ?? false) {
                ForEach(viewModel.userData?.users ?? []) { user in
                    userRowView(user: user)
                }
            }
        }.listStyle(.plain)
        .listRowInsets(EdgeInsets())
    }
    
    func userRowView(user: User) -> some View {
        return(
            HStack {
                avatarImageView(user: user)
                Spacer().frame(width: SpacingConstants.space4)
                VStack(alignment: .leading, spacing: SpacingConstants.space4) {
                    Text(user.fullname)
                        .font(Font.callout)
                    Text(user.email ?? "")
                        .font(Font.caption)
                }.padding()
                Spacer()
            }.frame(width: UIScreen.main.bounds.width, height: SpacingConstants.space60)
        )
    }
    
    func avatarImageView(user: User) -> some View {
        HStack {
            if let url = user.avatar {
                KFImage(URL(string: url))
                    .resizable()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(ColorConstants.white, lineWidth: 0))
                    .shadow(radius: 0)
                    .frame(width: SpacingConstants.space50, height: SpacingConstants.space50)
                    .padding(EdgeInsets(top: SpacingConstants.space0, leading: SpacingConstants.space8,
                                        bottom: SpacingConstants.space0, trailing: SpacingConstants.space0))
            } else {
                initialsUI(user: user)
            }
        }
    }
    
    func initialsUI(user: User) -> some View {
        return(
            ZStack {
                Circle().fill(ColorConstants.gray)
                    .frame(width: SpacingConstants.space50, height: SpacingConstants.space50)
                Text(user.getInitials)
                    .font(Font.title3)
                    .fontWeight(.bold)
                    .foregroundColor(ColorConstants.white)
            }.padding(EdgeInsets(top: SpacingConstants.space0, leading: SpacingConstants.space8,
                                 bottom: SpacingConstants.space0, trailing: SpacingConstants.space0))
        )
    }
    
}


#Preview {
    AssignmentView(viewModel: AssignmentViewModel(model: AssignmentModel()))
}

extension String {
    static func getInitials(firstName: String?, lastName: String?) -> String {
        var initials = ""
        var firstChar = ""
        var secondChar = ""
        if firstName != nil, lastName != nil {
            if let fName = firstName {
                firstChar = "\(fName.first ?? Character(""))"
            }
            if let lName = lastName {
                secondChar = "\(lName.first ?? Character(""))"
            }
            initials = firstChar + secondChar
        }
        return initials.uppercased()
    }
}
