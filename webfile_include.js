// connect to canvas
var Module = {
    preRun: [],
    postRun: [],
    print: (function() {
        var element = document.getElementById('output');
        element.value = ''; // clear browser cache
        return function(text) {
            // These replacements are necessary if you render to raw HTML
            //text = text.replace(/&/g, "&amp;");
            //text = text.replace(/</g, "&lt;");
            //text = text.replace(/>/g, "&gt;");
            //text = text.replace('\n', '<br>', 'g');
            element.value += text + "\n";
            element.scrollTop = 99999; // focus on bottom
        };
    })(),
    printErr: function(text) {
        if (0) { // XXX disabled for safety typeof dump == 'function') {
            dump(text + '\n'); // fast, straight to the real console
        } else {
            console.log(text);
        }
    },
    canvas: document.getElementById('canvas'),
    setStatus: function(text) {
        if (Module.setStatus.interval) clearInterval(Module.setStatus.interval);
        var m = text.match(/([^(]+)\((\d+(\.\d+)?)\/(\d+)\)/);
        var statusElement = document.getElementById('status');
        var progressElement = document.getElementById('progress');
        if (m) {
            text = m[1];
            progressElement.value = parseInt(m[2])*100;
            progressElement.max = parseInt(m[4])*100;
            progressElement.hidden = false;
        } else {
            progressElement.value = null;
            progressElement.max = null;
            progressElement.hidden = true;
        }
        statusElement.innerHTML = text;
    },
    totalDependencies: 0,
    monitorRunDependencies: function(left) {
        this.totalDependencies = Math.max(this.totalDependencies, left);
        Module.setStatus(left ? 'Preparing... (' + (this.totalDependencies-left) + '/' + this.totalDependencies + ')' : 'All downloads complete.');
    }
};
Module.setStatus('Downloading...');

Module.preRun = function(){

    // todo
    _regcomp = function(){return 0;};
    _regexec = function(){return 0;};
    _regfree = function(){return 0;};

    // webfile_check = cwrap('webfile_check', 'string', ['string', 'number']);
    // var data = "#bin/sh";
    // webfile_check(data, data.length);
}

window.webfile = {cwrap: cwrap}

