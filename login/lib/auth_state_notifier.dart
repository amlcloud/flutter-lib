part of login;

class AuthStateNotifier<V> extends StateNotifier<V> {
  AuthStateNotifier(V d) : super(d);

  set value(V v) {
    state = v;
  }

  V get value => state;
}
