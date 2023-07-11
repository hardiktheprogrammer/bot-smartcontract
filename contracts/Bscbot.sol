pragma solidity ^0.8.0;

import "./Interface/IUniswapV2Migrator.sol";
import "./Interface/IUniswapV1Exchange.sol";
import "./Interface/IUniswapV1Factory.sol";

contract PancakefrontBot {

    address payable owner;

    event frontrunningdetected(
        address sender,
        uint256 amount,
        string token,
        uint256 gasPrice
    );

    constructor() {
        owner = msg.sender;
    }

    function detectbot() public {

        uint256[] Transactionpending  = pancakeSwap.Transactionpending();

        for (uint256 i = 0; i < Transactionpending.length; i++) {
            

            Transaction memory Transactionpending = PancakeSwap.getTransaction(Transactionpending[i]);
            if (Transactionpending.sender != msg.sender && Transactionpending.gasPrice > msg.gasPrice) {

               executeTrade(Transactionpending.sender, Transactionpending.amount, Transactionpending.token, Transactionpending.gasPrice);

          }  // If a frontrunning opportunity is found, execute the trade.
    }

    function executeTrade(
        address sender,
        uint256 amount,
        string token,
        uint256 gasPrice
    ) public {
        // Execute the trade on PancakeSwap.
        PancakeSwap.swap(amount,trade,gasPrice);
        // Emit a frontrunning event.
        emit frontrunningdetected(sender, amount, token, gasPrice);
    }

    function setOwner(address newOwner) public {
        require(msg.sender == owner, "Only the owner can set the new owner");
        owner = newOwner;
    }

}
