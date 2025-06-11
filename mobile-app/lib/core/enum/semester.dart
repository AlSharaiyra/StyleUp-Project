enum Semester {
  winter,
  spring,
  summer,
  autumn,
}
String getSemesterName(Semester semester) {
  switch (semester) {
    case Semester.winter:
      return 'Winter';
    case Semester.spring:
      return 'Spring';
    case Semester.summer:
      return 'Summer';
    case Semester.autumn:
      return 'Autumn';
  }
}