//
//  PhotoAlbunsUtil.swift
//  OndeEstive
//
//  Created by Lucas Menezes on 1/15/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import Photos

class AlbumModel {
  let name:String
  let count:Int
  let collection:PHAssetCollection
  init(name:String, count:Int, collection:PHAssetCollection) {
    self.name = name
    self.count = count
    self.collection = collection
  }
}

func listAlbums() {
    var album:[AlbumModel] = [AlbumModel]()
    
    let options = PHFetchOptions()
    let userAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options)
    print(userAlbums)
    userAlbums.enumerateObjects{ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
        
        if object is PHAssetCollection {
            let obj:PHAssetCollection = object as! PHAssetCollection
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            
            let newAlbum = AlbumModel(name: obj.localizedTitle!, count: obj.estimatedAssetCount, collection:obj)
            album.append(newAlbum)
        }
    }
    
    for item in album {
        print(item.name)
    }
}
