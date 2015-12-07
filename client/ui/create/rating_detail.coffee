Meteor.startup ->
  Template.rp_rating_detail.created=->
    console.log @data
    @ratingdetailsView=new ReactiveVar()
    {query,collection,name,docId,audience}=@data
    defaults={docId:docId,collection:collection,name:name,audience:audience,query:query}
    Rp_Rating.initTemplate(defaults)
    if query
      Meteor.call 'getRatingResultsByTitle',defaults.query,(err,res)=>
        if res then @ratingdetailsView.set({data:res})
        console.log err or res
    ###@subscribe('findRatingItem',{_id:@data.id})###

  Template.rp_rating_detail.destroyed=->
    Rp_Rating.cleanUp(@data.name)

  Template.rp_rating_detail.helpers
    ratingDocument:->Rp_Rating.getDefaultData(Template.instance().data.name,Template.instance().ratingdetailsView.get())
    size:->
      Template.instance().data.size or "lg"
    mutable:->
      Template.instance().data.mutable


  Template.rp_rating_detail.events
    "click #rp_add_rating":(evt,temp)->
      Rp_Rating.saveRatingResults(temp.data.name,(err,res)->
        $('#rp_rating_modal').modal(toggle)
      )




