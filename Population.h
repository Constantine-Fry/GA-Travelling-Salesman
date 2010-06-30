//
//  Population.h
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/4/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "defs.h"

@class CostTable;
@class Chromosome;
@class Changer;
@interface Population : NSObject {
	int n_;
	int l_;
	NSMutableArray *chromosome_;
	NSMutableArray *childChromosome_;
	int length_;
	int *score_, *childScore_;
	int totalScore_, childTotalScore_;
	int best_,childBest_;
	Chromosome *allTimeBest_;
	int allTimeBestScore_;
	int generations_;
	Changer *changer_;
	CostTable *cost_;
	int* mark_;
}
- (id) initWithNC:(int)nc andLength:(int)len andCosts:(CostTable*)costs andChanger:(Changer*)changer;

-(void)CrossoverChild:(Chromosome*)child0 withChild:(Chromosome*)child1;
-(int)Fitness:(Chromosome*)chromosome;
-(void)Cycle;
-(Chromosome*)Select;
-(int)Generations;

-(float)BestScore;
-(Chromosome*)Best;
@end
