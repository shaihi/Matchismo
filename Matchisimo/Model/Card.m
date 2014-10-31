//
//  Card.m
//  Matchisimo
//
//  Created by Shai Haim on 10/13/14.
//  Copyright (c) 2014 Shai Haim. All rights reserved.
//

#import "Card.h"

@implementation Card

- (NSInteger)match:(NSArray *)othercards
{
    int score = 0;
    
    for(Card *card in othercards)
    {
        if ([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    return score;
}
@end
