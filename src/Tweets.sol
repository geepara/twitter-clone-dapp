// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Tweets {
    address public owner;
    uint256 private counter;

    mapping(uint256 => tweet) Tweets;

    constructor() {
        counter = 0;
        owner = msg.sender;
    }

    struct Tweet {
        address tweeter;
        uint256 id;
        string tweetTxt;
        string tweetImg;
    }

    event TweetCreated(
        address tweeter,
        uint256 id,
        string tweetTxt,
        string tweetImg
    );

    function addTweet(string memory tweetTxt, string memory tweetImg)
        public
        payable
    {
        require(msg.value == (1 ether), "Please submit 1 Matic");
        Tweet storage newTweet = tweets[counter];
        newTweet.tweetTxt = tweetTxt;
        newTweet.tweetImg = tweetImg;
        newTweet.tweeter = msg.sender;
        newTweet.id = counter;
        emit TweetCreated(msg.sender, counter, tweetTxt, tweetImg);
        counter++;

        payable(owner).transfer(msg.value);
    }

    function getTweet(uint256 id)
        public
        view
        returns (
            string memory,
            string memory,
            address
        )
    {
        require(id < counter, "No such Tweet exists!");

        Tweet storage t = tweets[id];
        return (t.tweetTxt, t.tweetImg, t.tweeter);
    }
}
