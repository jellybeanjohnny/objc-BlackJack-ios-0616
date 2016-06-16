//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Matt Amerige on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"

@implementation FISCardDeck

- (instancetype)init
{
	if (!(self = [super init])) {
		return nil;
	}
	
	_remainingCards = [[NSMutableArray alloc] init];
	_dealtCards = [[NSMutableArray alloc] init];
	[self _generateStandardDeck];
	
	return self;
}

/**
 Removes a card from the remaining cards array and its it to the dealt cards array
 */
- (FISCard *)drawNextCard
{
	if (self.remainingCards.count == 0) {
		// Can't draw any more cards!
		NSLog(@"Empty deck! Can't draw any more cards.");
		return nil;
	}
	
	// Pull the next card from the end of the remaining cards array
	FISCard *nextCard = [self.remainingCards lastObject];
	
	// Remove the pulled card from remaining cards
	[self.remainingCards removeLastObject];
	
	// Add it to the dealt cards
	[self.dealtCards addObject:nextCard];
	
	return nextCard;
}

/// Gathers dealt cards and then shuffles the remaining cards
- (void)resetDeck
{
	[self gatherDealtCards];
	[self shuffleRemainingCards];
}

/**
 It should add the cards in the dealtCards array back
 into the remainingCards array and leave the dealtCards array empty
 */
- (void)gatherDealtCards
{
	[self.remainingCards addObjectsFromArray:self.dealtCards];
	[self.dealtCards removeAllObjects];
}

- (void)shuffleRemainingCards
{
	NSUInteger count = self.remainingCards.count / 2;
	
	for (NSUInteger index = 0; index < count; index++) {
		// Pick two random indicies that are within the bounds of the remaining cards array
		NSUInteger randomIndex1 = [self _randomIndexFromArray:self.remainingCards];
		NSUInteger randomIndex2 = [self _randomIndexFromArray:self.remainingCards];
		[self.remainingCards exchangeObjectAtIndex:randomIndex1 withObjectAtIndex:randomIndex2];
	}
}

- (NSUInteger)_randomIndexFromArray:(NSArray *)array
{
	return arc4random_uniform((uint32_t)array.count - 1);
}

/**
 Generates the 52 cards in a standard deck
 */
- (void)_generateStandardDeck
{
	NSArray *ranks = [FISCard validRanks];
	NSArray *suits = [FISCard validSuits];
	
	for (NSString *rank in ranks) {
		for (NSString *suit in suits) {
			// Create card
			FISCard *card = [[FISCard alloc] initWithSuit:suit rank:rank];
			[self.remainingCards addObject:card];
		}
	}
}

- (NSString *)description
{
	NSString *countString = [NSString stringWithFormat:@"count:%ld\n", self.remainingCards.count];
	
	NSMutableString *cardString = [[NSMutableString alloc] initWithFormat:@"cards:"];
	
	for (FISCard *card in self.remainingCards) {
		[cardString appendFormat:@"\n%@",card];
	}
	
	NSString *result = [NSString stringWithFormat:@"%@%@",countString,cardString];
	
	return result;
	
}

@end
