//  FISSentence.h

#import <Foundation/Foundation.h>

@interface FISSentence : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *clauses;
@property (strong, nonatomic, readonly) NSMutableArray *punctuations;
@property (strong, nonatomic, readonly) NSString *sentence;

- (void)addClause:(NSArray *)clause withPunctuation:(NSString *)punctuation;

- (void)removeClauseAtIndex:(NSUInteger)index;

- (void)insertClause:(NSArray *)clause
     withPunctuation:(NSString *)punctuation
             atIndex:(NSUInteger)index;

- (void)replacePunctuationForClauseAtIndex:(NSUInteger)index
                             toPunctuation:(NSString *)punctuation;

- (void)addWord:(NSString *)word toClauseAtIndex:(NSUInteger)index;

- (void)removeWordFromClauseAtIndex:(NSUInteger)index
                      atClauseIndex:(NSUInteger)clauseIndex;

- (void)insertWord:(NSString *)word
   inClauseAtIndex:(NSUInteger)index
     atClauseIndex:(NSUInteger)clauseIndex;

@end
