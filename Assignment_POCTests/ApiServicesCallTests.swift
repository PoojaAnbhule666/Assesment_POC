//
//  ApiServicesCallTests.swift
//  Assignment_POCTests
//
//  Created by Deep on 09/04/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import XCTest
@testable import Assignment_POC
class ApiServicesCallTests: XCTestCase {
    var fact: FactsService?
          override func setUp() {
              super.setUp()
              fact = FactsService()
          }
          override func tearDown() {
              fact = nil
              super.tearDown()
          }
          func test_fetch_facts() {
              // Given A apiservice
              let fact = self.fact!
              var rowsArray = [Rows]()
              // When fetch popular photo
              let expect = XCTestExpectation(description: "callback")
              fact.apiCall { (isSuccesfull, response) in
                  expect.fulfill()
                  do {
                      let decoder = JSONDecoder()
                      guard let responseData = response as? Data else {
                          return
                      }
                      let jsonData = try decoder.decode(FactsData.self, from: responseData)
                      rowsArray = jsonData.rows ?? []
                      XCTAssertEqual( rowsArray.count, 20)
                      for row in rowsArray {
                          XCTAssertNotNil(row.title)
                      }
                  } catch {
                      print("error----", error.localizedDescription)
                  }
              }
          }

}
