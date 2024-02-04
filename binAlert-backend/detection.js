const receivedParameter = process.argv[2];

if (!receivedParameter) {
  console.error("Other File: No parameter received.");
  process.exit(1);
}

const symbol = receivedParameter;

const axios = require("axios");
const fs = require("fs");

//const symbol = 'DEGOUSDT';
const interval = "5m"; // Set to '1m' for a 1-minute interval
const csvFilePath = `./data/${symbol}.csv`;

const calculateAverageVolume = () => {
  try {
    // Read the last 1000 lines from the CSV file
    const csvData = fs.readFileSync(csvFilePath, "utf-8");
    const lines = csvData.trim().split("\n");
    const last1000Lines = lines.slice(-1000);

    // Calculate the average volume
    let totalVolume = 0;
    last1000Lines.forEach((line) => {
      const [time, open, close, volume] = line.split(",");
      //console.log(volume);
      totalVolume += parseFloat(volume);
    });

    const averageVolume = totalVolume / last1000Lines.length;

    //console.log(`Last 1000 lines average volume: ${averageVolume.toFixed(2)}`);
    return averageVolume.toFixed(2);
  } catch (error) {
    console.error("Error reading or processing data:", error.message);
    return -1;
  }
};

// Example usage

const delay = (milliseconds) => {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
};

const detect = async () => {
  while (true) {
    try {
      // Fetch the last 1000 1-minute interval data from the Binance API
      const response = await axios.get(
        `https://api.binance.com/api/v3/klines?symbol=${symbol}&interval=${interval}&limit=1`
      );
      const klines = response.data;
      const entry = klines[0];
      const volume = parseFloat(entry[5]); // Assuming 'Volume' is the 6th element in the kline data
      if (volume > (averageVolume*2)) {
        console.log(`${symbol} is Pumping!`);
      } else {
        //console.log("nothing");
      }
      await delay(10000);
      // console.log(
      //   `Last 1000 5-minute interval average volume: ${averageVolume} , current volume is ${volume}`
      // );
    } catch (error) {
      console.error("Error fetching or processing data:", error.message);
    }
  }
};

var averageVolume = 0;

const calculateAverageVolumeLoop = async () => {
  while (true) {
    averageVolume = await calculateAverageVolume();
    await delay(240000);
  }
};

const main = async () => {
  averageVolume = await calculateAverageVolume();
  calculateAverageVolumeLoop();
  detect();
};

main();
