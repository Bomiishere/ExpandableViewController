//
//  ExpandableViewController.h
//  FindBankMap
//
//  Created by Bomi on 2018/3/22.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expandable.h"
#import "UIView+AutoLayout.h"

@class ExpandableViewController;

@protocol ExpandableViewControllerDelegate <NSObject>
@optional
- (void)expandableViewController:(ExpandableViewController *)expandableViewController didChangeState:(ExpandState)expandState;
@end

@protocol ExpandableChildDelegate <NSObject>
@optional
- (void)expandableViewControllerDidChangeState:(ExpandState)expandState;
- (void)expandableViewControllerDidDragWithPercentage:(CGFloat)percentage;
@end

@protocol ExpandableChildDataSource <NSObject>
@optional
- (CGFloat)expandableViewControllerEntireHeightOffset;
- (CGFloat)expandableViewControllerHalfHeight;
- (CGFloat)expandableViewControllerOriginHeight;
@end

@interface ExpandableViewController : UIViewController<ExpandableChildDelegate, ExpandableChildDataSource>

@property (nonatomic, weak) id <ExpandableViewControllerDelegate> delegate;

@property (nonatomic, assign) ExpandState expandState;
@property (nonatomic, assign) BOOL isDraggable;
@property (nonatomic, assign) BOOL isRoundCorner;
@property (nonatomic, assign) BOOL isShadow;
@property (nonatomic, assign) CGFloat originHeight;
@property (nonatomic, assign) CGFloat halfHeight;
@property (nonatomic, assign) CGFloat entireHeightOffset;

- (void)displayWithState:(ExpandState)expandState;

@end
