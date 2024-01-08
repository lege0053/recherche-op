const express = require('express');
const bodyParser = require('body-parser');
const { exec } = require('child_process');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(cors()); 

app.post('/', (req, res) => {
    const scriptName = req.body.script;
    const data = req.body.data;

    const formattedData = Object.entries(data).map(([key, value]) => `${key}:${value}`).join(',');
  
    exec(`lua54 .\\scripts\\${scriptName}.lua "${formattedData}"`, (error, stdout, stderr) => {
      if (error) {
        res.status(500).json({ error: error.message });
        return;
      }
  
      res.json({ result: stdout });
    });
  });

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
