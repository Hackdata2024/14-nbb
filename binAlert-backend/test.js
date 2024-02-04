const axios = require('axios');

//https://api.binance.com/api/v3/depth?symbol=LTCUSDT&limit=1           LTC-USDT orderbook
//https://api.binance.com/api/v3/depth?symbol=LTCTRY&limit=1            LTC-TRY
//https://api.binance.com/api/v3/depth?symbol=USDTTRY&limit=1           USDT-TRY


//Target = z and z/x, z/y exsist then stable= x if x/y exsist,else y if y/x exsist
var stable = "USDT"; 
var inter = "TRY";     
var target = "WLD";

// Function to fetch data from Binance API
const fetchData = (url) => {
    return axios.get(url)
      .then(response => {
        // Parse the bid and ask prices into doubles
        const parsedData = {
          bids: response.data.bids.map(entry => [parseFloat(entry[0]), parseFloat(entry[1])]),
          asks: response.data.asks.map(entry => [parseFloat(entry[0]), parseFloat(entry[1])])
        };
        return parsedData;
      })
      .catch(error => {
        console.error('Error fetching data from Binance API:', error.message);
      });
  };

// Binance API URLs
const firstUrl = `https://api.binance.com/api/v3/depth?symbol=${target}${stable}&limit=1`;
const secondUrl = `https://api.binance.com/api/v3/depth?symbol=${target}${inter}&limit=1`;
const thirdUrl = `https://api.binance.com/api/v3/depth?symbol=${stable}${inter}&limit=1`;

// Use Promise.all to wait for all requests to complete
Promise.all([
  fetchData(firstUrl),
  fetchData(secondUrl),
  fetchData(thirdUrl)
])
  .then(([first, second, third]) => {
    // Now you have all the data
    console.log(`FIRST ${target}${stable}:`, first);
    console.log(`SECOND ${target}${inter}:`, second);
    console.log(`THIRD ${stable}${inter}:`, third);


    
    var targetbought = 100/first.asks[0][0];
    var interbought = targetbought*second.bids[0][0];
    var stablebought = interbought/third.bids[0][0];
    //var profit = (second.bids[0][0]/third.bids[0][0])-(100/first.asks[0][0]);
    console.log(stablebought);
  });
