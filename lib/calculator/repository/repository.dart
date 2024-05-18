abstract class Repository<T, P> {
  Future<List<T>> fetchData(P params);
}