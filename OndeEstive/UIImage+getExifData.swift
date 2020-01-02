//
//  UIImage+Exif.swift
//  OndeEstive
//
//  Created by Lucas Menezes on 1/1/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import UIKit
extension UIImage {
    func getExifData() -> CFDictionary? {
        var exifData: CFDictionary? = nil
        if let data = self.jpegData(compressionQuality: 1.0) {
            data.withUnsafeBytes {(bytes: UnsafePointer<UInt8>)->Void in
                if let cfData = CFDataCreate(kCFAllocatorDefault, bytes, data.count) {
                    let source = CGImageSourceCreateWithData(cfData, nil)
                    exifData = CGImageSourceCopyPropertiesAtIndex(source!, 0, nil)
                }
            }
        }
        return exifData
    }
}
