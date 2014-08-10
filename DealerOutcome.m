//
//  DealerOutcome.m
//  BlackjackApp2
//
//  Created by joshua boverman on 6/28/14.
//  Copyright (c) 2014 joshua boverman. All rights reserved.
//

#import "DealerOutcome.h"

@implementation DealerOutcome

@synthesize uC;

// initializes the dictionary of possibles

-(NSArray *) makeAllDealerHands {
    
    
    BOOL handsLeftToTally = YES;
    NSMutableArray *allHands = [[NSMutableArray alloc] init];
    
    DealerHand *d = [[DealerHand alloc] init];
    
    while (handsLeftToTally) {
        
        
        /* if < 17, add lowest
         else {
         addOdds
         if last < highest, index last
         else {
         while last == highest {
         if count > 1 remove last
         else you are DONE!
         }
         if (last < highest) index last else done!
         }
         */
        
        if(d.value < 17) { //keep adding aces til legal dealer hand
            [d addAce];
        } else { // legal hand
            
            
            //add the hand to the list
            [allHands addObject:[[DealerHand alloc] initWithCopyOf:d]];
            
            //    d = [[DealerHand alloc] init];
            
            
            
            // In the implementation
            /*
             NSString *s = [[NSString alloc] init];
             for (NSNumber *c in oneHand) {
             if (c.integerValue < 10) {
             s = [s stringByAppendingString:c.stringValue];
             } else {
             s = [s stringByAppendingString:@"T"];
             }
             }
             
             
             NSLog(@"%@ value %ld valueAceLow %ld", s, d.value, d.valueAceLow);
             */
            
            
            
            // for each legal hand, index last card if you can
            
            while ((![d indexLastCard])&& handsLeftToTally) {
                
                if (d.cards.count > 1) {
                    [d removeLastCard];
                } else {
                    handsLeftToTally = NO;
                }
            }
        }
        
    }
    
    
    
    
    
    
    return allHands;
}


-(void) makeAllUniqueDealerHandsWith: (NSArray *) allHands {
    
    NSUInteger i, m, c;
    
    
    NSMutableArray *uniqueHands = [[NSMutableArray alloc] init];
    UniqueDealerHand *newU;
    
    BOOL foundMatch = false;
    
    for (DealerHand *d in allHands) {
        
        
        for (UniqueDealerHand *u in uniqueHands) {
            
            
            foundMatch = false;
            if ([d.cardsByRank isEqualToArray:u.cardsByRank]) {
                
                
                if ([u.upCards containsObject: d.cards[0]]) {
                    
                    
                    
                    i = [u.upCards indexOfObject:d.cards[0]];
                    m = [u.multiplier[i] longValue];
                    [u.multiplier replaceObjectAtIndex:i withObject:@(m+1)];
                    
                } else {
                    
                    [u.upCards addObject:d.cards[0]];
                    [u.multiplier addObject:[NSNumber numberWithLong:1]];
                }
                
                foundMatch = true;
                break;
            }
            
            
            
        }
        if (!foundMatch) { //add the hand
            
            
            
            newU = [[UniqueDealerHand alloc] init];
            newU.multiplier = [NSMutableArray arrayWithObject:@1];
            newU.upCards = [NSMutableArray arrayWithObject:d.cards[0]];
            newU.cardsByRank = [d.cardsByRank copy];
            newU.cardsByRank = [NSMutableArray arrayWithArray:d.cardsByRank];
            newU.cards = [NSMutableArray   arrayWithArray:d.cards];
            
            newU.handValue = d.value;
            
            switch (newU.handValue) {
                case 17:
                    newU.outcomeCategory = 1;
                    break;
                case 18:
                    newU.outcomeCategory = 2;
                    break;
                case 19:
                    newU.outcomeCategory = 3;
                    break;
                case 20:
                    newU.outcomeCategory = 4;
                    break;
                case 21:
                    if ([newU.cards count] > 2) {
                        newU.outcomeCategory = 5;
                    } else {
                        newU.outcomeCategory = 6;
                    }
                    break;
                    
                default:
                    newU.outcomeCategory = 0; // busted! > 21!
            }
            [uniqueHands addObject:newU];
        }
    }
    
    
    
    
    
    NSArray *strippedUniqueHand = [[NSArray alloc] init];
    NSMutableArray *strippedUniqueHands = [[NSMutableArray alloc] init];
    NSArray *strippedForFile;
    
    for (UniqueDealerHand *u in uniqueHands) {
        
        
        // kludge - make the cardsByRank include 'all cards' in [0] for use later
        

         c = 0;
         for (NSInteger i = 1; i < 11; i++) {
         c += [u.cardsByRank[i] integerValue];
         }
        
        
         [u.cardsByRank replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:c]];
    
        

        strippedUniqueHand = [[NSArray alloc] initWithObjects: [u.cardsByRank copy], [u.upCards copy], [u.multiplier copy], [NSNumber numberWithInteger:u.outcomeCategory], nil];
        [strippedUniqueHands addObject:strippedUniqueHand];
    }
    
    strippedForFile = [strippedUniqueHands copy];
    

    NSLog(@"succeeeded? %d", [strippedForFile writeToFile:@"/Users/joshuaboverman/allUniqueDealerHands.plist" atomically:YES]);
    

    
    return;
}


