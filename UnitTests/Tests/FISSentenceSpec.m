//  FISSentenceSpec.m

#import "Specta.h"
#import "FISSentence.h"
#define EXP_SHORTHAND
#import "Expecta.h"


SpecBegin(FISSentence)

describe(@"FISSentence", ^{
    
    __block NSArray *invalidPuncts;
    
    __block FISSentence *welcome;
    __block FISSentence *heyBlinkin;
    __block FISSentence *kingIllegal;
    __block FISSentence *deeredToKill;
    
    beforeEach(^{
        
        // Hey Blinkin!
        // King illegal forest to pig kill in it a is.
        // He deered to kill a king's dare.
        
        invalidPuncts = [@"aAmMzZ13690~`@#$%^&*()[]{}|<>" componentsSeparatedByString:@""];

        welcome = [[FISSentence alloc] init];
        welcome.words = [[NSMutableArray alloc] init];
        welcome.punctuation = @"";
        
        heyBlinkin = [[FISSentence alloc] init];
        heyBlinkin.words = [[NSMutableArray alloc] initWithObjects:@"Hey", nil];
        heyBlinkin.punctuation = @"!";
        
        kingIllegal = [[FISSentence alloc] init];
        kingIllegal.words = [[NSMutableArray alloc] initWithObjects:@"King", @"illegal", @"forest", @"to", @"pig", @"kill", @"in", @"it", @"a", @"is", nil];
        kingIllegal.punctuation = @".";
        
        deeredToKill = [[FISSentence alloc] init];
        deeredToKill.words = [[NSMutableArray alloc] init];
        deeredToKill.punctuation = @"";
    });
    
    describe(@"addWord:", ^{
        it(@"should add the word argument to an empty sentence", ^{
            [welcome addWord:@"Welcome"];
            
            expect(welcome.sentence).to.equal(@"Welcome");
        });
        
        it(@"should add the word argument between the last word in the sentence and the punctuation mark", ^{
            [heyBlinkin addWord:@"Blinkin"];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey Blinkin!");
        });
        
        it(@"should do nothing when the word argument is nil", ^{
            [heyBlinkin addWord:nil];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey!");
        });
        
        it(@"should do nothing when the word argument is an empty string", ^{
            [heyBlinkin addWord:@""];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey!");
        });

        it(@"should do nothing when the word argument is a single space", ^{
            [heyBlinkin addWord:@" "];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey!");
        });
    });

    describe(@"addWords:WithPunctuation", ^{
        it(@"should add a single word and punctuation mark to an empty sentence", ^{
            [welcome addWords:@[@"Welcome"] withPunctuation:@"!"];
            
            expect(welcome.sentence).to.equal(@"Welcome!");
        });
        
        it(@"should add a single word to an existing sentence", ^{
            [heyBlinkin addWords:@[@"Blinkin"] withPunctuation:@"!"];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey Blinkin!");
        });
        
        it(@"should should overwrite the punctuation of an existing sentence", ^{
            [heyBlinkin addWords:@[@"Blinkin"] withPunctuation:@"?"];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey Blinkin?");
        });

        
        it(@"should add the words in the array argument to an empty sentence", ^{
            deeredToKill.punctuation = @".";
            [deeredToKill addWords:@[@"He", @"deered", @"to", @"kill", @"a", @"king's", @"dare"] withPunctuation:@"."];
            
            NSString *expectedSentence = @"He deered to kill a king's dare.";
            expect(deeredToKill.sentence).to.equal(expectedSentence);
        });
        
        it(@"should not add empty strings or spaces to the self.words array", ^{
            [heyBlinkin addWords:@[@"", @" ", @"Blinkin"] withPunctuation:@"!"];
            
            expect(heyBlinkin.words.count).to.equal(2);
        });
        
        it(@"should do nothing if the words argument is an empty array", ^{
            [heyBlinkin addWord:@"Blinkin"];
            [heyBlinkin addWords:@[] withPunctuation:@"?"];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey Blinkin!");
        });
        
        it(@"should do nothing if the words argument is nil", ^{
            [heyBlinkin addWord:@"Blinkin"];
            [heyBlinkin addWords:nil withPunctuation:@"?"];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey Blinkin!");
        });

        
        it(@"should do nothing if the punctuation argument is an empty string", ^{
            [heyBlinkin addWord:@"Blinkin"];
            [heyBlinkin addWords:@[@"watch", @"out"] withPunctuation:@""];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey Blinkin!");
        });
        
        it(@"should do nothing if the punctuation argument is nil", ^{
            [heyBlinkin addWord:@"Blinkin"];
            [heyBlinkin addWords:@[@"watch", @"out"] withPunctuation:nil];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey Blinkin!");
        });

        
        it(@"should do nothing if the punctuation argument is a non-punctuation character", ^{
            [heyBlinkin addWord:@"Blinkin"];
            for (NSString *badPunct in invalidPuncts) {
                [heyBlinkin addWords:@[@"watch", @"out"] withPunctuation:badPunct];
            }
            
            expect(heyBlinkin.sentence).to.equal(@"Hey Blinkin!");
        });
    });
    
    describe(@"removeWordAtIndex:", ^{
        it(@"should remove the first word when the argument integer is 0", ^{
            [kingIllegal removeWordAtIndex:0];
            
            NSString *expectedSentence = @"illegal forest to pig kill in it a is.";
            expect(kingIllegal.sentence).to.equal(expectedSentence);
        });
        
        it(@"should remove the second word when the argument integer is 1", ^{
            [kingIllegal removeWordAtIndex:1];
            
            NSString *expectedSentence = @"King forest to pig kill in it a is.";
            expect(kingIllegal.sentence).to.equal(expectedSentence);
        });
        
        it(@"should do nothing if the argument integer exceeds the bounds of the words array", ^{
            [kingIllegal removeWordAtIndex:10];
            
            expect(kingIllegal.words.count).to.equal(10);
        });
    });

    describe(@"insertWord:atIndex:", ^{
        it(@"should add the word argument to the beginning of the sentence when the index argument is 0", ^{
            [kingIllegal insertWord:@"It" atIndex:0];
            
            NSString *expectedSentence = @"It King illegal forest to pig kill in it a is.";
            expect(kingIllegal.sentence).to.equal(expectedSentence);
        });
        
        it(@"should add the word argument to to the middle of the sentence when the index argument is 3", ^{
            [kingIllegal insertWord:@"thieves" atIndex:3];
            
            NSString *expectedSentence = @"King illegal forest thieves to pig kill in it a is.";
            expect(kingIllegal.sentence).to.equal(expectedSentence);
        });
        
        it(@"should not add the word argument to the sentence when the index argument is beyond bounds of the words array", ^{
            [kingIllegal insertWord:@"jentacular" atIndex:10];
            
            NSString *expectedSentence = @"King illegal forest to pig kill in it a is.";
            expect(kingIllegal.sentence).to.equal(expectedSentence);
        });
    });

    describe(@"replacePunctuationWithPunctuation:", ^{
        it(@"should replace punctuation string with the argument string", ^{
            [heyBlinkin replacePunctuationWithPunctuation:@"?"];
            
            expect(heyBlinkin.sentence).to.equal(@"Hey?");
        });
        
        it(@"should not replace the punctuation string when the argument string is not a punctuation character", ^{
            for (NSString *badPunct in invalidPuncts) {
                [heyBlinkin replacePunctuationWithPunctuation:badPunct];
            }
            
            expect(heyBlinkin.sentence).to.equal(@"Hey!");
        });
    });

    describe(@"replaceWordAtIndex:withWord:", ^{
        it(@"should replace the fourth word in the sentence with the word argument when the index argument is 3", ^{
            [kingIllegal replaceWordAtIndex:3 withWord:@"any"];
            
            NSString *expectedSentence = @"King illegal forest any pig kill in it a is.";
            expect(kingIllegal.sentence).to.equal(expectedSentence);
        });
        
        it(@"should do nothing if the index argument is beyond bounds of the words array", ^{
            [kingIllegal addWord:@"definitely"];
            [kingIllegal replaceWordAtIndex:11 withWord:@"woah-woah-woah"];
            
            NSString *expectedSentence = @"King illegal forest to pig kill in it a is definitely.";
            expect(kingIllegal.sentence).to.equal(expectedSentence);
        });
        
        it(@"should do nothing if the word argument is an empty string", ^{
            [kingIllegal addWord:@"definitely"];
            [kingIllegal replaceWordAtIndex:0 withWord:@""];
            
            NSString *expectedSentence = @"King illegal forest to pig kill in it a is definitely.";
            expect(kingIllegal.sentence).to.equal(expectedSentence);
        });
        
        it(@"should do nothing if the word argument is nil", ^{
            [kingIllegal addWord:@"definitely"];
            [kingIllegal replaceWordAtIndex:0 withWord:nil];
            
            NSString *expectedSentence = @"King illegal forest to pig kill in it a is definitely.";
            expect(kingIllegal.sentence).to.equal(expectedSentence);
        });

        it(@"should do nothing if the word argument is a space", ^{
            [kingIllegal addWord:@"definitely"];
            [kingIllegal replaceWordAtIndex:0 withWord:@" "];
            
            NSString *expectedSentence = @"King illegal forest to pig kill in it a is definitely.";
            expect(kingIllegal.sentence).to.equal(expectedSentence);
        });

    });
});

SpecEnd
