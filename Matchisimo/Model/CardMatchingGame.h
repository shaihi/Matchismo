//
//  CardMatchingGame.h
//  Matchisimo
//
//  Created by Shai Haim on 10/15/14.
//  Copyright (c) 2014 Shai Haim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) int score;
@property (nonatomic) NSInteger numberOfCardsToMatch;
@property (nonatomic,strong) NSString *status;

@end