// gives an 11X7 array with all potential dealer outcomes
- (void) dealerOutcomesWithShoe: (Shoe *) shoe  {


    float o;
    int i,j;

    
    if (!shoe) shoe = [[Shoe alloc] initWithDecks:1];
    if (!uC) uC = [NSArray arrayWithContentsOfFile:@"/Users/joshuaboverman/allUniqueDealerHands.plist"];

    
    
    for (i = 0; i < 11; i++) {
        for (j = 0; j < 7 ; j++) {
            dO[i][j]=0;
        }
    }
    // for each UniqueHand
    // calc odds of any permutation
    /* for (each upcard)
     add oddsXmultiplier to the section dO[outcome][upcard]. but, special case for blackjack; if ace first, put in the second to last column, if 10 first, last column.
    */
    
    for (NSArray *u in uC) {
        o = [self oddsWithShoe: shoe andArray:u[0]];
        for (int i = 0; i < [u[2] count]; i++) {
            dO[[u[1][i] longValue]][[u[3] integerValue]] += o * [u[2][i] longValue];
        }

    }
    
    for (i= 0; i < 7; i++) {
        for (j = 1; j < 11; j++) {
            dO[0][i] += dO[j][i];
        }
    }
    
    
    NSString *outcomeString = [[NSString alloc] init];

    outcomeString = [outcomeString stringByAppendingString:@"\n"];
    for (i = 0; i < 11; i++) {
        for (j=0; j < 7; j++) {
            outcomeString = [outcomeString stringByAppendingFormat:@"%f   ",dO[i][j]];
        }
        outcomeString = [outcomeString stringByAppendingString:@"\n"];
    }
    //NSLog(@"%@",outcomeString);
    
}


-(void) dealerOutcomesWithShoe:(Shoe *) shoe andPlayerCardsByRank: (NSArray *) playerCardsByRank {
        
        float o;
        int i,j;
        
        
        if (!shoe) shoe = [[Shoe alloc] initWithDecks:1];
        if (!uC) uC = [NSArray arrayWithContentsOfFile:@"/Users/joshuaboverman/allUniqueDealerHands.plist"];
        
        
        
        for (i = 0; i < 11; i++) {
            for (j = 0; j < 7 ; j++) {
                dO[i][j]=0;
            }
        }
        // for each UniqueHand
        // calc odds of any permutation
        /* for (each upcard)
         add oddsXmultiplier to the section dO[outcome][upcard]. but, special case for blackjack; if ace first, put in the second to last column, if 10 first, last column.
         */
        
        for (NSArray *u in uC) {
            o = [self oddsWithShoe: shoe andPlayerCardsByRank: playerCardsByRank andArray:u[0]];
            for (int i = 0; i < [u[2] count]; i++) {
                dO[[u[1][i] longValue]][[u[3] integerValue]] += o * [u[2][i] longValue];
            }
            
        }
        
        for (i= 0; i < 7; i++) {
            for (j = 1; j < 11; j++) {
                dO[0][i] += dO[j][i];
            }
        }
        

    return;
}

