//
//  BNNConstants.h
//  CourseUI
//
//  Created by Admin on 15/09/13/.
//  Copyright (c) 2015 BenNovikov. All rights reserved.
//

#ifndef CourseUI_BNNConstants_h
#define CourseUI_BNNConstants_h

typedef NS_ENUM(NSUInteger, BNNRectPositionType) {
    BNNUpperLeftCorner,
    BNNUpperRightCorner,
    BNNBottomRightCorner,
    BNNBottomLeftCorner,
    BNNRectPositionTypeCount
};

typedef BNNRectPositionType(^BNNRectPositionBlock)(void);

#define GetOriginAdjustedForMainScreenBounds(objectName, subtractX, subtractY) \
objectName.origin.x = [[UIScreen mainScreen] bounds].size.width - subtractX; \
objectName.origin.y = [[UIScreen mainScreen] bounds].size.height - subtractY

#define GetRandomCGFloat(limit) (CGFloat)(arc4random() % (limit + 1)) / (float)limit

#define BNN_NSTIMEINTERVAL_KEY(key, value) static NSTimeInterval const key = value
BNN_NSTIMEINTERVAL_KEY(kBNNRectangleAnimationDuration,  3.0);
BNN_NSTIMEINTERVAL_KEY(kBNNRectangleAnimationDelay,     1.0);

#define BNN_FLOAT_KEY(key, value) static float const key = value
BNN_FLOAT_KEY(kBNNAffineTransformScaleUpperLimit,       1.5f);
BNN_FLOAT_KEY(kBNNAffineTransformScaleLowerLimit,       0.5f);
BNN_FLOAT_KEY(kBNNRandomColorAlpha,                     1.f);
BNN_FLOAT_KEY(kBNNRectSizeWidth,                        100.f);
BNN_FLOAT_KEY(kBNNRectSizeHeigh,                        100.f);

#define SetImageName(image, imageName) \
[UIImage imageNamed:@imageName]

/*
 UIImage *image[10];
 image[0] = SetImageName(image[0], "01.jpg");
 UIImage *image1 = [UIImage imageNamed:@"02.jpg"]; 
 NSArray *images = [NSArray arrayWithArray:image];
 */
/*reserved
#define BNN_STRING_KEY(key, value) static NSString *const key = value
BNN_STRING_KEY(kBNN_, @"");
*/
#endif
