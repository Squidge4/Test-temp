


//
//  Shoe.m
//  BlackjackApp2
//
//  Created by joshua boverman on 6/28/14.
//  Copyright (c) 2014 joshua boverman. All rights reserved.
//

#import "Shoe.h"

@implementation Shoe


@synthesize cardsOfGivenRank;



-(void) encodeWithCoder: (NSCoder *) aCoder {
    [aCoder encodeObject:self.cardsOfGivenRank forKey:@"cardsOfRank"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.cardsOfGivenRank = (NSMutableArray*)[aDecoder decodeObjectForKey:@"cardsOfRank"];
    return self;
}



-(id) initWithDecks:(NSInteger)numDecks {
    
    NSInteger i;
    
    
    self = [super init];
    cardsOfGivenRank = [[NSMutableArray alloc] init];
    [cardsOfGivenRank setObject:[NSNumber numberWithInteger:(numDecks*52)] atIndexedSubscript:0];
    for (i = 1; i < 10; i++) {
        [cardsOfGivenRank setObject:[NSNumber numberWithInteger:(numDecks*4)] atIndexedSubscript:i];
    }
    [cardsOfGivenRank setObject:[NSNumber numberWithInteger:(numDecks*16)] atIndexedSubscript:10];
    
    return self;
}

- (Shoe *) copyOfShoe: (Shoe *) shoe {
    Shoe *s = [[Shoe alloc] initWithDecks:1];
    s.cardsOfGivenRank = [shoe.cardsOfGivenRank mutableCopy];
    return s;
}



@end

