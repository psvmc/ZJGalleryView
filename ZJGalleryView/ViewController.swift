//
//  ViewController.swift
//  ZJGalleryView
//
//  Created by 张剑 on 16/1/21.
//  Copyright © 2016年 张剑. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ZJGalleryViewDelegate,ZJGalleryViewDataSource {
    
    @IBOutlet weak var imagesView: UIView!
    
    var images:[[String:String]] = [
        ["type":"local","url":"iphone6_1.jpg"],
        ["type":"local","url":"iphone6_2.jpg"],
        ["type":"local","url":"iphone6_3.jpg"],
        ["type":"local","url":"iphone6_4.jpg"],
        ["type":"web","url":"http://iphone.tgbus.com/UploadFiles/201206/20120618092005912.jpg"],
        ["type":"web","url":"http://static.yingyonghui.com/normalshots/440/440244_2.jpg"],
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        let galleryView = ZJGalleryView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height));
        imagesView.addSubview(galleryView);
        //设置占位图片
        galleryView.imageHoler = UIImage(named: "photo_loading");
        galleryView.dataSource = self;
        galleryView.delegate = self;
        //是否显示点分页
        galleryView.isShowPageControl = false;
        //是否显示数字分页
        galleryView.isShowPageNum = true;
        galleryView.generate();
    }
    
    func numberOfImagesInGalleryView(galleryView: ZJGalleryView!) -> Int {
        return self.images.count;
    }
    
    func imageURLAtIndex(index: Int32, inGalleryView galleryView: ZJGalleryView!) -> ZJGalleryImage! {
        let imageItem = self.images[Int(index)];
        if(imageItem["type"] == "local"){
            return ZJGalleryImage(local: true, url: imageItem["url"]!);
        }else{
            return ZJGalleryImage(local: false, url: imageItem["url"]!);
        }
    }
    
    func didSelectImageInGalleryView(galleryView: ZJGalleryView!, atIndex index: Int) {
        print("选择了图片\(index)")
    }
    
    
}

