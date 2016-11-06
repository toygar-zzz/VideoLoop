//
//  VideoLoopController.swift
//  VideoLoop
//
//  Created by Pi on 11/5/16.
//  Copyright © 2016 Pi Dynamics. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

public enum ScalingMode {
  case Resize
  case ResizeAspect
  case ResizeAspectFill
}

public class VideoLoopController: UIViewController {

  private let moviePlayer = AVPlayerViewController()
  private var moviePlayerSoundLevel: Float = 1.0
  public var contentURL: NSURL = NSURL() {
    didSet {
      setMoviePlayer(url: contentURL)
    }
  }

  public var videoFrame: CGRect = CGRect()
  public var startTime: CGFloat = 0.0
  public var duration: CGFloat = 0.0
  public var backgroundColor: UIColor = UIColor.black {
    didSet {
      view.backgroundColor = backgroundColor
    }
  }
  public var sound: Bool = true {
    didSet {
      if sound {
        moviePlayerSoundLevel = 1.0
      } else {
        moviePlayerSoundLevel = 0.0
      }
    }
  }
  public var alpha: CGFloat = CGFloat() {
    didSet {
      moviePlayer.view.alpha = alpha
    }
  }
  public var alwaysRepeat: Bool = true {
    didSet {
      if alwaysRepeat {
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(VideoLoopController.playerItemDidReachEnd),
          name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
          object: moviePlayer.player?.currentItem)
      }
    }
  }
  public var fillMode: ScalingMode = .ResizeAspectFill {
    didSet {
      switch fillMode {
      case .Resize:
        moviePlayer.videoGravity = AVLayerVideoGravityResize
      case .ResizeAspect:
        moviePlayer.videoGravity = AVLayerVideoGravityResizeAspect
      case .ResizeAspectFill:
        moviePlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
      }
    }
  }

  public var restartForeground: Bool = false {
    didSet {
      if restartForeground {
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(VideoLoopController.playerItemDidReachEnd),
          name: NSNotification.Name.UIApplicationWillEnterForeground,
          object: nil)
      }
    }
  }

  override public func viewDidAppear(_ animated: Bool) {
    moviePlayer.view.frame = videoFrame
    moviePlayer.view.backgroundColor = self.backgroundColor
    moviePlayer.showsPlaybackControls = false
    moviePlayer.view.isUserInteractionEnabled = false
    view.addSubview(moviePlayer.view)
    view.sendSubview(toBack: moviePlayer.view)
  }

  override public func viewWillDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }

  private func setMoviePlayer(url: NSURL) {
    let videoCutter = Trimmer()
    videoCutter.cropVideoWithUrl(
      videoUrl: url as URL,
      startTime: startTime,
      duration: duration) { (videoPath, error) -> Void in
        if let path = videoPath as NSURL? {
          let queue = DispatchQueue(label: "com.pidynamics.videoplayer")
          queue.async {
            self.moviePlayer.player = AVPlayer(url: path as URL)
            self.moviePlayer.player?.addObserver(
              self,
              forKeyPath: "status",
              options: .new,
              context: nil)
            self.moviePlayer.player?.play()
            self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
          }
        }
    }
  }

  public func observeValueForKeyPath(
    keyPath: String?,
    ofObject object: AnyObject?,
    change: [String : AnyObject]?,
    context: UnsafeMutableRawPointer) {
    guard let realObject = object, object != nil else {
      return
    }
    if !realObject.isKind(of: AVPlayer.self) {
      return
    }
    if realObject as? AVPlayer != self.moviePlayer.player || keyPath! != "status" {
      return
    }
    if self.moviePlayer.player?.status == AVPlayerStatus.readyToPlay {
      self.movieReadyToPlay()
    }
  }

  deinit {
    self.moviePlayer.player?.removeObserver(self, forKeyPath: "status")
    NotificationCenter.default.removeObserver(self)

  }

  // Override in subclass
  public func movieReadyToPlay() { }

  override public func viewDidLoad() {
    super.viewDidLoad()
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func playerItemDidReachEnd() {
    moviePlayer.player?.seek(to: kCMTimeZero)
    moviePlayer.player?.play()
  }

  func playVideo() {
    moviePlayer.player?.play()
  }

  func pauseVideo() {
    moviePlayer.player?.pause()
  }
}
