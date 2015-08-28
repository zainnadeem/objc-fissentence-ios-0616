//  FISSentence.m

#import "FISSentence.h"

@interface FISSentence ()

@property (strong, nonatomic) NSMutableArray *clauses;
@property (strong, nonatomic) NSMutableArray *punctuations;
@property (strong, nonatomic, readwrite) NSString *sentence;

@end

@implementation FISSentence

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _clauses = [[NSMutableArray alloc]init];
        _punctuations = [[NSMutableArray alloc] init];
        _sentence = @"";
    }
    
    return self;
}

- (void)assembleSentence {
    NSMutableString *sentence = [[NSMutableString alloc] initWithString:@""];
    
    for (NSUInteger i = 0; i < self.clauses.count; i++) {
        NSMutableArray *currentClause = [self.clauses[i] mutableCopy];
        if (i == 0) {
            NSString *firstWord = currentClause[0];
            currentClause[0] = firstWord.capitalizedString;
        }
        NSMutableString *phrase = [[currentClause componentsJoinedByString:@" "] mutableCopy];
        [phrase appendString:self.punctuations[i]];
        if (i > 0) {
            [phrase insertString:@" " atIndex:0];
        }
        [sentence appendString:phrase];
    }
    self.sentence = sentence;
}

- (BOOL)validClause:(NSArray *)clause {
    if (clause == nil) {
        return NO;
    }
    if (clause.count == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)validPunctuation:(NSString *)punctuation {
    if (punctuation == nil) {
        return NO;
    }
    NSString *validPunctuation = @".?!,;:—";
    if (![validPunctuation containsString:punctuation]) {
        return NO;
    }
    return YES;
}

- (BOOL)validClausesIndex:(NSUInteger)clausesIndex {
    if (clausesIndex >= self.clauses.count) {
        return NO;
    }
    if (clausesIndex >= self.punctuations.count) {
        return NO;
    }
    return YES;
}

- (BOOL)validWordsIndex:(NSUInteger)wordsIndex inClauseAtIndex:(NSUInteger)clausesIndex {
    BOOL validClausesIndex = [self validClausesIndex:clausesIndex];
    if (!validClausesIndex) {
        return NO;
    }
    
    NSArray *clause = self.clauses[clausesIndex];
    if (wordsIndex >= clause.count) {
        return NO;
    }
    return YES;
}

- (BOOL)validWord:(NSString *)word {
    if (word == nil) {
        return NO;
    }
    if ([word isEqualToString:@" "]) {
        return NO;
    }
    if (word.length == 0) {
        return NO;
    }
    return YES;
}

- (void)addClause:(NSArray *)clause withPunctuation:(NSString *)punctuation {
    BOOL validClause = [self validClause:clause];
    BOOL validPunctuation = [self validPunctuation:punctuation];
    
    if (validClause && validPunctuation) {
        [self.clauses addObject:[clause mutableCopy]];
        [self.punctuations addObject:punctuation];
    }
    
    [self assembleSentence];
}

- (void)removeClauseAtIndex:(NSUInteger)clausesIndex {
    BOOL validClausesIndex = [self validClausesIndex:clausesIndex];
    
    if (validClausesIndex) {
        [self.clauses removeObjectAtIndex:clausesIndex];
        [self.punctuations removeObjectAtIndex:clausesIndex];
    }
    
    [self assembleSentence];
}

- (void)insertClause:(NSArray *)clause
     withPunctuation:(NSString *)punctuation
      atClausesIndex:(NSUInteger)clausesIndex {
    BOOL validClause = [self validClause:clause];
    BOOL validPunctuation = [self validPunctuation:punctuation];
    BOOL validIndex = [self validClausesIndex:clausesIndex];
    
    
    if (validClause && validPunctuation && validIndex) {
        [self.clauses insertObject:[clause mutableCopy] atIndex:clausesIndex];
        [self.punctuations insertObject:punctuation atIndex:clausesIndex];
    }
    
    [self assembleSentence];
}

- (void)replacePunctuationForClauseAtIndex:(NSUInteger)clausesIndex
                           withPunctuation:(NSString *)punctuation {
    BOOL validClausesIndex = [self validClausesIndex:clausesIndex];
    BOOL validPunctuation = [self validPunctuation:punctuation];
    
    if (validClausesIndex && validPunctuation) {
        self.punctuations[clausesIndex] = punctuation;
    }
    
    [self assembleSentence];
}

- (void)addWord:(NSString *)word toClauseAtIndex:(NSUInteger)clausesIndex {
    BOOL validWord = [self validWord:word];
    BOOL validClausesIndex = [self validClausesIndex:clausesIndex];
    
    if (validWord && validClausesIndex) {
        [self.clauses[clausesIndex] addObject:word];
    }
    
    [self assembleSentence];
}

- (void)removeWordAtIndex:(NSUInteger)wordsIndex
        fromClauseAtIndex:(NSUInteger)clausesIndex {
    BOOL validClausesIndex = [self validClausesIndex:clausesIndex];
    BOOL validWordsIndex = [self validWordsIndex:wordsIndex inClauseAtIndex:clausesIndex];
    
    if (validClausesIndex && validWordsIndex) {
        [self.clauses[clausesIndex] removeObjectAtIndex:wordsIndex];
    }
    
    [self assembleSentence];
}

- (void)insertWord:(NSString *)word
           atIndex:(NSUInteger)wordsIndex
   inClauseAtIndex:(NSUInteger)clausesIndex {
    BOOL validWord = [self validWord:word];
    BOOL validClausesIndex = [self validClausesIndex:clausesIndex];
    BOOL validWordsIndex = [self validWordsIndex:wordsIndex inClauseAtIndex:clausesIndex];
    
    if (validWord && validClausesIndex && validWordsIndex) {
        [self.clauses[clausesIndex] insertObject:word atIndex:wordsIndex];
    }
    
    [self assembleSentence];
}

- (void)replaceWordAtIndex:(NSUInteger)wordsIndex
           inClauseAtIndex:(NSUInteger)clausesIndex
                  withWord:(NSString *)word {
    BOOL validClausesIndex = [self validClausesIndex:clausesIndex];
    BOOL validWordsIndex = [self validWordsIndex:wordsIndex inClauseAtIndex:clausesIndex];
    BOOL validWord = [self validWord:word];
    
    if (validClausesIndex && validWordsIndex && validWord) {
        [self.clauses[clausesIndex] replaceObjectAtIndex:wordsIndex withObject:word];
    }
    
    [self assembleSentence];
}

@end
