const receivedParameter = process.argv[2];

if (!receivedParameter) {
  console.error("Other File: No parameter received.");
  process.exit(1);
}
const trimmedDataList = receivedParameter.split(',').map(item => item.trim());

const axios = require("axios");
const interval = "5m";

const fs = require("fs");
var createCsvWriter = require("csv-writer").createObjectCsvWriter;
  

  
  const fetchSingleDataAndAppend = async (symbol) => {
    
    //console.log(symbol);
    const csvpath = `./data/${symbol}.csv`;

    //fetch previous 5 min data
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
      try {
        const response = await axios.get(`https://api.binance.com/api/v3/klines?symbol=${symbol}&interval=${interval}&limit=2`);
        const klines = response.data;
        const records =[];
        const [timestamp, open, high, low, close, volume] = klines[0];
        //console.log(`Time: ${new Date(timestamp).getTime()}, Open: ${open}, Close: ${close}, Volume: ${volume}`);
        records.push({ Time: new Date(timestamp).getTime(), Open: open, Close: close, Volume: volume });
        
    
        // Write new data to the CSV file
        csvWriter.writeRecords(records);
        //console.log('Data appended successfully.');
      } catch (error) {
        console.error('Error fetching or processing data:', error.message);
      }
    };
  
  
  const delay = (milliseconds) => {
    return new Promise(resolve => setTimeout(resolve, milliseconds));
  };
  
  
  const checkAndUpdateData = async (symbol) => {

    const csvpath = `./data/${symbol}.csv`;
      const csvData = fs.readFileSync(csvpath, 'utf-8');
      const lines = csvData.trim().split('\n');
      //var time = lines[1].split('"')[1];
      //console.log(time);
    
      if (lines.length > 1) {
        // Get the timestamp of the first entry
        //const firstEntryTimestamp = new Date(lines[1].split('"')[1]);
        const firstEntryTimestamp = lines[lines.length-1].split(',')[0];
        const currentTime = new Date().getTime();
        //const test = new Date(firstEntryTimestamp*1);
        // console.log(test);
        // console.log(firstEntryTimestamp);
        // console.log(currentTime);
        //console.log(currentTime-firstEntryTimestamp);
    
        // Check if the current time is greater than 5 minutes from the first entry
        if ((currentTime-firstEntryTimestamp) >  (10 * 60 * 1000)) {
          //console.log('Updating data from API...');
          await fetchSingleDataAndAppend(symbol);
        } else {
          //console.log('No need to update data.');
        }
      }
    };
  
  









const main = async () => {
  while (true) {

    for(const symbol of trimmedDataList){
        await checkAndUpdateData(symbol);
    }
    await delay(50000);
  }
};

main();
