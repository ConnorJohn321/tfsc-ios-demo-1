//
//  JWCHander.h
//  TreeWalletProject
//
//  Created by Gavery on 2023/9/23.
//

#import <Foundation/Foundation.h>
#import "sig.h"
#import "interface.h"
NS_ASSUME_NONNULL_BEGIN

@interface JWCHander : NSObject
+ (JWCHander *)sharedManager;
-(void)setProfileResult:(void(^)(NSString * out_private_key , NSString * out_public_key , NSString * mnemonic , NSString * walletAddress))result;
-(void)importMnemonic:(NSString *)MnemonicString result:(void(^)(NSString * out_private_key , NSString * out_public_key , NSString * walletAddress))result;
-(void)importpridata:(NSString *)pridataString result:(void(^)( NSString * out_public_key , NSString * walletAddress,  NSString * mnemonic))result;

-(void)sigWithmessage:(NSString *)message privateKey:(NSString *)privateKey result:(void(^)(NSString * signature))result;

@end

NS_ASSUME_NONNULL_END
