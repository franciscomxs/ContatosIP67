//
//  FormularioContatoViewConroller.h
//  ContatosIP67
//
//  Created by ios2984 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"

@interface FormularioContatoViewConroller : UIViewController
@property(nonatomic, weak) IBOutlet UITextField *nome;
@property(nonatomic, weak) IBOutlet UITextField *telefone;
@property(nonatomic, weak) IBOutlet UITextField *email;
@property(nonatomic, weak) IBOutlet UITextField *endereco;
@property(nonatomic, weak) IBOutlet UITextField *site;
@property(strong) NSMutableArray *contatos;
@end
