//
//  Trimmer.swift
//  VideoLoop
//
//  Created by Pi on 11/5/16.
//  Copyright © 2016 Pi Dynamics. All rights reserved.
//

import UIKit
import AVFoundation

extension String {
  var convert: NSString { return (self as NSString) }
}

public class Trimmer: NSObject {

  /**
  Block based method for crop video url

  @param videoUrl Video url
  @param startTime The starting point of the video segments
  @param duration Total time, video length

  */
  public func cropVideoWithUrl(videoUrl url: NSURL, startTime: CGFloat, duration: CGFloat,
    completion: ((_ videoPath: NSURL?, _ error: NSError?) -> Void)?) {
    let queue = DispatchQueue(label: "com.pidynamics.videoloop")
    queue.async {
      let asset = AVURLAsset(url: url as URL, options: nil)
      let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
      let paths: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory,
        .userDomainMask, true) as NSArray
      var outputURL = paths.object(at: 0) as? String
      let manager = FileManager.default
      do {
        try manager.createDirectory(
          atPath: outputURL!,
          withIntermediateDirectories: true,
          attributes: nil)
      } catch _ {
      }
      outputURL = outputURL!.convert.appendingPathComponent("output.mp4")
      do {
        try manager.removeItem(atPath: outputURL!)
      } catch _ {
      }
      if let exporter = exporter as AVAssetExportSession? {
        let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
        let duration = CMTimeMakeWithSeconds(Float64(duration), 600)
        let range = CMTimeRangeMake(start, duration)
        exporter.outputURL = NSURL(fileURLWithPath: outputURL!) as URL
        exporter.shouldOptimizeForNetworkUse = true
        exporter.outputFileType = AVFileTypeMPEG4
        exporter.timeRange = range
        exporter.exportAsynchronously(completionHandler: {
          switch exporter.status{
          case AVAssetExportSessionStatus.completed:
            completion?(exporter.outputURL as NSURL?, nil)
          case AVAssetExportSessionStatus.failed:
            print("Failed: \(exporter.error)")
          case AVAssetExportSessionStatus.cancelled:
            print("Failed: \(exporter.error)")
          default:
            print("default case")
          }
        })
      } else{
        print("exportSession nil")
      }
      
    }
  }
}
