var ipfs = Tools.ipfs

// TODO: Currently 127.0.0.1:5001 ; Need to change it later
ipfs.setProvider(ipfs.localProvider)

// fileFromEvent <- event.target.file[0]
// callback(hash) <- function that you want to run after getting hash value.
//                   Has hash as parameter
function ipfsStore(fileFromEvent, callback) {

  var reader = new FileReader();
  reader.readAsDataURL(fileFromEvent);

  reader.onload=function(){
    ipfs.add(reader.result, (err, hash) => {
      if(err || !hash){
        console.log(err);
      }
      else {
        callback(hash);
      }
    });
  }
}

// callback(bufferText) <- function that you want to run after getting buffer as text.
//                         Has bufferText as parameter
function ipfsRetrieve(hash, callback) {
  ipfs.catText(hash, (err, bufferText) => {
    if(err || !bufferText){
      console.log(err);
    }
    else{
      callback(bufferText);
    }
  })
}

// TODO: Remove this Demo
var saveFile = function(event) {
  var cbk = function(hash){
    document.getElementById('hashBox1').value  = hash;
  }
  ipfsStore(event.target.files[0], cbk);
};

// TODO: Remove this Demo
var retrieveFile = function(event) {
  var cbk = function(bufferText) {
    document.getElementById("imageFromIPFS").src = bufferText
  }
  hash = document.getElementById('hashBox2').value
  ipfsRetrieve(hash, cbk);
}
