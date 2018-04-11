//
//  MapGetCardNumberTableViewCell.m
//  FindBankMap
//
//  Created by Bomi on 2018/3/20.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "MapGetCardNumberTableViewCell.h"
#import "UITableViewCell+Subview.h"

@interface MapGetCardNumberTableViewCell ()

@property (nonatomic, strong) UILabel *numberCardTipLabel;
@property (nonatomic, strong) UIView *cardBallView;
@property (nonatomic, strong) UILabel *cardNumberLabel;
@property (nonatomic, strong) UIButton *getCardButton;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@property (nonatomic, assign) Boolean isGetCard;

@end

@implementation MapGetCardNumberTableViewCell

#pragma mark - Public

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.isGetCard = NO;
        
        self.numberCardTipLabel = [[UILabel alloc] init];
        self.numberCardTipLabel.text = @"您尚未取得號碼牌";
        self.numberCardTipLabel.textAlignment = NSTextAlignmentCenter;
        self.numberCardTipLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        self.cardBallView = [[UIView alloc] init];
        self.cardBallView.backgroundColor = [UIColor lightGrayColor];
        self.cardBallView.layer.masksToBounds = YES;
        self.cardBallView.layer.cornerRadius = 100;
        self.cardNumberLabel = [[UILabel alloc] init];
        self.cardNumberLabel.text = @"?";
        self.cardNumberLabel.textColor = [UIColor whiteColor];
        self.cardNumberLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:64.0f];
        self.cardNumberLabel.textAlignment = NSTextAlignmentCenter;
        self.getCardButton = [[UIButton alloc] init];
        self.getCardButton.backgroundColor = [UIColor colorWithRed:255/255.f green:93/255.f blue:65/255.f alpha:1.0f];
        [self.getCardButton setTitle:@"取號" forState:UIControlStateNormal];
        [self.getCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.getCardButton.layer.masksToBounds = YES;
        self.getCardButton.layer.cornerRadius = 10;
        
        [self addSubviews:@[self.numberCardTipLabel, self.cardBallView, self.cardNumberLabel, self.getCardButton]];
        [self initAutoLayout];
    }
    return self;
}

#pragma mark - Private

- (void)animateToolButtonsWithPercentage:(CGFloat)percentage {
    if (percentage >= 0 && percentage <= 1) {
        [UIView beginAnimations:@"ThirdRowAnimation" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.3];
        self.contentView.alpha = percentage;
        [UIView commitAnimations];
    }
}

- (void)setIsGetCard:(Boolean)isGetCard {
    _isGetCard = isGetCard;
}

- (void)initAutoLayout {
    self.numberCardTipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.numberCardTipLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:24]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.numberCardTipLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.numberCardTipLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.numberCardTipLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20]];
    self.cardBallView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cardBallView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.numberCardTipLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cardBallView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cardBallView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cardBallView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    self.cardNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cardNumberLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.cardBallView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cardNumberLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.cardBallView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cardNumberLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.cardNumberLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200]];
    self.getCardButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.getCardButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.cardBallView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.getCardButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.getCardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.getCardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30]];
    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.getCardButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-30]];
}

@end
