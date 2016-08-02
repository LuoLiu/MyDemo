//
//  NormalViewController.swift
//  MoveCollectionView
//
//  Created by LuoLiu on 16/8/1.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit

class NormalViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    var numbers: [Int] = []
    private var longPressGesture: UILongPressGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 1...100 {
            numbers.append(i)
        }
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture))
        self.collectionView?.addGestureRecognizer(longPressGesture)
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch gesture.state {
        case .Began:
            guard let selectedIndexPath = self.collectionView?.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else { break }
//            let cell = collectionView.cellForItemAtIndexPath(selectedIndexPath)
//            cell?.backgroundColor = UIColor.lightGrayColor()
            collectionView?.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
        case .Changed:
            collectionView?.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
        case .Ended:
            collectionView?.endInteractiveMovement()
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoveCell", forIndexPath: indexPath) as! MoveCollectionViewCell
        
        cell.label.text = "\(numbers[indexPath.item])"
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let temp = numbers.removeAtIndex(sourceIndexPath.item)
        numbers.insert(temp, atIndex: destinationIndexPath.item)
    }
}
