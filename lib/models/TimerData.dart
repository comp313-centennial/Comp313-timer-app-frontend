class TimerData {
  final String timerTitle;
  final int timerDuration;

  TimerData({
    this.timerTitle,
    this.timerDuration,
  });

  factory TimerData.fromMap(Map<dynamic, dynamic> data) {
    return TimerData(
      timerTitle: data['timerDescription'],
      timerDuration: data['timerDuration'] as int,
    );
  }

  @override
  String toString() {
    return 'TimerData{timerDescription: $timerTitle, timerDuration: $timerDuration}';
  }
}