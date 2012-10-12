Module = {}
Module.preRun = function(){
    var fs = require('fs');
    var filename = 'file.h';
    var data = fs.readFileSync(filename);
    console.log('OK: ' + filename);
    FS.createDataFile('/', 'temp.data', data, true, false);    
}
