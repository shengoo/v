/**
 * Created by UC165867 on 7/6/2015.
 */
/**
 * Created by sheng on 15/7/4.
 */
var express = require('express');
var router = express.Router();
var fs = require('fs');

router.get('/:filename', function(req, res, next) {
    var filename = req.params.filename;
    console.log(filename)
    var options = {
        //root: __dirname + '/../resources/',
        root: 'resources/',
        dotfiles: 'deny',
        headers: {
            'x-timestamp': Date.now(),
            'x-sent': true
        }
    };
    var filepath = 'resources/' + filename;
    if(fs.existsSync(filepath)){
        res.sendFile(filename,options);
    }else{
        res.status(404).send();
    }

});


module.exports = router;