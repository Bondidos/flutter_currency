class FlagStore{
  static const _directoryPath = 'assets/flags/';
  static const _flags = {
    440 : "${_directoryPath}austria.svg",
    510 : "${_directoryPath}armenia.svg",
    441 : "${_directoryPath}bulgaria.svg",
    449 : "${_directoryPath}ukraine.svg",
    450 : "${_directoryPath}denmark.svg",
    431 : "${_directoryPath}united_states.svg",
    451 : "${_directoryPath}europe.svg",
    452 : "${_directoryPath}poland.svg",
    508 : "${_directoryPath}japan.svg",
    461 : "${_directoryPath}iran.svg",
    453 : "${_directoryPath}iceland.svg",
    371 : "${_directoryPath}canada.svg",
    462 : "${_directoryPath}china.svg",
    394 : "${_directoryPath}kuwait.svg",
    454 : "${_directoryPath}moldova.svg",
    448 : "${_directoryPath}new_zealand.svg",
    455 : "${_directoryPath}norway.svg",
    456 : "${_directoryPath}russian_federation.svg",
    421 : "${_directoryPath}singapore.svg",
    458 : "${_directoryPath}kyrgyzstan.svg",
    459 : "${_directoryPath}kazakhstan.svg",
    460 : "${_directoryPath}turkey.svg",
    429 : "${_directoryPath}united_kingdom.svg",
    463 : "${_directoryPath}czech_republic.svg",
    464 : "${_directoryPath}sweden.svg",
    426 : "${_directoryPath}switzerland.svg",
    457 : "${_directoryPath}xdr.svg",
    -1 : "${_directoryPath}belarus.svg",
  };
  static String imagePath(int id) => _flags[id] ?? "";
  static String belarusImagePath() => "${_directoryPath}belarus.svg";
}