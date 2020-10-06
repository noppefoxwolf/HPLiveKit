//
//  FilePublisher.swift
//  HPLiveKit
//
//  Created by Huiping Guo on 2018/08/20.
//  Copyright © 2018 Huiping Guo. All rights reserved.
//

import Foundation
import HPLibRTMP

class FilePublisher: NSObject {

    private let rtmpSendQueue = DispatchQueue.global(qos: .userInitiated)

    private var fileHandle: FileHandle?
    
    private var fileName: String = ""
    
    private var patch: String {
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            fatalError("cannot find document path")
        }
        return documentsPath + "/abc.mp4"
    }
    
    override init() {
        super.init()
        
        fileHandle = FileHandle(forWritingAtPath: patch)
    }

    func start() {
        rtmpSendQueue.async {
        }
    }

    func stop() {
        rtmpSendQueue.async {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
        }
    }


    private func clean() {
       
    }

    func send(frame: Frame) {
        guard let frame = frame as? VideoFrame else { return }
        
        saveVideoFrame(frame)
    }
    
    func saveVideoFrame(_ frame: VideoFrame) {
        if frame.isKeyFrame {
            save(sps: frame.sps!, pps: frame.pps!)
            save(frameData: frame.data!)
            return
        }
        
        save(frameData: frame.data!)
    }
    
    private func save(sps: Data, pps: Data) {
        fileHandle?.write(naluHeader)
        fileHandle?.write(sps)
        
        fileHandle?.write(naluHeader)
        fileHandle?.write(pps)
    }
    
    private func save(frameData: Data) {
        fileHandle?.write(naluHeader)
        fileHandle?.write(frameData)
    }
    
    private var naluHeader: Data {
        let header:[UInt8] = [0x00,0x00,0x00,0x01]
        return Data(bytes: header)
    }

}
