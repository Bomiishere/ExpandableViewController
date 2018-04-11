//
//  ViewController.m
//  FindBankMap
//
//  Created by Bomi on 2018/3/19.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"
#import "UIViewController+Subview.h"


@interface ViewController ()<ExpandableViewControllerDelegate>

@property (nonatomic, strong) InfoViewController *infoExpandableViewController;

@end

@implementation ViewController

- (IBAction)noneButtonTapped:(id)sender {
    [self.infoExpandableViewController displayWithState:ExpandStateNone];
}
- (IBAction)simplebuttonTapped:(id)sender {
    [self.infoExpandableViewController displayWithState:ExpandStateHalf];
}
- (IBAction)entireButtonTapped:(id)sender {
    [self.infoExpandableViewController displayWithState:ExpandStateEntire];
}

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.infoExpandableViewController = [[InfoViewController alloc] init];
    self.infoExpandableViewController.delegate = self;
    self.infoExpandableViewController.isRoundCorner = YES;
    self.infoExpandableViewController.isDraggable = YES;
    self.infoExpandableViewController.isShadow = YES;
    
    [self addSubViews:@[self.infoExpandableViewController.view]];
    [self addChildViewController:self.infoExpandableViewController];
}

@end
