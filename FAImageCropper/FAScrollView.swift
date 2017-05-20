//
//  FAScrollView.swift
//  FAImageCropper
//
//  Created by Fahid Attique on 12/02/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class FAScrollView: UIScrollView{

    // MARK: Class properties
    
    var imageView:UIImageView = UIImageView()
    var imageToDisplay:UIImage? = nil{
        didSet{
            zoomScale = 1.0
            minimumZoomScale = 1.0
            imageView.image = imageToDisplay
            imageView.frame.size = sizeForImageToDisplay()
            imageView.center = center
            contentSize = imageView.frame.size
            contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            updateLayout()
        }
    }
    var gridView:UIView = Bundle.main.loadNibNamed("FAGridView", owner: nil, options: nil)?.first as! UIView
    

    // MARK : Class Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfigurations()
    }

    func updateLayout() {
        imageView.center = center;
        var frame:CGRect = imageView.frame;
        if (frame.origin.x < 0) { frame.origin.x = 0 }
        if (frame.origin.y < 0) { frame.origin.y = 0 }
        imageView.frame = frame
    }
    
    func zoom() {
        if (zoomScale <= 1.0) { setZoomScale(zoomScaleWithNoWhiteSpaces(), animated: true) }
        else{ setZoomScale(minimumZoomScale, animated: true) }
        updateLayout()
    }
    
    
    
    // MARK: Private Functions
    
    private func viewConfigurations(){
        
        clipsToBounds = false;
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        alwaysBounceHorizontal = true
        alwaysBounceVertical = true
        bouncesZoom = true
        decelerationRate = UIScrollViewDecelerationRateFast
        delegate = self
        maximumZoomScale = 5.0
        addSubview(imageView)
        
        gridView.frame = frame
        gridView.isHidden = true
        gridView.isUserInteractionEnabled = false
        addSubview(gridView)
    }
    
    private func sizeForImageToDisplay() -> CGSize{
        
        var actualWidth:CGFloat = imageToDisplay!.size.width
        var actualHeight:CGFloat = imageToDisplay!.size.height
        var imgRatio:CGFloat = actualWidth/actualHeight
        let maxRatio:CGFloat = frame.size.width/frame.size.height
        
        if imgRatio != maxRatio{
            if(imgRatio < maxRatio){
                imgRatio = frame.size.height / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = frame.size.height
            }
            else{
                imgRatio = frame.size.width / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = frame.size.width
            }
        }
        else {
            imgRatio = frame.size.width / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = frame.size.width
        }

        return  CGSize(width: actualWidth, height: actualHeight)
    }
    
    private func zoomScaleWithNoWhiteSpaces() -> CGFloat{
        
        let imageViewSize:CGSize  = imageView.bounds.size
        let scrollViewSize:CGSize = bounds.size;
        let widthScale:CGFloat  = scrollViewSize.width / imageViewSize.width
        let heightScale:CGFloat = scrollViewSize.height / imageViewSize.height
        return max(widthScale, heightScale)
    }

}



extension FAScrollView:UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateLayout()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        gridView.isHidden = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        gridView.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        var frame:CGRect = gridView.frame;
        frame.origin.x = scrollView.contentOffset.x
        frame.origin.y = scrollView.contentOffset.y
        gridView.frame = frame
        
        switch scrollView.pinchGestureRecognizer!.state {
        case .changed:
            gridView.isHidden = false
            break
        case .ended:
            gridView.isHidden = true
            break
        default: break
        }
        
    }
    
}
