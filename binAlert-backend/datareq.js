const fs = require('fs');
const http = require('http');
const csv = require('csv-parser');

const fiveMinPumpFilePath = '5minpump.csv'; // 5-minute pump data file
const pumpHistoryFilePath = 'pump.csv';    // Pump history data file

const clearFiveMinPumpData = () => {
  // Clear the content of 5minpump.csv
  fs.writeFileSync(fiveMinPumpFilePath, '');
  console.log('5-minute pump data cleared.');
};

// Schedule to clear the 5-minute pump data every 5 minutes
setInterval(clearFiveMinPumpData, 5 * 60 * 1000);

const server = http.createServer((req, res) => {
  // Function to handle reading and responding with JSON data
  const handleResponse = (filePath) => {
    // Check if the file exists
    fs.access(filePath, fs.constants.F_OK, (fileAccessErr) => {
      if (fileAccessErr) {
        console.error('File does not exist:', fileAccessErr);
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.end('File not found');
      } else {
        // Read the CSV file and parse it into JSON array
        const jsonArray = [];

        // Read the first line manually before starting the parsing
        const firstLine = fs.readFileSync(filePath, 'utf8').split('\n')[0];
        jsonArray.push(firstLine.split(','));

        fs.createReadStream(filePath)
          .pipe(csv())
          .on('data', (row) => {
            // Push each row as an array to the JSON array
            jsonArray.push(Object.values(row));
          })
          .on('end', () => {
            // Send the JSON data as the response
            res.writeHead(200, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify(jsonArray));
          })
          .on('error', (parseError) => {
            console.error('Error parsing file:', parseError);
            res.writeHead(500, { 'Content-Type': 'text/plain' });
            res.end('Internal Server Error');
          });
      }
    });
  };

  // Routing based on the request URL
  if (req.url === '/5minpump') {
    handleResponse(fiveMinPumpFilePath);
  } else if (req.url === '/history') {
    handleResponse(pumpHistoryFilePath);
  } else {
    // Handle other routes with a 404 response
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Not Found');
  }
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
