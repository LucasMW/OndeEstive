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
func removeExifFromLibrary() {
    let lib = PHPhotoLibrary()
    lib.performChanges({
        print("changes")
    }) { (bool, error) in
        print(bool,error)
    }
    let fetchResult = PHAsset.fetchAssets(with: .image, options: nil)
    let res = PHChange.init().changeDetails(for: fetchResult )
    
}
//from https://stackoverflow.com/questions/32788736/swift-how-to-delete-exif-data-from-picture-taken-with-avfoundation
func saveToPhotoLibrary_iOS9(data:NSData, completionHandler: @escaping (PHAsset?)->()) {
    var assetIdentifier: String?
    PHPhotoLibrary.requestAuthorization { (status:PHAuthorizationStatus) in
        if(status == PHAuthorizationStatus.authorized){
            
            PHPhotoLibrary.shared().performChanges({
                let creationRequest = PHAssetCreationRequest.forAsset()
                let placeholder = creationRequest.placeholderForCreatedAsset
                
                creationRequest.addResource(with: PHAssetResourceType.photo, data: data as Data, options: nil)
                assetIdentifier = placeholder?.localIdentifier
                
            }, completionHandler: { (success, error) in
                if let error = error {
                    print("There was an error saving to the photo library: \(error)")
                }
                
                var asset: PHAsset? = nil
                if let assetIdentifier = assetIdentifier{
                    asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetIdentifier], options: nil).firstObject//fetchAssetsWithLocalIdentifiers([assetIdentifier], options: nil).firstObject as? PHAsset
                }
                completionHandler(asset)
            })
        }else {
            print("Need authorisation to write to the photo library")
            completionHandler(nil)
        }
    }
    
}
func fetchLocationsFromLibrary() -> [CLLocation] {
    var locations = [CLLocation]()
    let fetchOptions: PHFetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
    fetchResult.enumerateObjects { (object, index, stop) -> Void in
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .fastFormat
        guard let location = object.location else {
            return
        }
        locations.append(location)
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        print("coordinates (\(lat),\(long))")
    }
    return locations
}
func fetchPhotoFromLibrary() -> [LocatableImage] {
    listAlbums()
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
