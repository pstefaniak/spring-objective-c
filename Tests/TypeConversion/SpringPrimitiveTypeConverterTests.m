////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2012 Jasper Blues
//  All Rights Reserved.
//
//  NOTICE: Jasper Blues permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import <SenTestingKit/SenTestingKit.h>
#import "SpringPrimitiveTypeConverter.h"
#import "SpringTypeDescriptor.h"
#import "SpringIntrospectiveNSObject.h"
#import "NSObject+SpringIntrospectionUtils.h"

@interface SpringPrimitiveTypeConverterTests : SenTestCase

@property(nonatomic) BOOL boolProperty;
@property(nonatomic) int intProperty;
@property(nonatomic) NSUInteger nsuIntegerProperty;

@end


@implementation SpringPrimitiveTypeConverterTests
{
    SpringPrimitiveTypeConverter* _typeConverter;
}

- (void)setUp
{
    _typeConverter = [[SpringPrimitiveTypeConverter alloc] init];
}

- (void)test_convertToBool
{
    SpringTypeDescriptor* typeDescriptor = [self typeForPropertyWithName:@"boolProperty"];

    BOOL converted = (BOOL) [_typeConverter convert:@"true" requiredType:typeDescriptor];
    assertThatBool(converted, equalToBool(YES));

    converted = (BOOL) [_typeConverter convert:@"yes" requiredType:typeDescriptor];
    assertThatBool(converted, equalToBool(YES));

    converted = (BOOL) [_typeConverter convert:@"1" requiredType:typeDescriptor];
    assertThatBool(converted, equalToBool(YES));

    converted = (BOOL) [_typeConverter convert:@"no" requiredType:typeDescriptor];
    assertThatBool(converted, equalToBool(NO));

    converted = (BOOL) [_typeConverter convert:@"false" requiredType:typeDescriptor];
    assertThatBool(converted, equalToBool(NO));

    converted = (BOOL) [_typeConverter convert:@"0" requiredType:typeDescriptor];
    assertThatBool(converted, equalToBool(NO));
}

- (void)test_convertToInt
{
    SpringTypeDescriptor* typeDescriptor = [self typeForPropertyWithName:@"intProperty"];

    int converted = (int) [_typeConverter convert:@"123" requiredType:typeDescriptor];
    assertThatInt(converted, equalToInt(123));

    converted = (int) [_typeConverter convert:@"zzz" requiredType:typeDescriptor];
    assertThatInt(converted, equalToInt(0));
}

- (void)test_convertToNSUInteger
{
    SpringTypeDescriptor* typeDescriptor = [self typeForPropertyWithName:@"nsuIntegerProperty"];

    NSUInteger converted = (NSUInteger) [_typeConverter convert:@"123" requiredType:typeDescriptor];
    assertThatUnsignedLongLong(converted, equalToUnsignedLongLong(123));

    converted = (int) [_typeConverter convert:@"zzz" requiredType:typeDescriptor];
    assertThatUnsignedLongLong(converted, equalToUnsignedLongLong(0));
}

@end