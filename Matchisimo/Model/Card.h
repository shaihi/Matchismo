//
//  Card.h
//  Matchisimo
//
//  Created by Shai Haim on 10/13/14.
//  Copyright (c) 2014 Shai Haim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL mathced;

- (NSInteger)match:(NSArray *)othercards;
@end
