function createJSON() {
  var url = 'https://anime-sama.fr/planning/';
  var response = UrlFetchApp.fetch(url);
  var content = response.getContentText();
  var data = [];

  var regex = /<h2 class="titreJours[^>]*>(.*?)<\/h2>\n<div class="categorieHome[^>]*>(.*?)<\/body>/gs;
  var match;

  while (match = regex.exec(content)) {
    var day = match[1].trim();
    var planningContent = match[2];

    var items = [];

    var animeRegex = /cartePlanningAnime\("(.*?)", "(.*?)", "(.*?)", "(.*?)", "(.*?)", "(.*?)"\);/g;
    var scanRegex = /cartePlanningScan\("(.*?)", "(.*?)", "(.*?)", "(.*?)", "(.*?)", "(.*?)"\);/g;

    var animeMatch, scanMatch;

    while (animeMatch = animeRegex.exec(planningContent)) {
      var nom = animeMatch[1];
      var url = animeMatch[2];
      var heure = animeMatch[4];
      var probleme = animeMatch[5];
      var langue = animeMatch[6];

      var item = {
        nom: nom,
        url: url,
        heure: heure,
        probleme: probleme,
        langue: langue
      };

      items.push(item);
    }

    while (scanMatch = scanRegex.exec(planningContent)) {
      var nom = scanMatch[1];
      var url = scanMatch[2];
      var heure = scanMatch[4];
      var probleme = scanMatch[5];
      var langue = scanMatch[6];

      var item = {
        nom: nom,
        url: url,
        heure: heure,
        probleme: probleme,
        langue: langue
      };

      items.push(item);
    }

    data.push({ day: day, items: items });
  }

  var jsonContent = JSON.stringify(data, null, 2);
  var encodedContent = Utilities.base64Encode(jsonContent);

  var repo = 'github repo example Dartsgame974/animesame-rss';
  var branch = 'main';
  var fileName = '';
  var commitMessage = 'Mise à jour du fichier flux.json';

  var url = 'https://api.github.com/repos/' + repo + '/contents/' + fileName;
  var options = {
    method: 'GET',
    headers: {
      Authorization: 'github token'
    },
    muteHttpExceptions: true
  };

  var response = UrlFetchApp.fetch(url, options);
  var result = JSON.parse(response.getContentText());

  var sha = result.sha;

  var payload = {
    message: commitMessage,
    content: encodedContent,
    sha: sha,
    branch: branch
  };

  options.method = 'PUT';
  options.headers['Content-Type'] = 'application/json';
  options.payload = JSON.stringify(payload);

  UrlFetchApp.fetch(url, options);
}

function doGet() {
  createJSON(); // Exécutez la fonction createJSON() lorsque doGet() est appelée
  var output = ContentService.createTextOutput("Le code a été exécuté avec succès !");
  return output;
}
