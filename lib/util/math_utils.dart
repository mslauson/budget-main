class MathUtils {
  MathUtils._();

  static String getAvailabileBalance(double allocated, double used) {
    double available = allocated - used;
    return "\$" + available.toString();
  }
}
