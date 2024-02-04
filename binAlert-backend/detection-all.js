const receivedParameter = process.argv[2];

if (!receivedParameter) {
  console.error("Other File: No parameter received.");
  process.exit(1);
}
const trimmedDataList = receivedParameter.split(',').map(item => item.trim());

//const symbol = receivedParameter;

const axios = require("axios");
const fs = require("fs");

//const symbol = 'DEGOUSDT';
const interval = "5m"; // Set to '1m' for a 1-minute interval

const averageVolumeMap = new Map();
const averageChangeMap = new Map();



const csvFilePath =(symbol) =>{return `./data/${symbol}.csv`;}

const appendPumpToCsv = (filePath, line) => {
  const timestamp = Date.now();
  const dataline = `${timestamp},${line}\n`;
  // console.log("tag");
  // console.log(dataline);

  fs.appendFileSync(filePath, dataline, 'utf8');
  fs.appendFileSync('5minpump.csv', dataline, 'utf8');

  // fs.appendFileSync(filePath, `${line}\n`, 'utf8');
};
const calculateAverageVolume = async(symbol) => {
  try {
    // Read the last 4,320 lines from the CSV file
    const csvData = fs.readFileSync(csvFilePath(symbol), "utf-8");
    const lines = csvData.trim().split("\n");
    const last1000Lines = lines.slice(-4320);

    // Calculate the average volume
    let totalVolume = 0;
    let i=0;
    let numberOfChange =0;
    let totalChange = 0;
    last1000Lines.forEach((line) => {
      const [time, open, close, volume] = line.split(",");
      //console.log(volume);
      totalVolume += parseFloat(volume);
      
      if(i>3520){
        if(open>close){
          totalChange = totalChange + (((open-close)/open)*100);
        }else{
          totalChange = totalChange + (((close-open)/open)*100);
        }
        numberOfChange++;
      }
      i++;
    });

    const averageChange = totalChange / numberOfChange;
    const averageVolume = totalVolume / last1000Lines.length;

    //console.log(`Last 1000 lines average volume: ${averageVolume.toFixed(2)}`);
    averageVolumeMap.set(symbol,averageVolume);
    averageChangeMap.set(symbol,averageChange);
  } catch (error) {
    console.error("Error reading or processing data:", error.message);
  }
};

// Example usage

const delay = (milliseconds) => {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
};

const detect = async (symbol) => { 
    try {
      // Fetch the last 1000 1-minute interval data from the Binance API
        const response = await axios.get(
        `https://api.binance.com/api/v3/klines?symbol=${symbol}&interval=${interval}&limit=1`
      );
      const klines = response.data;
      const entry = klines[0];
      const volume = parseFloat(entry[5]); // Assuming 'Volume' is the 6th element in the kline data
      const high = parseFloat(entry[2]);
      const low = parseFloat(entry[3]);
      const open = parseFloat(entry[1]);
      const close = parseFloat(entry[4]);
      const hike = ((high-low)/open)*100;
      const positive = close-open;
      //console.log(`${symbol}::: Average is ${averageVolumeMap.get(symbol)} and Hike is ${hike}`);
      if(averageChangeMap.get(symbol) || true){console.log(`${symbol} average change ${averageChangeMap.get(symbol)} snd average Vol ${averageVolumeMap.get(symbol)}`);}
      if ((volume > (averageVolumeMap.get(symbol)*1)) && (hike > 0.5) && (positive > 0 || true)) {  ////////////////////////FIX THE CONDITIONS SOON
        console.log(`${symbol} is Pumping! with hike of ${hike}`);
        appendPumpToCsv('pump.csv', symbol);
      } else {
        //console.log(`${symbol}nothing`);
      }
      
      // console.log(
      //   `Last 1000 5-minute interval average volume: ${averageVolume} , current volume is ${volume}`
      // );
    } catch (error) {
      console.error("Error fetching or processing data:",symbol, error.message);
    }
    
  
};



const calculateAverageVolumeLoop = async () => {
  while (true) {
    for(const x of trimmedDataList){ await calculateAverageVolume(x);}
    await delay(300000);
  }
};

const main = async () => {

    for(const x of trimmedDataList){await calculateAverageVolume(x);}
    calculateAverageVolumeLoop();
    while (true) {
        for(const symbol of trimmedDataList){
            detect(symbol);
        }
        await delay(100000);
    }
};

main();
