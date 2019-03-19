//
//  ViewController.swift
//  One-image Viewer
//
//  Created by vic_liu on 2019/3/19.
//  Copyright © 2019 ios-class. All rights reserved.
//

import UIKit



class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, MyPhotoClipperDelegate {

    @IBOutlet var PickAnImageButton: UIView!

    @IBAction func pickAnImageButton(_ sender: Any) {

                let imagePickerVC = UIImagePickerController()
                // 設定相片的來源為行動裝置內的相本
               // imagePickerVC.sourceType = .photoLibrary
                 imagePickerVC.sourceType = .savedPhotosAlbum
                 imagePickerVC.delegate = self

                // 開啟照片
               // show(imagePickerVC, sender: self)
        present(imagePickerVC, animated: true, completion: nil)
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }



    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // 取得拍下來的照片
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

         print("MySelect-\(selectedImage)")

        picker.dismiss(animated: false, completion: {
         // print("123456")
            let clipper = MyPhotoClipperViewController()
            clipper.delegate = self
            clipper.img = selectedImage
            self.present(clipper, animated: true, completion: nil)

        })



    }

    func didFinishClippingPhoto(image: UIImage) {

        let imgv = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        imgv.image = image

        view.addSubview(imgv)
    }



}

