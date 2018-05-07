//
//  ExpandableViewController.m
//  FindBankMap
//
//  Created by Bomi on 2018/3/22.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "ExpandableViewController.h"

#define DRAGGABLEVIEW_CHANGING_ANIMATE_DURATION 0.1
#define DRAGGABLEVIEW_ENDING_ANIMATE_DURATION 0.35
__unused static CGFloat const kDisplayLinkDuration = 2.5;

@interface ExpandableViewController () <Expandable>

@property (nonatomic, strong) id <ExpandableChildDelegate> childDelegate;
@property (nonatomic, strong) id <ExpandableChildDataSource> childDatasource;

@property (nonatomic, strong) NSLayoutConstraint *draggableViewTopConstraint;
@property (nonatomic, assign) CGFloat superViewHeight;

///Tap & Expand
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

///Drag
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

///PanGesture - store height
@property (nonatomic, assign) CGFloat storedHeight;

//display link
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat startTime;
@property (nonatomic, assign) CGFloat animLength;
@property (nonatomic) CGFloat percent;

@end

@implementation ExpandableViewController

#pragma mark - Public

- (instancetype)init {
    self = [super init];
    if (self) {
        self.childDelegate = self;
        self.childDatasource = self;
        
        self.originHeight = 0;
        self.halfHeight = 0;
        self.entireHeightOffset = 0;
        
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandWithTapGesture:)];
        self.storedHeight = 0.0f;
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(draggingWithPanGesture:)];
    }
    return self;
}

- (void)displayWithState:(ExpandState)expandState {
    //guard if no superview
    if (!self.view.superview) {
        return;
    }
    
    if (!self.draggableViewTopConstraint) {
        [self initAutoLayout];
    }
    self.expandState = expandState;
}

#pragma mark - ViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self.view addGestureRecognizer:self.tapGesture];
    [self.view addGestureRecognizer:self.panGesture];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    [self initAutoLayout];
    [parent.view layoutIfNeeded];
}

#pragma mark - ExpandStateExist

- (void)expandWithState:(ExpandState)expandState {
    CGFloat expandHeight;
    switch (expandState) {
        case ExpandStateNone:
                expandHeight = self.originHeight;
            break;
            
        case ExpandStateHalf:
                expandHeight = self.halfHeight;
            break;
            
        case ExpandStateEntire:
                expandHeight = [self superViewHeight] - self.entireHeightOffset;
            break;
    }
    self.draggableViewTopConstraint.constant = -expandHeight;
    
    [UIView animateWithDuration:DRAGGABLEVIEW_ENDING_ANIMATE_DURATION delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view.superview layoutIfNeeded];
    } completion:^(BOOL finished) {}];
}

#pragma mark - Setter, Getter

- (CGFloat)originHeight {
    if ([_childDatasource respondsToSelector:@selector(expandableViewControllerOriginHeight)]) {
        return [_childDatasource expandableViewControllerOriginHeight];
    } else {
        return _originHeight;
    }
}

- (CGFloat)halfHeight {
    if ([_childDatasource respondsToSelector:@selector(expandableViewControllerHalfHeight)]) {
        return [_childDatasource expandableViewControllerHalfHeight];
    } else {
        return _halfHeight;
    }
}

- (CGFloat)entireHeightOffset {
    if ([_childDatasource respondsToSelector:@selector(expandableViewControllerEntireHeightOffset)]) {
        return [_childDatasource expandableViewControllerEntireHeightOffset];
    } else {
        return _entireHeightOffset;
    }
}

- (CGFloat)superViewHeight {
    return self.view.superview.bounds.size.height;
}

- (void)setIsRoundCorner:(BOOL)isRoundCorner {
    _isRoundCorner = isRoundCorner;
    if (isRoundCorner) {
        self.view.layer.cornerRadius = 10;
    }
}

- (void)setIsShadow:(BOOL)isShadow {
    _isShadow = isShadow;
    if (isShadow) {
        self.view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.view.layer.shadowRadius = 3.0;
        self.view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        self.view.layer.shadowOpacity = 0.8f;
    }
}

