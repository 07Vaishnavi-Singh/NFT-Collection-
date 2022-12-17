// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IWizzz.sol";

contract CryptoDevs is ERC721Enumerable , Ownable {

// token uri to store tokens
string baseTokenURI ;

// max number of CryptoDevs
    uint256 public maxTokenIds = 20;

// total number of tokenIds minted
uint256 public tokenIds;

 
uint public preSalePrice = 0.005 ether ;

uint public postSalePrice = 0.01 ether ;

bool public paused;

IWizzz instanceContract; 

bool public preSaleStarted ;

uint public preSaleEnded ;

modifier onlyWhenNotPaused {
    require( !paused  ,"Sorry the contract ha s been paused");
    _;
}

   function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

constructor( string memory _baseTokenURI , address wizzContract ) ERC721( "Crypto Devs", "CD"){
baseTokenURI = _baseTokenURI ;
instanceContract = IWizzz(wizzContract);
}

function setPaused(bool val) public onlyOwner {
        paused = val;
    }

function startSale(uint _setDurationInMinutes) public onlyOwner{
 
 preSaleStarted = true;
 preSaleEnded = block.timestamp + _setDurationInMinutes;

}

function preSaleMint() public payable  onlyWhenNotPaused{
require((preSaleStarted && (block.timestamp < preSaleEnded )) , "You are either late or too early for the presale ");
require(instanceContract.whetherIsWhitelisted(msg.sender) , "You are not allpwed to take part in the pre sale");
require(msg.value == preSalePrice , "Please put in more ether");
require(tokenIds < maxTokenIds, "Exceeded maximum Crypto Devs supply");

tokenIds+=1;
_safeMint( msg.sender , tokenIds );
}

function mint() public payable  onlyWhenNotPaused{
 require((preSaleStarted && (block.timestamp > preSaleEnded )) , "We suggest yo uto wait for some time as the pre-sale has not ended yet ");
require(msg.value == postSalePrice , "Please put in more ether");
require(tokenIds < maxTokenIds, "Exceeded maximum Crypto Devs supply");

tokenIds+=1;
_safeMint( msg.sender , tokenIds );
}

function withdraw() public onlyOwner {
address owner = owner();
uint256 amount = address(this).balance;
(bool sent, ) =  owner.call{value: amount}("");
require(sent, "Failed to send Ether");
}

receive() external payable {}

fallback() external {}

}








