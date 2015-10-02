# FISSentence

## Objectives

1. Create a custom class with a `readonly` property.
2. Write a private "helper" method that assembles data held in other properties to show publicly in a `readonly` property.
3. Write private "helper" methods to assess the validity of input through public methods.
4. Write public methods that allow controlled access to the private properties while utilizing private validation methods to protect the class from incorrect use.

## Introduction

Putting a together a proper sentence can be difficult at times.

![](https://curriculum-content.s3.amazonaws.com/ios-intro-to-objects-unit/men_in_tights_sentence.gif)

In this lab, we're going to write a custom class to handle the logic of how to assemble the individual components (words and punctuation) of a sentence into a single string. We'll then present that string publicly as a read-only property and provide public methods that offer a controlled interface to the data that is used to form that sentence.

In our implementation, we're going to hold the individual words as separate strings in an array called words, and the punctuation character in a separate string property called `punctuation`.

```objc
NSArray *words = @[ @"King", @"illegal", @"forest", @"to", @"pig", @"kill", @"in", @"it", @"a", @"is" ];
NSString *punctuation = @".";
```

Once we've collected the data held in these variables (which we'll save as properties), we can assemble their contents in a specified way to present to the public:

```
NSString *sentence = @"King illegal forest to pig kill in it a is.";
```
That sounds easy enough!

