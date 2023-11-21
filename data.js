var playersData = [
    {
      "joueur": "LeBron James",
      "equipe": "Los Angeles Lakers",
      "m": 20,
      "mj": 30,
      "ppm": 25,
      "rpm": 10,
      "pdpm": 5,
      "mpm": 28,
      "eff": 30,
      "fg": "55%",
      "3p": "40%",
      "lf": "85%"
    },
    {
      "joueur": "Stephen Curry",
      "equipe": "Golden State Warriors",
      "m": 18,
      "mj": 32,
      "ppm": 22,
      "rpm": 12,
      "pdpm": 6,
      "mpm": 25,
      "eff": 28,
      "fg": "50%",
      "3p": "38%",
      "lf": "90%"
    }
  ];


  function generateTableRows() {
    var tableBody = document.getElementById('tableBody');

    playersData.forEach(function(player) {
      var row = '<tr>';
      row += '<td>' + player.joueur + '</td>';
      row += '<td>' + player.equipe + '</td>';
      row += '<td>' + player.m + '</td>';
      row += '<td>' + player.mj + '</td>';
      row += '<td>' + player.ppm + '</td>';
      row += '<td>' + player.rpm + '</td>';
      row += '<td>' + player.pdpm + '</td>';
      row += '<td>' + player.mpm + '</td>';
      row += '<td>' + player.eff + '</td>';
      row += '<td>' + player.fg + '</td>';
      row += '<td>' + player["3p"] + '</td>';
      row += '<td>' + player.lf + '</td>';
      row += '</tr>';
      tableBody.innerHTML += row;
    });
  }


  generateTableRows();