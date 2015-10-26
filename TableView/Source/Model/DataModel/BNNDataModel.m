//
//  BNNDataModel.m
//  CourseUI
//
//  Created by Admin on 15/09/27/.
//  Copyright (c) 2015 BenNovikov. All rights reserved.
//

#import "BNNDataModel.h"

#import "NSString+BNNExtensions.h"
#import "BNNMacros.h"

//static NSString * const kBNNTextKey = @"text";
static NSString * const kBNNURL     = @"http://static.standard.co.uk/s3fs-public/styles/story_large/public/thumbnails/image/2015/04/15/10/griner3.jpg";

@interface BNNDataModel()
//@property(nonatomic, assign)  BNNImageModel   *imageModel;
@property(nonatomic, strong)  UIImage   *image;

@end

@implementation BNNDataModel

# pragma mark - 
# pragma mark Class Methods

+ (instancetype)dataModel {
    return [[self alloc] initWithString:[NSString randomUnicodeStringWithLength:kBNNRandomStringLength]];
}

- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        self.text = string;
    }
    
    return self;
}

#pragma mark -
#pragma mark BNNModel

- (void)performLoading {
    UIImage *image = [UIImage imageNamed:kBNNImageName];
    self.image = image;
    
    BNNWeakify(self);
    BNNDispatchAsyncOnMainThread(^{
        BNNStrongify(self);
        
        BNNSleep(kBNNDefaultSleepDuration);

        self.state = image ? BNNDataModelDidLoad : BNNDataModelDidFailLoading;
        BNNLogLoadingPerformed;
    });
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
    
    // The following commented code...
    /*
    NSString *kBNNTextKey = NSStringFromClass([self class]);
    BNNLogForObject(@"Key:%@", kBNNTextKey);
    [coder encodeObject:self.text forKey:kBNNTextKey];
     */
    // ... is ABSOLUTELY THE SAME as this Macro deleted before:
    
    BNNSynthesizeEncoderForProperty(text);
    
    // just some logs to make the case OBVIOUS were added
}

- (id)initWithCoder:(NSCoder *)coder {
//    self = [super init];
//    if (self) {
//        NSString *kBNNTextKey = NSStringFromClass([self class]);
//        BNNLogForObject(@"Key:%@", kBNNTextKey);
//        self.text = [coder decodeObjectForKey:kBNNTextKey];
//    }
    BNNSynthesizeDecoderForProperty(text);
}

@end
