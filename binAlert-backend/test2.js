const { spawn } = require('child_process');


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


main =async () =>{  
  mylist = await getlist();

  const childProcessPushNotification = spawn('node', ['datareq.js']);
  
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

main()


