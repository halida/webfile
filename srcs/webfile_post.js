
_regcomp = function(){return 0;};
_regexec = function(){return 0;};
_regfree = function(){return 0;};

webfile_check = cwrap('webfile_check', 'string', ['string', 'number']);

var data = "#bin/sh";
webfile_check(data, data.length);
