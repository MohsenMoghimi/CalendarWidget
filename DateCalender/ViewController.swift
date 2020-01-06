//
//  ViewController.swift
//  DateCalender
//
//  Created by Mohsen Moghimi on 1/5/20.
//  Copyright © 2020 Mohsen Moghimi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var pageController: UIPageControl!
    
    let image1 = UIImage(named: "01")
    let image2 = UIImage(named: "02")
    let image3 = UIImage(named: "03")
    let image4 = UIImage(named: "04")
    
    let iv1 = UIImageView()
    let iv2 = UIImageView()
    let iv3 = UIImageView()
    let iv4 = UIImageView()
    
    var images : [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iv1.image = image1
        iv2.image = image2
        iv3.image = image3
        iv4.image = image4
        
        images = [iv1, iv2, iv3, iv4]
        
        setupSlideScrollView(images: images)
        
        pageController.numberOfPages = images.count
        pageController.currentPage = 0
        view.bringSubviewToFront(pageController)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupSlideScrollView(images : [UIImageView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(images.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< images.count {
            images[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(images[i])
        }
    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageController.currentPage == 0) {
            
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageController.pageIndicatorTintColor = pageUnselectedColor
            
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            images[pageController.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageController.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
    
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}
