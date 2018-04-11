//
//  MapBankInfoTableViewCell.h
//  FindBankMap
//
//  Created by Bomi on 2018/3/20.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapBankInfoTableViewCell : UITableViewCell

- (void)shrinkToolButtons;
- (void)expandToolButtons;
- (void)animateToolButtonsWithPercentage:(CGFloat)percentage;

@end
