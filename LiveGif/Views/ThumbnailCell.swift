//
//  LivePhotoCollectionViewCell.swift
//  LiveGif
//
//  Created by Pete Smith on 02/04/2016.
//  Copyright © 2016 Pete Smith. All rights reserved.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
    
    // Properties
    var photoAssetIdentifier = ""
    var thumbnailImage: UIImage? {
        didSet {
            if let image = thumbnailImage {
                thumbnail.image = image
            }
        }
    }
    
    // IB Outlets
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func prepareForReuse() {
        thumbnail.image = nil
    }
}
