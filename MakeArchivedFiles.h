//
//  MakeArchivedFiles.h
//  makeDealerCalcFile
//
//  Created by joshua boverman on 7/19/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewPlayerOutcome.h"
#import "PlayerNode.h"
#import "NewPlayerHand.h"



/* creates the data files needed for running blackjack
 
Creates a file that points to an 11 object array.
first object: all PlayerNodes that are legal for that deck, with dependencies
 objs 1:10: the PlayerNodes but only for the particular upcard (useful for calculating splits).
 
 two dealerOutcome files:  hit or stand on s17.
 
 
 */


@interface MakeArchivedFiles : NSObject <NSCoding>

@property (strong, nonatomic) NSArray *allPlayerNodes;
@property (strong, nonatomic) NSArray *allDealerNodes;


- (BOOL) makePlayerFilesWithNumDecks:(NSInteger) numDecks;



- (BOOL) makeDealerFilesWithNumDecks:(NSInteger) numDecks andHitsS17:(BOOL) hitSoftSeventeen;

- (BOOL) addParentsOnToFileOfAllPlayerNodes;
- (BOOL) addOddsOnToFileOfAllPlayerNodes;
- (BOOL) addDealerHandOnToFileOfAllPlayerNodes;

-(void) encodeWithCoder: (NSCoder *) aCoder;
-(id) initWithCoder: (NSCoder *) aDecoder;


@end
