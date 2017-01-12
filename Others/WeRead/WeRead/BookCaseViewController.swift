//
//  BookCaseViewController.swift
//  WeRead
//
//  Created by LuoLiu on 17/1/12.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

import UIKit

class BookCaseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var longPressGesture: UILongPressGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)

        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture))
        self.collectionView?.addGestureRecognizer(longPressGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = self.collectionView?.indexPathForItem(at: gesture.location(in: self.collectionView)) else { break }
//            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
            print(selectedIndexPath)
        case .changed:
//            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            print("changed")
        case .ended:
//            collectionView?.endInteractiveMovement()
            print("ended")
        default:
//            collectionView?.cancelInteractiveMovement()
            print("> <")
        }
    }
    
    // Mark: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCoverCell", for: indexPath) as! BookCoverCell
        
        cell.coverImg.image = #imageLiteral(resourceName: "bookCover")
        cell.nameLabel.text = "Book \(indexPath.item)"
                
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    
}

class BookCoverCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    var isEdit: Bool = false {
        didSet {
            checkImg.isHidden = !isEdit
        }
    }
    
    override func awakeFromNib() {
        coverImg.layer.shadowOpacity = 0.7
        coverImg.layer.shadowColor = UIColor.gray.cgColor
        coverImg.layer.shadowOffset = CGSize(width: 1, height: 3)
        
        checkImg.isHidden = true
    }
    
    
}
