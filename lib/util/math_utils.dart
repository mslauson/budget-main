class MathUtils {
  MathUtils._();

  static String getAvailabileBalance(double allocated, double used) {
    double available = allocated - used;
    if (available.isNegative) {
      available = 0;
    }
    return "\$" + available.toStringAsFixed(2);
  }
}
