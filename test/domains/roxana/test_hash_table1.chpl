class HashTable { 
  var size : integer;
  var table : _data(integer, size);
  
  function Init(s : integer) {
    size = s;
    [i in 1..size] table(i) = 0;
  }
}  

var size : integer;
writeln("Enter table size");
read(size);
writeln("Size is: ", size);
  
var ht : HashTable = HashTable();
ht.Init(size);
writeln(ht);