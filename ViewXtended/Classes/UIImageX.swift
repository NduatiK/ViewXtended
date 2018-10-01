//
//  UIImageX.swift
//  DeckTransition
//
//  Created by Nduati Kuria on 30/09/2018.
//

import UIKit
extension UIImage {
    public func crop(_ selectedCorner: UIRectCorner) -> UIImage? {
        var corner = selectedCorner
        if corner == .allCorners {
            NSLog("Invalid option \(corner) selected -> defaulting to topRight")
            corner = .topRight
        }
        let cgIM = self.cgImage!

        let size = CGSize(width: cgIM.width, height: cgIM.height)
        let height = size.height / 3 - 1
        let width = size.width / 3 - 1

        let rect: CGRect = {
            switch corner {

            case .bottomRight:
                return CGRect(x: 2 * width,
                              y: 2 * height,
                              width: width,
                              height: height)
            case .bottomLeft:
                return CGRect(x: 0,
                              y: 2 * height,
                              width: width,
                              height: height)
            case .topLeft:
                return CGRect(x: 0,
                              y: 0,
                              width: width,
                              height: height)
            default:
                return CGRect(x: 2 * width,
                              y: 0,
                              width: width,
                              height: height)
            }
        }()

        guard let cgImage = cgIM.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
