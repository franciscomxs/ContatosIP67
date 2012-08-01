//
//  ListaContatosProtocol.h
//  ContatosIP67
//
//  Created by ios2984 on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@protocol ListaContatosProtocol <NSObject>
-(void) contatoAtualizado:(Contato *) contato;
-(void) contatoAdicionado:(Contato *) contato;
@end
