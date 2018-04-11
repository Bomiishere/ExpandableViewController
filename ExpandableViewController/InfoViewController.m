//
//  BankInfoViewController.m
//  FindBankMap
//
//  Created by Bomi on 2018/3/19.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "InfoViewController.h"
#import "MapBankInfoTableViewCell.h"
#import "MapFunctionsTableViewCell.h"
#import "MapGetCardNumberTableViewCell.h"
#import "UIViewController+Subview.h"


@interface InfoViewController ()<UITableViewDelegate, UITableViewDataSource, ExpandableChildDelegate, ExpandableChildDataSource>

@property (nonatomic, strong) UIView *swipeSignalView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation InfoViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.swipeSignalView = [[UIView alloc] init];
        self.swipeSignalView.backgroundColor = [UIColor colorWithRed:214/255.f green:214/255.f blue:214/255.f alpha:1.0f];
        self.swipeSignalView.layer.masksToBounds = YES;
        self.swipeSignalView.layer.cornerRadius = 3;
        
        self.tableView = [[UITableView alloc] init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 77;
        self.tableView.allowsSelection = NO;
        self.tableView.scrollEnabled = NO;
    }
    return self;
}

#pragma mark - ViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews:@[self.swipeSignalView, self.tableView]];
    [self arrangeAutoLayout];
}

#pragma mark - ExpandableChildDelegate

- (void)expandableViewControllerDidChangeState:(ExpandState)expandState {
    switch (expandState) {
        case ExpandStateNone:
            [self showFiritColumn:NO];
            [self showSecondColumn:YES];
            [self showThirdColumn:YES];
            break;
            
        case ExpandStateHalf:
            [self showFiritColumn:YES];
            [self showSecondColumn:NO];
            [self showThirdColumn:NO];
            break;
            
        case ExpandStateEntire:
            [self showFiritColumn:NO];
            [self showSecondColumn:YES];
            [self showThirdColumn:YES];
            break;
    }
}

- (void)showFiritColumn:(BOOL)isShow {
    if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] isKindOfClass:[MapBankInfoTableViewCell class]]) {
        MapBankInfoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell animateToolButtonsWithPercentage:isShow];
    }
}

- (void)showSecondColumn:(BOOL)isShow {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    if ([[self.tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[MapFunctionsTableViewCell class]]) {
        MapFunctionsTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell animateToolButtonsWithPercentage:isShow];
    }
}

- (void)showThirdColumn:(BOOL)isShow {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    if ([[self.tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[MapGetCardNumberTableViewCell class]]) {
        MapGetCardNumberTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell animateToolButtonsWithPercentage:isShow];
    }
}

- (void)expandableViewControllerDidDragWithPercentage:(CGFloat)percentage {
    if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] isKindOfClass:[MapBankInfoTableViewCell class]]) {
        MapBankInfoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        if (self.expandState == ExpandStateHalf) {
            [cell animateToolButtonsWithPercentage:1 - fabs(percentage)];
        } else if (self.expandState == ExpandStateEntire) {
            [cell animateToolButtonsWithPercentage:fabs(percentage) - 0.7];// 0.7 use for control last percentages to display
        }
    }
    if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]] isKindOfClass:[MapFunctionsTableViewCell class]]) {
        MapFunctionsTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        if (self.expandState == ExpandStateHalf) {
            [cell animateToolButtonsWithPercentage:fabs(percentage)];
        }
    }
    if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]] isKindOfClass:[MapGetCardNumberTableViewCell class]]) {
        MapGetCardNumberTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        if (self.expandState == ExpandStateHalf) {
            [cell animateToolButtonsWithPercentage:fabs(percentage)];
        }
    }
}

#pragma mark - ExpandableChildDatasource

- (CGFloat)expandableViewControllerEntireHeight {
    return self.view.superview.frame.size.height - 20;
}

- (CGFloat)expandableViewControllerHalfHeight {
    return 110;
}

#pragma mark - Private

- (void)arrangeAutoLayout {
    self.swipeSignalView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.swipeSignalView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:3]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.swipeSignalView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.swipeSignalView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.swipeSignalView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *identifiers = @[@"bankinfo", @"functions", @"getcardnunber"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiers[indexPath.section]];
    
    if (!cell) {
        if (indexPath.section == 0) {
            MapBankInfoTableViewCell *bankInfoCell = [[MapBankInfoTableViewCell alloc] init];
            cell = bankInfoCell;
        } else if (indexPath.section == 1) {
            MapFunctionsTableViewCell *functionsCell = [[MapFunctionsTableViewCell alloc] init];
            cell = functionsCell;
        } else if (indexPath.section == 2) {
            MapGetCardNumberTableViewCell *getCardNumberCell = [[MapGetCardNumberTableViewCell alloc] init];
            cell = getCardNumberCell;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDatasource

@end
