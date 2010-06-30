//
//  Mutator.m
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/6/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "Changer.h"
#import "Chromosome.h"
#import "Crossover.h"
#import "Mutator.h"
#import "Invertor.h"
#import "Shuffler.h"

#define FLAG1 0x0001   //1
#define FLAG2 0x0002   //10
#define FLAG3 0x0004   //100
#define ISTRUE(EXP, FLAG) ((EXP & FLAG) == FLAG)


@implementation Changer

- (id) initWithInt:(int)num
{
	self = [super init];
	if (self != nil) {
		int types[7]= {1,2,4,3,6,5,7};
		type_ = num;
		arr_ =[[NSMutableArray alloc]init];
		if (ISTRUE(types[num],FLAG1)) {
			Crossover *cr = [[Crossover alloc]init];
			[arr_ addObject:cr];
			[cr release];
		}
		if (ISTRUE(types[num],FLAG2)) {
			Mutator *cr = [[Mutator alloc]init];
			[arr_ addObject:cr];
			[cr release];
		}
		if (ISTRUE(types[num],FLAG3)) {
//			Invertor *cr = [[Invertor alloc]init];
//			[arr_ addObject:cr];
//			[cr release];
			Shuffler *sh = [[Shuffler alloc]init];
			[arr_ addObject:sh];
			[sh release];
		}
	}
	return self;
}

- (void) dealloc{
	[arr_ release];
	[super dealloc];
}


-(void)ChangeThisChromosoms:(Chromosome*)one and:(Chromosome*)two{
	for(id<ChangerProtocol> proto in arr_){
		[proto Change:one and:two];
	}
}








@end
