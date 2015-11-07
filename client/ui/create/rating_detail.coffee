Meteor.startup ->
  Template.rp_create_rating_detail.created=->
    console.log @data
    {collection,name,docId,audience}=@data
    defaults={docId:docId,collection:collection,name:name,audience:audience}
    Rp_Rating.initTemplate(defaults)
    @subscribe('findRatingItem',{_id:@data.id})

  Template.rp_create_rating_detail.destroyed=->
    Rp_Rating.cleanUp(@data.name)

  Template.rp_create_rating_detail.helpers
    ratingDocument:->Rp_Rating.getDefaultData(Template.instance().data.name,Rp_Ratings.findOne())
    size:->
      Template.instance().data.size or "lg"
    mutable:->
      console.log Template.instance().data.mutable
      Template.instance().data.mutable
    showRateButton:->
      Template.instance().data.showRateButton or false

  Template.rp_create_rating_detail.events
    "click #rp_add_rating":(evt,temp)->
      Rp_Rating.saveRatingResults(temp.data.name,(err,res)->
        console.log err or res
      )




