//
//  NewPlayerOutcome.h
//  makeDealerCalcFile
//
//  Created by joshua boverman on 7/6/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewPlayerHand.h"

@interface NewPlayerOutcome : NSObject <NSCoding>


@property NSArray *allUniquePlayerHands;


- (NSArray *) makeAllUniquePlayerHands;


-(void) encodeWithCoder: (NSCoder *) aCoder;
-(id) initWithCoder: (NSCoder *) aDecoder;


@end
