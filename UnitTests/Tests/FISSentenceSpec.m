//  FISSentenceSpec.m

#import "Specta.h"
#import "FISSentence.h"
#define EXP_SHORTHAND
#import "Expecta.h"


SpecBegin(FISSentence)

describe(@"FISSentence", ^{
    
    __block NSArray *invalidPuncts;
    
    __block FISSentence *defaultSentence;
    __block FISSentence *welcome;
    __block FISSentence *heyHiHello;
    __block FISSentence *heyNonny;
    
    beforeEach(^{
        
        invalidPuncts = [@"aAmMzZ13690~`@#$%^&*()[]{}|<>" componentsSeparatedByString:@""];

        defaultSentence = [[FISSentence alloc] init];
        welcome = [[FISSentence alloc] init];
        
        heyHiHello = [[FISSentence alloc] init];
        [heyHiHello addClause:@[@"hey"] withPunctuation:@","];
        [heyHiHello addClause:@[@"hi"] withPunctuation:@","];
        [heyHiHello addClause:@[@"hello"] withPunctuation:@"!"];
        
        heyNonny = [[FISSentence alloc] init];
        [heyNonny addClause:@[@"hey"] withPunctuation:@","];
        [heyNonny addClause:@[@"nonny", @"and", @"a", @"ho-ho-ho"] withPunctuation:@"."];
        
    });
    
    describe(@"default initializer", ^{
        it(@"should set the sentence property to an empty string", ^{
            expect(defaultSentence.sentence).to.equal(@"");
        });
    });
    
    describe(@"addClause:withPunctuation", ^{
        it(@"should add a single word in the clause array argument and the punctuation argument to an empty sentence", ^{
            [welcome addClause:@[@"Welcome"] withPunctuation:@"!"];
            
            expect(welcome.sentence).to.equal(@"Welcome!");
        });
        
        it(@"should capitalize the first word of the sentence", ^{
            [welcome addClause:@[@"welcome"] withPunctuation:@"!"];
            
            expect(welcome.sentence).to.equal(@"Welcome!");
        });
        
        it(@"should add the words in the clause array argument and the punctuation argument to an empty sentence", ^{
            [welcome addClause:@[@"Welcome", @"to", @"the", @"Flatiron", @"School"] withPunctuation:@"!"];
            
            NSString *welcomeString = @"Welcome to the Flatiron School!";
            expect(welcome.sentence).to.equal(welcomeString);
        });
        
        it(@"should add the words in the clause array argument and the punctuation argument to an existing sentence with a space between the clauses", ^{
            [welcome addClause:@[@"Hello"] withPunctuation:@","];
            [welcome addClause:@[@"welcome", @"to", @"the", @"Flatiron", @"School"] withPunctuation:@"!"];
            
            NSString *helloWelcome = @"Hello, welcome to the Flatiron School!";
            expect(welcome.sentence).to.equal(helloWelcome);
        });
        
        it(@"should not accept an empty array or nil as the clause argument", ^{
            [welcome addClause:@[] withPunctuation:@"!"];
            [welcome addClause:nil withPunctuation:@"."];
            
            expect(welcome.sentence).to.equal(@"");
        });
        
        it(@"should not accept an empty string or nil as the punctuation argument", ^{
            [welcome addClause:@[@"Welcome"] withPunctuation:@""];
            [welcome addClause:@[@"Welcome"] withPunctuation:nil];
            
            expect(welcome.sentence).to.equal(@"");
        });
        
        it(@"should not accept non-punctuation characters as the punctuation argument", ^{
            for (NSString *badPunct in invalidPuncts) {
                [welcome addClause:@[@"Welcome"] withPunctuation:badPunct];
            }
            
            expect(welcome.sentence).to.equal(@"");
        });
    });
    
    describe(@"removeClauseAtIndex:", ^{
        it(@"should remove the first clause and its punctuation when the argument integer is 0", ^{
            [heyHiHello removeClauseAtIndex:0];
            
            expect(heyHiHello.sentence).to.equal(@"Hi, hello!");
        });
        
        it(@"should remove the second clause and its punctuation when the argument integer is 1", ^{
            [heyHiHello removeClauseAtIndex:1];
            
            expect(heyHiHello.sentence).to.equal(@"Hey, hello!");
        });
        
        it(@"should do nothing if the argument integer exceeds the bounds of the clause array", ^{
            [heyHiHello removeClauseAtIndex:3];
            
            expect(heyHiHello.sentence).to.equal(@"Hey, hi, hello!");
        });
    });
    
    describe(@"insertClause:withPunctuation:atClausesIndex:", ^{
        it(@"should add the clause and its punctuation to the beginning of the sentence when the clausesIndex argument is 0", ^{
            [heyNonny insertClause:@[@"hey", @"nonny"] withPunctuation:@"," atClausesIndex:0];
            
            NSString *nonnyString = @"Hey nonny, hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should add the clause and its punctuation to to the middle of the sentence when the clausesIndex argument is 1", ^{
            [heyNonny insertClause:@[@"nonny"] withPunctuation:@"," atClausesIndex:1];
            
            NSString *nonnyString = @"Hey, nonny, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should not add the clause and its punctuation when the clausesIndex argument is beyond bounds of the clauses array", ^{
            [heyNonny insertClause:@[@"nonny"] withPunctuation:@"," atClausesIndex:2];
            
            NSString *nonnyString = @"Hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
    });
    
    describe(@"replacePunctuationForClauseAtIndex:withPunctuation:", ^{
        it(@"should replace the string in the punctuations array at the argument index with the argument string", ^{
            [heyHiHello replacePunctuationForClauseAtIndex:0 withPunctuation:@";"];
            
            expect(heyHiHello.sentence).to.equal(@"Hey; hi, hello!");
        });
        
        it(@"should not replace the string in the punctuations array when the argument string is not a punctuation character", ^{
            for (NSString *badPunct in invalidPuncts) {
                [heyHiHello replacePunctuationForClauseAtIndex:0 withPunctuation:badPunct];
            }
            
            expect(heyHiHello.sentence).to.equal(@"Hey, hi, hello!");
        });
        
        it(@"should do nothing when the index argument is beyond bounds of the punctuation array", ^{
            [heyHiHello replacePunctuationForClauseAtIndex:3 withPunctuation:@"!"];
            
            expect(heyHiHello.sentence).to.equal(@"Hey, hi, hello!");
        });
    });
    
    describe(@"addWord:toClauseAtIndex:", ^{
        it(@"should add the word argument to the end of the clause sub-array at the clausesIndex argument", ^{
            [heyNonny addWord:@"nonny" toClauseAtIndex:0];
            
            NSString *nonnyString = @"Hey nonny, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should do nothing when the clausesIndex argument is out of bounds of the clauses array", ^{
            [heyNonny addWord:@"nonny" toClauseAtIndex:2];
            
            NSString *nonnyString = @"Hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
    });
    
    describe(@"removeWordAtIndex:fromClauseAtIndex:", ^{
        it(@"should remove the second word from the second clause in the clauses array", ^{
            [heyNonny removeWordAtIndex:1 fromClauseAtIndex:1];
            
            NSString *nonnyString = @"Hey, nonny a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should do nothing when the wordsIndex is beyond bounds of the clause at the clausesIndex", ^{
            [heyNonny removeWordAtIndex:1 fromClauseAtIndex:0];
            
            NSString *nonnyString = @"Hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should do nothing when the clausesIndex is beyond bounds of the clauses array", ^{
            [heyNonny removeWordAtIndex:1 fromClauseAtIndex:2];
            
            NSString *nonnyString = @"Hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
    });
    
    describe(@"insertWord:atIndex:inClauseAtIndex:", ^{
        it(@"should add the word argument to second index in the second clause in the clauses array", ^{
            [heyNonny insertWord:@"nonny" atIndex:1 inClauseAtIndex:1];
            
            NSString *nonnyString = @"Hey, nonny nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should do nothing if the word argument is an empty string or nil", ^{
            [heyNonny insertWord:@"" atIndex:1 inClauseAtIndex:1];
            [heyNonny insertWord:nil atIndex:1 inClauseAtIndex:1];
            
            NSString *nonnyString = @"Hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should do nothing if the clausesIndex argument is out of bounds of the clauses array", ^{
            [heyNonny insertWord:@"nonny" atIndex:1 inClauseAtIndex:2];
            
            NSString *nonnyString = @"Hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should do nothing if the wordsIndex argument is out of bounds for the sub-array at the clausesIndex argument of the clauses array", ^{
            [heyNonny insertWord:@"nonny" atIndex:1 inClauseAtIndex:0];
            
            NSString *nonnyString = @"Hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
    });

    describe(@"replaceWordAtIndex:inClauseAtIndex:withWord:", ^{
        it(@"should replace the fourth word in the second clause with word argument", ^{
            [heyNonny replaceWordAtIndex:3 inClauseAtIndex:1 withWord:@"woah-woah-woah"];
            
            NSString *nonnyString = @"Hey, nonny and a woah-woah-woah.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should do nothing if the wordsIndex argument is beyond bounds of the sub-array at the clausesIndex in the clauses array", ^{
            [heyNonny replaceWordAtIndex:4 inClauseAtIndex:1 withWord:@"woah-woah-woah"];
            
            NSString *nonnyString = @"Hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should do nothing if the clausesIndex argument is beyond bounds of the clauses array", ^{
            [heyNonny replaceWordAtIndex:3 inClauseAtIndex:2 withWord:@"woah-woah-woah"];
            
            NSString *nonnyString = @"Hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
        
        it(@"should do nothing if the word argument is an empty string or nil", ^{
            [heyNonny replaceWordAtIndex:3 inClauseAtIndex:1 withWord:@""];
            [heyNonny replaceWordAtIndex:3 inClauseAtIndex:1 withWord:nil];
            
            NSString *nonnyString = @"Hey, nonny and a ho-ho-ho.";
            expect(heyNonny.sentence).to.equal(nonnyString);
        });
    });
});

SpecEnd
