//
//  HorizontalSnappingController.swift
//  AppStore
//
//  Created by Emir Alkal on 27.02.2023.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    convenience init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        self.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
}

final class SnappingLayout: UICollectionViewFlowLayout {
    // From stackoverflow
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)

        let itemWidth = collectionView.frame.size.width * 0.9
        let itemSpace = itemWidth + minimumInteritemSpacing
        var currentItemIdx = round(collectionView.contentOffset.x / itemSpace)

        // Skip to the next cell, if there is residual scrolling velocity left.
        // This helps to prevent glitches
        let vX = velocity.x
        if vX > 0 {
          currentItemIdx += 1
        } else if vX < 0 {
          currentItemIdx -= 1
        }

        let nearestPageOffset = currentItemIdx * itemSpace
        return CGPoint(x: nearestPageOffset,
                       y: parent.y)
      }
}
