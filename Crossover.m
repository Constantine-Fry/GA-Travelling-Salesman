//
//  Crossover.m
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/6/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "Crossover.h"
#import "Chromosome.h"

@implementation Crossover

-(Chromosome*)CrossoverWith:(Chromosome*)chromosome0 and:(Chromosome*)chromosome1
{
	int L = [chromosome0 Length];
	int* parent1 = chromosome0.intChr;
	int* parent2 = chromosome1.intChr;
	int child1[L];
	bool mark[L+1];
	memset(mark, -1, (L+1) * sizeof(bool));
	
	// select a random sub-string from parent chromosome 1
	int a = rand() % L;
	int b = rand() % (L - a) + a;
	for (int i = 0; i <= b - a; ++i) {
		child1[i] = parent1[a + i];
		mark[child1[i]] = 1;
	}	
	
	// add the maximum compatible sub-string from parent chromosome 2
	int p = 1;
	for (int i = 0; i < L - 1; ++i)
		if (parent2[i] == parent1[b]) {
			p = 1;
			while (i + p < L && !mark[parent2[i + p]]) {
				mark[parent2[i + p]] = 1;
				child1[b - a + p] = parent2[i + p];
				++p;
			}
			break;
		}
	
	// if needed, complete the path with missing nodes
	for (int i = 1; i <=L; ++i)
		if (!mark[i])
			child1[b - a + p++] = i;

	Chromosome *res =[[Chromosome alloc]InitEmptyChromosomeWithSize:L];
	memcpy(res.intChr, child1, L * sizeof(int));
	return res;

}

-(void)Change:(Chromosome*)child0 and:(Chromosome*)child1{
	Chromosome *chr0 = [self CrossoverWith:child0 and:child1];
	Chromosome *chr1 = [self CrossoverWith:child1 and:child0];
	[child0 Copy:chr0];
	[child1 Copy:chr1];
	[chr0 release];
	[chr1 release];
}

@end
