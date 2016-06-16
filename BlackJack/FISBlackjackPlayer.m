//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Matt Amerige on 6/15/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"

@implementation FISBlackjackPlayer

- (instancetype)init
{
	return [self initWithName:@""];
}

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self) {
		_name = name;
		_cardsInHand = [[NSMutableArray alloc] init];
		
		_aceInHand = NO;
		_blackjack = NO;
		_busted = NO;
		_stayed = NO;
		
		_handscore = 0;
		_wins = 0;
		_losses = 0;
		
	}
	return self;
}

- (void)resetForNewGame
{
	[self.cardsInHand removeAllObjects];
	self.handscore = 0;
	self.aceInHand = NO;
	self.stayed = NO;
	self.blackjack = NO;
	self.busted = NO;
}

- (void)acceptCard:(FISCard *)card
{
	[self.cardsInHand addObject:card];
	self.handscore += [self _cardValueForCard:card];
	if ([self _hasBlackjackForCardsInHand:self.cardsInHand]) {
		self.blackjack = YES;
	}
	else if ([self _didBust]) {
		self.busted = YES;
	}
}

- (NSUInteger)_cardValueForCard:(FISCard *)card
{
	// Is this an ace?
	if ([card.rank isEqualToString:@"A"]) {
		self.aceInHand = YES;
		return [self _aceValueForScore:self.handscore];
	}
	return card.cardValue;
}



/// Returns 11 if the current score is 11 or less, otherwise returns 1
- (NSUInteger)_aceValueForScore:(NSUInteger)score
{
	if (score < 11) {
		return 11;
	}
	return 1;
}

- (BOOL)_hasBlackjackForCardsInHand:(NSArray *)cards
{
	if (cards.count > 2 || self.handscore != 21) {
		return NO;
	}
	return YES;
}

- (BOOL)_didBust
{
	if (self.handscore > 21) {
		return YES;
	}
	return NO;
}

- (BOOL)shouldHit
{
	if (self.handscore > 17) {
		self.stayed = YES;
		return NO;
	}
	return YES;
}

- (NSString *)description
{
	NSString *cards = [self _stringForCardsInHand];
	
	return [NSString stringWithFormat:@"name: %@\ncards: %@\nhandscore: %ld\nace in hand: %d\nstayed: %d\nblackjack: %d\nbusted: %d\nwins: %ld\nlosses: %ld", self.name, cards, self.handscore, self.aceInHand, self.stayed, self.blackjack, self.busted, self.wins, self.losses];
}

- (NSString *)_stringForCardsInHand
{
	NSMutableString *cards = [[NSMutableString alloc] init];
	for (FISCard *card in self.cardsInHand) {
		[cards appendFormat:@"%@ ", card];
	}
	return cards;
}

@end










