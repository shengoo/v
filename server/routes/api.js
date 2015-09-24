/**
 * Created by sheng on 15/7/4.
 */
var express = require('express');
var router = express.Router();
var fs = require('fs');
var _ = require("underscore");
var dateFormat = require('dateformat');
var movies = JSON.parse(fs.readFileSync('./resources/data.json', 'utf8'));
var categories = JSON.parse(fs.readFileSync('./resources/category.json', 'utf8'));
var pageSize = 20;

function sendResult(req,res,result){
  if(req.query.callback){
    res.jsonp(result);
  }else{
    res.json(result);
  }
}

router.get('/today', function(req, res, next) {
    var date = dateFormat(new Date(),"yyyy-mm-dd");
    var result = _.where(movies, {date: date});

    //will be delete
    if(result.length === 0){
        result = movies.slice(0,3)
    }

    sendResult(req,res,result)
});
router.get('/category', function(req, res, next) {
    sendResult(req,res,categories);
});
router.get('/getmoviebycategory/:category', function(req, res, next) {
    var category = req.params.category;
    var result = _.where(movies, {category: category});
    sendResult(req,res,result)
});
router.get('/getmoviebycategory/:category/:page', function(req, res, next) {
    var page = req.params.page;
    var start = page * pageSize;
    var end = (page + 1) * pageSize;
    var category = req.params.category;
    var result = _.where(movies, {category: category});
    sendResult(req,res,result.slice(start,end))
});
router.get('/getmoviebydate/:date', function(req, res, next) {
    var date = req.params.date;
    var result = _.where(movies, {date: date});

    //will be delete
    if(result.length === 0){
        result = movies.slice(0,3)
    }

    sendResult(req,res,result)
});
router.get('/', function(req,res,next){
    sendResult(req,res,movies);
});
router.get('/:page', function(req,res,next){
    var page = req.params.page;
    var start = page * pageSize;
    var end = (page + 1) * pageSize;
    sendResult(req,res,movies.slice(start,end));
});

module.exports = router;