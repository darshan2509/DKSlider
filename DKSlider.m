//
//  DKSlider.m
//  DKRangeSliderObjectiveC
//
//  Created by Darshan on 7/20/17.
//
//

#import "DKSlider.h"

@implementation DKSlider
@dynamic minValue, maxValue, currentProgressValue;
@dynamic leftValue, rightValue;
@dynamic showThumbs, showRange;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setLeftValue:(CGFloat)newValue {
    if (newValue < minValue)
        newValue = minValue;
    
    if (newValue > rightValue)
        newValue = rightValue;
    
    leftValue = newValue;
    
    [self setNeedsLayout];
}

- (void)setRightValue:(CGFloat)newValue {
    if (newValue > maxValue)
        newValue = maxValue;
    
    if (newValue < leftValue)
        newValue = leftValue;
    
    rightValue = newValue;
    
    [self setNeedsLayout];
}

- (void)setCurrentProgressValue:(CGFloat)newValue {
    if (newValue > maxValue)
        newValue = maxValue;
    
    if (newValue < minValue)
        newValue = minValue;
    
    currentProgressValue = newValue;
    
    [self setNeedsLayout];
}

- (void)setMinValue:(CGFloat)newValue {
    minValue = newValue;
    
    if (leftValue < minValue)
        leftValue = minValue;
    
    if (rightValue < minValue)
        rightValue = minValue;
    
    [self setNeedsLayout];
}

- (void)setMaxValue:(CGFloat)newValue {
    maxValue = newValue;
    
    if (leftValue > maxValue)
        leftValue = maxValue;
    
    if (rightValue > maxValue)
        rightValue = maxValue;
    
    [self setNeedsLayout];
}

- (CGFloat)minValue {
    return minValue;
}

- (CGFloat)maxValue {
    return maxValue;
}

- (CGFloat)currentProgressValue {
    return currentProgressValue;
}

- (CGFloat)leftValue {
    return leftValue;
}

- (CGFloat)rightValue {
    return rightValue;
}

- (void)setShowThumbs:(BOOL)showThumbs {
    leftThumb.hidden = !showThumbs;
    rightThumb.hidden = !showThumbs;
}

- (BOOL)showThumbs {
    return !leftThumb.hidden;
}




- (void)setShowRange:(BOOL)showRange {
    rangeImage.hidden = !showRange;
}

- (BOOL)showRange {
    return !rangeImage.hidden;
}

- (void)handleLeftPan:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        CGFloat range = maxValue - minValue;
        CGFloat availableWidth = self.frame.size.width - DKSLIDER_THUMB_SIZE;
        self.leftValue += translation.x / availableWidth * range;
        
        [gesture setTranslation:CGPointZero inView:self];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)handleRightPan:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        CGFloat range = maxValue - minValue;
        CGFloat availableWidth = self.frame.size.width - DKSLIDER_THUMB_SIZE;
        self.rightValue += translation.x / availableWidth * range;
        
        [gesture setTranslation:CGPointZero inView:self];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)setup {
    
    self.showThumbs = YES;
    self.showRange = YES;

    
    
    if (maxValue == 0.0) {
        maxValue = 100.0;
    }
    
    leftValue = minValue;
    rightValue = maxValue;
    
    slider = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"sliderEmpty"] stretchableImageWithLeftCapWidth:5 topCapHeight:4]];
    [self addSubview:slider];
    
    rangeImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"progress_bar"] stretchableImageWithLeftCapWidth:5 topCapHeight:4]];
    [self addSubview:rangeImage];
    
    // left thumb
    leftThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, DKSLIDER_THUMB_SIZE + 12, DKSLIDER_THUMB_SIZE )];
    leftThumb.image = [UIImage imageNamed:@"filter"];
    leftThumb.userInteractionEnabled = YES;
    leftThumb.contentMode = UIViewContentModeCenter;
    [self addSubview:leftThumb];
    
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftPan:)];
    [leftThumb addGestureRecognizer:leftPan];
    
    //right thumb 
    rightThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DKSLIDER_THUMB_SIZE + 12, DKSLIDER_THUMB_SIZE * 2)];
    rightThumb.image = [UIImage imageNamed:@"filter"];
    rightThumb.userInteractionEnabled = YES;
    rightThumb.contentMode = UIViewContentModeCenter;
    [self addSubview:rightThumb];
    
    UIPanGestureRecognizer *rightPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightPan:)];
    [rightThumb addGestureRecognizer:rightPan];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    
    CGFloat availableWidth = self.frame.size.width - DKSLIDER_THUMB_SIZE;
    CGFloat inset = DKSLIDER_THUMB_SIZE / 2;
    
    CGFloat range = maxValue - minValue;
    
    CGFloat left = floorf((leftValue - minValue) / range * availableWidth);
    CGFloat right = floorf((rightValue - minValue) / range * availableWidth);
    
    if (isnan(left)) {
        left = 0;
    }
    
    if (isnan(right)) {
        right = 0;
    }
    
    slider.frame = CGRectMake(inset, self.frame.size.height / 2 - 5, availableWidth, 10);
    
    CGFloat rangeWidth = right - left;
    if ([self showRange]) {
        rangeImage.frame = CGRectMake(inset + left, self.frame.size.height / 2 - 5, rangeWidth, 10);
    }
    
    
     // Adjust left thumb position here
    leftThumb.center = CGPointMake(inset + left, self.frame.size.height/2 );
    
    // Adjust right thumb position here
    rightThumb.center = CGPointMake(inset + right, self.frame.size.height / 2 );
}



@end
