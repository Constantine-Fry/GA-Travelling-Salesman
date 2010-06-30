//
//  Chromosome.m
//  GATravellingSalesman
//
//  Created by Constantine Fry on 5/5/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "Chromosome.h"



@implementation Chromosome
@synthesize intChr =intChr_;

- (id) InitEmptyChromosomeWithSize:(int)L
{
	self = [super init];
	if (self != nil) {
		l_ = L;
		intChr_ = malloc(sizeof(int)*L);
		memset(intChr_,0,sizeof(int)*L);
	}
	return self;
}


- (id) InitRandomChromosomeWithSize:(int)L
{
	self = [self InitEmptyChromosomeWithSize:L];
	if (self != nil) {
		for(int i = 1;i<=l_ ;++i){
			intChr_[i-1] = i;
		}
		//[self shuffle];
	}
	return self;
}

- (void) dealloc{
	free(intChr_);
	intChr_ = NULL;
	[super dealloc];
}

-(int)Length{
	return l_;
}

-(int)GenAtindex:(int)index{
	return intChr_[index];
}

-(void)Copy:(Chromosome*)chr{
//	if(chr == nil)
//		NSLog(nil);
	memcpy(intChr_,chr.intChr,sizeof(int)*l_);
//	if (![child0 CheckSum]) {
//		NSLog(@"%@",child0);
//	}
//	if (![child1 CheckSum]) {
//		NSLog(@"%@",child1);
//	}
}

-(NSString*)description{
	NSMutableString *str = [[NSMutableString alloc]init];
	[str appendString:@"["];
	for(int i=0; i<l_;++i){
		[str appendFormat:@"%d, ",intChr_[i]];
	}
	[str appendString:@"]"];
	return [str autorelease];
}

-(int)FirstGen{
	return intChr_[0];
}

-(int)LastGen{
	return intChr_[l_-1];
}

- (void)shuffle{
	size_t i;
	for (i = 0; i < l_ - 1; i++) {
		size_t j = i + rand() / (RAND_MAX / (l_ - i) + 1);
		int t = intChr_[j];
		intChr_[j] = intChr_[i];
		intChr_[i] = t;
	}
}

-(BOOL)CheckSum{
	int a = 0;
	int f = 0;
	for (int i = 0;i<l_;++i){
		a += intChr_[i];
		f += i+1;
	}
	if (a ==f ) {
		return TRUE;
	}
	return FALSE;
}
@end
