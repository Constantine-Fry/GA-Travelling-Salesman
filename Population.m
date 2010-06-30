//
//  Population.m
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/4/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "Population.h"
#import "CostTable.h"
#import "Chromosome.h"
#import "Changer.h"

@implementation Population

- (id) initWithNC:(int)nc andLength:(int)len andCosts:(CostTable*)costs andChanger:(Changer*)changer
{
	self = [super init];
	if (self != nil) {
		n_ = nc;
		l_ = len;
		changer_ = [changer retain];
		cost_ = [costs retain];
		length_ = l_ * 4;
		chromosome_ = [[NSMutableArray alloc]init];
		childChromosome_ = [[NSMutableArray alloc]init];
		score_ = malloc(sizeof(int) * n_);
		childScore_ = malloc(sizeof(int) * n_);
		mark_ = malloc(sizeof(int) * n_);
		totalScore_ = 0;
		best_ = 0;
		generations_ = 0;
		
		
		for(int i = 0; i < n_; ++i){			
			Chromosome *chr = [[Chromosome alloc]InitRandomChromosomeWithSize:l_];
			[chromosome_ addObject:chr];
			[chr release];
			
			Chromosome *emptyChr = [[Chromosome alloc]InitEmptyChromosomeWithSize:l_];
			[childChromosome_ addObject:emptyChr];
			[emptyChr release];
			
			score_[i] = [self Fitness:[chromosome_ objectAtIndex:i]];
			if (score_[i] > score_[best_])
				best_ = i;
		}
		allTimeBest_ = [chromosome_ objectAtIndex:best_];
		allTimeBestScore_ = score_[best_];
	}		 
	return self;
}

- (void) dealloc
{
	[chromosome_ release];
	[childChromosome_ release];
	[cost_ release];
	[changer_ release];
	free(score_);
	free(childScore_);
	[super dealloc];
}


-(int)Generations{
	return generations_;
}

-(int)Fitness:(Chromosome*)chromosome{
	int totalCost = 0;
	int j =0;
	int i = 0;
	for (int ii = 0; ii < [chromosome Length] - 1; ++ii){
		i = [chromosome GenAtindex:ii];
		j = [chromosome GenAtindex:ii+1];
		totalCost += [cost_ CostBetweenI:i andJ:j];
	}
	i = [chromosome FirstGen];
	 j= [chromosome LastGen];
	totalCost += [cost_ CostBetweenI:i andJ:j];
	return (int)(MAX_COST * l_ - totalCost);
}

-(void)Cycle{
	childTotalScore_ = 0;
	childBest_ = 0;
	
	for(int i = 0; i < (n_/2)*2; i+=2){
		memset(mark_,0,sizeof(int) * n_);
		Chromosome *parent0 = [self Select];
		Chromosome *parent1 = [self Select];

		Chromosome *child0 = [childChromosome_ objectAtIndex:i];
		Chromosome *child1 = [childChromosome_ objectAtIndex:i+1];
		[child0 Copy:parent0];
		[child1 Copy:parent1];
		
		[changer_ ChangeThisChromosoms:child0 and:child1];

		childScore_[i] = [self Fitness:child0];
		childScore_[i+1] = [self Fitness:child1];
		childTotalScore_ += childScore_[i] + childScore_[i+1];

		if (childScore_[i] > childScore_[childBest_])
			childBest_ = i;
		if (childScore_[i+1] > childScore_[childBest_])
			childBest_ = i+1;
	}
	NSMutableArray *tmpChromosome = chromosome_;
	chromosome_ = childChromosome_;
	childChromosome_ = tmpChromosome;	
	
	int *tmpScore = score_;
	score_ = childScore_;
	childScore_ = tmpScore;
	
	totalScore_ = childTotalScore_;
	best_ = childBest_;
	
	++generations_;

	childTotalScore_ = 0;
	childBest_ = 0;
	
	if(allTimeBestScore_ < score_[best_]){
		allTimeBest_ = [chromosome_ objectAtIndex:best_];
		allTimeBestScore_ = score_[best_];
	}
}




-(Chromosome*)Select{
//	int choice = (int) rand()/RAND_MAX *childTotalScore_;
//	int position = 0;
//	for (int i = 0; i < n_; ++i)
//		if (position + score_[i] >= choice)
//			return [chromosome_ objectAtIndex:i];
//		else
//			position += score_[i];
//	return [chromosome_ objectAtIndex:rand()%n_];
	int best = 0;
	int positionOfBest = 0;
	for(int i = 0;i<n_;i++){
		if (!mark_[i]) {
			if (best < score_[i]) {
				positionOfBest = i;
			}
		}
	}
	mark_[positionOfBest] = 1;
	return [chromosome_ objectAtIndex:positionOfBest];
}


-(float)BestScore{
	return allTimeBestScore_; 
}

-(Chromosome*)Best{
	return allTimeBest_;
}

@end
