require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

const QUICKNODE_HTTP_URL = process.env.QUICKNODE_HTTP_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.9",
  networks: {
    goerli: {
      url:  "https://long-billowing-hexagon.ethereum-goerli.discover.quiknode.pro/a2c26742839dc11b429e4989c4042fedcf1e486b/" , 
      accounts : ["7797d35a68ee39fb61094f46187a1d849a289778503cc21d4e6f8aada09c3386"],
    },
  },
};