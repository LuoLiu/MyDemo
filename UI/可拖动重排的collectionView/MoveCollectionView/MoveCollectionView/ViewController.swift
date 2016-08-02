//
//  ViewController.swift
//  MoveCollectionView
//
//  Created by LuoLiu on 16/8/1.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var numbers: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        for i in 1...100 {
            numbers.append(i)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoveCell", forIndexPath: indexPath) as! MoveCollectionViewCell
        
        cell.label.text = "\(numbers[indexPath.item])"
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let temp = numbers.removeAtIndex(sourceIndexPath.item)
        numbers.insert(temp, atIndex: destinationIndexPath.item)
    }
}

