//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios2984 on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListaContatosProtocol.h"

@interface ListaContatosViewController : UITableViewController<ListaContatosProtocol>
@property (weak) NSMutableArray *contatos;
-(void)contatoAtualizado:(Contato *)contato;
-(void)contatoAdicionado:(Contato *)contato;
@end
