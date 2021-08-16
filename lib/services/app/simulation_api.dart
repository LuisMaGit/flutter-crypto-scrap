class SimulationApi {
  Future<bool> simulateApi([int seconds = 1, bool error = false]) async {
    await Future.delayed(Duration(seconds: seconds));
    return !error;
  }
}
