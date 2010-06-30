//
//  GATravellingSalesmanAppDelegate.m
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/4/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "GATravellingSalesmanAppDelegate.h"
#import "PopulationController.h"
#import "defs.h"
#import "CostTable.h"
#import "Changer.h"
#import "Chromosome.h"

@implementation GATravellingSalesmanAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	int L = 14;
	int N = L * 4;
	float score = -1;
	int G =	1000 * L;
	int count1 = 0;
	int cou = 0;
	
	NSDate *fulltime = [NSDate date];
	CostTable *cTable = [[CostTable alloc]initRandomTableWithSize:L];
	//NSLog(@"%@",cTable);
	
	for(int i =0;i<7;++i){
		Changer * changer = [[Changer alloc]initWithInt:0];
		PopulationController *popmt = [[PopulationController alloc]initWithNT:T andNC:N/T
													andLength:L andCosts:cTable andChanger:changer];
		cou = 0;
		score = -1;
		Chromosome *best = [[Chromosome alloc]InitEmptyChromosomeWithSize:L];
		NSDate *start = [NSDate date];

		while (1) {
			[popmt Cycle];
			if([popmt AllTimeBestScore]>score){
				score = [popmt AllTimeBestScore];
				[best Copy:popmt.allTimeBest];
				count1 = 0;
			}
			++count1;
			cou++;
			if (count1 >= G) {
				count1 =0;
				//NSLog(@"Best path was stable for %d generations. Algorithm halted.",G);
				break;
			}
		}

		NSTimeInterval timeInterval = -[start timeIntervalSinceNow];
		
		NSLog(@"\nBest path was stable for %d generations. Algorithm halted.\nBest path: %@\nCost = %d \nBirthGeneration = %d\nTime elapsed = %g (%d min %d sec)\n\n",G,best,MAX_COST * L - (int)score,cou -G,timeInterval,(int)timeInterval/60,(int)timeInterval%60); 
		[popmt release];
		[changer release];
		[best release];
	}
	NSTimeInterval fullTimeInterval = -[fulltime timeIntervalSinceNow];
	NSLog(@"%d (%d %d)",fullTimeInterval,(int)fullTimeInterval/60,(int)fullTimeInterval%60);
	[cTable release];
}

@end
