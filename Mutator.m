//
//  Mutator.m
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/6/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "Mutator.h"
#import "Chromosome.h"

@implementation Mutator

-(void)Change:(Chromosome*)one and:(Chromosome*)two{
	int l = [one Length];
	int a = rand() % l;
	int b = rand() % l;
	int tmp = one.intChr[a];
	one.intChr[a] = one.intChr[b];
	one.intChr[b] = tmp;
	
	a = rand() % [one Length];
	b = rand() % [one Length];
	tmp = two.intChr[a];
	two.intChr[a] = two.intChr[b];
	two.intChr[b] = tmp;
}

@end
