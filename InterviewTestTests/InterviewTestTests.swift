//
//  InterviewTestTests.swift
//  InterviewTestTests
//
//  Created by Avinash Boora on 2/5/21.
//

import XCTest
@testable import InterviewTest

class InterviewTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSuccessfulAPIResponse() {
        let session = URLSessionMock()
        let manager = NetworkManager(session: session)
        
        let data = Data(bytes: [0, 1, 0, 1], count: 4)
        session.data = data
        
        let url = URL(fileURLWithPath: "url")
        manager.qeustionAPI(with: url) { (qns, res, error) in
            XCTAssert(error == nil)
        }
    }
    
    func testQuestionAPI(){
        if let path = Bundle.main.path(forResource: "answers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let session = URLSessionMock()
                let manager = NetworkManager(session: session)
                session.data = data
                let url = URL(fileURLWithPath: "url")
                manager.qeustionAPI(with: url) { [self] (qns, res, error) in
                    XCTAssert(qns?.items.count ?? 0 > 0)
                    testHasAnsweredQuestion(qns: qns?.items)
                }
            } catch {
                XCTAssert(false)
            }
        }
    }
    
    func testHasAnsweredQuestion(qns : [Item]?){
        if let hasQuestions = qns {
            let qns = hasQuestions.filter{$0.isAnswered && $0.answerCount > 0}
            XCTAssert(qns.count > 0)
        }
        XCTAssert(true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
