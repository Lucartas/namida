typedef VideoHeatMap = List<YoutiPieVideoHeatMap>;

class YoutiPieVideoHeatMap {
  final int startMS;
  final int durationMS;
  final double intensity;

  const YoutiPieVideoHeatMap({this.startMS = 0, this.durationMS = 0, this.intensity = 0});
}
