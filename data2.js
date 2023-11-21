async function fetchData() {
    try {
      const response = await fetch('https://nba-ws.onreader.com/statistics');
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching data:', error);
      return null;
    }
  }
  
  async function generateTableRows() {
    var tableBody = document.getElementById('tableBody');
  
    try {
      const playersData = await fetchData();
  
      if (!playersData) {
        console.error('No data available.');
        return;
      }
  
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
    } catch (error) {
      console.error('Error generating table rows:', error);
    }
  }
  
  generateTableRows();
  