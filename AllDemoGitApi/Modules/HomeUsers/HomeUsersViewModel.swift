//
//  HomeUsersViewModel.swift
//  AllDemoGitApi
//
//  Created by C879403 on 30/05/22.
//

import Foundation

struct UsersViewModel {
    let loginUserName: String?
    let avatarUrl: String?
    
    init(userModel: HomeUsersModelElement) {
        self.loginUserName = userModel.login
        self.avatarUrl = userModel.avatarURL
    }
}

protocol ParsableData {
    var arrayUsersViewModel: [UsersViewModel] { get set }
    var output: OutputHomeViewData? { get set }
    func getParsableData() -> Void
}

protocol OutputHomeViewData: AnyObject {
    func didReceivedOutPutData(_ userViewModel: [UsersViewModel]?, error: Error?) -> Void
}

final class HomeUsersViewModel: ParsableData {
    weak var output: OutputHomeViewData?
    var arrayUsersViewModel: [UsersViewModel] = []
    private let getApiData: GetAPIRquestData
    
    init(getApiData: GetAPIRquestData){
        self.getApiData = getApiData
    }
    
    func getParsableData() -> Void {
        getApiData.getAPIData { result in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(HomeUsersModel.self, from: data)
                    let viewModel = self.mapModelDataToViewModelData(userModel: jsonData)
                    self.output?.didReceivedOutPutData(viewModel, error: nil)
                } catch let error {
                    self.output?.didReceivedOutPutData(nil, error: error)
                }
            case .failure(let err):
                self.output?.didReceivedOutPutData(nil, error: err)
            }
        }
    }
    //Map API response data to View Model and assign to delegete object.
    func mapModelDataToViewModelData(userModel: HomeUsersModel) -> [UsersViewModel] {
        let modelArray = userModel.map { (obj: HomeUsersModelElement) -> UsersViewModel in
            return UsersViewModel(userModel: obj)
        }
        return modelArray
    }
}
