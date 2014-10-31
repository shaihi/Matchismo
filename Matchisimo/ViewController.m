//
//  ViewController.m
//  Matchisimo
//
//  Created by Shai Haim on 10/8/14.
//  Copyright (c) 2014 Shai Haim. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "playingcarddeck.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation ViewController
- (IBAction)chooseNumberCardsToMatch:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    self.game.numberOfCardsToMatch = segment.selectedSegmentIndex + 2;
    NSLog(@"User selected a game of %d cards matching", (int)self.game.numberOfCardsToMatch);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    self.gameSelector.enabled = NO;
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}
- (IBAction)redealButton:(id)sender {
    for (UIButton *cardButton in self.cardButtons){
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"]
                              forState:UIControlStateNormal];
        [cardButton setTitle:@""
                    forState:UIControlStateNormal];
        cardButton.enabled = YES;
        self.gameSelector.enabled = YES;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
    self.statusLabel.text = [NSString stringWithFormat:@"Status: Game reset"];
    self.game = nil;
}

- (Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)game{
    if (!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        _game.numberOfCardsToMatch = self.gameSelector.selectedSegmentIndex + 2;
    }
    
    return _game;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:(card.isChosen)?[card contents]:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:card.isChosen?@"cardfront":@"cardback"] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.statusLabel.text = [NSString stringWithFormat:@"Status: %@", self.game.status];
    }
}

@end

