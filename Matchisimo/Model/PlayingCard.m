//
//  PlayingCard.m
//  Matchisimo
//
//  Created by Shai Haim on 10/13/14.
//  Copyright (c) 2014 Shai Haim. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    return [[PlayingCard validRanks][self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♣︎",@"♥︎",@"♦︎",@"♠︎"];
}

+ (NSArray *)validRanks
{
    return @[@"?", @"A",@"2",@"3",@"4",
             @"5",@"6",@"7",@"8",@"9",@"J",@"Q",@"K"];
}

@synthesize suit = _suit;

- (NSString *)suite{
    return _suit ? _suit:@"?";
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

+ (NSUInteger) maxRank
{
    return [[PlayingCard validRanks] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank<=[PlayingCard maxRank]){
        _rank = rank;
    }
}

- (int) getSuitIndex:(NSString *)suit{
    static int const SPADE_INDEX = 0;
    static int const CLUBS_INDEX = 1;
    static int const HEARTS_INDEX = 2;
    static int const DIAMOND_INDEX = 3;
    
    if ([suit  isEqual: @"♠︎"]){ return SPADE_INDEX;}
    if ([suit  isEqual: @"♦︎"]){ return DIAMOND_INDEX;}
    if ([suit  isEqual: @"♥︎"]){ return HEARTS_INDEX;}
    if ([suit  isEqual: @"♣︎"]){ return CLUBS_INDEX;}
    return -1;
}
- (NSInteger)match:(NSArray *)othercards
{
    NSInteger score = 0;
    NSInteger numberOfCardsToCompareAgainst = [othercards count];
    int maxRankMatch = 0;
    int maxSuitMatch = 0;

    int rankMatch[13]={0};
    int suitMatch[4]={0};
    if (numberOfCardsToCompareAgainst){
        suitMatch[[self getSuitIndex:self.suit]]++;
        rankMatch[self.rank]++;
        for (PlayingCard *card in othercards){
            suitMatch[[self getSuitIndex:card.suit]]++;
            rankMatch[card.rank]++;
        }
        for (int i=0; i<13; i++){
            maxRankMatch = maxRankMatch>rankMatch[i]?maxRankMatch:rankMatch[i];
        }
        for (int i=0; i<4; i++){
            maxSuitMatch = maxSuitMatch>suitMatch[i]?maxSuitMatch:suitMatch[i];
        }
        
        if (maxSuitMatch == 1 && maxRankMatch == 1){
            score = 0;
        } else {
            score = maxRankMatch > maxSuitMatch? 4 * maxRankMatch : maxSuitMatch;
        }
    }
    
    return score;
}

@end
