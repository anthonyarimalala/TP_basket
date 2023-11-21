async function fetchDataFromWebService(url) {
  try {
    const response = await fetch(url);

    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching data:', error.message);
    return null;
  }
}

const apiUrl = 'https://nba-ws.onrender.com/statistics'; // Remplacez par votre URL API
const tableBody = document.getElementById('tableBody');

fetchDataFromWebService(apiUrl)
  .then(data => {
    if (data && data.length > 0) {
      // Boucle à travers les données et les ajoute au tableau HTML
      data.forEach(player => {
        const row = document.createElement('tr');
        row.innerHTML = `
          <td>${player.joueur}</td>
          <td>${player.equipe}</td>
          <td>${player.mj}</td>
          <td>${player.ppm}</td>
          <td>${player.rpm}</td>
          <td>${player.pdpm}</td>
          <td>${player.fg.toFixed(1)}%</td>
          <td>${player.three_p.toFixed(1)}%</td>
          <td>${player.lf.toFixed(1)}%</td>
        `;
        tableBody.appendChild(row);
      });
    } else {
      const row = document.createElement('tr');
      row.innerHTML = '<td colspan="12">Erreur lors de la récupération des données.</td>';
      tableBody.appendChild(row);
    }
  })
  .catch(error => {
    console.error('Error:', error);
    const row = document.createElement('tr');
    row.innerHTML = '<td colspan="12">Erreur lors de la récupération des données.</td>';
    tableBody.appendChild(row);
  });