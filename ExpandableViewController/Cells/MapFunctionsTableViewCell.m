//
//  MapFunctionsTableViewCell.m
//  FindBankMap
//
//  Created by Bomi on 2018/3/20.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "MapFunctionsTableViewCell.h"
#import "UITableViewCell+Subview.h"

@interface MapFunctionsTableViewCell ()

@property (nonatomic, strong) UIImageView *routeImageView;
@property (nonatomic, strong) UIImageView *phoneNumberImageView;
@property (nonatomic, strong) UILabel *routeLabel;
@property (nonatomic, strong) UILabel *phoneNumberLabel;
@property (nonatomic, strong) UILabel *waitNumberLabel;
@property (nonatomic, strong) UIView *separatedView;

@end

@implementation MapFunctionsTableViewCell

#pragma mark - Public

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.routeImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"route.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        self.routeImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.routeImageView.tintColor = [UIColor colorWithRed:255/255.f green:93/255.f blue:65/255.f alpha:1.0f];

        self.phoneNumberImageView = [[UIImageView alloc] init];
        self.phoneNumberImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"phone.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        self.phoneNumberImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.phoneNumberImageView.tintColor = [UIColor colorWithRed:255/255.f green:93/255.f blue:65/255.f alpha:1.0f];
        
        self.routeLabel = [[UILabel alloc] init];
        self.routeLabel.text = @"規劃路線";
        
        self.phoneNumberLabel = [[UILabel alloc] init];
        self.phoneNumberLabel.text = @"02-27685966";
        
        self.waitNumberLabel = [[UILabel alloc] init];
        self.waitNumberLabel.textAlignment = NSTextAlignmentRight;
        NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:20.f]};
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"等候人數 3 位" attributes:attrs];
        NSMutableAttributedString *mutableAttr =
        [[NSMutableAttributedString alloc]
         initWithAttributedString: attrStr];
        [mutableAttr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 1)];
        self.waitNumberLabel.attributedText = mutableAttr;
        
        self.separatedView = [[UIView alloc] init];
        self.separatedView.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubviews:@[self.routeImageView, self.phoneNumberImageView, self.routeLabel, self.phoneNumberLabel, self.waitNumberLabel, self.separatedView]];
        [self initAutoLayout];
    }
    return self;
}

- (void)animateToolButtonsWithPercentage:(CGFloat)percentage {
    if (percentage >= 0 && percentage <= 1) {
        [UIView beginAnimations:@"SencondRowAnimation" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.3];
        self.contentView.alpha = percentage;
        [UIView commitAnimations];
    }
}

#pragma mark - Private

- (void)initAutoLayout {
    self.routeImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:38]];
    
    self.phoneNumberImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.routeImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:36]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:36]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:42]];
    
    self.routeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.routeImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.routeImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:22]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-30]];
    
    self.phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.phoneNumberImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.phoneNumberImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:22]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-30]];
    
    self.waitNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.waitNumberLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.phoneNumberImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.waitNumberLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.waitNumberLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.waitNumberLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-30]];
    
    self.separatedView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.separatedView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.waitNumberLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.separatedView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.separatedView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.separatedView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.separatedView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20]];
}

@end
