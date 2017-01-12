//
//  DiscoverViewController.swift
//  WeRead
//
//  Created by LuoLiu on 17/1/10.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var numOfPages: Int = 5
    var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        if let vc = self.viewControllerAtIndex(index: 0) {
            pageViewController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func viewControllerAtIndex(index: Int) -> PageContentViewController? {
        guard self.numOfPages > 0 else {
            return nil
        }
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let pageContentVC = sb.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        pageContentVC.pageIndex = index
        
        return pageContentVC
    }
    
    // MARK: - Page View Controller Data Source

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        if let pageContentVC = viewController as? PageContentViewController {
            var index = pageContentVC.pageIndex
            if index == nil || index == 0 {
                return nil
            }
            index! -= 1
            return self.viewControllerAtIndex(index: index!)
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let pageContentVC = viewController as? PageContentViewController {
            var index = pageContentVC.pageIndex
            if index == nil {
                return nil
            }
            index! += 1
            if index == numOfPages {
                return nil
            }
            return self.viewControllerAtIndex(index: index!)
        }
        return nil
    }
        
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return numOfPages
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
}
