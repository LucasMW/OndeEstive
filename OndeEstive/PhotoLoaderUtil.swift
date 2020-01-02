//
//  PhotoLoaderUtil.swift
//  OndeEstive
//
//  Created by Lucas Menezes on 1/1/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import Foundation
import UIKit
import Photos
func getUIImage(asset: PHAsset) -> UIImage? {

    var img: UIImage?
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    options.version = .original
    options.isSynchronous = true
    do {
        try manager.requestImageData(for: asset, options: options) { data, _, _, _ in

               if let data = data {
                   img = UIImage(data: data)
               }
           }
           return img
    } catch {
        return nil
    }
}
func fetchPhotoFromLibrary() -> [LocatableImage] {
  var imageLocationPairs = [LocatableImage]()
    let fetchOptions: PHFetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
  let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
 fetchResult.enumerateObjects { (object, index, stop) -> Void in
        let options = PHImageRequestOptions()
     options.isSynchronous = true
     options.deliveryMode = .highQualityFormat
  print("\(object.creationDate)")
    guard let location = object.location else {
        return
    }
  let lat = location.coordinate.latitude
    let long = location.coordinate.longitude
  print("coordinates (\(lat),\(long))")
    
  if let img = getUIImage(asset: object){
    let x = LocatableImage(location: location,image: img)
    imageLocationPairs.append(x)
  }
  let count = fetchResult.countOfAssets(with: .image)
  print("found \(count) pictures")
  print("retrieved with coordinates \(imageLocationPairs.count) pictures")
     PHImageManager.default().requestAVAsset(forVideo: object , options: .none) { (avAsset, avAudioMix, dict) -> Void in
            print(avAsset)
        }
    }
  return imageLocationPairs
}
