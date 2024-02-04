const axios = require('axios');
const symbol = 'BTCUSDT';
const interval = '5m';
const startDate = new Date('2023-01-01T00:00:00Z');
const createCsvWriter = require('csv-writer').createObjectCsvWriter;
//var data = [];
const csvWriter = createCsvWriter({
  path: 'output.csv',
  header: [
    { id: 'Time', title: 'Time' },
    { id: 'Open', title: 'Open' },
    { id: 'Close', title: 'Close' },
    { id: 'Volume', title: 'Volume' }
  ]
});

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

  for (let i = 0; i < klines.length; i++) {
    const [timestamp, open, high, low, close, volume] = klines[i];
    console.log(`Time: ${new Date(timestamp).toLocaleString()}, Open: ${open}, Close: ${close}, Volume: ${volume}`);
    records.push({ Time: new Date(timestamp).toLocaleString(), Open: open, Close: close, Volume: volume });
  }
  csvWriter.writeRecords(records);
};

const fetchDataForDays = async () => {
  const numberOfDays = 365;

  

  for (let j = 0; j < numberOfDays; j++) {
    const currentDate = new Date(startDate);
    currentDate.setDate(startDate.getDate() + j);
    const startTime = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate(), 0, 0, 0, 0).getTime();
    const endTime = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate(), 23, 59, 59, 999).getTime();

    const klines = await fetchKlinesForDay(symbol, interval, startTime, endTime);
    processKlines(klines);
  }
};

// Start fetching data for each day
fetchDataForDays();
