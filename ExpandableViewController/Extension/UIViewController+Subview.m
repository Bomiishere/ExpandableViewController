//
//  UIViewController+Subview.m
//  FindBankMap
//
//  Created by Bomi on 2018/3/21.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "UIViewController+Subview.h"

@implementation UIViewController (Subview)

- (void)addSubViews:(NSArray *)array {
    if (!array) {
        return;
    }
    for (id object in array) {
        if ([object isKindOfClass:[UIView class]]) {
            [self.view addSubview:object];
        }
    }
}

@end
