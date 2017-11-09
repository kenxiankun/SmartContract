contract SHA3Test
{
    
    function getSHA3Hash() returns (bytes32 hashedOutput) {
        bytes memory input = string_tobytes("testing");
        bytes32 hashedkeccak256 = keccak256(input);
        bytes32 hashedsha256 = sha256(input);
        hashedOutput = sha3(input);
        
        afterGetSHA3Hash(input, hashedOutput,hashedkeccak256, hashedsha256);
    }
    
    event afterGetSHA3Hash (
            bytes input,
            bytes32 outputsha3,
            bytes32 outputkeccak256,
            bytes32 outputsha256
     );
    
    function string_tobytes(string _inputstr) constant returns (bytes){
        bytes memory results = bytes(_inputstr);
        return results;
    }
    
    
}

// Ethereum uses KECCAK-256. It should be noted that it does not follow 
// the FIPS-202 based standard of Keccak, which was finalized in August 2015.

// Hashing the string "testing":
// Ethereum SHA3 function in Solidity = 5f16f4c7f149ac4f9510d9cf8cf384038ad348b3bcdc01915f95de12df9d1b02
// Keccak-256 (Original Padding) = 5f16f4c7f149ac4f9510d9cf8cf384038ad348b3bcdc01915f95de12df9d1b02
// SHA3-256 (NIST Standard) = cf80cd8aed482d5d1527d7dc72fceff84e6326592848447d2dc0b0e87dfc9a90

// More info:
// https://github.com/ethereum/EIPs/issues/59
// http://ethereum.stackexchange.com/questions/550/which-cryptographic-hash-function-does-ethereum-use