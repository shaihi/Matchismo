//
//  PlayingCard.h
//  Matchisimo
//
//  Created by Shai Haim on 10/13/14.
//  Copyright (c) 2014 Shai Haim. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger) maxRank;

@end
