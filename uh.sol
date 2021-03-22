pragma solidity >=0.7.0;

contract AAA {
    address god;
    
    uint articleNum;
    mapping (uint => article) articles;
    
    event editString(uint articleId, string editString, address fromAddress);

    struct article{
        mapping (address => bool) autherized;
        string content;
        address owner;
        
    }
  
    function create(string memory _content) public{
        article storage newArticle = articles[articleNum++];
        newArticle.content = _content;
        newArticle.owner = msg.sender;
        newArticle.autherized[msg.sender] = true;
        newArticle.autherized[god] = true;
        emit editString(articleNum-1, _content, msg.sender);
    }
    function levelUp(uint id, address userAddress) public {
        require(id < articleNum);
        require(msg.sender == articles[id].owner || msg.sender == god);
        articles[id].autherized[userAddress] = true;
    }
    function levelDown(uint id, address userAddress) public {
        require(id < articleNum);
        require(msg.sender == articles[id].owner || msg.sender == god);
        articles[id].autherized[userAddress] = false;
    }
    function edit(uint id, string memory _content) public {
        require(id < articleNum);
        require(articles[id].autherized[msg.sender]);
        articles[id].content = _content;
        emit editString(id, _content, msg.sender);
    }
    function transfer(uint id, address userAddress) public {
        require(id < articleNum);
        require(msg.sender == articles[id].owner || msg.sender == god);
        articles[id].autherized[articles[id].owner] = false;
        articles[id].autherized[userAddress] = true;
        articles[id].owner = userAddress;
    }
    
    
    
    function getContent(uint id) public view returns(string memory){
        require(id < articleNum);
        return articles[id].content;
    }
    
    function ssss() public view returns(string memory){
        return articles[0].content;
    }

    
    modifier onlyGod(){
        require(msg.sender == god);
        _;
    }
    
    constructor (){
        god = msg.sender;
    }    

    
}
