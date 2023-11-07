//
//  JWCHander.m
//  TreeWalletProject
//
//  Created by Gavery on 2023/9/23.
//

#import "JWCHander.h"
#include <string>

@implementation JWCHander
+ (JWCHander *)sharedManager
{
    static JWCHander *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JWCHander alloc] init];
    });
    return manager;
}
- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

/**
 privateKey  Your wallet's private key
 */

-(void)sigWithmessage:(NSString *)message privateKey:(NSString *)privateKey result:(void (^)(NSString * _Nonnull))result{
    const char * pridata = [privateKey UTF8String];
    void * pkey = ImportFromHexStr(pridata);
    const char * messagedata = [message UTF8String];
    char * signature =  sig_tx((long long)pkey, messagedata, (int)message.length);
    NSString *signatureString = [NSString stringWithCString:signature encoding:NSUTF8StringEncoding];
    free(signature);
    result(signatureString);
}



-(void)setProfileResult:(void (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))result{
    unsigned char *buf=nullptr;
    int bufsize = 0;
    BOOL code =  ExportEVP_PKEY(&buf,&bufsize);
    if(code == NO){
        free(buf);
        return;
    }
    NSLog(@"----------------------------------------");

    void * pkey = ImportEVP_PKEY(buf,bufsize);
    free(buf);
    NSLog(@"----------------------------------------");
    if(pkey == nullptr){
        return;
    }
    char *prihex=nullptr;
    int prihexsize = 0;
    BOOL ceode1 = ExportToHexStr(pkey,&prihex,&prihexsize);
    if(ceode1 == NO){
        free(prihex);
        return;
    }
    NSData *data = [NSData dataWithBytes:prihex length:prihexsize];
    NSString * pridataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    free(prihex);
    NSLog(@"----------------------------------------");
    
    char *Mnemonic=nullptr;
    int Mnemonicsize = 0;
    BOOL ceode2 = ExportMnemonic(pkey,&Mnemonic,&Mnemonicsize);
    if(ceode2 == NO){
        free(Mnemonic);
        return;
    }
    NSData *Mnemonicdata = [NSData dataWithBytes:Mnemonic length:Mnemonicsize];
    NSString * MnemonicString  = [[NSString alloc] initWithData:Mnemonicdata encoding:NSUTF8StringEncoding];
    free(Mnemonic);
    NSLog(@"----------------------------------------");


    char *base58=nullptr;
    int base58size = 0;
    getBase58addr_c(pkey,&base58,&base58size);
    NSData *base58data = [NSData dataWithBytes:base58 length:base58size];
    NSString * base58string =[[NSString alloc] initWithData:base58data encoding:NSUTF8StringEncoding];
    free(base58);
    NSLog(@"----------------------------------------");
    result(pridataString,@"",MnemonicString,base58string);

}

-(void)importMnemonic:(NSString *)MnemonicString result:(void (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))result{
    const char * mnemonic = [MnemonicString UTF8String];
    void * pkey = ImportFromMnemonic(mnemonic);
    if(pkey == nullptr){
        return;
    }
    char *prihex=nullptr;
    int prihexsize = 0;
    BOOL ceode1 = ExportToHexStr(pkey,&prihex,&prihexsize);
    if(ceode1 == NO){
        free(prihex);
        return;
    }
    NSData *data = [NSData dataWithBytes:prihex length:prihexsize];
    NSString * pridataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    free(prihex);
    NSLog(@"----------------------------------------");
    
    char *base58=nullptr;
    int base58size = 0;
    getBase58addr_c(pkey,&base58,&base58size);
    NSData *base58data = [NSData dataWithBytes:base58 length:base58size];
    NSString * base58string =[[NSString alloc] initWithData:base58data encoding:NSUTF8StringEncoding];
    free(base58);
    NSLog(@"----------------------------------------");
    result(pridataString,@"",base58string);
}


-(void)importpridata:(NSString *)pridataString result:(void (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))result{
    const char * pridata = [pridataString UTF8String];
    void * pkey = ImportFromHexStr(pridata);
    if(pkey == nullptr){
        return;
    }
    char *Mnemonic=nullptr;
    int Mnemonicsize = 0;
    BOOL ceode2 = ExportMnemonic(pkey,&Mnemonic,&Mnemonicsize);
    if(ceode2 == NO){
        free(Mnemonic);
        return;
    }
    NSData *Mnemonicdata = [NSData dataWithBytes:Mnemonic length:Mnemonicsize];
    NSString * MnemonicString  = [[NSString alloc] initWithData:Mnemonicdata encoding:NSUTF8StringEncoding];
    free(Mnemonic);
    NSLog(@"----------------------------------------");


    char *base58=nullptr;
    int base58size = 0;
    getBase58addr_c(pkey,&base58,&base58size);
    NSData *base58data = [NSData dataWithBytes:base58 length:base58size];
    NSString * base58string =[[NSString alloc] initWithData:base58data encoding:NSUTF8StringEncoding];
    free(base58);
    NSLog(@"----------------------------------------");
    result(@"",base58string,MnemonicString);
   
}

@end

