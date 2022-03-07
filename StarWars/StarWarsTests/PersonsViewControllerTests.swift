//
//  PersonsViewControllerTests.swift
//  StarWarsTests
//
//  Created by Paul O'Neill on 3/4/22.
//

@testable import StarWars
import XCTest

class PersonsViewControllerTests: XCTestCase {
    var sut: PersonsViewController!
    

    override func tearDownWithError() throws {
        sut = nil
    }

    func testViewDidLoad_tableViewDelegateAndDataSource_shouldNotBeNil() {
        let person1 = Test_Person(name: "Ryan")
        let person2 = Test_Person(name: "Joe")
        let person3 = Test_Person(name: "Cal")
        
        let viewModel = PersonsViewController.ViewModel(service: MockPersonService(persons: [person1, person2, person3]))
        
        sut = PersonsViewController(viewModel)
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.contentView.tableView.delegate)
        XCTAssertNotNil(sut.contentView.tableView.dataSource)
    }
    
    func testDidSelect_selectFirstIndex_shouldPushVC() {
        // Arrange
        let person1 = Test_Person(name: "Ryan")
        let person2 = Test_Person(name: "Joe")
        let person3 = Test_Person(name: "Cal")
        let viewModel = PersonsViewController.ViewModel(service: MockPersonService(persons: [person1, person2, person3]))
        sut = PersonsViewController(viewModel)
        
        let window = UIWindow()
        let navigationController = UINavigationController(rootViewController: sut)
        
        guard let topViewController = navigationController.topViewController as? PersonsViewController else {
            XCTFail("Unable to load view controller `PersonsViewController`")
            return
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        topViewController.loadViewIfNeeded()
        
        // Act
        
        topViewController.tableView(topViewController.contentView.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        RunLoop.current.run(until: Date())
        
        
        // Assert
        XCTAssertTrue(navigationController.topViewController is PersonDetailViewController)
        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
    
    func testDidSelect_selectBadIndex_shouldNotPushVC() {
        // Arrange
        let person1 = Test_Person(name: "Ryan")
        let person2 = Test_Person(name: "Joe")
        let person3 = Test_Person(name: "Cal")
        let viewModel = PersonsViewController.ViewModel(service: MockPersonService(persons: [person1, person2, person3]))
        sut = PersonsViewController(viewModel)
        
        let window = UIWindow()
        let navigationController = UINavigationController(rootViewController: sut)
        
        guard let topViewController = navigationController.topViewController as? PersonsViewController else {
            XCTFail("Unable to load view controller `PersonsViewController`")
            return
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        topViewController.loadViewIfNeeded()
        
        // Act
        topViewController.tableView(topViewController.contentView.tableView, didSelectRowAt: IndexPath(row: 10, section: 1))
        RunLoop.current.run(until: Date())
        
        
        // Assert
        XCTAssertTrue(navigationController.topViewController is PersonsViewController)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
    
    func testUpdateSearchResults_searchBarTextR_results1() {
        // Arrange
        let person1 = Test_Person(name: "Ryan")
        let person2 = Test_Person(name: "Joe")
        let person3 = Test_Person(name: "Cal")
        let viewModel = PersonsViewController.ViewModel(service: MockPersonService(persons: [person1, person2, person3]))
        sut = PersonsViewController(viewModel)
        
        let window = UIWindow()
        let navigationController = UINavigationController(rootViewController: sut)
        
        guard let topViewController = navigationController.topViewController as? PersonsViewController else {
            XCTFail("Unable to load view controller `PersonsViewController`")
            return
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        topViewController.loadViewIfNeeded()
        
        // Act
        topViewController.searchController.searchBar.text = "R"
        RunLoop.current.run(until: Date())
        
        // Assert
        DispatchQueue.main.async {
            XCTAssertEqual(topViewController.contentView.tableView.numberOfRows(inSection: 0), 1)
        }
    }
    
    func testUpdateSearchResults_searchBarTextRy_results2() {
        // Arrange
        let person1 = Test_Person(name: "Ryan")
        let person2 = Test_Person(name: "Ryo")
        let person3 = Test_Person(name: "Cal")
        let viewModel = PersonsViewController.ViewModel(service: MockPersonService(persons: [person1, person2, person3]))
        sut = PersonsViewController(viewModel)
        
        let window = UIWindow()
        let navigationController = UINavigationController(rootViewController: sut)
        
        guard let topViewController = navigationController.topViewController as? PersonsViewController else {
            XCTFail("Unable to load view controller `PersonsViewController`")
            return
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        topViewController.loadViewIfNeeded()
        
        // Act
        topViewController.searchController.searchBar.text = "R"
        RunLoop.current.run(until: Date())
        
        // Assert
        DispatchQueue.main.async {
            XCTAssertEqual(topViewController.contentView.tableView.numberOfRows(inSection: 0), 2)
        }
    }
    
    func testUpdateSearchResults_errorLoading_errorIsVisible() {
        // Arrange
        let error = NetworkManagerError.badHTTPResponse
        let viewModel = PersonsViewController.ViewModel(service: MockPersonService(error: error))
        sut = PersonsViewController(viewModel)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: sut)
        
        guard let topViewController = navigationController.topViewController as? PersonsViewController else {
            XCTFail("Unable to load view controller `PersonsViewController`")
            return
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // Act
        topViewController.loadViewIfNeeded()
        
        let expectation = expectation(description: "wait for modal to present")
        
        // Assert
        DispatchQueue.main.async {
            let presentedViewController = navigationController.presentedViewController
            XCTAssertNotNil(presentedViewController)
            XCTAssert(presentedViewController is UIAlertController)
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 0.1)
    }
}
