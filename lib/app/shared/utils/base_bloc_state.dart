enum BaseStateStatus { initial, loading, error, success }

class BaseBlocState {
  BaseStateStatus status;
  String callbackMessage;

  BaseBlocState({required this.status, this.callbackMessage = ''});

  T when<T>({
    required T Function(BaseBlocState state) onState,
    T Function(BaseBlocState error)? onError,
    T Function()? onLoading,
  }) {
    switch (status) {
      case BaseStateStatus.loading:
        return onLoading!();
      case BaseStateStatus.error:
        return onError != null ? onError(this) : onState(this);
      default:
        return onState(this);
    }
  }

  BaseBlocState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
  }) {
    return BaseBlocState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
    );
  }
}
