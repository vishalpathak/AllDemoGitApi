//
//  ViewController.swift
//  AllDemoGitApi
//
//  Created by C879403 on 27/05/22.
//

import UIKit

class HomeUsersViewController: UIViewController {
    
    private var parsableData: ParsableData = HomeUsersViewModel(getApiData: NetworkManager(session: URLSession(configuration: .default), path: "/users", method: HTTPMethod.get.rawValue))
    private var userVM: [UsersViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
      
        parsableData.getParsableData()
        parsableData.output = self
    }
}

extension HomeUsersViewController: OutputHomeViewData {
    
    func didReceivedOutPutData(_ userViewModel: [UsersViewModel]?, error: Error?) {
        if let userVM = userViewModel {
            self.userVM = userVM
            print("VM:\(self.userVM)")
        } else if let _ = error {
            
        } else {
            
        }
    }
}
