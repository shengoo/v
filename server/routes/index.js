var express = require('express');
var router = express.Router();
var fs = require('fs');
var _ = require("underscore");
var movies = JSON.parse(fs.readFileSync('./resources/data.json', 'utf8'));

/* GET home page. */
router.get('/:id', function(req, res, next) {
  //res.render('index', { title: 'Express' });
  //res.sendFile('index.html');
    var id = parseInt(req.params.id);
    var result = _.where(movies, {id: id});
    if(result.length === 0){
        var err = new Error('Not Found');
        err.status = 404;
        next(err);
    }else{
        res.render("index",{movie:result[0]});
    }
});

module.exports = router;
