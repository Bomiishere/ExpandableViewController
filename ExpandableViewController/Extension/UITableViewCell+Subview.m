//
//  UITableViewCell+Subview.m
//  FindBankMap
//
//  Created by Bomi on 2018/3/20.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "UITableViewCell+Subview.h"

@implementation UITableViewCell (Subview)

- (void)addSubviews:(NSArray *)array {
    for (id object in array) {
        if ([object isKindOfClass:[UIView class]]) {
            [self.contentView addSubview:object];
        }
    }
}

@end
