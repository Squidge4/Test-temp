//
//  MakeArchivedFiles.m
//  makeDealerCalcFile
//
//  Created by joshua boverman on 7/19/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "MakeArchivedFiles.h"

@implementation MakeArchivedFiles


@synthesize allDealerNodes, allPlayerNodes;

- (BOOL) makePlayerFilesWithNumDecks:(NSInteger) numDecks {
    
    NSArray  *source = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/allUniquePlayerHands"];
    
    
    // first, make the array well behaved by transferring it to a mutable array a
    
    NSMutableArray *a = [[NSMutableArray alloc] init];
    
    [a addObject: [source[0][0] mutableCopy]];
    

    for (int i = 1; i <= 10; i++) {
        [a addObject: [source[i] mutableCopy]];
    }
    
    // next, change all the objects from hands to nodes
    
    for (int i = 0; i <= 10; i++) {
        for (int j= 0; j < [a[i] count]; j++) {
            [a[i] replaceObjectAtIndex:j withObject:[[PlayerNode alloc] initWithNewPlayerHand:a[i][j] ]];
        }
    }
    
    
    // transfer to sorted array
    
    
    NSSortDescriptor *numCardsSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"numCards" ascending:YES];
    
    
    NSMutableArray *sortedPlayerOutcomes = [[NSMutableArray alloc] initWithCapacity:11];
    
    for (int i = 0; i <=10; i++) {
        sortedPlayerOutcomes[i] = [[a[i] sortedArrayUsingDescriptors:@[numCardsSortDescriptor]]mutableCopy];
    }
    
    
    NSMutableArray *hitCards;
    PlayerNode *comparisonNode;
    NSInteger c;
    
    for (int i = 0; i <=10; i++) { // all 11 sorted player outcomes
       for (int j = 0; j < [sortedPlayerOutcomes[i] count]; j++) { // all player nodes
        
        
    
            for (int k = 1; k <=10; k++) {  // all hit options
                
                comparisonNode = sortedPlayerOutcomes[i][j];
                hitCards = [comparisonNode.cardsByRank mutableCopy];
                c = [[hitCards objectAtIndex:k] integerValue];
                [hitCards replaceObjectAtIndex:k withObject:[NSNumber numberWithInteger:(c+1)]];
                
                for (PlayerNode *p in sortedPlayerOutcomes[i]) {
                    if ([hitCards isEqualTo:p.cardsByRank]) {
                        [comparisonNode.hits replaceObjectAtIndex:k withObject:p];
                        if (!p.parent) {
                            
                            
                            p.parent = [[PlayerNode alloc] init];
                            p.parent = sortedPlayerOutcomes[i][j];

                            
                        }
                        break;
                    }
                    
                    
                }
                
            }
        }
        
    }
    if (!allPlayerNodes) allPlayerNodes = [[NSArray alloc] init];
    allPlayerNodes = [sortedPlayerOutcomes copy];
    
    
    [NSKeyedArchiver archiveRootObject:allPlayerNodes toFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/temp"];
    
    NSArray *testArray = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/temp"];

    
    return true;
}

- (BOOL) makeDealerFilesWithNumDecks:(NSInteger) numDecks andHitsS17:(BOOL) hitSoftSeventeen {
  
    return true;
    
}

- (BOOL) addOddsOnToFileOfAllPlayerNodes {
    
    NSMutableArray *testArray = [[NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/AllCompletePlayerNodes"] mutableCopy];
    
    PlayerNode *p;
    
    for (int i = 0; i <=10; i++) {
        for (int j = 0; j < [testArray[i] count]; j++) {
            p = testArray[i][j];
            p.oddsHandWithUpcard = [[NSMutableArray alloc] init];
            for (int k = 0; k <= 10; k++) {
                [p.oddsHandWithUpcard addObject:[NSNumber numberWithFloat:0.0]];
            }
        }
    }
    
    [NSKeyedArchiver archiveRootObject:testArray toFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/AllCompletePlayerNodes"];
    
    return true;
    

    
}


- (BOOL) addDealerHandOnToFileOfAllPlayerNodes {
    
    NSMutableArray *testArray = [[NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/AllCompletePlayerNodes"] mutableCopy];
    
    PlayerNode *p;
    
    
    // make a dealerOutcome
    DealerOutcome *rootDealerOutcome = [[DealerOutcome alloc] init];
    
    rootDealerOutcome.uC = [NSArray arrayWithContentsOfFile:@"/Users/joshuaboverman/allUniqueDealerHands.plist"];
    
    for (int i = 0; i <=10; i++) {
        for (int j = 0; j < [testArray[i] count]; j++) {
            p = testArray[i][j];
            p.dealerOutcome  = [[DealerOutcome alloc] init];
            p.dealerOutcome.uC = rootDealerOutcome.uC;
         }
    }
    
    [NSKeyedArchiver archiveRootObject:testArray toFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/AllCompletePlayerNodes"];
    
    return true;
    
    
    
}


- (BOOL) addParentsOnToFileOfAllPlayerNodes {
    
    NSMutableArray *testArray = [[NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/temp"] mutableCopy];
    
    PlayerNode *p;
    
    for (int i = 0; i <=10; i++) {
        for (int j = 0; j < [testArray[i] count]; j++) {
            p = testArray[i][j];
            
            if (p.parent) {
                for (int k = 1; k <= 10; k++) {
                    if ([p.parent.cardsByRank[k] integerValue] < [p.cardsByRank[k] integerValue]) {
                        p.addCard = k;
                        
                        break;
                    }
                }
                
            }
        }
    }
    
    [NSKeyedArchiver archiveRootObject:testArray toFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/AllCompletePlayerNodes"];

    return true;
    
}



-(void) encodeWithCoder: (NSCoder *) aCoder {
    [aCoder encodeObject:self.allPlayerNodes forKey:@"allPlayerNodes"];
    [aCoder encodeObject:self.allDealerNodes forKey:@"allDealerNodes"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.allPlayerNodes = (NSArray*)[aDecoder decodeObjectForKey:@"allPlayerNodes"];
    self.allDealerNodes = (NSArray*)[aDecoder decodeObjectForKey:@"allDealerNodes"];
    return self;
}

@end
