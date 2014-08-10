//
//  PlayerNode.h
//  makeDealerCalcFile
//
//  Created by joshua boverman on 7/19/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "NewPlayerHand.h"
#import "DealerOutcome.h"

@interface PlayerNode : NewPlayerHand <NSCoding>

// these are arrays, because the values depend on dealer's upcard
@property (strong, nonatomic) NSMutableArray *stayVal;
@property (strong, nonatomic) NSMutableArray *bestVal;
@property (strong, nonatomic) NSMutableArray *hitVal;

@property (strong, nonatomic) PlayerNode *parent;
@property NSInteger addCard; // add this card to the parent to make the hand

//hands made of hits
@property (strong, nonatomic) NSMutableArray *hits;

//odds, overall, and then with each dealer upcard
@property (strong, nonatomic) NSMutableArray *oddsHandWithUpcard;

// for convenience, allows sorting
@property  NSInteger numCards;

// and a dealerOutcome
@property (strong, nonatomic) DealerOutcome *dealerOutcome;


-(PlayerNode *) initWithNewPlayerHand: (NewPlayerHand *) p;


- (void) oddsWithShoe: (Shoe *) shoe;

-(float) stayOutcomeWithShoe: (Shoe *) shoe;
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
       parent.odds * (odds are number of player's cards in the shoe - # player's cards in parent)/(#cards in shoe - # cards in player -1)
     if they are the same:
         parent.odds*(# cards in shoe = # cards in player -1)/#cards in shoe - # cards in player -1)

*/
- (float) bestOutcomeWithShoe: (Shoe *) shoe;

- (float) hitOutcomeWithShoe: (Shoe *) shoe;

- (BOOL) calculateStayValueWithShoe: (Shoe *) shoe;

-(float) oddsWithDealerUpcard:(NSInteger) upcard andShoe: (Shoe *) shoe;



-(void) encodeWithCoder: (NSCoder *) aCoder;
-(id) initWithCoder: (NSCoder *) aDecoder;


@end
