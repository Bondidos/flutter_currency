class Rate{
  final int curId;
  final String curAbbr;
  final int curScale;
  final String curName;
  final double? actualCurRate;
  final double? alternativeCurRate;

  const Rate({
    required this.curId,
    required this.curAbbr,
    required this.curScale,
    required this.curName,
    required this.actualCurRate,
    required this.alternativeCurRate ,
  });
}