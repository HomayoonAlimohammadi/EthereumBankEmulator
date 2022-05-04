pragma solidity >=0.8.7;


contract BankEmulator {

    mapping(address => uint) private balances;

    function deposite() external payable {

        require(msg.value > 0, "Can not deposite 0 wei.");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {

        require(balances[msg.sender] >= amount, "Insufficient funds.");
        (bool sent, bytes memory data) = msg.sender.call{value: amount}("");
        require(sent, "Error sending Eth.");
        balances[msg.sender] -= amount;
    }

    function getBankBalance() view public returns (uint) {
        return address(this).balance;
    }

    function getAccountBalance() view public returns (uint) {
        return balances[msg.sender];
    }

    function transfer(address payable recipient, uint amount) public {

        require(amount > 0, "Can not Transfer 0 wei.");
        require(balances[msg.sender] >= amount, "Insufficient Funds.");
        (bool sent, bytes memory data) = recipient.call{value: amount}("");
        require(sent, "Error sending Eth.");
        balances[msg.sender] -= amount;      
    }
}