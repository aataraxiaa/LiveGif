//
//  LivePhotosViewModel.swift
//  LiveGif
//
//  Created by Pete Smith on 03/04/2016.
//  Copyright © 2016 Pete Smith. All rights reserved.
//

import Photos
import ReactiveCocoa

struct PhotosViewModel {
    
    // Array of PHAssets representing photos
    var photos = MutableProperty<PHFetchResult>(PHFetchResult())
    
    // Function to load live photos and store the result
    mutating func refreshPhotos() {
        // Set our photo fetching options
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaSubtype = %d", argumentArray: [PHAssetMediaSubtype.PhotoLive.rawValue])
        
        // Fetch all live photos
        photos = MutableProperty(PHAsset.fetchAssetsWithOptions(fetchOptions))
    }
    
}
