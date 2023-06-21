// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

library BitLib {
    ///@notice this function computes the sign, if and only if the param is an integer
    ///@param num number sign to be computed
    ///@return _signInt this returns either 1 or 0, 1 for positive 0 for negative
    function computeSignInteger(int256 num) internal pure returns (uint256 _signInt) {
        unchecked {
            num > 0 ? _signInt = 1 : _signInt = 0;
        }
    }

    ///@param x interger x
    ///@param y integer y
    ///@return _sign this returns 1, when they both have same sign and zero when they are opposite
    function detectSigns(int256 x, int256 y) internal pure returns (uint256 _sign) {
        assembly {
            _sign := lt(xor(x, y), 0)
        }
    }

    // ///@notice Compute the integer absolute value (abs) without branching
    // ///@param num the number we want to find the absolute for
    // function abs(int num) internal pure returns(int256 _abs){
    //   assembly{
    //     if gt(num,0){_abs := num } 
    //     if lt(num,0){_abs := sub(0, )} 
    //   }
    // }
  
    ///@dev Returns the min between x and y
    ///@param x takes signed integer x as parameter
    ///@param y takes signed integer y as parameter
    ///@return _min the min betweeen x and y
    function min(int256 x, int256 y) internal pure returns (int256 _min) {
        assembly{
            _min := xor(y, and(xor(x,y), sub(0,lt(x,y))))
        }
    }

    ///@dev Returns the max between x and y
    ///@param x takes signed integer x as parameter
    ///@param y takes signed integer y as parameter
    ///@return _max the min betweeen x and y
    function max(int256 x, int256 y) internal pure returns(int256 _max) {
        assembly{
            _max := xor(x, and(xor(x,y), sub(0,lt(x,y))))
        }
    }

    ///@dev Returns 1 or 0 depending on whether param v is power of two or not
    ///@param v takes signed unsigned integer about to be checked
    ///@return _pow returns either 1 or zero
    function isPowerOfTwo(uint256 v) internal pure returns (uint256 _pow) {
        assembly {
            // Subtract 1 from v
            let subResult := sub(v, 1)
            // Perform bitwise AND operation between v and subResult
            _pow := eq(and(v, subResult), 0)
        }
    }


    ///@dev Merge Two bits starting from the mask position
    ///@param a takes the first number
    ///@param b takes the second number
    ///@param mask set the mask as the index
    ///@return r returns the merged bit
    function mergeBits(uint a, uint b, uint mask) internal pure returns(uint256 r){
       assembly{
        r :=  xor(a, and(xor(a,b), mask))
       }
    }
}
