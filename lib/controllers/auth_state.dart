// Compatibility auth state for existing UI components
class AuthState {
  final bool isLoading;
  final bool isAuthenticated; 
  final bool hasError;
  final String? errorMessage;
  final dynamic user;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.hasError = false,
    this.errorMessage,
    this.user,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    bool? hasError,
    String? errorMessage,
    dynamic user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
