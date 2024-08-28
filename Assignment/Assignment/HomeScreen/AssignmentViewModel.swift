//
//  AssignmentViewModel.swift
//  Assignment
//
//  Created by Raju on 28/08/24.
//

import Foundation

class AssignmentViewModel: ObservableObject {
    
    @Published var model: AssignmentModel
    let useCase: AssignmentUsecaseProtocol = AssignmentUsecase()
    
    init(model: AssignmentModel) {
        self.model = model
    }
    
    func getUsers(perPage: Int) {
        self.isLoading = true
        useCase.fetchUserList(perPage: perPage) { result in
            self.isLoading = false
            switch result {
            case .success(let result):
                self.model.userData = result
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension AssignmentViewModel {
    var userData: UserData? {
        get { model.userData }
        set { model.userData = newValue }
    }
    var isLoading: Bool {
        get { model.isLoading ?? false }
        set { model.isLoading = newValue }
    }
    var loadingMessage: String {
        get { model.loadingMessage }
        set { model.loadingMessage = newValue }
    }
}