- (void)setExpandState:(ExpandState)expandState {
    _expandState = expandState;
    [self expandWithState:expandState];
    if ([self.childDelegate respondsToSelector:@selector(expandableViewControllerDidChangeState:)]) {
        [self.childDelegate expandableViewControllerDidChangeState:self.expandState];
    }
}

#pragma mark - Gesture

- (void)expandWithTapGesture:(UITapGestureRecognizer *)gesture {
    switch (self.expandState) {
        case ExpandStateNone:
            break;
        case ExpandStateHalf:
            self.expandState = ExpandStateEntire;
            break;
        case ExpandStateEntire:
            self.expandState = ExpandStateHalf;
            break;
    }
}

- (void)draggingWithPanGesture:(UIPanGestureRecognizer *)gesture {
    if (!self.isDraggable) {
        return;
    }
    
    CGPoint translationPoint = [gesture translationInView:self.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.storedHeight = self.superViewHeight - gesture.view.frame.origin.y;
//            [self startDisplayLink];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self viewDidDragWithTransitionY:translationPoint.y];
            break;
            
        case UIGestureRecognizerStateEnded:
//            [self stopDisplayLink];
            if (translationPoint.y < - [UIScreen mainScreen].bounds.size.height/4 || translationPoint.y > 0) {
                if (translationPoint.y < 0) {
                    [self viewDraggedUp];
                } else if (translationPoint.y > 0) {
                    [self viewDraggedDown];
                }
            } else {
                [self displayWithState:self.expandState];
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - Private

- (void)viewDraggedDown {
    switch (self.expandState) {
        case ExpandStateNone:
            break;
            
        case ExpandStateHalf:
            self.expandState = ExpandStateNone;
            break;
            
        case ExpandStateEntire:
            self.expandState = ExpandStateHalf;
            break;
    }
}

- (void)viewDraggedUp {
    self.expandState = ExpandStateEntire;
}

- (void)viewDidDragWithTransitionY:(CGFloat)transitionY {
    CGFloat height = self.storedHeight - transitionY;
    
    if (height > self.superViewHeight + 20) { // 20 for extend space
        return;
    }
    
    //drag animation
    self.draggableViewTopConstraint.constant = -height;
    [UIView animateWithDuration:DRAGGABLEVIEW_CHANGING_ANIMATE_DURATION delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view.superview layoutIfNeeded];
    } completion:^(BOOL finished) {}];
    
    //delegate percent of animation
    CGFloat percentage = (transitionY)/[self superViewHeight]*2; // multiple 2 for half way entire animation
    if ([self.childDelegate respondsToSelector:@selector(expandableViewControllerDidDragWithPercentage:)]) {
        [self.childDelegate expandableViewControllerDidDragWithPercentage:percentage];
    }
}

- (void)startDisplayLink {
//    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
//    self.startTime = CFAbsoluteTimeGetCurrent() + (1.0 - self.percent) * kDisplayLinkDuration;
//    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stopDisplayLink {
//    [self.displayLink invalidate];
//    self.displayLink = nil;
}

- (void)handleDisplayLink:(CADisplayLink *)displayLink {
//    CFAbsoluteTime elapsed = CFAbsoluteTimeGetCurrent() - self.startTime;
//    self.percent = elapsed / kDuration - floor(elapsed / kDisplayLinkDuration);
//    self.view.transform = CGAffineTransformMakeRotation(M_PI * 2.0 * self.percent);
}

- (void)setup {
    self.expandState = ExpandStateNone;
}

- (void)initAutoLayout {
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.draggableViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:self.originHeight];
    [self.view.superview addConstraint: self.draggableViewTopConstraint];
    [self.view.superview addConstraint: [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    [self.view.superview addConstraint: [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view.superview addConstraint: [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self.view.superview layoutIfNeeded];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kExpandableViewControllerStateChanged object:nil];
}

@end
