//
//  MapBankInfoTableViewCell.m
//  FindBankMap
//
//  Created by Bomi on 2018/3/20.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "MapBankInfoTableViewCell.h"
#import "UITableViewCell+Subview.h"

@interface MapBankInfoTableViewCell ()

@property (nonatomic, strong) UILabel *bankNameLabel;
@property (nonatomic, strong) UILabel *bankAddressLabel;
@property (nonatomic, strong) UIButton *routeButton;
@property (nonatomic, strong) UIButton *phoneNumberButton;

@end

@implementation MapBankInfoTableViewCell

#pragma mark - Public

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bankNameLabel = [[UILabel alloc] init];
        self.bankNameLabel.numberOfLines = 0;
        self.bankNameLabel.text = @"東台北分行";
        self.bankNameLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:22.0f];
        
        self.bankAddressLabel = [[UILabel alloc] init];
        self.bankAddressLabel.numberOfLines = 0;
        self.bankAddressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.bankAddressLabel.text = @"台北市松山區光復北路11巷29號";
        self.bankAddressLabel.font = [UIFont fontWithName:@"Helvetica Regular" size:18.0f];
        self.bankAddressLabel.textColor = [UIColor colorWithRed:68/255.f green:68/255.f blue:68/255.f alpha:1.0f];
        
        self.routeButton = [[UIButton alloc] init];
        [self.routeButton setImage:[[UIImage imageNamed:@"route.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        self.routeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.routeButton.tintColor = [UIColor colorWithRed:255/255.f green:93/255.f blue:65/255.f alpha:1.0f];
        
        self.phoneNumberButton = [[UIButton alloc] init];
        [self.phoneNumberButton setImage:[[UIImage imageNamed:@"phone.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        self.phoneNumberButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.phoneNumberButton.tintColor = [UIColor colorWithRed:255/255.f green:93/255.f blue:65/255.f alpha:1.0f];
        
        [self addSubviews:@[self.bankNameLabel, self.bankAddressLabel, self.routeButton, self.phoneNumberButton]];
        [self initAutoLayout];
    }
    return self;
}

- (void)shrinkToolButtons {
    [UIView animateWithDuration:0.35 animations:^{
        self.routeButton.layer.transform = CATransform3DMakeScale(0.0, 0.0, 1);
        self.phoneNumberButton.layer.transform = CATransform3DMakeScale(0.0, 0.0, 1);
    } completion:^(BOOL finished) {}];
}

- (void)expandToolButtons {
    [UIView animateWithDuration:0.35 animations:^{
        self.routeButton.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.phoneNumberButton.layer.transform = CATransform3DMakeScale(1, 1, 1);
    } completion:^(BOOL finished) {}];
}

- (void)animateToolButtonsWithPercentage:(CGFloat)percentage {
    if (percentage >= 0 && percentage <= 1) {
        CATransform3D transform = CATransform3DMakeScale(percentage, percentage, 1);
        [UIView beginAnimations:@"FirstRowAnimation" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.3];
        self.routeButton.alpha = percentage;
        self.phoneNumberButton.alpha = percentage;
        self.routeButton.layer.transform = transform;
        self.phoneNumberButton.layer.transform = transform;
        [UIView commitAnimations];
    }
}

#pragma mark - Private

- (void)initAutoLayout {
    self.bankNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.bankNameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.bankNameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.bankNameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.bankNameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20]];
    
    self.bankAddressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.bankAddressLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bankNameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.bankAddressLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.bankAddressLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.bankAddressLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10]];
    
    self.routeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.phoneNumberButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.routeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.phoneNumberButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-15]];
    
    self.phoneNumberButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bankNameLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:00]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:36]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:36]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.phoneNumberButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20]];
}

@end
