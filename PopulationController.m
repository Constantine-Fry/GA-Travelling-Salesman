//
//  PopulationMT.m
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/4/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "PopulationController.h"
#import "Population.h"


@implementation PopulationController
@synthesize allTimeBest = allTimeBest_;

- (id) initWithNT:(int)nt andNC:(int)nc andLength:(int)len 
		 andCosts:(CostTable*)costs andChanger:(Changer*)changer
{
	self = [super init];
	if (self != nil) {
		nthreads_ = nt;
		length_ = len;
		tribe_ = [[NSMutableArray alloc]init];
		thread_ = malloc(sizeof(pthread_t) *nthreads_);
		for (int i = 0; i < nthreads_; ++i){
			Population *pop = [[Population alloc]initWithNC:nc andLength:len andCosts:costs andChanger:changer];
			[tribe_ addObject:pop];
			[pop release];
		}
		bestTribe_ = 0;
		best_ = [tribe_ objectAtIndex:bestTribe_];
		for (int i = 0; i < nthreads_; ++i)
            if ([[tribe_ objectAtIndex:i] BestScore] > [self BestScore]) {
                bestTribe_ = i;
                best_ = [[tribe_ objectAtIndex:bestTribe_]Best ];
            }

		allTimeBest_ = [[tribe_ objectAtIndex:bestTribe_] Best];
		allTimeBestScore_  = [[tribe_ objectAtIndex:bestTribe_] BestScore];
	}
	return self;
}

- (void) dealloc
{
//	for(int i = 0; i<nthreads_;++i)
//		pthread_exit(&thread_[i]);
	free(thread_);
	allTimeBest_ =nil;
	best_ = nil;
	[tribe_ release];
	[super dealloc];
}


-(float)BestScore{
	return [[tribe_ objectAtIndex:bestTribe_] BestScore];
}

-(int)AllTimeBestScore{
	return allTimeBestScore_;
}

-(int)Generations{
	return [[tribe_ objectAtIndex:0] Generations];
}

void ThreadWrapper(void *t){
	[(Population*)t Cycle];
}

-(void)Cycle{
	for (int i = 0; i < nthreads_; ++i)
		pthread_create(&(thread_[i]), NULL, ThreadWrapper, (void *) &(*([tribe_ objectAtIndex:i])));
	for (int i = 0; i < nthreads_; ++i)
		pthread_join(thread_[i], NULL);
	bestTribe_ = 0;
	best_ = [tribe_ objectAtIndex:bestTribe_];
	for (int i = 0; i < nthreads_; ++i)
		if ([[tribe_ objectAtIndex:i] BestScore] > [self BestScore]) {
			bestTribe_ = i;
			best_ = [[tribe_ objectAtIndex:bestTribe_]Best ];
		}
	if(allTimeBestScore_ < [[tribe_ objectAtIndex:bestTribe_] BestScore]){
		allTimeBest_ = [[tribe_ objectAtIndex:bestTribe_] Best];
		allTimeBestScore_  = [[tribe_ objectAtIndex:bestTribe_] BestScore];
	}
}


@end
