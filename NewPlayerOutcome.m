//
//  NewPlayerOutcome.m
//  makeDealerCalcFile
//
//  Created by joshua boverman on 7/6/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "NewPlayerOutcome.h"

@implementation NewPlayerOutcome

@synthesize allUniquePlayerHands;

-(NSArray *) makeAllUniquePlayerHands {
    
    /* careful - takes hours to run!  makes an unfortunate array, with item 0  corresponding to all unique possible hands, and 1 - 10 corresponding to all possible hands with a given single player card (useful if you are calculating splits).  Unfortunate because item 0 is actually an array of objects with the hands in the first object and all the others are just arrays of hands; and arrays include single card hands (which don't exist of course).
     */
    
    BOOL handsLeftToTally = YES;
    
    BOOL matchFound = NO;
    
    BOOL matchFoundUpcard = NO;
    
    
    NewPlayerHand *p = [[NewPlayerHand alloc] init];
    NSMutableArray *s = [[NSMutableArray alloc] init];
    NSMutableArray *sByUpcard = [[NSMutableArray alloc] init];
    
    
    NSLog(@"in makeDealerCalcFile");
    
    int counter = 0;
    
    for (int i = 0; i <= 10; i++) {
        [sByUpcard addObject:[[NSMutableArray alloc] init]];
    }
    
    
    while (handsLeftToTally) {
        if(p.value < 21) { // add aces til 21.
            [p addAce];
        } else {  // index last indexable card. if no cards indexable, you are done!
            while ((![p indexLastCard])&& handsLeftToTally) {
                if (p.cards.count > 1) {
                    [p removeLastCard];
                } else {
                    handsLeftToTally = NO;
                }
            }
        }
        // add to the list but only if it is a unique hand
        counter++; // just to track progress
        matchFound = false;
        for  (NewPlayerHand *u in s) {
            
            if ([u.cardsByRank isEqualToArray: p.cardsByRank]) {
                matchFound = true;
                break;
            }
            
        }
        
        if (!matchFound) {
            
            [s addObject:[[NewPlayerHand alloc] initWithCopyOf:p]];
            
            [sByUpcard[[p.cards[0] integerValue]] addObject:[[NewPlayerHand alloc] initWithCopyOf:p]];
            
        } else {
            
            
            matchFoundUpcard = false;
            
            for (NewPlayerHand *u in sByUpcard[[p.cards[0] integerValue]]) {
                if ([u.cardsByRank isEqualToArray: p.cardsByRank]) {
                    matchFoundUpcard = true;
                    break;
                }
                
            }
            if (!matchFoundUpcard) {
                [sByUpcard[[p.cards[0] integerValue]] addObject:[[NewPlayerHand alloc] initWithCopyOf:p]];
            }
        }
    }
    
    
    [sByUpcard[0] addObject:s]; //now its a 11 item matrix with [0] for all upcards
    
    allUniquePlayerHands = [sByUpcard copy];
    
    NSLog(@"done with makeDealerCalcFile");

    return sByUpcard;
    
}



-(void) encodeWithCoder: (NSCoder *) aCoder {
    [aCoder encodeObject:self.allUniquePlayerHands forKey:@"allUniquePlayerHands"];

}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.allUniquePlayerHands = (NSArray*)[aDecoder decodeObjectForKey:@"allUniquePlayerHands"];
    return self;
}

@end
