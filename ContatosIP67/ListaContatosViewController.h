//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios2984 on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ListaContatosProtocol.h"

@interface ListaContatosViewController : UITableViewController<ListaContatosProtocol, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
{
    Contato * contatoSelecionado;
}
@property (weak) NSMutableArray *contatos;
-(void)contatoAtualizado:(Contato *)contato;
-(void)contatoAdicionado:(Contato *)contato;
-(void)exibeMaisAcoes:(UIGestureRecognizer *)gesture;
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;

@property (weak) NSManagedObjectContext *contexto;
@end
