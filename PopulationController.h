//
//  PopulationMT.h
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/4/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Population;
@class CostTable;
@class Chromosome;
@class Changer;

@interface PopulationController : NSObject {
	int nthreads_;
	int length_;
	NSMutableArray *tribe_;
	pthread_t *thread_;
	Chromosome  *best_;
	Chromosome *allTimeBest_;
	int allTimeBestScore_;
	int bestTribe_;
}

@property (readonly) Chromosome* allTimeBest;


- (id) initWithNT:(int)nt andNC:(int)nc andLength:(int)len 
		 andCosts:(CostTable*)costs andChanger:(Changer*)changer;

-(int)Generations;
-(float)BestScore;
-(int)AllTimeBestScore;
-(void)Cycle;
@end
