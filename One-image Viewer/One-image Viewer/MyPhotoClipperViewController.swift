//
//  MyPhotoClipperViewController.swift
//  One-image Viewer
//
//  Created by vic_liu on 2019/3/19.
//  Copyright © 2019 ios-class. All rights reserved.
//

import UIKit


protocol MyPhotoClipperDelegate {

    func didFinishClippingPhoto(image:UIImage)
}
class MyPhotoClipperViewController: UIViewController {

     var delegate: MyPhotoClipperDelegate?

    var imgView:UIImageView?

    var img:UIImage?

    let scrollview = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    var maxScale:CGFloat = 2.0
    var minScale:CGFloat = 1.0

    let HEIGHT = UIScreen.main.bounds.height
    let WIDTH = UIScreen.main.bounds.width


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MyPhotoClipperViewController {

        func setupUI() {

            scrollview.backgroundColor = UIColor.black

            imgView = UIImageView(image: img)

            guard let imgView = imgView else {
                return
            }
            view.backgroundColor = UIColor.white
            imgView.contentMode = .scaleToFill
            scrollview.delegate = self
            imgView.center = scrollview.center

            if imgView.bounds.width > WIDTH {
                imgView.frame.size = CGSize(width: WIDTH, height: imgView.bounds.height / imgView.bounds.width * WIDTH)
                imgView.center = scrollview.center
            }
            if imgView.bounds.height > HEIGHT{
                imgView.frame.size = CGSize(width: HEIGHT, height: imgView.bounds.width / imgView.bounds.height * HEIGHT)
                imgView.center = scrollview.center
            }

            view.addSubview(scrollview)
            scrollview.addSubview(imgView)

            scrollview.contentSize = CGSize(width: WIDTH, height: HEIGHT + imgView.frame.height / 2)

            scrollview.showsHorizontalScrollIndicator = false
            scrollview.showsVerticalScrollIndicator = false

            scrollview.maximumZoomScale = maxScale
            scrollview.minimumZoomScale = minScale
        }

}

extension MyPhotoClipperViewController: UIScrollViewDelegate {


    func scrollViewDidZoom(_ scrollView: UIScrollView) {

       
        var centerX = scrollView.center.x
        var centerY = scrollView.center.y
        centerX = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 1  : centerX
        centerY = scrollView.contentSize.height > scrollView.frame.size.height ?scrollView.contentSize.height / 1 : centerY
        self.imgView?.center = CGPoint(x: centerX, y: centerY)

        guard let imgView = imgView else {
            return
        }

        scrollview.contentSize = CGSize(width: imgView.frame.width, height: HEIGHT + imgView.frame.height / 2)

    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }








}
