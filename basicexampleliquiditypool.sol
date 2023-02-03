pragma solidity ^0.8.0;

contract LiquidityPool {
    address[] public liquidityProviders;
    uint[] public liquidityProviderAmounts;
    uint public totalLiquidity;

    function addLiquidity(uint _amount) public {
        liquidityProviders.push(msg.sender);
        liquidityProviderAmounts.push(_amount);
        totalLiquidity += _amount;
    }

    function removeLiquidity(uint _amount) public {
        uint index = 0;
        for (uint i = 0; i < liquidityProviders.length; i++) {
            if (liquidityProviders[i] == msg.sender) {
                index = i;
                break;
            }
        }

        if (liquidityProviderAmounts[index] < _amount) {
            revert();
        }

        liquidityProviderAmounts[index] -= _amount;
        totalLiquidity -= _amount;
    }

    function getLiquidityRatio() public view returns (uint) {
        uint senderLiquidity = 0;
        uint index = 0;
        for (uint i = 0; i < liquidityProviders.length; i++) {
            if (liquidityProviders[i] == msg.sender) {
                index = i;
                break;
            }
        }
        senderLiquidity = liquidityProviderAmounts[index];
        return senderLiquidity / totalLiquidity;
    }
}
