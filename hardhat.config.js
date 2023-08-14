require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    mumbai: {
      url: process.env.MUMBAI_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
    sepolia: {
      url: process.env.SEPOLIA_URL;
      accounts: [process.env.PRIVATE_KEY],
    }
  },
};
