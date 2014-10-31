//
//  CardMatchingGame.m
//  Matchisimo
//
//  Created by Shai Haim on 10/15/14.
//  Copyright (c) 2014 Shai Haim. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic,readwrite) int score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@end
@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    
    self = [super init];
    
    if (self)
    {
        for (int i=0; i < count ; i++){
            Card *card = [deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    
    self.status = [NSString stringWithFormat:@"%@", card.contents];
    if (!card.isMatched)
    {
        if (card.isChosen){
            card.chosen = NO;
            self.status = [self.status stringByAppendingString:@" Deselected"];
        }else{
            for (Card *card in self.cards){
                if (card.isChosen && !card.isMatched){
                    [chosenCards addObject:card];
                    self.status = [self.status stringByAppendingString:[NSString stringWithFormat:@" %@", card.contents]];
                }
            }
            
            //only if there are n cards selected do we check for a match
            if ([chosenCards count] == self.numberOfCardsToMatch - 1)
            {
                int matchScore = (int)[card match:chosenCards];
                if (matchScore)
                {
                    self.score += matchScore * MATCH_BONUS;
                    card.mathced = YES;
                    for (Card *otherCard in chosenCards){
                        otherCard.mathced = YES;
                     //   self.status = [self.status stringByAppendingString:[NSString stringWithFormat:@" %@", otherCard.contents]];
                    }
                    self.status = [self.status stringByAppendingString:[NSString stringWithFormat:@" match! Score %d", matchScore * MATCH_BONUS]];
                }
                else
                {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in chosenCards){
                        otherCard.chosen = NO;
                        //self.status = [self.status stringByAppendingString:[NSString stringWithFormat:@" %@", otherCard.contents]];
                    }
                    self.status = [self.status stringByAppendingString:[NSString stringWithFormat:@" do not match!%d points penalty", MISMATCH_PENALTY]];
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]?self.cards[index]:nil);
}

- (NSMutableArray *)cards{
    if (! _cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}
@end
