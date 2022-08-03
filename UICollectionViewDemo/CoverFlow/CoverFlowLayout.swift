//
//  CoverFlowLayout.swift
//  UICollectionViewDemo
//
//  Created by alenpaulkevin on 2017/6/23.
//  Copyright © 2017年 alenpaulkevin. All rights reserved.
//

import UIKit

class CoverFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // Получить массив макетов для этого диапазона
        let attributes = super.layoutAttributesForElements(in: rect)
        // найти центральную точку
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        
        // Каждая точка масштабируется в соответствии с расстоянием от центральной точки
        attributes!.forEach({ (attr) in
            let pad = abs(centerX - attr.center.x)
            let scale = 1.8 - pad / collectionView!.bounds.width
            attr.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
        return attributes
    }
    
    /// Переопределить, где остановиться при прокрутке
    ///
    /// - Parameters:
    ///   - proposedContentOffset: указать, чтобы остановиться
    ///   - velocity: скорость прокрутки
    /// - Returns: точка остановки прокрутки
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var targetPoint = proposedContentOffset
        
        // 中心点
        let centerX = proposedContentOffset.x + collectionView!.bounds.width
        
        // Получить массив макетов для этого диапазона
        let attributes = self.layoutAttributesForElements(in: CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: collectionView!.bounds.width, height: collectionView!.bounds.height))
        
        // Минимальное расстояние для перемещения
        var moveDistance: CGFloat = CGFloat(MAXFLOAT)
        // Пройдите массив, чтобы найти минимальное расстояние
        attributes!.forEach { (attr) in
            if abs(attr.center.x - centerX) < abs(moveDistance) {
                moveDistance = attr.center.x - centerX
            }
        }
        // Перемещение только в пределах ContentSize
        if targetPoint.x > 0 && targetPoint.x < collectionViewContentSize.width - collectionView!.bounds.width {
            targetPoint.x += moveDistance
        }
        
        return targetPoint
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {        
        return CGSize(width:sectionInset.left + sectionInset.right + (CGFloat(collectionView!.numberOfItems(inSection: 0)) * (itemSize.width + minimumLineSpacing)) - minimumLineSpacing, height: 0)
    }
}
