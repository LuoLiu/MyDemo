//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by LuoLiu on 16/10/26.
//  Copyright © 2016年 Razeware LLC. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
  
  func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
  
  func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {

  var delegate: PinterestLayoutDelegate!
  
  var numOfColumns = 2
  var cellPadding: CGFloat = 6.0
  
  private var cache = [PinterestLayoutAttributes]()
  
  private var contentHeight: CGFloat = 0.0
  private var contentWidth: CGFloat {
    let insets = collectionView!.contentInset
    return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
  }
  
  override func prepareLayout() {
    if cache.isEmpty {
      
      let columnWidth = contentWidth / CGFloat(numOfColumns)
      var xOffset = [CGFloat]()
      for column in 0..<numOfColumns {
        xOffset.append(CGFloat(column) * columnWidth)
      }
      
      var column = 0
      var yOffset = [CGFloat](count: numOfColumns, repeatedValue: 0)
      for item in 0..<collectionView!.numberOfItemsInSection(0) {
        
        let indexPath = NSIndexPath(forItem: item, inSection: 0)
        let width = columnWidth - cellPadding * 2
        let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
        let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
        let height = cellPadding * 2 + photoHeight + annotationHeight
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
        
        let attributes = PinterestLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.photoHeight = photoHeight
        attributes.frame = insetFrame
        cache.append(attributes)
        
        contentHeight = max(contentHeight, CGRectGetMaxY(frame))
        yOffset[column] += height
        
//        column = column >= (numOfColumns - 1) ? 0 : ++column
        if column >= numOfColumns - 1 {
          column = 0
        } else {
          column += 1
        }
      }
    }
  }
  
  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in cache {
      if CGRectIntersectsRect(attributes.frame, rect) {
        layoutAttributes.append(attributes)
      }
    }
    
    return layoutAttributes
  }
  
  override class func layoutAttributesClass() -> AnyClass {
    return PinterestLayoutAttributes.self
  }

}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
  
  var photoHeight: CGFloat = 0.0
  
  override func copyWithZone(zone: NSZone) -> AnyObject {
    let copy = super.copyWithZone(zone) as! PinterestLayoutAttributes
    copy.photoHeight = photoHeight
    
    return copy
  }
  
  override func isEqual(object: AnyObject?) -> Bool {
    if let attributes = object as? PinterestLayoutAttributes {
      if attributes.photoHeight == photoHeight {
        return super.isEqual(object)
      }
    }
    return false
  }
  
}
