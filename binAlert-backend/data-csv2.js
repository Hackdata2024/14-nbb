const { spawn } = require('child_process');
const receivedParameter = process.argv[2];

if (!receivedParameter) {
  console.error("Other File: No parameter received.");
  process.exit(1);
}

const symbol = receivedParameter;

const axios = require('axios');
const interval = '5m';
const csvpath = `./data/${symbol}.csv`;
const startDate = new Date();
const fs = require('fs');
var createCsvWriter = require('csv-writer').createObjectCsvWriter;
var csvWriter = createCsvWriter({
  path: csvpath,
  header: [
    { id: 'Time', title: 'Time' },
    { id: 'Open', title: 'Open' },
    { id: 'Close', title: 'Close' },
    { id: 'Volume', title: 'Volume' }
  ],
  //append: true
});

//var data = [];

const deleteLastRecordFromCSV = () => {
  try {
    // Read the entire content of the CSV file
    const lines = fs.readFileSync(csvpath, 'utf-8').split('\n');

    // Remove the last line (record)
    lines.pop();

    // Join the lines back into a string
    const updatedCSVData = lines.join('\n');

    // Write the updated content back to the file
    fs.writeFileSync(csvpath, updatedCSVData);

    console.log('Last record deleted successfully.');
  } catch (error) {
    console.error('Error deleting last record:', error.message);
  }
};

const fetchKlinesForDay = async (symbol, interval, startTime, endTime) => {
  const apiUrl = `https://api.binance.com/api/v3/klines?symbol=${symbol}&interval=${interval}&startTime=${startTime}&endTime=${endTime}`;
  try {
    const response = await axios.get(apiUrl);
    return response.data;
  } catch (error) {
    console.error('Error fetching data from Binance API:', error.message);
    return [];
  }
};

const processKlines = (klines) => {
  
  const records = [];


  for (let i = 0; i <klines.length ; i++) {
    const [timestamp, open, high, low, close, volume] = klines[i];
    //console.log(`Time: ${new Date(timestamp).getTime()}, Open: ${open}, Close: ${close}, Volume: ${volume}`);
    records.push({ Time: new Date(timestamp).getTime(), Open: open, Close: close, Volume: volume });
  }
  csvWriter.writeRecords(records);
};

const fetchDataForDays = async () => {
  const numberOfDays = 17;
  for (let j = 0; j < numberOfDays; j++) {
    const currentDate = new Date(startDate);
    currentDate.setDate(startDate.getDate() - 16 + j);
    const startTime = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate(), 0, 0, 0, 0).getTime();
    const endTime = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate(), 23, 59, 59, 999).getTime();

    const klines = await fetchKlinesForDay(symbol, interval, startTime, endTime);
    processKlines(klines);
    csvWriter = createCsvWriter({
      path: csvpath,
      header: [
        { id: 'Time', title: 'Time' },
        { id: 'Open', title: 'Open' },
        { id: 'Close', title: 'Close' },
        { id: 'Volume', title: 'Volume' }
      ],
      append: true
    });
  }

  deleteLastRecordFromCSV();
  deleteLastRecordFromCSV();
};

const main = async() => {
  
// Start fetching data for each day AND STORE
await fetchDataForDays();

}

main();