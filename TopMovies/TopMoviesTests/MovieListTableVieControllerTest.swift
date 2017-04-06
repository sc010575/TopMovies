//
//  MovieListTableVieControllerTest.swift
//  TopMovies
//
//  Created by Suman Chatterjee on 06/04/2017.
//  Copyright © 2017 Suman Chatterjee. All rights reserved.
//

import XCTest
import UIKit
import Foundation
@testable import TopMovies

class MovieListTableVieControllerTest: XCTestCase {
    
    var systemUnderTest: MovieListTableViewController!

    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        
        systemUnderTest = navigationController.topViewController as! MovieListTableViewController
        
        //Load View hierarchy
        _ = systemUnderTest.view

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad() {
        
        XCTAssertNotNil(systemUnderTest.tableView)
    }
    
    func test_ShouldSetTableViewDataSource() {
        
        XCTAssertNotNil(systemUnderTest.tableView.dataSource)
    }
    
    func test_ShouldSetTableViewDelegate() {
        
        XCTAssertNotNil(systemUnderTest.tableView.dataSource)
    }
    
    func testSUT_ShouldSetTableViewDataSource() {
        
        XCTAssertNotNil(systemUnderTest.tableView.dataSource)
    }
    
}
