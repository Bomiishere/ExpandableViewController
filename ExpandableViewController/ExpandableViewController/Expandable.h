//
//  Expandable.h
//  FindBankMap
//
//  Created by Bomi on 2018/3/21.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const kExpandableViewControllerStateChanged;

typedef enum : NSUInteger {
    ExpandStateNone,
    ExpandStateHalf,
    ExpandStateEntire,
} ExpandState;

@protocol Expandable <NSObject>

- (void)expandWithState:(ExpandState)expandstate;

@end
