//
//  FormularioContatoViewConroller.h
//  ContatosIP67
//
//  Created by ios2984 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListaContatosProtocol.h"
#import "Contato.h"

@interface FormularioContatoViewConroller : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>
@property(nonatomic, weak) IBOutlet UITextField *nome;
@property(nonatomic, weak) IBOutlet UITextField *telefone;
@property(nonatomic, weak) IBOutlet UITextField *email;
@property(nonatomic, weak) IBOutlet UITextField *endereco;
@property(nonatomic, weak) IBOutlet UITextField *site;
@property(nonatomic, weak) IBOutlet UITextField *twitter;
@property(strong) NSMutableArray *contatos;
@property(strong) Contato *contato;
-(id)initWithContato:(Contato *)_contato;
@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;
@property (weak) id<ListaContatosProtocol> delegate;
-(IBAction)selecionaFoto:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;
@property (weak) UITextField *campoAtual;
@property CGSize tamanhoInicialDoScroll;
@end
