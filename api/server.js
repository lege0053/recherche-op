const express = require('express');
const bodyParser = require('body-parser');
const { exec } = require('child_process');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(cors()); 

app.post('/parcours_largeur', (req, res) => {
    const scriptName = req.body.script;
    const data = req.body.data;
  
    const scriptPath = `.\\scripts\\${scriptName}.lua`;
  
    exec(`lua54 .\\scripts\\parcours_largeur.lua`, (error, stdout, stderr) => {
      if (error) {
        res.status(500).json({ error: error.message });
        return;
      }
  
      res.json({ result: stdout });
    });
  });

  app.get('/parcours_largeur', (req, res) => {
    res.statut(200).send('GET request to /parcours_largeur');
  });

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
