//
//  LiveSession.swift
//  HPLiveKit
//
//  Created by Huiping Guo on 2018/08/20.
//  Copyright © 2018 Huiping Guo. All rights reserved.
//

import Foundation
import UIKit

public class LiveSession {

    fileprivate let audioConfiguration: LiveAudioConfiguration
    fileprivate let videoConfiguration: LiveVideoConfiguration

    fileprivate var videoCapture: LiveVideoCapture?
    fileprivate var audioCapture: LiveAudioCapture?

    public var perview: UIView? {
        get {
            return videoCapture?.perview
        }
        set {
            videoCapture?.perview = newValue
        }
    }

    public var warterMarkView: UIView? {
        get {
            return videoCapture?.warterMarkView
        }
        set {
            videoCapture?.warterMarkView = newValue
        }
    }

    var streamInfo: LiveStreamInfo?

    public init(audioConfiguration: LiveAudioConfiguration, videoConfiguration: LiveVideoConfiguration) {
        self.audioConfiguration = audioConfiguration
        self.videoConfiguration = videoConfiguration

        videoCapture = LiveVideoCapture(videoConfiguration: videoConfiguration)
        audioCapture = LiveAudioCapture(configuration: audioConfiguration)
    }

    public func startLive() {
        //        videoCapture?.running = true
        audioCapture?.running = true
    }

    public func stopLive() {
        videoCapture?.running = false
        audioCapture?.running = false
    }
}
