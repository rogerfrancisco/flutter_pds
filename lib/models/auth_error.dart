class AuthError {
  final String code;
  late final String message;
  AuthError(this.code) {
    message = errors(code);
  }

  String errors(String code) {
    String message;
    switch (code) {
      case 'wrong-password':
        message = 'Senha incorreta, verifique e tente novamente.';
        break;
      case 'network-request-failed':
        message = 'Verifique sua conexão com a internet.';
        break;
      case 'too-many-requests':
        message =
            'Foi registrado uma grande quantidade de tentativas, aguarde e tente novamente.';
        break;
      case 'user-disabled':
        message = 'Sua conta está inativada ou deletada.';
        break;
      case 'requires-recent-login':
        message = 'Por favor, tente novamente.';
        break;
      case 'email-already-exists':
        message = 'Email já cadastrado.';
        break;
      case 'user-not-found':
        message = 'Usuário não encontrado';
        break;
      case 'phone-number-already-exists':
        message = 'Número já cadastrado';
        break;
      case 'invalid-phone-number':
        message = 'Número inválido';
        break;
      case 'invalid-email':
        message = 'Email inválido';
        break;
      case 'cannot-delete-own-user-account':
        message = 'Você não tem permissão para deletar essa conta.';
        break;
      default:
        message = 'Ops. Algo deu errado, tente novamente.';
        break;
    }
    return message;
  }
}
