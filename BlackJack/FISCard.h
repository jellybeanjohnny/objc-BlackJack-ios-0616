//
//  FISCard.h
//  OOP-Cards-Model
//
//  Created by Matt Amerige on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISCard : NSObject

@property (strong, nonatomic, readonly) NSString *suit;
@property (strong, nonatomic, readonly) NSString *rank;
@property (strong, nonatomic, readonly) NSString *cardLabel;
@property (nonatomic, readonly) NSUInteger cardValue;

/// Array of type NSString
+ (NSArray *)validSuits;

/// Array of type NSString
+ (NSArray *)validRanks;

/// Designated Initializer
- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank;
- (instancetype)init;

@end
