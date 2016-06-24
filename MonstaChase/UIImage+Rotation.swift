//
//  UIImage+Rotation.swift
//  MonstaChase
//
//  Created by Christoph Leimbrock on 24/06/16.
//  Copyright © 2016 chris. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func imageForDirection(dir:Direction) -> UIImage {
        var angle: CGFloat = 0
        switch dir {
        case .East: angle = 0
        case .West: angle = 180
        case .North: angle = -90
        case .South: angle = 90
        }
        return imageRotatedByDegrees(angle, flip: false)
    }

    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }

        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
        let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size

        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()

        // Move the origin to the middle of the image so we will rotate and scale around the center.
        CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);

        //   // Rotate the image context
        CGContextRotateCTM(bitmap, degreesToRadians(degrees));

        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat

        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }

        CGContextScaleCTM(bitmap, yFlip, -1.0)
        CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
