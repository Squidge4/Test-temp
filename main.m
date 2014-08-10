//
//  main.m
//  makeDealerCalcFile
//
//  Created by joshua boverman on 7/6/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DealerOutcome.h"
#import "NewPlayerOutcome.h"
#import "MakeArchivedFiles.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        
        

        
 
  
  MakeArchivedFiles *m = [[MakeArchivedFiles alloc] init];

        
        m.allPlayerNodes = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/AllCompletePlayerNodes"];
        
        
        
        Shoe *s = [[Shoe alloc] initWithDecks:1];

        for (int i = 0; i <= 10; i++) {
        for (PlayerNode *p in m.allPlayerNodes[i] ) {
            [p oddsWithShoe:s];
            
            [p calculateStayValueWithShoe:s ];
            
            // apache relay katie be my darlin
        }
        }
        
     //   [m addDealerHandOnToFileOfAllPlayerNodes];
        
        
        
    //    m.allPlayerNodes = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/AllCompletePlayerNodes"];
        
        
        
        
        
        
        
      //  [m addParentsOnToFileOfAllPlayerNodes];
       // [m addOddsOnToFileOfAllPlayerNodes];

        
      //  Shoe *s = [[Shoe alloc] initWithDecks:1];
        
      //  for (PlayerNode *p in m.allPlayerNodes[0]) {
       //     [p oddsWithShoe:s ];
            
      //  }

        
/*
 
        [m addOddsOnToFileOfAllPlayerNodes];
        
        
        
        m.allPlayerNodes = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/joshuaboverman/Desktop/BlackjackDataFiles/AllCompletePlayerNodes"];
        
        
   //     [m addParentsOnToFileOfAllPlayerNodes];
         
        
    //    [m makePlayerFilesWithNumDecks:1];
        
  
        NSArray *p = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/joshuaboverman/Desktop/allUniquePlayerHands"];
        
   
        int c[22];
        for (int i = 0; i <= 21; i++) {
            c[i] = 0;
        }
        
        for (NewPlayerHand *n in p[10]) {
            
            c[[n.cards count]]++;
            
        
        }

         
        */

        
       //  Shoe *s = [[Shoe alloc] initWithDecks:1];
         
         //DealerOutcome *d = [[DealerOutcome alloc] init];
        
         //[d dealerOutcomesWithShoe:s];
        
        

    }
    return 0;
}

