//
//  NewPlayerHand.m
//  makeDealerCalcFile
//
//  Created by joshua boverman on 7/6/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "NewPlayerHand.h"

@implementation NewPlayerHand


@synthesize  cards;  //  a string of NSNumbers (= card rank)
@synthesize cardsByRank; // index 0 is not used; indexes 1 - 10 are cards of rank
@synthesize value, valueAceLow;

-(void) addAce {
    
    NSInteger numCards;
    
    [cards addObject:[NSNumber numberWithInteger:1]];
    
    numCards = [[cardsByRank objectAtIndex:1] integerValue];
    [cardsByRank replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:(numCards+1)]];
    
    valueAceLow++;
    if (valueAceLow < 12) {
        value = valueAceLow + 10;
    } else {
        value = valueAceLow;
    }
    
}

- (void) removeLastCard {
    NSInteger rank, val;
    
    rank = [[cards lastObject] integerValue];
    val = [[cardsByRank objectAtIndex:rank] integerValue];
    
    valueAceLow = valueAceLow - rank;
    if ((valueAceLow < 12) && [[cardsByRank objectAtIndex:1] integerValue]) {
        value = valueAceLow + 10;
    } else {
        value = valueAceLow;
    }
    
    
    
    
    [cards removeLastObject];
    
    [cardsByRank replaceObjectAtIndex:rank withObject:[NSNumber numberWithInteger:(val-1)]];
    
    return;
}


- (BOOL) indexLastCard {
    
    NSInteger rank, n;
    
    rank = [[cards lastObject] integerValue];
    
    if (rank == 10) {
        return NO;
    } else {
        
        
        n = [[cardsByRank objectAtIndex:rank] integerValue];
        
        [cardsByRank replaceObjectAtIndex:rank withObject:[NSNumber numberWithInteger:(n -1)]];
        
        n = [[cardsByRank objectAtIndex:(rank+1)] integerValue];
        
        [cardsByRank replaceObjectAtIndex:(rank+1) withObject:[NSNumber numberWithInteger:(n +1)]];
        
        [cards removeLastObject];
        [cards addObject:[NSNumber numberWithInteger:(rank+1)]];
        
        valueAceLow++;
        if ((valueAceLow < 12) && [[cardsByRank objectAtIndex:1] integerValue]) {
            value = valueAceLow + 10;
        } else {
            value = valueAceLow;
        }
        
        
        return YES;
    }
    
}

- (id) init {
    
    int i;
    
    self = [super init];
    
    self.cards = [[NSMutableArray alloc] init];
    self.cardsByRank = [[NSMutableArray alloc] init];
    for (i = 0; i <=10; i++) {
        [cardsByRank addObject:[NSNumber numberWithInteger:0]];
    }
    
    return self;
}

- (id) initWithCopyOf:(NewPlayerHand *)d {
    
    NewPlayerHand *copy = [[NewPlayerHand alloc] init];
    
    for (int i = 0; i < [d.cards count]; i++) {
        copy.cards[i] = [NSNumber numberWithInteger:[d.cards[i] integerValue]];
    }
    for (int i = 0; i <[d.cardsByRank count]; i++) {
        copy.cardsByRank[i] = [NSNumber numberWithInteger:[d.cardsByRank[i] integerValue]];
    }
    
    copy.value = d.value;
    copy.valueAceLow = d.valueAceLow;
    
    return copy;
    
}

- (void) handFromCards: (NSArray *) c {
    
    NSInteger rank, numCards;
    
    for (NSNumber *n in c) {
        rank = [n integerValue];
        [cards addObject:[NSNumber numberWithInteger:rank]];
        numCards = [[cardsByRank objectAtIndex:rank] integerValue];
        [cardsByRank replaceObjectAtIndex:rank withObject:[NSNumber numberWithInteger:(numCards+1)]];
        valueAceLow += rank;
    }
    if ((valueAceLow < 12) && [[cardsByRank objectAtIndex:1] integerValue]) {
        value = valueAceLow + 10;
    } else {
        value = valueAceLow;
    }
}

- (float) probabilityWithShoe: (Shoe *) shoe {
    
    float p = 1.0;
    NSInteger i,j,k,l,r;
    
    p = 1.0;
    l = 0;
    for (i = 1; i <= 10; i++) {
        j = [[cardsByRank objectAtIndex:i] integerValue];
        if (j) {
            r = [[shoe.cardsOfGivenRank objectAtIndex:i] integerValue];
            if (j <= r) {
                for (k = 1; k <= j; k++) {
                    p = p*(r - k + 1);
                    l++;
                }
            } else {
                return 0.0;
            }
        }
    }
    r = [[shoe.cardsOfGivenRank objectAtIndex:0] integerValue];
    
    for (i = 0; i < l; i++) {
        p = p/(r-i);
        
    }
    if (p > 1.0) {
        NSLog(@"error  - p = %e", p);
    }
    return p;
}



-(void) encodeWithCoder: (NSCoder *) aCoder {
    

    [aCoder encodeObject:self.cards forKey:@"cards"];
    [aCoder encodeObject:self.cardsByRank forKey:@"cardsByRank"];
    [aCoder encodeInteger:self.value forKey:@"value"];
    [aCoder encodeInteger:self.valueAceLow forKey:@"valueAceLow"];
    
    

    
}

-(id)initWithCoder:(NSCoder *)aDecoder {

    self = [super init];
    
    self.cards = [aDecoder decodeObjectForKey:@"cards"];
    self.CardsByRank = [aDecoder decodeObjectForKey:@"cardsByRank"];
    self.value = [aDecoder decodeIntegerForKey:@"value"];
    self.valueAceLow = [aDecoder decodeIntegerForKey:@"valueAceLow"];
    
    return self;
 
}

@end

