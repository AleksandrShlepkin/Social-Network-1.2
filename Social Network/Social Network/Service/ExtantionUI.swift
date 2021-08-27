//
//  File.swift
//  Social Network
//
//  Created by Alex on 11.08.2021.
//
import Foundation
import UIKit

class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.isUserInteractionEnabled = true
    }
    
}

class PresentAnimatior: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.2
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerVIew = transitionContext.containerView
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let finalFrame = toView.frame
        
        let xScaleFactor = originFrame.width / finalFrame.width
        let yScaleFactor = originFrame.height / finalFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        toView.transform = scaleTransform
        toView.center = CGPoint(x: originFrame.midX,
                                y: originFrame.midY)
        
        toView.clipsToBounds = true
        
        containerVIew.addSubview(toView)
        
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [],
                       animations: {
                        toView.transform = CGAffineTransform.identity
                        toView.center = CGPoint(x: -finalFrame.midX,
                                                y: -finalFrame.midY)
                       }, completion: { _ in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                       }      )
    }
    
    
}

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
}

extension MainTabViewController: UITabBarControllerDelegate  {
    
       @objc func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let tabViewControllers = tabBarController.viewControllers,
              let toIndex = tabViewControllers.firstIndex(of: viewController)
        else {
            return false
        }
        animateToTab(toIndex: toIndex)
        return true
    }
    
    func animateToTab(toIndex: Int) {
        guard let tabViewControllers = viewControllers,
              let selectedVC = selectedViewController else { return }
        
        guard let fromView = selectedVC.view,
              let toView = tabViewControllers[toIndex].view,
              let fromIndex = tabViewControllers.firstIndex(of: selectedVC),
              fromIndex != toIndex else { return }
        
        fromView.superview?.addSubview(toView)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.7,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
                        toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)
                        
                       }, completion: { finished in
                        fromView.removeFromSuperview()
                        self.selectedIndex = toIndex
                        self.view.isUserInteractionEnabled = true
                       })
    }
    
}


