//
//  CustomPresentations.swift
//  XCoordinator_Example
//
//  Created by Joan Disho on 04.05.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//


import UIKit
import XCoordinator

private let defaultAnimationDuration: TimeInterval = 0.35

extension Animation {
    static let staticScale = Animation(
        presentation: StaticTransitionAnimation.scale,
        dismissal: StaticTransitionAnimation.scale
    )


    static let interactiveScale = Animation(
        presentation: InteractiveTransitionAnimation.scale,
        dismissal: InteractiveTransitionAnimation.scale
    )

    static let staticFade = Animation(
        presentation: StaticTransitionAnimation.fade,
        dismissal: StaticTransitionAnimation.fade
    )

    static let interactiveFade = Animation(
        presentation: InteractiveTransitionAnimation.fade,
        dismissal: InteractiveTransitionAnimation.fade
    )
}

extension StaticTransitionAnimation {
    static let fade = StaticTransitionAnimation(duration: defaultAnimationDuration) { transitionContext in
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!

        toView.alpha = 0.0
        containerView.addSubview(toView)

        UIView.animate(withDuration: defaultAnimationDuration, delay: 0, options: [.curveLinear], animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    static let scale = StaticTransitionAnimation(duration: defaultAnimationDuration) { transitionContext in
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!

        containerView.backgroundColor = .white
        toView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)

        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            toView.transform = .identity
            fromView.alpha = 0
        }, completion: { _ in
            fromView.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

extension InteractiveTransitionAnimation {
    static let fade = InteractiveTransitionAnimation(transitionAnimation: StaticTransitionAnimation.fade)
    static let scale = InteractiveTransitionAnimation(transitionAnimation: StaticTransitionAnimation.scale)
}
