//
//  PlayerNode.m
//  makeDealerCalcFile
//
//  Created by joshua boverman on 7/19/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "PlayerNode.h"



@implementation PlayerNode

@synthesize stayVal, bestVal, hitVal, numCards, hits, parent, addCard, oddsHandWithUpcard, dealerOutcome;





-(PlayerNode *) initWithNewPlayerHand: (NewPlayerHand *) p {
    
    
    
    self = [super init];
    
    self.cards = [p.cards copy];
    self.cardsByRank = [p.cardsByRank copy];
    self.value = p.value;
    self.valueAceLow = p.valueAceLow;
    
    
    stayVal = [[NSMutableArray alloc] init];
    hitVal = [[NSMutableArray alloc] init];
    bestVal = [[NSMutableArray alloc] init];
    hits = [[NSMutableArray alloc] init];
    parent = nil; // empty, til filled in by MakeArchivedFiles;
    
    numCards = [self.cards count];
    
    for (int i = 0; i <= 10; i++) {
        [stayVal addObject:[NSNumber numberWithFloat:0.0]];
        [hitVal addObject:[NSNumber numberWithFloat:0.0]];
        [bestVal addObject:[NSNumber numberWithFloat:0.0]];
        [hits addObject:@[]];
    }
    


    return self;
    
}


-(float) stayOutcomeWithShoe: (Shoe *) shoe {
    
 
    return 0.0;
}

- (float) bestOutcomeWithShoe: (Shoe *) shoe {
    return 0;
}

- (float) hitOutcomeWithShoe: (Shoe *) shoe {
    return 0;
    
}

- (void) oddsWithShoe: (Shoe *) shoe {
    
    float o;
    
    /*
     
     algorithm:
     
     if (!parent) {
     if the dealer and player cards are different:
     odds are number of player's cards in the shoe)*number of dealers cards in the shoe/(number of cards in the shoe)(number of cards in the shoe -1)
     if the dealer and the player cards are the same:
     odds are number of player's cards in the shoe* (number of dealers cards in the shoe -1)/# cards in shoe)(#cards in shoe -1)
     }
     if (parent)
     if dealer and player's cards are different:
     parent.odds * ( number of player's cards in the shoe - # player's cards in parent)/(#cards in shoe - # cards in player -1)
     if they are the same:
     parent.odds*(# cards in shoe - # cards in player -1)/#cards in shoe - # cards in player -1)
     
     */
    
    for (int i = 1; i <=10; i++) {
        if (parent) {
            
            if (parent > 0) {
                
                if (addCard == i) {
                    
                    o = [parent.oddsHandWithUpcard[i] floatValue];
                    
                    o *= ([shoe.cardsOfGivenRank[addCard] integerValue]
                      -[self.cardsByRank[addCard] integerValue]);
                    
                    o /= ([shoe.cardsOfGivenRank[0] integerValue]
                      - self.numCards -1);
                    
                    
                } else {
                    o = [parent.oddsHandWithUpcard[i] floatValue];
                    
                    o *= ([shoe.cardsOfGivenRank[addCard] integerValue]
                      -([self.cardsByRank[addCard] integerValue]-1));
                    
                    
                    o /= ([shoe.cardsOfGivenRank[0] integerValue]
                      -self.numCards -1);
                }
                
            } else {
                o = 0;
            }
            
        } else {
            
            if ([self.cards[0] integerValue] == i) {
                o = [shoe.cardsOfGivenRank[[self.cards[0] integerValue]] integerValue];
                
                o = o*([shoe.cardsOfGivenRank[[self.cards[0] integerValue]] integerValue]-1);
                
                o = o/([shoe.cardsOfGivenRank[0] integerValue]*([shoe.cardsOfGivenRank[0] integerValue]-1));
                
                
            } else {
                
                o = [shoe.cardsOfGivenRank[[self.cards[0] integerValue]] integerValue];
                
                o *= [shoe.cardsOfGivenRank[i] integerValue];
                
                o /= ([shoe.cardsOfGivenRank[0] integerValue]
                  *([shoe.cardsOfGivenRank[0] integerValue]-1));
                
            }
            
            
        }
        
        
        [oddsHandWithUpcard replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:o]];
    }
    return;
}

-(float) oddsWithDealerUpcard:(NSInteger) upcard andShoe: (Shoe *) shoe {
    float o;

    return o;
    
}
                                                                  
                                                                  

- (BOOL) calculateStayValueWithShoe:(Shoe *)shoe   {
    

    NSInteger pC, sC;

    // make the shoe.  if the shoe does not contain all the player cards, return FALSE;
    Shoe *sMinusPlayer = [shoe copyOfShoe:shoe];
    for (int i = 1; i <= 10; i++) {
        pC = [self.cardsByRank[i] integerValue];
        sC = [shoe.cardsOfGivenRank[i] integerValue];
        if (pC > sC) {
            return FALSE; // can't do this one - shoe does not contain all player cards!
        }
        sMinusPlayer.cardsOfGivenRank[i] = [NSNumber numberWithInteger:(sC-pC)];
    }
    
    
    // calculate the dealer outcome matrix with shoe
    [self.dealerOutcome dealerOutcomesWithShoe: sMinusPlayer];
    
    for (int i = 1; i <= 10; i++) {
        
    }
       
    return TRUE;
}


-(void) encodeWithCoder: (NSCoder *) aCoder {
    
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.stayVal forKey:@"stayVal"];
    [aCoder encodeObject:self.bestVal forKey:@"bestVal"];
    [aCoder encodeObject:self.hitVal forKey:@"hitVal"];
    [aCoder encodeInteger:self.numCards forKey:@"numCards"];
    [aCoder encodeObject:self.parent forKey:@"parent"];
    [aCoder encodeObject:self.hits forKey:@"hits"];
    [aCoder encodeInteger:self.addCard forKey:@"addCard"];
    [aCoder encodeObject:self.oddsHandWithUpcard forKey:@"oddsHandWithUpcard"];
    [aCoder encodeObject:self.dealerOutcome forKey:@"dealerOutcome"];


    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    self.stayVal = (NSMutableArray*)[aDecoder decodeObjectForKey:@"stayVal"];
    self.bestVal = (NSMutableArray *)[aDecoder decodeObjectForKey:@"bestVal"];
    self.hitVal = (NSMutableArray *)[aDecoder decodeObjectForKey:@"hitVal"];
    self.numCards = (NSInteger)[aDecoder decodeIntegerForKey:@"numCards"];
    self.hits = (NSMutableArray *)[aDecoder decodeObjectForKey:@"hits"];
    self.parent = (PlayerNode *)[aDecoder decodeObjectForKey:@"parent"];
    self.addCard = (NSInteger)[aDecoder decodeIntegerForKey:@"addCard"];
    self.oddsHandWithUpcard = (NSMutableArray *)[aDecoder decodeObjectForKey:@"oddsHandWithUpcard"];
    self.dealerOutcome = (DealerOutcome *) [aDecoder decodeObjectForKey:@"dealerOutcome"];


    return self;
}



@end
