//
//  DKSlider.h
//  DKRangeSliderObjectiveC
//
//  Created by Darshan on 7/20/17.
//
//

#import <UIKit/UIKit.h>


typedef enum {
   
    DKTrimMode,
    
} BJRangeSliderWithProgressDisplayMode;

#define DKSLIDER_THUMB_SIZE 30.0
@interface DKSlider : UIControl{
    
    UIImageView *slider;
    
    UIImageView *rangeImage;
    
    UIImageView *leftThumb;
    UIImageView *rightThumb;
    
    CGFloat minValue;
    CGFloat maxValue;
    CGFloat currentProgressValue;
    
    CGFloat leftValue;
    CGFloat rightValue;
}
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat currentProgressValue;

@property (nonatomic, assign) CGFloat leftValue;
@property (nonatomic, assign) CGFloat rightValue;

@property (nonatomic, assign) BOOL showThumbs;
@property (nonatomic, assign) BOOL showRange;

@end
