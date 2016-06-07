//
//  LivePhotoCollectionViewController.swift
//  LiveGif
//
//  Created by Pete Smith on 02/04/2016.
//  Copyright © 2016 Pete Smith. All rights reserved.
//

import UIKit
import PhotosUI

private let reuseIdentifier = "thumbnailCell"

class LivePhotoCollectionViewController: UICollectionViewController {
    
    // Photos
    private var photosFetchResult = PHFetchResult()
    
    // Image Caching
    private lazy var imageManager = PHCachingImageManager()
    
    // Thumbnails
    private var thumbnailSize = CGSize.zero

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Calculate the size of the thumbnails we need to fetch
        let scale = UIScreen.mainScreen().scale
        if let cellSize = (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize {
            thumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale);
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Begin caching assets in and around collection view's visible rect.
        updateCachedAssets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosFetchResult.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Get the associated photo asset
        let photoAsset = photosFetchResult[indexPath.item] as! PHAsset
        
        let photoCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ThumbnailCell
        
        photoCell.photoAssetIdentifier = photoAsset.localIdentifier
        
        // Request a suitably sized thumbnail image for the asset from the PHCachingImageManager.
        imageManager.requestImageForAsset(photoAsset, targetSize: thumbnailSize, contentMode: .AspectFill, options: nil, resultHandler: { (image: UIImage?, info: [NSObject : AnyObject]?) in
            if let photoThumbnail = image {
                // If the cell is still showing this photo asset, set the thumbnail image
                if photoAsset.localIdentifier == photoCell.photoAssetIdentifier {
                    photoCell.thumbnailImage = photoThumbnail
                }
            }
        })
    
        return photoCell
    }
    
    // MARK: - Caching
    
    func updateCachedAssets() {
        guard isViewLoaded() && self.view.window != nil else {
            return
        }
        
        // The preheat window is twice the height of the visible rect.
        if var preheatRect = collectionView?.bounds {
            preheatRect = CGRectInset(preheatRect, 0.0, -0.5 * preheatRect.height)
            
            // Check if the collection view is showing an area
        }
        
//        // The preheat window is twice the height of the visible rect.
//        CGRect preheatRect = self.collectionView.bounds;
//        preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
//        
//        /*
//         Check if the collection view is showing an area that is significantly
//         different to the last preheated area.
//         */
//        CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
//        if (delta > CGRectGetHeight(self.collectionView.bounds) / 3.0f) {
//            
//            // Compute the assets to start caching and to stop caching.
//            NSMutableArray *addedIndexPaths = [NSMutableArray array];
//            NSMutableArray *removedIndexPaths = [NSMutableArray array];
//            
//            [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
//                NSArray *indexPaths = [self.collectionView aapl_indexPathsForElementsInRect:removedRect];
//                [removedIndexPaths addObjectsFromArray:indexPaths];
//                } addedHandler:^(CGRect addedRect) {
//                NSArray *indexPaths = [self.collectionView aapl_indexPathsForElementsInRect:addedRect];
//                [addedIndexPaths addObjectsFromArray:indexPaths];
//                }];
//            
//            NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
//            NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
//            
//            // Update the assets the PHCachingImageManager is caching.
//            [self.imageManager startCachingImagesForAssets:assetsToStartCaching
//                targetSize:AssetGridThumbnailSize
//                contentMode:PHImageContentModeAspectFill
//                options:nil];
//            [self.imageManager stopCachingImagesForAssets:assetsToStopCaching
//                targetSize:AssetGridThumbnailSize
//                contentMode:PHImageContentModeAspectFill
//                options:nil];
//            
//            // Store the preheat rect to compare against in the future.
//            self.previousPreheatRect = preheatRect;
//        }

    }
    
    func resetCachedPhotos() {
        imageManager.stopCachingImagesForAllAssets()
    }

}