- (float) oddsWithShoe:(Shoe *) shoe andPlayerCardsByRank: (NSArray *) playerCardsByRank andArray: (NSArray *) uniqueElement {
    
    NSInteger i, j;
    float o;
    
    o = 1;
    
    NSMutableArray *leftInShoe = [[NSMutableArray alloc] init];
    for (i = 1; i <= 10; i++) {
        leftInShoe[i] = [NSNumber numberWithInteger:([shoe.cardsOfGivenRank[i] integerValue] - [playerCardsByRank[i] integerValue])];
    }
    
    
    for (i = 1; i <= 10; i++) {
        
        if ([uniqueElement[i] integerValue] > 0) {
            
            if ([leftInShoe[i] integerValue] >= [uniqueElement[i] integerValue]) {
                for (j = [leftInShoe[i] integerValue]; j > [leftInShoe[i] integerValue]-[uniqueElement[i] integerValue]; j-- ) {
                    
                    
                    o = o * j;
                    
                    
                }
            } else {
                o = 0;
                break;
            }
            
        } else {
            // do nothing - skip this set
        }
    }
    
    for (i = [leftInShoe[0] integerValue]; i > ([leftInShoe[0] integerValue]-[uniqueElement[0] integerValue]);i--) {
        if (i) {
            
            
            o = o/i;
            
            
        }
    }
    
    
    return o;
    
}


- (float) oddsWithShoe:(Shoe *) shoe andArray: (NSArray *) uniqueElement {
    NSInteger i, j;
    float o;
    
    o = 1;
    for (i = 1; i <= 10; i++) {
        
        if ([uniqueElement[i] integerValue] > 0) {
        
            if ([shoe.cardsOfGivenRank[i] integerValue] >= [uniqueElement[i] integerValue]) {
                for (j = [shoe.cardsOfGivenRank[i] integerValue]; j > [shoe.cardsOfGivenRank[i] integerValue]-[uniqueElement[i] integerValue]; j-- ) {
                    
                    
                    o = o * j;
                    
                    
                }
            } else {
                o = 0;
                break;
            }
            
        } else {
            // do nothing - skip this set
        }
    }
    
    for (i = [shoe.cardsOfGivenRank[0] integerValue]; i > ([shoe.cardsOfGivenRank[0] integerValue]-[uniqueElement[0] integerValue]);i--) {
        if (i) {
            
            
        o = o/i;
            
            
        }
    }
    
    
    return o;
}

- (NSArray *) returnWithPlayerHandValue: (NSInteger) val {  // doesnt take dealer or player blackjack into account!!
    

    
    NSMutableArray *odds = [[NSMutableArray alloc] init];
    
    int i;
     
    for (i = 1; i <= 10; i++) {
        
        if (val > 21) {
            
            
        } else if (val < 17) {
            
        } else if (val == 17) {
        } else if (val == 18) {
        } else if (val == 19) {
        } else if (val == 20) {
        } else if (val == 21) {
        }
    }
        if (outcome[6]>0) {
     for (i=0; i<6; i++) {
     outcome[i]=outcome[i]/(1-outcome[6]);
     }
     outcome[6]=0;
     }
     if (pva < 17) {
     r = (2*outcome[0])-1;
     } else if (pva == 17) {
     r = (2*outcome[0]) + outcome[1]-1;
     } else if (pva == 18) {
     r = (2*(outcome[0]+outcome[1])) + outcome[2]-1;
     } else if (pva == 19) {
     r = (2*(outcome[0]+outcome[1]+outcome[2])) + outcome[3]-1;
     } else if (pva==20) {
     r = (2*(outcome[0]+outcome[1]+outcome[2]+outcome[3])) + outcome[4]-1;
     } else if (pva==21) {
     if ((np > 2)||(splitnum>0)) {
     r = (2*(outcome[0]+outcome[1]+outcome[2]+ outcome[3]+outcome[4])) + outcome[5]-1;
     } else {
     r = (2.5*(outcome[0]+outcome[1]+outcome[2]+ outcome[3]+outcome[4]+outcome[5])) + outcome[6]-1;
     }
     } else {
     r = -1;
     }
     
     return r;
     
     }
     
     */

}



-(void) encodeWithCoder: (NSCoder *) aCoder {
    [aCoder encodeObject:self.uC forKey:@"uC"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.uC = (NSArray *)[aDecoder decodeObjectForKey:@"uC"];
    return self;
}


@end
