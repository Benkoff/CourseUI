//
//  BNNDataArrayModel.m
//  CourseUI
//
//  Created by Admin on 15/10/05/.
//  Copyright (c) 2015 BenNovikov. All rights reserved.
//

#import "BNNDataArrayModel.h"

//#import "BNNDataModel.h"
#import "BNNDataArrayModelChanges.h"

#import "NSIndexPath+BNNExtensions.h"

static NSString * const kBNNMutableModelArrayKey = @"mutableModelArray";

@interface BNNDataArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableModelArray;

@end

@implementation BNNDataArrayModel

@dynamic modelArray;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)dataWithModelsCount:(NSUInteger)count {
    return [[self alloc] initWithModelsCount:count];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithModelsCount:(NSUInteger)count {
    self = [super init];
    if (self) {
        self.mutableModelArray = [NSMutableArray arrayWithCapacity:count];
    }
    
    return self;
}

- (instancetype)init {
    return [self initWithModelsCount:0];
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)modelArray {
    @synchronized(self) {
        return [self.mutableModelArray copy];
    }
}

#pragma mark -
#pragma mark Public Methods

- (NSUInteger)count {
    @synchronized (self) {
        return self.mutableModelArray.count;
    }
}

- (id)modelAtIndex:(NSUInteger)index {
    @synchronized (self) {
        return [self.mutableModelArray objectAtIndex:index];
    }
}

- (id)modelAtIndexedSubscript:(NSUInteger)index {
    @synchronized (self) {
        return [self.mutableModelArray objectAtIndexedSubscript:index];
    }
}

- (void)addModel:(id)model {
    [self insertModel:model atIndex:self.mutableModelArray.count];
}

- (void)insertModel:(id)model atIndex:(NSUInteger)index {
    @synchronized (self) {
        NSMutableArray *array = self.mutableModelArray;
        if (index < [array count]) {
            [array insertObject:model atIndex:index];
        } else {
            [array addObject:model];
        }
        
        BNNDataArrayModelChanges *changes = [BNNDataArrayModelChanges changesWithIndicesSource:index
                                                                                   destination:index
                                                                                     withState:BNNDataArrayModelInsert];
        [self setState:BNNDataModelDidChange withObject:changes];
    }
}

- (void)removeModel:(id)model {
    [self removeModelAtIndex:[self.mutableModelArray indexOfObject:model]];
}

- (void)removeModelAtIndex:(NSUInteger)index {
    @synchronized (self) {
        [self.mutableModelArray removeObjectAtIndex:index];
        
        BNNDataArrayModelChanges *changes = [BNNDataArrayModelChanges changesWithIndicesSource:index
                                                                                   destination:index
                                                                                     withState:BNNDataArrayModelDelete];
        [self setState:BNNDataModelDidChange withObject:changes];
    }
}

- (void)moveModelAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex {
    @synchronized (self) {
        NSMutableArray *array = self.mutableModelArray;
        id model = [array objectAtIndex:sourceIndex];
        [array removeObjectAtIndex:sourceIndex];
        [array insertObject:model atIndex:destinationIndex];
        
        BNNDataArrayModelChanges *changes = [BNNDataArrayModelChanges changesWithIndicesSource:sourceIndex
                                                                                   destination:destinationIndex
                                                                                     withState:BNNDataArrayModelMove];
        [self setState:BNNDataModelDidChange withObject:changes];
    }
}

#pragma mark -
#pragma mark BNNModel

- (void)performLoading {
    self.state = BNNDataModelDidLoad;
    
    BNNLogLoadingPerformed;
}

#pragma mark -
#pragma mark NSFastEnumeration protocol

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(__unsafe_unretained id[])buffer
                                    count:(NSUInteger)len
{
    return [self.mutableModelArray countByEnumeratingWithState:state
                                                       objects:buffer
                                                         count:len];
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
     NSString *kBNNMutableModelArrayKey = NSStringFromClass([self class]);
     BNNLogForObject(@"Key:%@", kBNNMutableModelArrayKey);
     [coder encodeObject:self.mutableModelArray forKey:kBNNMutableModelArrayKey];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        NSString *kBNNMutableModelArrayKey = NSStringFromClass([self class]);
        BNNLogForObject(@"Key:%@", kBNNMutableModelArrayKey);
        self.mutableModelArray = [coder decodeObjectForKey:kBNNMutableModelArrayKey];
    }
    
    return self;
}

@end
