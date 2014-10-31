//
//  Deck.h
//  Matchisimo
//
//  Created by Shai Haim on 10/13/14.
//  Copyright (c) 2014 Shai Haim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
