const { spawn } = require('child_process');
const { spawnSync } = require('child_process');


const axios = require('axios');

var mylist = [];

const apiUrl = 'https://api.binance.com/api/v3/exchangeInfo';

const getlist = async () => {
  try {
    const response = await axios.get(apiUrl);
    const exchangeInfo = response.data;

    if (exchangeInfo && exchangeInfo.symbols) {
      const usdtPairs = exchangeInfo.symbols
        .filter(symbol => symbol.quoteAsset === 'USDT')
        .map(symbol => symbol.symbol);

      console.log(usdtPairs);
      return usdtPairs;
    } else {
      console.log('Failed to retrieve exchange information.');
      return [];
    }
  } catch (error) {
    console.error('Error:', error.message);
    return [];
  }
}

const delay = (milliseconds) => {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
};



const main=async ()=>{

  mylist = await getlist();
  //mylist = ["BTCUSDT"];
  console.log(mylist);
  var i=1;
  for (const currency of mylist) {
    console.log(`${i}|${currency}`)
    const result = spawnSync('node', ['data-csv2.js', currency]); //do spawnsync

    //await delay(200);
    if (result.error) {
      console.error('Error:', result.error.message);
    } else {
      // Access the child process's output
      const output = result.stdout.toString();
      console.log('Child process output:', output);
    }
    i++;
  }

console.log("ALL DATA ENTRY DONE");


const childProcessPushNotification = spawn('node', ['push-notification.js']);
const childProcessDataUpdate = spawn('node', ['dataupdate.js', mylist]);




// for (const currency of mylist) {
//   const childProcess = spawn('node', ['detection.js', currency]);

//   childProcess.stdout.on('data', (data) => {
//     console.log(`Other File (${currency}): ${data}`);
//   });

//   childProcess.stderr.on('data', (data) => {
//     console.error(`Error from Other File (${currency}): ${data}`);
//   });

//   childProcess.on('close', (code) => {
//     console.log(`Other File (${currency}) process exited with code ${code}`);
//   });
// }
  const childProcess = spawn('node', ['detection-all.js', mylist]);
  childProcess.stdout.on('data', (data) => {
    console.log(`Other File : ${data}`);
  });

  childProcess.stderr.on('data', (data) => {
    console.error(`Error from Other File : ${data}`);
  });

  childProcess.on('close', (code) => {
    console.log(`Other File process exited with code ${code}`);
  });
}


main();