![](https://curriculum-content.s3.amazonaws.com/ios-intro-to-objects-unit/men_in_tights_deered_a_dare.gif)

Well, maybe not for the Sheriff.

## Instructions

Open the `objc-fissentence.xcworkspace` file.

### I. Set Up the Custom Class Files

Create a custom class called `FISSentence` that inherits from `NSObject`.

#### Properties

In the `FISSentence.h` header file, declare three public properties:

  * a `readonly` property that is an `NSString` called `sentence`,
  * an `NSMutableArray` called `words`, and
  * an `NSString` called `punctuation`.  

In the `FISSentence.m` implementation file, create a private `@interface` section between the `#import` lines and the `@implementation` section with the correct syntax:

```objc
@interface FISSentence ()

@end
```

Within this private `@interface`:

  *  redeclare the `sentence` property as `readwrite`,
 
#### Public Methods

In the `FISSentence.h` header file, declare the following six (6) public methods, none of which provide a return (i.e. are return-type `void`):

  * `addWord:` which takes one argument, an `NSString` called `word`,

  * `addWords:withPunctuation:` which takes two arguments, an `NSArray` called `words` and an `NSString` called punctuation,

  * `removeWordAtIndex:` which takes one argument, an `NSUInteger` called `index`,

  * `insertWord:atIndex:` which takes two arguments, an `NSString` called `word` and an `NSUInteger` called `index`,

  * `replacePunctuationWithPunctuation:`which takes one argument, an `NSString` called `punctuation`, and

  * `replaceWordAtIndex:withWord:` which takes two argument, an `NSUInteger` called `index` and an `NSString` called `word`.

#### Private Methods

Declare a private method called `assembleSentence` with return-type `void`. Leave the implementation empty for now.

Declare the following three (3) private methods that will be used internally to verify the argument values passed into the public methods. All of them should be return-type `BOOL`. Write their implementations to simply `return NO;` for now:

  * `validWord:` which takes one `NSString` argument called `word`,
  * `validPunctuation:` which takes one `NSString` argument called `punctuation`, and
  * `validIndex:` which takes one `NSUInteger` argument called `index`.

#### Define Public Method Implementations

Below the private methods, use autocomplete to define the six (6) public method implementations to do nothing.

At this point, your project should be complete enough to successfully build. Run the tests (`⌘` `U`) now to see that they fail.

### II. Write the First Method Implementations

In the course of writing the implementation for the public method `addWord:`, you'll need to write the implementations for some of the private methods, particularly `assembleSentence`.

1. In `addWord:`, use the `self` keyword to add the `word` arguments to `words` property array (**Hint:** *Use the* `addObject:` *method.*). End the method implementation with a call to `self` of the private `assembleSentence` method.

2. The `assembleSentence` method should read the `words` property array and the `punctuation` property string and assemble their contents into a properly formatted sentence (i.e., spaces between each of the words with the `punctuation` string at the end). Save the assembled string to the `readonly` string property called `sentence`.  
**Hint:** *Use the* `componentsJoinedByString:` *method to concatenate all of the individual "word" strings to the body of the sentence.*

3. Now, add logic to the `addWord:` method that validates that the `word` argument string meets certain expectations: it cannot be `nil`, an empty string (`@""`), or a string with only a space in it (`@" "`). **Make sure that the `assembleSentence` method still gets called every time** (i.e. don't wrap the protections around the call of `assembleSentence`; instead, protect changing the data that `assembleSentence` relies upon). Get all of the tests for this method to pass.

4. Finally, move the validation logic for this check into the private `validWord:` methods. Refactor the `addWord:` method to call this validation method instead of doing the check itself. This will allow other methods to use the same uniform validation logic without having to copy/paste the code. Verify that `addWord:` still passes all of its tests before moving on.

### III. Write the Public Method Implementations

Continue writing the implementations for the other five (5) public methods. **All of the public methods should end with a call of the `assembleSentence` method to update the `sentence` property string with the new information.**

1. The `addWords:withPunctuation:` method should add the strings in the `words` *argument* array to the end of the `words` *property* array, and it should overwrite the string in the `punctuation` *property* with the `punctuation` *argument* string.
	* Add checks that the `words` argument array is neither `nil` nor an `empty` array. If it is, then the method should do nothing.  
**Hint:** *Use a* `return;` *statement to escape the method implementation if either case is true.*

  * Write validation logic that checks that the `punctuation` argument string is one of these seven (7) characters: `.?!,;:—` (period, question mark, exclamation point, comma, semicolon, colon, and long-dash). If the `punctuation` argument is invalid, then this method should do nothing.  
**Hint:** *Use another* `return;` *statement to escape the method implementation if the check fails.*

  * Use the `validWord:` method inside a loop to avoid adding any strings to the `words` property array that are empty string or spaces. At this point, all of the tests for this method should pass.

  * Move the validation logic of the `punctuation` argument string into the `validPunctuation:` method. Refactor the `addWords:withPunctuation:` method to use this method to perform its check. Verify that the tests for `addWord:withPunctuation:` still pass before moving on.

2. The `removeWordAtIndex:` method should remove the string from the `words` property array at the index position specified by the `index` argument.
  * Add in a check the makes sure that the `index` argument is not beyond the bounds of the `words` property array. Verify that all of the tests pass for this method.
  * Move the validation logic of the `index` argument into the `validIndex:` method. Refactor `removeWordAtIndex:` to use `validIndex:` to perform the check. Verify that all of the tests for `removeWordAtIndex:` continue to pass before moving on.

3. The `insertWord:atIndex:` method should insert the submitted `word` string argument into the `words` property array at the position specified bye the `index` argument. Use the private validation methods `validWord:` and `validIndex:` to perform checks on the method arguments. The `insertWord:atIndex:` method should only attempt to change the properties if both arguments pass validation.

4. The `replacePunctuationWithPunctuation:` method should overwrite the string in the `punctuation` property string with the new `punctuation` argument string. This method should only attempt to make the change if the new `punctuation` argument string passes validation.

10. The `replaceWordAtIndex:withWord:` method should overwrite the string in the `words` property array at the position specified by the `index` argument with the new `word` argument string. This method should not attempt to make an overwrite unless the `word` argument passes the `validWord:` check and the `index` argument passes the `validIndex:` argument.

Now give yourself a high five; you deserve it!

![](https://curriculum-content.s3.amazonaws.com/ios-intro-to-objects-unit/men_in_tights_air_five.gif)

## Advanced

Did you notice, that the `words` and `punctuation` properties that we stored the data in were public? Ideally these would be private and not even visible to the public, but since we needed to give them starting values in order to run the tests, we needed to make them public so the test file could set the initial values.

In order to initialize private properties so they can be used internally by method implementations, a special method called an "initializer" can be written to set private properties to default values without giving access to an outside class. In the case of our `words` mutable array, it could be initialized to and empty mutable array so that it's prepared to receive method calls that changes its data.