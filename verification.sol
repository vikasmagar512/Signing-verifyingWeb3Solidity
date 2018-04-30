pragma solidity ^0.4.0;
contract Verification{
    mapping (string=>string) map;
    function Verification() public {
    }
    function storeSignature(string msg,string accNo) public {
        map[accNo]=msg;
    }
    function verify(bytes32 r, bytes32 s, uint8 v, bytes32 hash) returns(address) {
        return ecrecover(hash, v, r, s);
    } 

    function verify(uint256 address, bytes sig) public {
        // This recreates the message that was signed on the client.
        bytes32 message = prefixed(keccak256(address, msgString, this));
        require(recoverSigner(message, sig) == owner);
        //msg.sender.transfer(amount);
    }

    // Signature methods
    function splitSignature(bytes sig)
        internal
        pure
        returns (uint8, bytes32, bytes32)
    {
        require(sig.length == 65);

        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }
       
        return (v, r, s);
    }

    function recoverSigner(bytes32 message, bytes sig)
        internal
        pure
        returns (address)
    {
        uint8 v;
        bytes32 r;
        bytes32 s;

        (v, r, s) = splitSignature(sig);

        return ecrecover(message, v, r, s);
    }

    // Builds a prefixed hash to mimic the behavior of eth_sign.
    function prefixed(bytes32 hash) internal pure returns (bytes32) {
        return keccak256("\x19Ethereum Signed Message:\n32", hash);
    }
}