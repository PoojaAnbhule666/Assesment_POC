//
//  Assignment_POCTests.swift
//  Assignment_POCTests
//
//  Created by Pooja on 26/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import XCTest
@testable import Assignment_POC

class AssignmentPOCTests: XCTestCase {
    var viewControllerUnderTest: ViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.tableViewFacts )
    }
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.tableViewFacts.dataSource)
    }
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
    func testDownloadWebData() {
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Download Facts")
        // Create a URL for a web page to be downloaded.
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        // Create a background task to download the web page.
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded.")
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }
        // Start the download task.
        dataTask.resume()
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
}
