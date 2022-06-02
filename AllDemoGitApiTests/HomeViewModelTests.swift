//
//  HomeViewModelTests.swift
//  AllDemoGitApiTests
//
//  Created by C879403 on 31/05/22.
//

import XCTest
@testable import AllDemoGitApi

class HomeViewModelTests: XCTestCase {

    var sut: HomeUsersViewModel!
    var parsable: MockHomeViewModel!
    var output: MockOutputHomeViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        output = MockOutputHomeViewModel()
        parsable = MockHomeViewModel()
        mockNetworkManager = MockNetworkManager()
        sut = HomeUsersViewModel(getApiData: parsable.netManager)
        sut.output = output
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        output = nil
        parsable = nil
        sut = nil
        mockNetworkManager = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetAPIDataWithSuccess() {
        //given
        parsable.getParsableData()
         
        //when
        sut.getParsableData()
        
        //then
        XCTAssertEqual(sut.arrayUsersViewModel.count, 0)
    }
    
    func testGetAPIDataWithFailure() {
       
    }

}

class MockHomeViewModel: ParsableData {
    
    var output: OutputHomeViewData?
    var arrayUsersViewModel: [UsersViewModel] = []
    var netManager: GetAPIRquestData = MockNetworkManager()
    
    func getParsableData() {
        netManager.getAPIData { _ in
//            let userObj = HomeUsersModelElement(login: "", id: 1, nodeID: "", avatarURL: "", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: nil, siteAdmin: true)
//            let newObj = [UsersViewModel(userModel: userObj)]
            //self.output?.didReceivedOutPutData(newObj, error: nil)
        }
    }
}

class MockOutputHomeViewModel: OutputHomeViewData {

    var userVM: [UsersViewModel] = []
    var errorVM: Error = NSError()
    
    func didReceivedOutPutData(_ userViewModel: [UsersViewModel]?, error: Error?) {
        if let vm = userViewModel {
            userVM = vm
        } else {
            errorVM = error!
        }
    }
}

class MockNetworkManager: GetAPIRquestData {
    
    var path: String = ""
    var method: String = ""
    var mockResult: Result<Data, Error>?
    
    func getAPIData(_ completion: @escaping (Result<Data, Error>) -> Void) {
        if let mockResult = mockResult {
            
            completion(mockResult)
        }
    }
}
