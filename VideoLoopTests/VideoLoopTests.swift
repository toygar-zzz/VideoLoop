//
//  VideoLoopTests.swift
//  VideoLoopTests
//
//  Created by Pi on 11/5/16.
//  Copyright © 2016 Pi Dynamics. All rights reserved.
//

import UIKit
import XCTest
@testable import VideoLoop

class VideoLoopTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
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
  
  func testVideoCut(){
    let videoCutter = Trimmer()
    let url = NSURL.fileURL(withPath: Bundle.main.path(forResource: "test", ofType: "mp4")!)
    videoCutter.cropVideoWithUrl(
      videoUrl: url,
      startTime: 0.0,
      duration: 1.0) { (videoPath, error) -> Void in
        if let path = videoPath as NSURL? {
          DispatchQueue.main.async {
            XCTAssertNotNil(path, "video cut has failed")
          }
        }
    }
  }
}
