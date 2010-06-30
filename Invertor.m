//
//  Invertor.m
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/6/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "Invertor.h"
#import "Chromosome.h"

@implementation Invertor

-(void)Change:(Chromosome*)one and:(Chromosome*)two{
	int l = [one Length];
	for(int i = 0; i<l;++i){
		int a = one.intChr[i];
		int b = l -a;
		one.intChr[i] = l + 1 - one.intChr[i];

	}
	for(int i = 0; i<l;++i){
		two.intChr[i] = l + 1 - two.intChr[i];

	}
}

@end
