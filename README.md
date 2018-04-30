# Signing-verifyingWeb3Solidity

Steps:
* Turn on Ganache-cli on a terminal
* Open Remix browser IDE 
* Compile the Verifier.sol contract and copy the ABI
* Paste this ABI in all html files, where 
   var CoursetroContract = web3.eth.contract(ABI)
* Attach a Web3 instance to remix ide on "localhost:8545"
* Create a contract, copy the contract Address 
* Paste this contract ADDRESS, in all html files where
     var Coursetro = CoursetroContract.at(ADDRESS);
* Open "bankSubmission.html" file in browser
  * Enter your name, submit the info (By default bankID is 2)
* Open "bankVerify.html" file in browser
  * Enter the account ID,(By default bankID is 2)
  * press the button, you will get the customer info for bankID = 2
  * See if you get the same customer name, you entered in "bankSubmission.html"
  * press the Verify button
  * See the Result (Verified or Not Verified)
