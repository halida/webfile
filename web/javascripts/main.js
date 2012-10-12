$(function(){

    function handleFileSelect(evt) {

        _regcomp = function(){return 0;};
        _regexec = function(){return 0;};
        _regfree = function(){return 0;};
        webfile_check = webfile.cwrap('webfile_check', 'string', ['string', 'number']);

        function check_file(f){
            var reader = new FileReader();
            reader.onload = function(e){
                var data = e.target.result;
                var result = webfile_check(data, data.length);
                var o = [];

                o.push('<li><strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
                       f.size, ' bytes, last modified: ',
                       f.lastModifiedDate ? f.lastModifiedDate.toLocaleDateString() : 'n/a',
                       '<br/>',
                       result, 
                       '</li>');
                document.getElementById('list').innerHTML = '<ul>' + o.join('') + '</ul>';
                console.log(o);
            };
            reader.readAsBinaryString(f);
        };

        var files = evt.target.files; // FileList object

        // files is a FileList of File objects. List some properties.
        for (var i = 0, f; f = files[i]; i++) {
            check_file(f);
        };
    }

    document.getElementById('files').addEventListener('change', handleFileSelect, false);

});
