//
//  ViewController.swift
//  AlbumDemo
//
//  Created by LuoLiu on 16/6/22.
//  Copyright © 2016年 fenrir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewLeftAlignedLayout!
    @IBOutlet weak var verticalLayoutConstraint: NSLayoutConstraint!
    
    var numberOfItemsInSection = 40

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.registerClass(TagCell.self, forCellWithReuseIdentifier: String(TagCell.self))
        collectionView.registerNib(UINib.init(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        flowLayout.estimatedItemSize = CGSize(width: 120, height: 40)
        
        collectionView.addObserver(self, forKeyPath: "contentSize", options: .Old, context: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        verticalLayoutConstraint.constant = flowLayout.collectionViewContentSize().height
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        collectionView.removeObserver(self, forKeyPath: "contentSize")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInSection
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(TagCell.self), forIndexPath: indexPath) as! TagCell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TagCell

        if indexPath.row % 3 == 0 {
            cell.lbTag?.text = "abcdabcdabcd"
        }
        else if indexPath.row % 2 == 0 {
            cell.lbTag?.text = "oh"
        }
        else {
            cell.lbTag?.text = "Tag-\(indexPath.item)"
        }

        cell.isHeightCalculated = false

        return cell
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        verticalLayoutConstraint.constant = flowLayout.collectionViewContentSize().height
    }
    
    // 屏幕旋转
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView.reloadData()
        })
    }
}

