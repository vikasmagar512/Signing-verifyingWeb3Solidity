pragma solidity ^0.4.8;
contract Verifier {
    struct Customer{
        address custAddress;
        string name;
        string sig;
    }
    
    mapping (string=>Customer) custMapping;
    mapping (string=>string) sigMapping;
    function storeSig(string bankID,string sig) public {
        sigMapping[bankID]=sig;
    }
    function storeCust(string bankID,string name,address custAddress,string sig) public {
        custMapping[bankID]=Customer({custAddress:custAddress,name:name,sig:sig});
        // custMapping[bankID]=Customer(custAddress,name,sig);
    }
    
    function getCustInfo(string bankID)  public constant returns (address ad,string name,string sig){
        return (custMapping[bankID].custAddress,custMapping[bankID].name,custMapping[bankID].sig);
    }
    function getSig(string bankID)  public constant  returns (string){
        return sigMapping[bankID];
    }
    
    function recoverAddr(bytes32 msgHash, uint8 v, bytes32 r, bytes32 s) view public  returns (address) {
        return ecrecover(msgHash, v, r, s);
    }
    
  function verifyAddress(bytes32 _message,address signerAddress, uint8 _v, bytes32 _r, bytes32 _s) constant returns (bool) {
    bytes memory prefix = "\x19Ethereum Signed Message:\n32";
    bytes32 prefixedHash = sha3(prefix, _message);
    address signer = ecrecover(prefixedHash, _v, _r, _s);
    return signer == signerAddress;
  }

    function isSigned(address _addr, bytes32 msgHash, uint8 v, bytes32 r, bytes32 s) returns (bool) {
        return ecrecover(msgHash, v, r, s) == _addr;
    }
    
  function verify(bytes32 _message, uint8 _v, bytes32 _r, bytes32 _s) constant returns (address) {
    bytes memory prefix = "\x19Ethereum Signed Message:\n32";
    bytes32 prefixedHash = sha3(prefix, _message);
    address signer = ecrecover(prefixedHash, _v, _r, _s);
    return signer;
  }
}
