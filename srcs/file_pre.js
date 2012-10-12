Module = {}
Module.preRun = function(){
    var fs = require('fs');

    var data = fs.readFileSync("magic.mgc");
    FS.createDataFile('/', 'magic.mgc', data, true, false);
    
    var filename = process.argv[2];
    var data = fs.readFileSync(filename);
    FS.createDataFile('/', 'testfile', data, true, false);

}
