const fs = require('fs');
const http = require('http');
const csv = require('csv-parser');

const csvFilePath = 'pump.csv'; // Replace with the path to your CSV file

const server = http.createServer((req, res) => {
  // Check if the file exists
  fs.access(csvFilePath, fs.constants.F_OK, (fileAccessErr) => {
    if (fileAccessErr) {
      console.error('CSV file does not exist:', fileAccessErr);
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end('CSV file not found');
    } else {
      // Read the CSV file and parse it into JSON array
      const jsonArray = [];

      // Read the first line manually before starting the parsing
      const firstLine = fs.readFileSync(csvFilePath, 'utf8').split('\n')[0];
      jsonArray.push(firstLine.split(','));

      fs.createReadStream(csvFilePath)
        .pipe(csv())
        .on('data', (row) => {
          // Push each row as an array to the JSON array
          jsonArray.push(Object.values(row));
        })
        .on('end', () => {
          // Delete the CSV file after serving its content
          fs.unlink(csvFilePath, (unlinkErr) => {
            if (unlinkErr) {
              console.error('Error deleting CSV file:', unlinkErr);
            } else {
              console.log('CSV file deleted.');
            }
          });

          // Send the JSON data as the response
          res.writeHead(200, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify(jsonArray));
        })
        .on('error', (parseError) => {
          console.error('Error parsing CSV file:', parseError);
          res.writeHead(500, { 'Content-Type': 'text/plain' });
          res.end('Internal Server Error');
        });
    }
  });
});

const PORT = 3000; // Replace with your desired port
server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
