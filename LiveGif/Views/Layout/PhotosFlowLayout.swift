//
//  PhotosFlowLayout.swift
//  LiveGif
//
//  Created by Pete Smith on 03/04/2016.
//  Copyright © 2016 Pete Smith. All rights reserved.
//

import UIKit

struct PhotosFlowLayoutConstants {
    static let minimumItemSpacing: CGFloat = 3.0
}

class PhotosFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        
        // We present photos in rows of 3
        let itemDimension = UIScreen.mainScreen().bounds.width/3 - (2 * PhotosFlowLayoutConstants.minimumItemSpacing)
        itemSize = CGSize(width: itemDimension, height: itemDimension)
        minimumInteritemSpacing = PhotosFlowLayoutConstants.minimumItemSpacing
    }

}
