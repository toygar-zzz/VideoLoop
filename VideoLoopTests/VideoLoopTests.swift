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
  }

  override func tearDown() {
    super.tearDown()
  }

  func testVideoCut() {
    let videoCutter = Trimmer()
    let url = NSURL.fileURL(withPath: Bundle.main.path(forResource: "test", ofType: "mp4")!)
    videoCutter.cropVideoWithUrl(
      videoUrl: url,
      startTime: 0.0,
      duration: 2.0) { (videoPath, error) -> Void in
        if let path = videoPath as NSURL? {
          DispatchQueue.main.async {
            XCTAssertNotNil(path, "video cut has failed")
          }
        }
    }
  }
}
