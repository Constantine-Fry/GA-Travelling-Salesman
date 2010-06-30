//
//  Shuffler.m
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/7/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "Shuffler.h"
#import "Chromosome.h"

@implementation Shuffler

-(void)Change:(Chromosome*)child0 and:(Chromosome*)child1{
	[child0 shuffle];
	[child1 shuffle];
}

@end
