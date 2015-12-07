class Rp_Rating_Client
  _resultsByTitle=new ReactiveVar([])
  _ratingSummary=new ReactiveVar([])
  _config={}
  _currentRatingResults={}

  initTemplate:(templateDefaults)->
    check(templateDefaults,Match.ObjectIncluding({name:String,collection:String}))
    _currentRatingResults[templateDefaults.name]=templateDefaults

  getDefaultData:(name,data)->
    if data
      check(data,Match.ObjectIncluding({data:[Match.ObjectIncluding({title:String,description:String,value:Number})]}))
      _currentRatingResults[name]=data
    else
      _currentRatingResults[name]=_.extend(_config[name],_currentRatingResults[name])
    _currentRatingResults[name]

  modalHandle:undefined


  identityFields:['emails.0.address']

  setConfig:(configs)->
    check(configs,[{name:String,data:[{title:String,description:String,value:Number}]}])
    console.log configs
    _config[config.name]=data:config.data for config in configs

  getRatingResults:(name)->
    _currentRatingResults[name]

  saveRatingResults:(name,callback)->
    _.each _currentRatingResults[name].data,(val)->
      val.value=$("##{val.title}").data('userrating') or val.value
    comment=$('.rp_rating_comment').val()
    _currentRatingResults[name]["comment"]=comment
    Meteor.call 'saveRatingResults',_currentRatingResults[name],(err,res)->
      callback.call null,err,res

  getAverageForSet:(set,basis)->
    set.average(basis)


  cleanUp:(name)->
   delete _currentRatingResults[name]


  getConfig:(name)->
    _config[name]

  resultsByTitle:(qry)->
    _resultsByTitle.set([])
    Meteor.call 'getRatingResultsByTitle',qry,(err,res)->
      if res then _resultsByTitle=res else console.log err
    _resultsByTitle.get()


  ratingSummary:(qry,group)->
    _ratingSummary.set([])
    Meteor.call 'getRatingResultsSummary',qry,group,(err,res)->
      if res then _ratingSummary=res else console.log err
    _ratingSummary.get()

  getRatings:(qry,modifier)->
    Rp_Ratings.find(qry,modifier)

Rp_Rating=new Rp_Rating_Client()