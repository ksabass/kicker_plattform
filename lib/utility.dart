List<String> location = ["Location1", "Location2", "Location3"];

class Profile {
  //TODO add location check with ENUM

  final String name;
  final String location;
  Profile(this.name, this.location);
}

class Match {
  final Profile offenseTeamRed;
  final Profile defenseTeamRed;
  final Profile offenseTeamBlue;
  final Profile defenseTeamBlue;
  final List<int> result;

  Match(this.offenseTeamBlue, this.offenseTeamRed, this.defenseTeamBlue,
      this.defenseTeamRed, this.result);
}

class MeetUp {
  final String location = '';
  final List<Profile> players = [];

  int mode = 0;
  List<Match> _matches = [];

  int winner = 0;

  void addMatch(match) {
    _matches.add(match);
  }

  void deleteMatch(index) {
    _matches.removeAt(index);
  }

  List<Match> showMatches() {
    return _matches;
  }
}
